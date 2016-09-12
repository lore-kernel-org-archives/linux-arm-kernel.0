From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 12 Sep 2016 17:13:47 +0100
Subject: [PATCH v7 09/22] iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
In-Reply-To: <cover.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Message-ID: <39a127b6729e8d0d51b62e74cdff6df4323b024a.1473695704.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the SMMUv3 equivalent of d346180e70b9 ("iommu/arm-smmu: Treat
all device transactions as unprivileged"), so that once again those
pesky DMA controllers with their privileged instruction fetches don't
unexpectedly fault in stage 1 domains due to VMSAv8 rules.

Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 52860bcf80f2..0c45c1e02e04 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -267,6 +267,9 @@
 #define STRTAB_STE_1_SHCFG_INCOMING	1UL
 #define STRTAB_STE_1_SHCFG_SHIFT	44
 
+#define STRTAB_STE_1_PRIVCFG_UNPRIV	2UL
+#define STRTAB_STE_1_PRIVCFG_SHIFT	48
+
 #define STRTAB_STE_2_S2VMID_SHIFT	0
 #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
 #define STRTAB_STE_2_VTCR_SHIFT		32
@@ -1068,7 +1071,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
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
