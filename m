From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Apr 2016 11:13:43 +0800
Subject: [PATCH 4/4] mtd: provide helper to prepare buffers for DMA
 operations
In-Reply-To: <1459427384-21374-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201604011151.adkPJgri%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[auto build test ERROR on spi/for-next]
[also build test ERROR on v4.6-rc1 next-20160331]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/scatterlist-sg_table-from-virtual-pointer/20160331-203118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi for-next
config: m32r-m32104ut_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mtd/super.h:17:0,
                    from fs/romfs/storage.c:13:
>> include/linux/mtd/mtd.h:426:10: error: expected ';', ',' or ')' before 'enum'
             enum dma_data_direction dir)
             ^
   include/linux/mtd/mtd.h: In function 'mtd_unmap_buf':
>> include/linux/mtd/mtd.h:434:2: warning: 'return' with a value, in function returning void
     return -ENOTSUPP;
     ^
   fs/romfs/storage.c: At top level:
   include/linux/mtd/mtd.h:431:13: warning: 'mtd_unmap_buf' defined but not used [-Wunused-function]
    static void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
                ^
--
   In file included from include/linux/mtd/super.h:17:0,
                    from fs/romfs/super.c:72:
>> include/linux/mtd/mtd.h:426:10: error: expected ';', ',' or ')' before 'enum'
             enum dma_data_direction dir)
             ^
   include/linux/mtd/mtd.h: In function 'mtd_unmap_buf':
>> include/linux/mtd/mtd.h:434:2: warning: 'return' with a value, in function returning void
     return -ENOTSUPP;
     ^
   fs/romfs/super.c: At top level:
   include/linux/mtd/mtd.h:431:13: warning: 'mtd_unmap_buf' defined but not used [-Wunused-function]
    static void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
                ^

vim +426 include/linux/mtd/mtd.h

   420			   struct sg_table *sgt, enum dma_data_direction dir);
   421	#else
   422	static inline int mtd_map_buf(struct mtd_info *mtd, struct device *dev,
   423				      struct sg_table *sgt, const void *buf,
   424				      size_t len,
   425				      const struct sg_constraints *constraints
 > 426				      enum dma_data_direction dir)
   427	{
   428		return -ENOTSUPP;
   429	}
   430	
   431	static void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
   432				  struct sg_table *sgt, enum dma_data_direction dir)
   433	{
 > 434		return -ENOTSUPP;
   435	}
   436	#endif
   437	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 10416 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160401/54de4e78/attachment-0001.obj>
