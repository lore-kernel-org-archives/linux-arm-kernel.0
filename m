From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 12 Dec 2014 16:41:03 +0800
Subject: [PATCH 1/1] iommu/arm-smmu: modify the calculation of PASize and SEP
 fields
Message-ID: <1418373663-9124-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. the calculation appear 3 times, it's good to define a function.
2. VA_BITS is dynamic determined by CONFIG_ARM64_VA_BITS yet, but current
   switch..case can not cover all possible values.
3. change TTBCR2_ADDR_xx to ADDR_SIZE_xx, because it's not only TTBCR2 use it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu.c | 104 ++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 70 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f7..968ca76 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -290,12 +290,12 @@
 #define TTBCR2_PASIZE_MASK		0x7

 /* Common definitions for PASize and SEP fields */
-#define TTBCR2_ADDR_32			0
-#define TTBCR2_ADDR_36			1
-#define TTBCR2_ADDR_40			2
-#define TTBCR2_ADDR_42			3
-#define TTBCR2_ADDR_44			4
-#define TTBCR2_ADDR_48			5
+#define ADDR_SIZE_32			0
+#define ADDR_SIZE_36			1
+#define ADDR_SIZE_40			2
+#define ADDR_SIZE_42			3
+#define ADDR_SIZE_44			4
+#define ADDR_SIZE_48			5

 #define TTBRn_HI_ASID_SHIFT		16

@@ -727,6 +727,30 @@ static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
 	}
 }

+static u32 size_to_field(unsigned long size, int shift)
+{
+	u32 val;
+
+	/*
+	 * 0b000 32-bits (<=32)
+	 * 0b001 36-bits (33,34,35,36)
+	 * 0b010 40-bits (37,38,39,40)
+	 * 0b011 42-bits (41,42)
+	 * 0b100 44-bits (43,44)
+	 * 0b101 48-bits (>=45)
+	 */
+	if (size <= 32)
+		val = ADDR_SIZE_32;
+	else if (size <= 40)
+		val = ((size - 33) >> 2) + ADDR_SIZE_36;
+	else if (size <= 44)
+		val = ((size - 41) >> 1) + ADDR_SIZE_42;
+	else
+		val = ADDR_SIZE_48;
+
+	return val << shift;
+}
+
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 {
 	u32 reg;
@@ -768,49 +792,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 			       gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));

 		/* TTBCR2 */
-		switch (smmu->s1_input_size) {
-		case 32:
-			reg = (TTBCR2_ADDR_32 << TTBCR2_SEP_SHIFT);
-			break;
-		case 36:
-			reg = (TTBCR2_ADDR_36 << TTBCR2_SEP_SHIFT);
-			break;
-		case 39:
-		case 40:
-			reg = (TTBCR2_ADDR_40 << TTBCR2_SEP_SHIFT);
-			break;
-		case 42:
-			reg = (TTBCR2_ADDR_42 << TTBCR2_SEP_SHIFT);
-			break;
-		case 44:
-			reg = (TTBCR2_ADDR_44 << TTBCR2_SEP_SHIFT);
-			break;
-		case 48:
-			reg = (TTBCR2_ADDR_48 << TTBCR2_SEP_SHIFT);
-			break;
-		}
-
-		switch (smmu->s1_output_size) {
-		case 32:
-			reg |= (TTBCR2_ADDR_32 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 36:
-			reg |= (TTBCR2_ADDR_36 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 39:
-		case 40:
-			reg |= (TTBCR2_ADDR_40 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 42:
-			reg |= (TTBCR2_ADDR_42 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 44:
-			reg |= (TTBCR2_ADDR_44 << TTBCR2_PASIZE_SHIFT);
-			break;
-		case 48:
-			reg |= (TTBCR2_ADDR_48 << TTBCR2_PASIZE_SHIFT);
-			break;
-		}
+		reg  = size_to_field(smmu->s1_input_size, TTBCR2_SEP_SHIFT);
+		reg |= size_to_field(smmu->s1_output_size, TTBCR2_PASIZE_SHIFT);

 		if (stage1)
 			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR2);
@@ -838,27 +821,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)

 		if (!stage1) {
 			reg |= (64 - smmu->s2_input_size) << TTBCR_T0SZ_SHIFT;
-
-			switch (smmu->s2_output_size) {
-			case 32:
-				reg |= (TTBCR2_ADDR_32 << TTBCR_PASIZE_SHIFT);
-				break;
-			case 36:
-				reg |= (TTBCR2_ADDR_36 << TTBCR_PASIZE_SHIFT);
-				break;
-			case 40:
-				reg |= (TTBCR2_ADDR_40 << TTBCR_PASIZE_SHIFT);
-				break;
-			case 42:
-				reg |= (TTBCR2_ADDR_42 << TTBCR_PASIZE_SHIFT);
-				break;
-			case 44:
-				reg |= (TTBCR2_ADDR_44 << TTBCR_PASIZE_SHIFT);
-				break;
-			case 48:
-				reg |= (TTBCR2_ADDR_48 << TTBCR_PASIZE_SHIFT);
-				break;
-			}
+			reg |= size_to_field(smmu->s2_output_size,
+							TTBCR_PASIZE_SHIFT);
 		} else {
 			reg |= (64 - smmu->s1_input_size) << TTBCR_T0SZ_SHIFT;
 		}
--
1.8.0
