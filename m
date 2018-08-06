From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Mon, 6 Aug 2018 20:27:04 +0800
Subject: [PATCH v4 5/5] iommu/arm-smmu-v3: add bootup option "arm_iommu"
In-Reply-To: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1533558424-16748-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a bootup option to make the system manager can choose which mode to
be used. The default mode is strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 drivers/iommu/arm-smmu-v3.c                     | 17 ++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c..426e989 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1720,6 +1720,15 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.

+	arm_iommu=	[ARM64]
+		non-strict	[Default Off]
+			Put off TLBs invalidation and release memory first.
+			It's good for scatter-gather performance but lacks full
+			isolation, an untrusted device can access the reused
+			memory because the TLBs may still valid. Please take
+			full consideration before choosing this mode.
+			Note that, VFIO will always use strict mode.
+
 	iommu.passthrough=
 			[ARM64] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 904bc1e..9a30892 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -631,6 +631,21 @@ struct arm_smmu_option_prop {
 	{ 0, NULL},
 };

+static u32 smmu_non_strict __read_mostly;
+
+static int __init arm_smmu_setup(char *str)
+{
+	if (!strncmp(str, "non-strict", 10)) {
+		smmu_non_strict = 1;
+		pr_warn("WARNING: iommu non-strict mode is chosen.\n"
+			"It's good for scatter-gather performance but lacks full isolation\n");
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+	}
+
+	return 0;
+}
+early_param("arm_iommu", arm_smmu_setup);
+
 static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
 						 struct arm_smmu_device *smmu)
 {
@@ -1622,7 +1637,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;

-	if (domain->type == IOMMU_DOMAIN_DMA) {
+	if ((domain->type == IOMMU_DOMAIN_DMA) && smmu_non_strict) {
 		domain->non_strict = 1;
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 	}
--
1.8.3
