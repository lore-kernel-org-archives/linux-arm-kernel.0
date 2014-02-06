From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Feb 2014 18:09:32 +0000
Subject: [PATCH 4/5] iommu/arm-smmu: set CBARn.BPSHCFG to NSH for s1-s2-bypass
 contexts
In-Reply-To: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
Message-ID: <1391710173-4343-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst trying to bring-up an SMMUv2 implementation with the table
walker plumbed into a coherent interconnect, I noticed that the memory
transactions targetting the CPU caches from the SMMU were marked as
outer-shareable instead of inner-shareable.

After a bunch of digging, it seems that we actually need to program
CBARn.BPSHCFG for s1-s2-bypass contexts to act as non-shareable in order
for the shareability configured in the corresponding TTBCR not to be
overridden with an outer-shareable attribute.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 509f01f054d9..0ae4dd39197f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -190,6 +190,9 @@
 #define ARM_SMMU_GR1_CBAR(n)		(0x0 + ((n) << 2))
 #define CBAR_VMID_SHIFT			0
 #define CBAR_VMID_MASK			0xff
+#define CBAR_S1_BPSHCFG_SHIFT		8
+#define CBAR_S1_BPSHCFG_MASK		3
+#define CBAR_S1_BPSHCFG_NSH		3
 #define CBAR_S1_MEMATTR_SHIFT		12
 #define CBAR_S1_MEMATTR_MASK		0xf
 #define CBAR_S1_MEMATTR_WB		0xf
@@ -671,11 +674,16 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	if (smmu->version == 1)
 	      reg |= root_cfg->irptndx << CBAR_IRPTNDX_SHIFT;
 
-	/* Use the weakest memory type, so it is overridden by the pte */
-	if (stage1)
-		reg |= (CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
-	else
+	/*
+	 * Use the weakest shareability/memory types, so they are
+	 * overridden by the ttbcr/pte.
+	 */
+	if (stage1) {
+		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
+			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
+	} else {
 		reg |= ARM_SMMU_CB_VMID(root_cfg) << CBAR_VMID_SHIFT;
+	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(root_cfg->cbndx));
 
 	if (smmu->version > 1) {
-- 
1.8.2.2
