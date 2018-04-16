From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 16 Apr 2018 16:23:03 +0200
Subject: [PATCH v3 5/7] mmc: sunxi: Move the card power configuration to a
 function
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Message-ID: <138e91cbbe9c5f5de71b76a9e66e76b68c7122f2.1523888566.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to improve readibility and reusability, let's move the card setup
to a small function called by our .set_ios hook.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 3c1ab46cc60a..0165da0d022a 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -888,17 +888,15 @@ static void sunxi_mmc_set_clk(struct sunxi_mmc_host *host, struct mmc_ios *ios)
 	/* Android code had a usleep_range(50000, 55000); here */
 }
 
-static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+static void sunxi_mmc_card_power(struct sunxi_mmc_host *host,
+				 struct mmc_ios *ios)
 {
-	struct sunxi_mmc_host *host = mmc_priv(mmc);
-	u32 rval;
+	struct mmc_host *mmc = host->mmc;
 
-	/* Set the power state */
 	switch (ios->power_mode) {
-	case MMC_POWER_ON:
-		break;
-
 	case MMC_POWER_UP:
+		dev_dbg(mmc_dev(mmc), "Powering card up\n");
+
 		if (!IS_ERR(mmc->supply.vmmc)) {
 			host->ferror = mmc_regulator_set_ocr(mmc,
 							     mmc->supply.vmmc,
@@ -916,25 +914,37 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 			host->vqmmc_enabled = true;
 		}
-
-		host->ferror = sunxi_mmc_init_host(host);
-		if (host->ferror)
-			return;
-
-		dev_dbg(mmc_dev(mmc), "power on!\n");
 		break;
 
 	case MMC_POWER_OFF:
-		dev_dbg(mmc_dev(mmc), "power off!\n");
-		sunxi_mmc_reset_host(host);
+		dev_dbg(mmc_dev(mmc), "Powering card off\n");
+
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
 		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
 			regulator_disable(mmc->supply.vqmmc);
+
 		host->vqmmc_enabled = false;
 		break;
+
+	default:
+		dev_dbg(mmc_dev(mmc), "Ignoring unknown card power state\n");
+		break;
 	}
+}
+
+static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+
+	if (ios->power_mode == MMC_POWER_OFF)
+		sunxi_mmc_reset_host(host);
+
+	sunxi_mmc_card_power(host, ios);
+
+	if (ios->power_mode == MMC_POWER_UP)
+		sunxi_mmc_init_host(host);
 
 	sunxi_mmc_set_bus_width(host, ios->bus_width);
 	sunxi_mmc_set_clk(host, ios);
-- 
git-series 0.9.1
