From: lkp@intel.com (kbuild test robot)
Date: Fri, 27 Apr 2018 05:00:07 +0800
Subject: [PATCH 3/4] ARM: dma-mapping: Implement arch_iommu_detach_device()
In-Reply-To: <20180425091815.16264-3-thierry.reding@gmail.com>
References: <20180425091815.16264-3-thierry.reding@gmail.com>
Message-ID: <201804270211.gKsBUvoQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc2 next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Thierry-Reding/drm-nouveau-tegra-Detach-from-ARM-DMA-IOMMU-mapping/20180426-140854
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   arch/arm/mm/dma-mapping.c: In function 'arch_iommu_detach_device':
>> arch/arm/mm/dma-mapping.c:2380:12: error: implicit declaration of function 'arm_get_dma_map_ops'; did you mean 'arm_get_iommu_dma_map_ops'? [-Werror=implicit-function-declaration]
     dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
               ^~~~~~~~~~~~~~~~~~~
               arm_get_iommu_dma_map_ops
>> arch/arm/mm/dma-mapping.c:2380:10: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
             ^
   arch/arm/mm/dma-mapping.c: At top level:
>> arch/arm/mm/dma-mapping.c:2402:34: error: conflicting types for 'arm_get_dma_map_ops'
    static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
                                     ^~~~~~~~~~~~~~~~~~~
   arch/arm/mm/dma-mapping.c:2380:12: note: previous implicit declaration of 'arm_get_dma_map_ops' was here
     dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
               ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +2380 arch/arm/mm/dma-mapping.c

  2368	
  2369	void arch_iommu_detach_device(struct device *dev)
  2370	{
  2371		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
  2372		const struct dma_map_ops *dma_ops;
  2373	
  2374		if (!mapping)
  2375			return;
  2376	
  2377		arm_iommu_release_mapping(mapping);
  2378		arm_iommu_detach_device(dev);
  2379	
> 2380		dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
  2381		set_dma_ops(dev, dma_ops);
  2382	}
  2383	
  2384	#else
  2385	
  2386	static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
  2387					    const struct iommu_ops *iommu)
  2388	{
  2389		return false;
  2390	}
  2391	
  2392	static void arm_teardown_iommu_dma_ops(struct device *dev) { }
  2393	
  2394	#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
  2395	
  2396	void arch_iommu_detach_device(struct device *dev)
  2397	{
  2398	}
  2399	
  2400	#endif	/* CONFIG_ARM_DMA_USE_IOMMU */
  2401	
> 2402	static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
  2403	{
  2404		return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
  2405	}
  2406	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33598 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180427/3a09a331/attachment-0001.gz>
