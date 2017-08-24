From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Aug 2017 14:15:47 +0800
Subject: [PATCH v2 7/8] iommu/mediatek: Enlarge the validate PA range for
 4GB mode
In-Reply-To: <1503313221-26453-8-git-send-email-yong.wu@mediatek.com>
Message-ID: <201708241354.NkAGPHib%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

[auto build test WARNING on iommu/next]
[also build test WARNING on next-20170823]
[cannot apply to v4.13-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yong-Wu/MT2712-IOMMU-SUPPORT/20170824-074750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/bootmem.h:7,
                    from drivers/iommu/mtk_iommu.c:14:
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_iova_to_phys':
   include/linux/bitops.h:6:24: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
>> drivers/iommu/mtk_iommu.c:407:9: note: in expansion of macro 'BIT'
      pa |= BIT(32);
            ^~~
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_hw_init':
   drivers/iommu/mtk_iommu.c:536:30: error: 'const struct mtk_iommu_data' has no member named 'm4u_type'; did you mean 'm4u_dom'?
     if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
                                 ^~
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/bootmem.h:7,
                    from drivers/iommu/mtk_iommu.c:14:
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_probe':
   include/linux/bitops.h:6:24: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define BIT(nr)   (1UL << (nr))
                           ^
   drivers/iommu/mtk_iommu.c:589:35: note: in expansion of macro 'BIT'
     data->enable_4GB = !!(max_pfn > (BIT(32) >> PAGE_SHIFT));
                                      ^~~

vim +/BIT +407 drivers/iommu/mtk_iommu.c

   393	
   394	static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
   395						  dma_addr_t iova)
   396	{
   397		struct mtk_iommu_domain *dom = to_mtk_domain(domain);
   398		struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
   399		unsigned long flags;
   400		phys_addr_t pa;
   401	
   402		spin_lock_irqsave(&dom->pgtlock, flags);
   403		pa = dom->iop->iova_to_phys(dom->iop, iova);
   404		spin_unlock_irqrestore(&dom->pgtlock, flags);
   405	
   406		if (data->enable_4GB)
 > 407			pa |= BIT(32);
   408	
   409		return pa;
   410	}
   411	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62774 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/1828f7b1/attachment-0001.gz>
