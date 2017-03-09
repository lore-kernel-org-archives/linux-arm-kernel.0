From: lkp@intel.com (kbuild test robot)
Date: Thu, 9 Mar 2017 22:06:54 +0800
Subject: [PATCH v2 5/7] ARM: NOMMU: Introduce dma operations for noMMU
In-Reply-To: <1488885154-12429-6-git-send-email-vladimir.murzin@arm.com>
Message-ID: <201703092203.goMXDQRU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

[auto build test WARNING on next-20170308]
[also build test WARNING on v4.11-rc1]
[cannot apply to linux/master v4.9-rc8 v4.9-rc7 v4.9-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vladimir-Murzin/ARM-Fix-dma_alloc_coherent-and-friends-for-NOMMU/20170309-193212
config: arm-allnoconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   arch/arm/mm/dma-mapping-nommu.c: In function 'arm_nommu_dma_alloc':
>> arch/arm/mm/dma-mapping-nommu.c:42:28: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     struct dma_map_ops *ops = &dma_noop_ops;
                               ^
   arch/arm/mm/dma-mapping-nommu.c: In function 'arm_nommu_dma_free':
   arch/arm/mm/dma-mapping-nommu.c:64:28: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     struct dma_map_ops *ops = &dma_noop_ops;
                               ^
   arch/arm/mm/dma-mapping-nommu.c: In function 'arm_nommu_dma_mmap':
   arch/arm/mm/dma-mapping-nommu.c:78:28: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     struct dma_map_ops *ops = &dma_noop_ops;
                               ^
   arch/arm/mm/dma-mapping-nommu.c: In function 'arm_nommu_get_dma_map_ops':
>> arch/arm/mm/dma-mapping-nommu.c:207:34: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return coherent ? &dma_noop_ops : &arm_nommu_dma_ops;
            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~

vim +/const +42 arch/arm/mm/dma-mapping-nommu.c

    36	
    37	static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
    38					 dma_addr_t *dma_handle, gfp_t gfp,
    39					 unsigned long attrs)
    40	
    41	{
  > 42		struct dma_map_ops *ops = &dma_noop_ops;
    43	
    44		/*
    45		 * We are here because:
    46		 * - no consistent DMA region has been defined, so we can't
    47		 *   continue.
    48		 * - there is no space left in consistent DMA region, so we
    49		 *   only can fallback to generic allocator if we are
    50		 *   advertised that consistency is not required.
    51		 */
    52	
    53		if (attrs & DMA_ATTR_NON_CONSISTENT)
    54			return ops->alloc(dev, size, dma_handle, gfp, attrs);
    55	
    56		WARN_ON_ONCE(1);
    57		return NULL;
    58	}
    59	
    60	static void arm_nommu_dma_free(struct device *dev, size_t size,
    61				       void *cpu_addr, dma_addr_t dma_addr,
    62				       unsigned long attrs)
    63	{
  > 64		struct dma_map_ops *ops = &dma_noop_ops;
    65	
    66		if (attrs & DMA_ATTR_NON_CONSISTENT)
    67			ops->free(dev, size, cpu_addr, dma_addr, attrs);
    68		else
    69			WARN_ON_ONCE(1);
    70	
    71		return;
    72	}
    73	
    74	static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
    75				      void *cpu_addr, dma_addr_t dma_addr, size_t size,
    76				      unsigned long attrs)
    77	{
    78		struct dma_map_ops *ops = &dma_noop_ops;
    79		int ret;
    80	
    81		if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
    82			return ret;
    83	
    84		if (attrs & DMA_ATTR_NON_CONSISTENT)
    85			return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
    86	
    87		WARN_ON_ONCE(1);
    88		return -ENXIO;
    89	}
    90	
    91	static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
    92					  enum dma_data_direction dir)
    93	{
    94		dmac_map_area(__va(paddr), size, dir);
    95	
    96		if (dir == DMA_FROM_DEVICE)
    97			outer_inv_range(paddr, paddr + size);
    98		else
    99			outer_clean_range(paddr, paddr + size);
   100	}
   101	
   102	static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
   103					  enum dma_data_direction dir)
   104	{
   105		if (dir != DMA_TO_DEVICE) {
   106			outer_inv_range(paddr, paddr + size);
   107			dmac_unmap_area(__va(paddr), size, dir);
   108		}
   109	}
   110	
   111	static dma_addr_t arm_nommu_dma_map_page(struct device *dev, struct page *page,
   112						 unsigned long offset, size_t size,
   113						 enum dma_data_direction dir,
   114						 unsigned long attrs)
   115	{
   116		dma_addr_t handle = page_to_phys(page) + offset;
   117	
   118		__dma_page_cpu_to_dev(handle, size, dir);
   119	
   120		return handle;
   121	}
   122	
   123	static void arm_nommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
   124					     size_t size, enum dma_data_direction dir,
   125					     unsigned long attrs)
   126	{
   127		__dma_page_dev_to_cpu(handle, size, dir);
   128	}
   129	
   130	
   131	static int arm_nommu_dma_map_sg(struct device *dev, struct scatterlist *sgl,
   132					int nents, enum dma_data_direction dir,
   133					unsigned long attrs)
   134	{
   135		int i;
   136		struct scatterlist *sg;
   137	
   138		for_each_sg(sgl, sg, nents, i) {
   139			sg_dma_address(sg) = sg_phys(sg);
   140			sg_dma_len(sg) = sg->length;
   141			__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
   142		}
   143	
   144		return nents;
   145	}
   146	
   147	static void arm_nommu_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
   148					   int nents, enum dma_data_direction dir,
   149					   unsigned long attrs)
   150	{
   151		struct scatterlist *sg;
   152		int i;
   153	
   154		for_each_sg(sgl, sg, nents, i)
   155			__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
   156	}
   157	
   158	static void arm_nommu_dma_sync_single_for_device(struct device *dev,
   159			dma_addr_t handle, size_t size, enum dma_data_direction dir)
   160	{
   161		__dma_page_cpu_to_dev(handle, size, dir);
   162	}
   163	
   164	static void arm_nommu_dma_sync_single_for_cpu(struct device *dev,
   165			dma_addr_t handle, size_t size, enum dma_data_direction dir)
   166	{
   167		__dma_page_cpu_to_dev(handle, size, dir);
   168	}
   169	
   170	static void arm_nommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
   171						     int nents, enum dma_data_direction dir)
   172	{
   173		struct scatterlist *sg;
   174		int i;
   175	
   176		for_each_sg(sgl, sg, nents, i)
   177			__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
   178	}
   179	
   180	static void arm_nommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
   181						  int nents, enum dma_data_direction dir)
   182	{
   183		struct scatterlist *sg;
   184		int i;
   185	
   186		for_each_sg(sgl, sg, nents, i)
   187			__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
   188	}
   189	
   190	const struct dma_map_ops arm_nommu_dma_ops = {
   191		.alloc			= arm_nommu_dma_alloc,
   192		.free			= arm_nommu_dma_free,
   193		.mmap			= arm_nommu_dma_mmap,
   194		.map_page		= arm_nommu_dma_map_page,
   195		.unmap_page		= arm_nommu_dma_unmap_page,
   196		.map_sg			= arm_nommu_dma_map_sg,
   197		.unmap_sg		= arm_nommu_dma_unmap_sg,
   198		.sync_single_for_device	= arm_nommu_dma_sync_single_for_device,
   199		.sync_single_for_cpu	= arm_nommu_dma_sync_single_for_cpu,
   200		.sync_sg_for_device	= arm_nommu_dma_sync_sg_for_device,
   201		.sync_sg_for_cpu	= arm_nommu_dma_sync_sg_for_cpu,
   202	};
   203	EXPORT_SYMBOL(arm_nommu_dma_ops);
   204	
   205	static struct dma_map_ops *arm_nommu_get_dma_map_ops(bool coherent)
   206	{
 > 207		return coherent ? &dma_noop_ops : &arm_nommu_dma_ops;
   208	}
   209	
   210	void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 5897 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/5dbb0bd7/attachment.gz>
