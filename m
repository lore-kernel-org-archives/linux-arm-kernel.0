From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Jan 2015 13:54:17 +0000
Subject: [PATCH v2 5/5] iommu: io-pgtable-arm: add non-secure quirk
In-Reply-To: <1420811657-21321-1-git-send-email-will.deacon@arm.com>
References: <1420811657-21321-1-git-send-email-will.deacon@arm.com>
Message-ID: <1420811657-21321-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The quirk causes the Non-Secure bit to be set in all page table entries.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 +++++++
 drivers/iommu/io-pgtable.h     | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 52fb21487f02..5a500edf00cc 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -82,11 +82,13 @@
 #define ARM_LPAE_PTE_TYPE_TABLE		3
 #define ARM_LPAE_PTE_TYPE_PAGE		3
 
+#define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
 #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
 #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
 #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
 #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
 #define ARM_LPAE_PTE_SH_IS		(((arm_lpae_iopte)3) << 8)
+#define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
 #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
 
 #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
@@ -208,6 +210,9 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		return -EEXIST;
 	}
 
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		pte |= ARM_LPAE_PTE_NS;
+
 	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
@@ -251,6 +256,8 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		data->iop.cfg.tlb->flush_pgtable(cptep, 1UL << data->pg_shift,
 						 cookie);
 		pte = __pa(cptep) | ARM_LPAE_PTE_TYPE_TABLE;
+		if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
+			pte |= ARM_LPAE_PTE_NSTABLE;
 		*ptep = pte;
 		data->iop.cfg.tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
 	} else {
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 05c4e593a25f..10e32f69c668 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -43,7 +43,8 @@ struct iommu_gather_ops {
  * @tlb:           TLB management callbacks for this set of tables.
  */
 struct io_pgtable_cfg {
-	int				quirks; /* IO_PGTABLE_QUIRK_* */
+	#define IO_PGTABLE_QUIRK_ARM_NS	(1 << 0)	/* Set NS bit in PTEs */
+	int				quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
 	unsigned int			oas;
-- 
2.1.4
