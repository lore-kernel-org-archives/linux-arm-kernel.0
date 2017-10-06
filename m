From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri,  6 Oct 2017 14:31:50 +0100
Subject: [RFCv2 PATCH 23/36] iommu/arm-smmu-v3: Share process page tables
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Message-ID: <20171006133203.22803-24-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy the content of TCR, MAIR and TTBR of a given task into a context
descriptor.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c86a1182c137..293f260782c2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -43,6 +43,7 @@
 #include <linux/amba/bus.h>
 
 #include "io-pgtable.h"
+#include "io-pgtable-arm.h"
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -2170,13 +2171,46 @@ static int arm_smmu_process_init_pgtable(struct arm_smmu_process *smmu_process,
 					 struct mm_struct *mm)
 {
 	int asid;
+	unsigned long tcr;
+	unsigned long reg, par;
+	struct arm_smmu_ctx_desc *cfg = &smmu_process->ctx_desc;
 
 	asid = mm_context_get(mm);
 	if (!asid)
 		return -ENOSPC;
 
-	smmu_process->ctx_desc.asid = asid;
-	/* TODO: init the rest */
+	tcr = TCR_T0SZ(VA_BITS) | TCR_IRGN0_WBWA | TCR_ORGN0_WBWA |
+		TCR_SH0_INNER | ARM_LPAE_TCR_EPD1;
+
+	switch (PAGE_SIZE) {
+		case SZ_4K:
+			tcr |= TCR_TG0_4K;
+			break;
+		case SZ_16K:
+			tcr |= TCR_TG0_16K;
+			break;
+		case SZ_64K:
+			tcr |= TCR_TG0_64K;
+			break;
+		default:
+			WARN_ON(1);
+			return -EFAULT;
+	}
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
+
+	tcr |= TCR_TBI0;
+
+	cfg->asid       = asid;
+	cfg->ttbr       = virt_to_phys(mm->pgd);
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cfg->mair       = read_sysreg(mair_el1);
+	cfg->tcr        = tcr;
 
 	return 0;
 }
-- 
2.13.3
