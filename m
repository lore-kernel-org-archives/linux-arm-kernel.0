From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 23 Dec 2014 13:26:05 +1100
Subject: linux-next: missing merge fix patch for the merge of the xen-tip
 tree with the arm-soc tree
In-Reply-To: <20141208103328.GE27367@arm.com>
References: <20141208184908.27bfd605@canb.auug.org.au>
 <20141208103328.GE27367@arm.com>
Message-ID: <20141223132605.02d81e01@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I have been carrying this merge fix patch for some time that is now
needed in your tree:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Dec 2014 18:46:59 +1100
Subject: [PATCH] arm: introduce is_device_dma_coherent merge fix

The merge of the (linux-next) xen-tip tree got a conflict in
arch/arm/include/asm/dma-mapping.h between commits a3a60f81ee6f
("dma-mapping: replace set_arch_dma_coherent_ops with
arch_setup_dma_ops") and 4bb25789ed28 ("arm: dma-mapping: plumb our
iommu mapping ops into arch_setup_dma_ops") from the arm-soc tree and
commit 3d5391ac6f5e ("arm: introduce is_device_dma_coherent") from the
xen-tip tree.  It was fixed up, but also required this additional fix.

"Looks good to me"-by: Will Deacon <will.deacon@arm.com>
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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141223/6530ebe9/attachment.sig>
