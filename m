From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 3 Jun 2013 00:59:03 +0200
Subject: [PATCH 06/10] mmc: dw_mmc-pltfm: add Rockchip variant
In-Reply-To: <201306030055.15413.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
Message-ID: <201306030059.03783.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mmc
controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
always be set.

There also seem to be no other modifications (additional register etc)
present, so to keep the footprint low, add this small variant to the
pltfm driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   48 +++++++++++++++++++++++++++-----------
 1 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 0048da8..7d041b5 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -24,6 +24,16 @@
 
 #include "dw_mmc.h"
 
+
+static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
+{
+	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
+}
+
+static const struct dw_mci_drv_data rockchip_drv_data = {
+	.prepare_command	= dw_mci_rockchip_prepare_command,
+};
+
 int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data)
 {
@@ -63,20 +73,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
-static int dw_mci_pltfm_probe(struct platform_device *pdev)
-{
-	return dw_mci_pltfm_register(pdev, NULL);
-}
-
-int dw_mci_pltfm_remove(struct platform_device *pdev)
-{
-	struct dw_mci *host = platform_get_drvdata(pdev);
-
-	dw_mci_remove(host);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
-
 #ifdef CONFIG_PM_SLEEP
 /*
  * TODO: we should probably disable the clock to the card in the suspend path.
@@ -114,10 +110,34 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
 
 static const struct of_device_id dw_mci_pltfm_match[] = {
 	{ .compatible = "snps,dw-mshc", },
+	{ .compatible = "rockchip,cortex-a9-dw-mshc",
+		.data = &rockchip_drv_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
 
+static int dw_mci_pltfm_probe(struct platform_device *pdev)
+{
+	const struct dw_mci_drv_data *drv_data = NULL;
+	const struct of_device_id *match;
+
+	if (pdev->dev.of_node) {
+		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
+		drv_data = match->data;
+	}
+
+	return dw_mci_pltfm_register(pdev, drv_data);
+}
+
+int dw_mci_pltfm_remove(struct platform_device *pdev)
+{
+	struct dw_mci *host = platform_get_drvdata(pdev);
+
+	dw_mci_remove(host);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
+
 static struct platform_driver dw_mci_pltfm_driver = {
 	.probe		= dw_mci_pltfm_probe,
 	.remove		= dw_mci_pltfm_remove,
-- 
1.7.2.3
