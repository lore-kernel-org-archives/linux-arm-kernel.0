From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 17 Nov 2015 02:30:06 +0800
Subject: [arm:drm-etnaviv-devel 3/149]
 drivers/staging/etnaviv/etnaviv_iommu.c:96:8: error: 'struct iommu_domain'
 has no member named 'priv'
Message-ID: <201511170205.1DddFiK9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
head:   77c57a5498ebe5c85b4a71fbcf800a9140f9a697
commit: b920a1d21ac9c12ddb174daca7d99ab81d791ad6 [3/149] staging: etnaviv: add drm driver
config: i386-randconfig-r0-201546 (attached as .config)
reproduce:
        git checkout b920a1d21ac9c12ddb174daca7d99ab81d791ad6
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the arm/drm-etnaviv-devel HEAD 77c57a5498ebe5c85b4a71fbcf800a9140f9a697 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_domain_init':
>> drivers/staging/etnaviv/etnaviv_iommu.c:96:8: error: 'struct iommu_domain' has no member named 'priv'
     domain->priv = etnaviv_domain;
           ^
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_domain_destroy':
   drivers/staging/etnaviv/etnaviv_iommu.c:102:54: error: 'struct iommu_domain' has no member named 'priv'
     struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
                                                         ^
   drivers/staging/etnaviv/etnaviv_iommu.c:107:8: error: 'struct iommu_domain' has no member named 'priv'
     domain->priv = NULL;
           ^
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_map':
   drivers/staging/etnaviv/etnaviv_iommu.c:113:54: error: 'struct iommu_domain' has no member named 'priv'
     struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
                                                         ^
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_unmap':
   drivers/staging/etnaviv/etnaviv_iommu.c:128:54: error: 'struct iommu_domain' has no member named 'priv'
     struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
                                                         ^
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_iova_to_phys':
   drivers/staging/etnaviv/etnaviv_iommu.c:143:54: error: 'struct iommu_domain' has no member named 'priv'
     struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
                                                         ^
   drivers/staging/etnaviv/etnaviv_iommu.c: At top level:
>> drivers/staging/etnaviv/etnaviv_iommu.c:149:3: error: unknown field 'domain_init' specified in initializer
      .domain_init = etnaviv_iommu_domain_init,
      ^
>> drivers/staging/etnaviv/etnaviv_iommu.c:149:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
      .domain_init = etnaviv_iommu_domain_init,
                     ^
   drivers/staging/etnaviv/etnaviv_iommu.c:149:18: note: (near initialization for 'etnaviv_iommu_ops.capable')
>> drivers/staging/etnaviv/etnaviv_iommu.c:150:3: error: unknown field 'domain_destroy' specified in initializer
      .domain_destroy = etnaviv_iommu_domain_destroy,
      ^
   drivers/staging/etnaviv/etnaviv_iommu.c:150:21: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
      .domain_destroy = etnaviv_iommu_domain_destroy,
                        ^
   drivers/staging/etnaviv/etnaviv_iommu.c:150:21: note: (near initialization for 'etnaviv_iommu_ops.domain_alloc')
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_domain_alloc':
>> drivers/staging/etnaviv/etnaviv_iommu.c:169:19: error: 'const struct iommu_ops' has no member named 'domain_init'
     ret = domain->ops->domain_init(domain);
                      ^
   drivers/staging/etnaviv/etnaviv_iommu.c:174:25: error: 'struct iommu_domain' has no member named 'priv'
     etnaviv_domain = domain->priv;
                            ^
   cc1: all warnings being treated as errors

vim +96 drivers/staging/etnaviv/etnaviv_iommu.c

    90		if (ret < 0) {
    91			kfree(etnaviv_domain);
    92			return ret;
    93		}
    94	
    95		spin_lock_init(&etnaviv_domain->map_lock);
  > 96		domain->priv = etnaviv_domain;
    97		return 0;
    98	}
    99	
   100	static void etnaviv_iommu_domain_destroy(struct iommu_domain *domain)
   101	{
   102		struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
   103	
   104		pgtable_free(&etnaviv_domain->pgtable, PT_SIZE);
   105	
   106		kfree(etnaviv_domain);
   107		domain->priv = NULL;
   108	}
   109	
   110	static int etnaviv_iommu_map(struct iommu_domain *domain, unsigned long iova,
   111		   phys_addr_t paddr, size_t size, int prot)
   112	{
   113		struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
   114	
   115		if (size != SZ_4K)
   116			return -EINVAL;
   117	
   118		spin_lock(&etnaviv_domain->map_lock);
   119		pgtable_write(&etnaviv_domain->pgtable, iova, paddr);
   120		spin_unlock(&etnaviv_domain->map_lock);
   121	
   122		return 0;
   123	}
   124	
   125	static size_t etnaviv_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
   126		     size_t size)
   127	{
 > 128		struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
   129	
   130		if (size != SZ_4K)
   131			return -EINVAL;
   132	
   133		spin_lock(&etnaviv_domain->map_lock);
   134		pgtable_write(&etnaviv_domain->pgtable, iova, ~0);
   135		spin_unlock(&etnaviv_domain->map_lock);
   136	
   137		return 0;
   138	}
   139	
   140	static phys_addr_t etnaviv_iommu_iova_to_phys(struct iommu_domain *domain,
   141		dma_addr_t iova)
   142	{
 > 143		struct etnaviv_iommu_domain *etnaviv_domain = domain->priv;
   144	
   145		return pgtable_read(&etnaviv_domain->pgtable, iova);
   146	}
   147	
   148	static struct iommu_ops etnaviv_iommu_ops = {
 > 149			.domain_init = etnaviv_iommu_domain_init,
 > 150			.domain_destroy = etnaviv_iommu_domain_destroy,
   151			.map = etnaviv_iommu_map,
   152			.unmap = etnaviv_iommu_unmap,
   153			.iova_to_phys = etnaviv_iommu_iova_to_phys,
   154			.pgsize_bitmap = SZ_4K,
   155	};
   156	
   157	struct iommu_domain *etnaviv_iommu_domain_alloc(struct etnaviv_gpu *gpu)
   158	{
   159		struct iommu_domain *domain;
   160		struct etnaviv_iommu_domain *etnaviv_domain;
   161		int ret;
   162	
   163		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
   164		if (!domain)
   165			return NULL;
   166	
   167		domain->ops = &etnaviv_iommu_ops;
   168	
 > 169		ret = domain->ops->domain_init(domain);
   170		if (ret)
   171			goto out_free;
   172	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22037 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/63299304/attachment-0001.obj>
