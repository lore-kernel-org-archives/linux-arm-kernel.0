From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 28 Jun 2016 16:48:28 +0100
Subject: [PATCH v3 9/9] iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
In-Reply-To: <cover.1467123945.git.robin.murphy@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
Message-ID: <9f731605877ae85aaaac98a614882be7186d0843.1467123945.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the SMMUv3 equivalent of d346180e70b9 ("iommu/arm-smmu: Treat
all device transactions as unprivileged"), so that once again those
pesky DMA controllers with their privileged instruction fetches don't
unexpectedly fault in stage 1 domains due to VMSAv8 rules.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: New.

 drivers/iommu/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 735690e03818..e4c3916efba9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -263,6 +263,9 @@
 #define STRTAB_STE_1_SHCFG_INCOMING	1UL
 #define STRTAB_STE_1_SHCFG_SHIFT	44
 
+#define STRTAB_STE_1_PRIVCFG_UNPRIV	2UL
+#define STRTAB_STE_1_PRIVCFG_SHIFT	48
+
 #define STRTAB_STE_2_S2VMID_SHIFT	0
 #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
 #define STRTAB_STE_2_VTCR_SHIFT		32
@@ -1070,7 +1073,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 #ifdef CONFIG_PCI_ATS
 			 STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT |
 #endif
-			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
+			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT |
+			 STRTAB_STE_1_PRIVCFG_UNPRIV <<
+			 STRTAB_STE_1_PRIVCFG_SHIFT);
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
-- 
2.8.1.dirty
