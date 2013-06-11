From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 11 Jun 2013 13:30:28 +0200
Subject: [PATCH v3 3/7] mmc: dw_mmc-pltfm: move probe and remove below dt
 match table
In-Reply-To: <201306111328.52679.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
Message-ID: <201306111330.28759.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a subsquent patch probe will need to do some handling of data from
the dt match table. So to prevent the need for forward declarations,
move probe and remove below the match table.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 0048da8..9b05381 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -63,20 +63,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
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
@@ -118,6 +104,20 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
 
+static int dw_mci_pltfm_probe(struct platform_device *pdev)
+{
+	return dw_mci_pltfm_register(pdev, NULL);
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
