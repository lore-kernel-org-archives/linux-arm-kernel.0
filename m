From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 11 Aug 2016 17:44:05 +0100
Subject: [PATCH 1/2] iommu/io-pgtable-arm-v7s: Fix attributes when splitting
 blocks
Message-ID: <e1733d2c426f73441abc12a386d23ab2546c536a.1470933167.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the attribute bits being all over the place in the different
types of short-descriptor PTEs, when remapping an existing entry, e.g.
splitting a section into pages, we take the approach of decomposing
the PTE attributes back to the IOMMU API flags to start from scratch.

On inspection, though, the existing code seems to have got the read-only
bit backwards and ignored the XN bit. How embarrassing...

Fortunately the primary user so far, the Mediatek IOMMU, both never
splits blocks (because it only serves non-overlapping DMA API calls) and
also ignores permissions anyway, but let's put things right before any
future users trip up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 8c6139986d7d..def8ca1c982d 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -286,12 +286,14 @@ static int arm_v7s_pte_to_prot(arm_v7s_iopte pte, int lvl)
 	int prot = IOMMU_READ;
 	arm_v7s_iopte attr = pte >> ARM_V7S_ATTR_SHIFT(lvl);
 
-	if (attr & ARM_V7S_PTE_AP_RDONLY)
+	if (!(attr & ARM_V7S_PTE_AP_RDONLY))
 		prot |= IOMMU_WRITE;
 	if ((attr & (ARM_V7S_TEX_MASK << ARM_V7S_TEX_SHIFT)) == 0)
 		prot |= IOMMU_MMIO;
 	else if (pte & ARM_V7S_ATTR_C)
 		prot |= IOMMU_CACHE;
+	if (pte & ARM_V7S_ATTR_XN(lvl))
+		prot |= IOMMU_NOEXEC;
 
 	return prot;
 }
-- 
2.8.1.dirty
