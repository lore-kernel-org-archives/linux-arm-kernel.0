From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Feb 2016 10:47:30 +0530
Subject: [PATCH v2 2/4] iommu/arm-smmu: Invoke DT probe from
 arm_smmu_of_setup()
In-Reply-To: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1454908652-15317-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMMUv1/SMMUv2 driver is initialized very early using the
IOMMU_OF_DECLARE() but the actual platform device is probed
via normal DT probing.

This patch uses of_platform_device_create() from arm_smmu_of_setup()
to ensure that SMMU platform device is probed immediately.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2c8f871..02cd67d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -40,6 +40,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -1956,10 +1957,15 @@ static int __init arm_smmu_init(void)
 
 static int __init arm_smmu_of_setup(struct device_node *np)
 {
+	struct platform_device *pdev;
 
 	if (!init_done)
 		arm_smmu_init();
 
+	pdev = of_platform_device_create(np, NULL, NULL);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
 	of_iommu_set_ops(np, &arm_smmu_ops);
 
 	return 0;
-- 
1.9.1
