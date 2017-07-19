From: lkp@intel.com (kbuild test robot)
Date: Wed, 19 Jul 2017 23:07:38 +0800
Subject: [PATCH 4/4] iommu/iova: Make dma_32bit_pfn implicit
In-Reply-To: <a994de98adbd37e0755cce1184f06186e67db67b.1500396007.git.robin.murphy@arm.com>
Message-ID: <201707192352.79mkRePJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhen,

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.13-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robin-Murphy/Optimise-64-bit-IOVA-allocations/20170719-060847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/iommu/iova.c: In function 'init_iova_domain':
>> drivers/iommu/iova.c:53:41: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     iovad->dma_32bit_pfn = iova_pfn(iovad, 1ULL << 32);
                                            ^~~~

vim +53 drivers/iommu/iova.c

    35	
    36	void
    37	init_iova_domain(struct iova_domain *iovad, unsigned long granule,
    38		unsigned long start_pfn)
    39	{
    40		/*
    41		 * IOVA granularity will normally be equal to the smallest
    42		 * supported IOMMU page size; both *must* be capable of
    43		 * representing individual CPU pages exactly.
    44		 */
    45		BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
    46	
    47		spin_lock_init(&iovad->iova_rbtree_lock);
    48		iovad->rbroot = RB_ROOT;
    49		iovad->cached_node = NULL;
    50		iovad->cached32_node = NULL;
    51		iovad->granule = granule;
    52		iovad->start_pfn = start_pfn;
  > 53		iovad->dma_32bit_pfn = iova_pfn(iovad, 1ULL << 32);
    54		init_iova_rcaches(iovad);
    55	}
    56	EXPORT_SYMBOL_GPL(init_iova_domain);
    57	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41230 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/ed8e7764/attachment-0001.gz>
