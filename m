From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 13 Oct 2016 21:25:59 +0800
Subject: [arm-soc:to-build 4/4] arch/s390/pci/pci_dma.c:309:13: warning: 'pa'
 may be used uninitialized in this function
Message-ID: <201610132149.t5xXbZdB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   346c22ea9cb8d0ee331c73529b205414e43a4655
commit: 346c22ea9cb8d0ee331c73529b205414e43a4655 [4/4] Revert "Disable "maybe-uninitialized" warning globally"
config: s390-default_defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 346c22ea9cb8d0ee331c73529b205414e43a4655
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   arch/s390/pci/pci_dma.c: In function '__s390_dma_map_sg':
>> arch/s390/pci/pci_dma.c:309:13: warning: 'pa' may be used uninitialized in this function [-Wmaybe-uninitialized]
     } __packed data = {rc, addr};
                ^~~~
   arch/s390/pci/pci_dma.c:426:16: note: 'pa' was declared here
     unsigned long pa;
                   ^~

vim +/pa +309 arch/s390/pci/pci_dma.c

828b35f6 Jan Glauber         2012-11-29  293  		goto out;
13954fd6 Sebastian Ott       2016-09-08  294  
13954fd6 Sebastian Ott       2016-09-08  295  	if (zdev->tlb_refresh || s390_iommu_strict)
828b35f6 Jan Glauber         2012-11-29  296  		bitmap_clear(zdev->iommu_bitmap, offset, size);
13954fd6 Sebastian Ott       2016-09-08  297  	else
13954fd6 Sebastian Ott       2016-09-08  298  		bitmap_set(zdev->lazy_bitmap, offset, size);
13954fd6 Sebastian Ott       2016-09-08  299  
828b35f6 Jan Glauber         2012-11-29  300  out:
828b35f6 Jan Glauber         2012-11-29  301  	spin_unlock_irqrestore(&zdev->iommu_bitmap_lock, flags);
828b35f6 Jan Glauber         2012-11-29  302  }
828b35f6 Jan Glauber         2012-11-29  303  
52d43d81 Sebastian Ott       2015-10-26  304  static inline void zpci_err_dma(unsigned long rc, unsigned long addr)
52d43d81 Sebastian Ott       2015-10-26  305  {
52d43d81 Sebastian Ott       2015-10-26  306  	struct {
52d43d81 Sebastian Ott       2015-10-26  307  		unsigned long rc;
52d43d81 Sebastian Ott       2015-10-26  308  		unsigned long addr;
52d43d81 Sebastian Ott       2015-10-26 @309  	} __packed data = {rc, addr};
52d43d81 Sebastian Ott       2015-10-26  310  
52d43d81 Sebastian Ott       2015-10-26  311  	zpci_err_hex(&data, sizeof(data));
52d43d81 Sebastian Ott       2015-10-26  312  }
52d43d81 Sebastian Ott       2015-10-26  313  
828b35f6 Jan Glauber         2012-11-29  314  static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
828b35f6 Jan Glauber         2012-11-29  315  				     unsigned long offset, size_t size,
828b35f6 Jan Glauber         2012-11-29  316  				     enum dma_data_direction direction,
00085f1e Krzysztof Kozlowski 2016-08-03  317  				     unsigned long attrs)

:::::: The code at line 309 was first introduced by commit
:::::: 52d43d8184b1840c7cf6136724223585f51a1074 s390/pci_dma: improve debugging of errors during dma map

:::::: TO: Sebastian Ott <sebott@linux.vnet.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16396 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161013/6b7b2883/attachment-0001.gz>
