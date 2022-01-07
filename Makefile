# Change NUM_PROCS if necessary
NUM_PROCS=8
# Change PREFIX if necessary
PREFIX=/home/jose/haha
INCLUDE_DIR=$(PREFIX)/usr/include
LIB_DIR=$(PREFIX)/usr/lib
TAR_FILE=tbb-2020_U3.tar.gz
PATCH=oneTBB-2020_U3
MACAULAY_WEBSITE=https://faculty.math.illinois.edu/Macaulay2

all: done

.PHONY: done
done:
	mkdir -p $(INCLUDE_DIR)
	mkdir -p $(LIB_DIR)
	curl -fLo $(TAR_FILE) $(MACAULAY_WEBSITE)/Downloads/OtherSourceCode/$(TAR_FILE)
	tar -xvf $(TAR_FILE)
	cd $(PATCH) && make -j$(NUM_PROCS)
	sudo rm -rf $(INCLUDE_DIR)/serial
	sudo rm -rf $(INCLUDE_DIR)/tbb
	sudo cp -r $(PATCH)/include/serial $(INCLUDE_DIR)/
	sudo cp -r $(PATCH)/include/tbb $(INCLUDE_DIR)/
	find $(PATCH)/build/*release/libtbb* | xargs -I{} sudo cp {} $(LIB_DIR)/

.PHONY: clean
clean:
	rm -rf $(PATCH) $(TAR_FILE)
