From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 17 Nov 2015 03:18:42 +0800
Subject: [arm:drm-etnaviv-devel 3/149]
 drivers/staging/etnaviv/etnaviv_iommu.c:53:13: error: conflicting types for
 'pgtable_free'
Message-ID: <201511170340.1q6ZhNK8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
head:   77c57a5498ebe5c85b4a71fbcf800a9140f9a697
commit: b920a1d21ac9c12ddb174daca7d99ab81d791ad6 [3/149] staging: etnaviv: add drm driver
config: tile-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b920a1d21ac9c12ddb174daca7d99ab81d791ad6
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

>> drivers/staging/etnaviv/etnaviv_iommu.c:53:13: error: conflicting types for 'pgtable_free'
   arch/tile/include/asm/pgalloc.h:73:13: note: previous declaration of 'pgtable_free' was here
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_domain_init':
   drivers/staging/etnaviv/etnaviv_iommu.c:96:8: error: 'struct iommu_domain' has no member named 'priv'
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_domain_destroy':
   drivers/staging/etnaviv/etnaviv_iommu.c:102:54: error: 'struct iommu_domain' has no member named 'priv'
   drivers/staging/etnaviv/etnaviv_iommu.c:107:8: error: 'struct iommu_domain' has no member named 'priv'
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_map':
   drivers/staging/etnaviv/etnaviv_iommu.c:113:54: error: 'struct iommu_domain' has no member named 'priv'
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_unmap':
   drivers/staging/etnaviv/etnaviv_iommu.c:128:54: error: 'struct iommu_domain' has no member named 'priv'
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_iova_to_phys':
   drivers/staging/etnaviv/etnaviv_iommu.c:143:54: error: 'struct iommu_domain' has no member named 'priv'
   drivers/staging/etnaviv/etnaviv_iommu.c: At top level:
   drivers/staging/etnaviv/etnaviv_iommu.c:149:3: error: unknown field 'domain_init' specified in initializer
   drivers/staging/etnaviv/etnaviv_iommu.c:149:3: error: initialization from incompatible pointer type
   drivers/staging/etnaviv/etnaviv_iommu.c:149:3: error: (near initialization for 'etnaviv_iommu_ops.capable')
   drivers/staging/etnaviv/etnaviv_iommu.c:150:3: error: unknown field 'domain_destroy' specified in initializer
   drivers/staging/etnaviv/etnaviv_iommu.c:150:3: error: initialization from incompatible pointer type
   drivers/staging/etnaviv/etnaviv_iommu.c:150:3: error: (near initialization for 'etnaviv_iommu_ops.domain_alloc')
   drivers/staging/etnaviv/etnaviv_iommu.c: In function 'etnaviv_iommu_domain_alloc':
   drivers/staging/etnaviv/etnaviv_iommu.c:169:19: error: 'const struct iommu_ops' has no member named 'domain_init'
   drivers/staging/etnaviv/etnaviv_iommu.c:174:25: error: 'struct iommu_domain' has no member named 'priv'
   cc1: all warnings being treated as errors

vim +/pgtable_free +53 drivers/staging/etnaviv/etnaviv_iommu.c

    47		if (!pgtable->pgtable)
    48			return -ENOMEM;
    49	
    50		return 0;
    51	}
    52	
  > 53	static void pgtable_free(struct etnaviv_iommu_domain_pgtable *pgtable,
    54				 size_t size)
    55	{
    56		dma_free_coherent(NULL, size, pgtable->pgtable, pgtable->paddr);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 41456 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/e5f84ecc/attachment-0001.obj>
