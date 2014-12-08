From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 8 Dec 2014 18:49:08 +1100
Subject: linux-next: manual merge of the xen-tip tree with the arm-soc tree
Message-ID: <20141208184908.27bfd605@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the xen-tip tree got a conflict in
arch/arm/include/asm/dma-mapping.h between commits a3a60f81ee6f
("dma-mapping: replace set_arch_dma_coherent_ops with
arch_setup_dma_ops") and 4bb25789ed28 ("arm: dma-mapping: plumb our
iommu mapping ops into arch_setup_dma_ops") from the arm-soc tree and
commit 3d5391ac6f5e ("arm: introduce is_device_dma_coherent") from the
xen-tip tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

I also neede this merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Dec 2014 18:46:59 +1100
Subject: [PATCH] arm: introduce is_device_dma_coherent merge fix

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mm/dma-mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 09645f00bd17..43064cbe58f9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2058,6 +2058,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	else
 		dma_ops = arm_get_dma_map_ops(coherent);
 
+	dev->archdata.dma_coherent = coherent;
 	set_dma_ops(dev, dma_ops);
 }
 
-- 
2.1.3

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/include/asm/dma-mapping.h
index 9410b7e548fc,e6e3446abdf6..000000000000
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@@ -121,13 -121,20 +121,19 @@@ static inline unsigned long dma_max_pfn
  }
  #define dma_max_pfn(dev) dma_max_pfn(dev)
  
 -static inline int set_arch_dma_coherent_ops(struct device *dev)
 -{
 -	dev->archdata.dma_coherent = true;
 -	set_dma_ops(dev, &arm_coherent_dma_ops);
 -	return 0;
 -}
 -#define set_arch_dma_coherent_ops(dev)	set_arch_dma_coherent_ops(dev)
 +#define arch_setup_dma_ops arch_setup_dma_ops
 +extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 +			       struct iommu_ops *iommu, bool coherent);
 +
 +#define arch_teardown_dma_ops arch_teardown_dma_ops
 +extern void arch_teardown_dma_ops(struct device *dev);
  
+ /* do not use this function in a driver */
+ static inline bool is_device_dma_coherent(struct device *dev)
+ {
+ 	return dev->archdata.dma_coherent;
+ }
+ 
  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
  {
  	unsigned int offset = paddr & ~PAGE_MASK;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/295ecdc6/attachment.sig>
