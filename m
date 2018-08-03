From: jolly.shah@xilinx.com (Jolly Shah)
Date: Fri, 3 Aug 2018 10:53:28 -0700
Subject: [PATCH v11 11/11] firmware: xilinx: Replace init call with probe
 method
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
Message-ID: <1533318808-10781-12-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

As of all of child of ZynqMP firmware are platform
driver, there is no need of init call in firmware
driver. Earlier clock driver was init method so
firmware driver had to use init call to make sure
firmware init is done in early stage.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 63 ++++++++++++----------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf0..ce6c746 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -476,50 +476,17 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static const struct of_device_id zynqmp_firmware_of_match[] = {
-	{.compatible = "xlnx,zynqmp-firmware"},
-	{},
-};
-MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
-
-static struct platform_driver zynqmp_firmware_driver = {
-	.driver = {
-		.name = "zynqmp_firmware",
-		.of_match_table = zynqmp_firmware_of_match,
-	},
-	.probe = zynqmp_firmware_probe,
-};
-module_platform_driver(zynqmp_firmware_driver);
-
-static int __init zynqmp_plat_init(void)
-{
-	int ret;
 	struct device_node *np;
+	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
 	if (!np)
 		return 0;
 	of_node_put(np);
 
-	/*
-	 * We're running on a ZynqMP machine,
-	 * the zynqmp-firmware node is mandatory.
-	 */
-	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
-	if (!np) {
-		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
-		return -ENXIO;
-	}
-
-	ret = get_set_conduit_method(np);
-	if (ret) {
-		of_node_put(np);
+	ret = get_set_conduit_method(dev->of_node);
+	if (ret)
 		return ret;
-	}
 
 	/* Check PM API version number */
 	zynqmp_pm_get_api_version(&pm_api_version);
@@ -547,16 +514,22 @@ static int __init zynqmp_plat_init(void)
 	pr_info("%s Trustzone version v%d.%d\n", __func__,
 		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
 
-	of_node_put(np);
+	zynqmp_pm_api_debugfs_init();
 
-	return ret;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
-early_initcall(zynqmp_plat_init);
 
-static int zynqmp_firmware_init(void)
-{
-	zynqmp_pm_api_debugfs_init();
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
 
-	return 0;
-}
-device_initcall(zynqmp_firmware_init);
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+};
+module_platform_driver(zynqmp_firmware_driver);
-- 
2.7.4
