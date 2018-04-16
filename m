From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 16 Apr 2018 16:23:05 +0200
Subject: [PATCH v3 7/7] mmc: sunxi: Drop the init / reset of the controller
 from set_ios
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Message-ID: <68af0c20ec99bda4af61d413e5feee75f0577292.1523888566.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our set_ios hook is, when the card is power up or down, either doing a full
init or put our controller back into a reset mode.

Since we're also doing that in our runtime_pm hooks, and at possibly much
more often, we can drop it from the set_ios, and either rely on our
runtime_pm hooks or our probe to do it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 0253deb153a4..97c6b79b7d6f 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -939,14 +939,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
 
-	if (ios->power_mode == MMC_POWER_OFF)
-		sunxi_mmc_reset_host(host);
-
 	sunxi_mmc_card_power(host, ios);
-
-	if (ios->power_mode == MMC_POWER_UP)
-		sunxi_mmc_init_host(host);
-
 	sunxi_mmc_set_bus_width(host, ios->bus_width);
 	sunxi_mmc_set_clk(host, ios);
 }
@@ -1401,6 +1394,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_dma;
 
+	ret = sunxi_mmc_init_host(host);
+	if (ret)
+		goto error_free_dma;
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
git-series 0.9.1
