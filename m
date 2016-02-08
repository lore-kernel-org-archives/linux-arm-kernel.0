From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Feb 2016 10:47:29 +0530
Subject: [PATCH v2 1/4] iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
In-Reply-To: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1454908652-15317-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sricharan R <sricharan@codeaurora.org>

This patch uses IOMMU_OF_DECLARE to register the driver
and the iommu_ops. So when master devices of the iommu are
registered, of_xlate callback can be used to add the master
configurations to the smmu driver.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Tested-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bf1895c..2c8f871 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -265,6 +266,8 @@
 #define FSYNR0_WNR			(1 << 4)
 
 static int force_stage;
+static bool init_done;
+
 module_param_named(force_stage, force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed@a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
@@ -1926,20 +1929,8 @@ static struct platform_driver arm_smmu_driver = {
 
 static int __init arm_smmu_init(void)
 {
-	struct device_node *np;
 	int ret;
 
-	/*
-	 * Play nice with systems that don't have an ARM SMMU by checking that
-	 * an ARM SMMU exists in the system before proceeding with the driver
-	 * and IOMMU bus operation registration.
-	 */
-	np = of_find_matching_node(NULL, arm_smmu_of_match);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
 		return ret;
@@ -1958,15 +1949,33 @@ static int __init arm_smmu_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 #endif
 
+	init_done = true;
+
 	return 0;
 }
 
+static int __init arm_smmu_of_setup(struct device_node *np)
+{
+
+	if (!init_done)
+		arm_smmu_init();
+
+	of_iommu_set_ops(np, &arm_smmu_ops);
+
+	return 0;
+}
+
+IOMMU_OF_DECLARE(arm_smmu_v1, "arm,smmu-v1", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_v2, "arm,smmu-v2", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_400, "arm,mmu-400", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_401, "arm,mmu-401", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_500, "arm,mmu-500", arm_smmu_of_setup);
+
 static void __exit arm_smmu_exit(void)
 {
 	return platform_driver_unregister(&arm_smmu_driver);
 }
 
-subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
-- 
1.9.1
