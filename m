From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu,  8 Mar 2018 15:52:50 +0100
Subject: [PATCH v2 4/8] mmc: sunxi: Move the power up action in a separate
 function
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Message-ID: <81323d51de103251658535c4c787d687316395c7.1520520655.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'll need to have the power up behaviour in order to implement runtime_pm.
Move it outside of the .set_ios callback for an easier access.

And it improves readibility as a bonus.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 60 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 4e81fe171532..e4b44c4adb8f 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -888,6 +888,37 @@ static void sunxi_mmc_power_on(struct mmc_host *mmc, struct mmc_ios *ios)
 	/* Android code had a usleep_range(50000, 55000); here */
 }
 
+static void sunxi_mmc_power_up(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+
+	dev_dbg(mmc_dev(mmc), "Powering up\n");
+
+	if (!IS_ERR(mmc->supply.vmmc)) {
+		host->ferror = mmc_regulator_set_ocr(mmc,
+						     mmc->supply.vmmc,
+						     ios->vdd);
+		if (host->ferror)
+			return;
+	}
+
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		host->ferror = regulator_enable(mmc->supply.vqmmc);
+		if (host->ferror) {
+			dev_err(mmc_dev(mmc),
+				"failed to enable vqmmc\n");
+			return;
+		}
+		host->vqmmc_enabled = true;
+	}
+
+	host->ferror = sunxi_mmc_init_host(mmc);
+	if (host->ferror)
+		return;
+
+	sunxi_mmc_power_on(mmc, ios);
+}
+
 static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -906,45 +937,20 @@ static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct sunxi_mmc_host *host = mmc_priv(mmc);
-
 	/* Set the power state */
 	switch (ios->power_mode) {
 	case MMC_POWER_ON:
+		sunxi_mmc_power_on(mmc, ios);
 		break;
 
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc)) {
-			host->ferror = mmc_regulator_set_ocr(mmc,
-							     mmc->supply.vmmc,
-							     ios->vdd);
-			if (host->ferror)
-				return;
-		}
-
-		if (!IS_ERR(mmc->supply.vqmmc)) {
-			host->ferror = regulator_enable(mmc->supply.vqmmc);
-			if (host->ferror) {
-				dev_err(mmc_dev(mmc),
-					"failed to enable vqmmc\n");
-				return;
-			}
-			host->vqmmc_enabled = true;
-		}
-
-		host->ferror = sunxi_mmc_init_host(mmc);
-		if (host->ferror)
-			return;
-
-		dev_dbg(mmc_dev(mmc), "power on!\n");
+		sunxi_mmc_power_up(mmc, ios);
 		break;
 
 	case MMC_POWER_OFF:
 		sunxi_mmc_power_off(mmc, ios);
 		break;
 	}
-
-	sunxi_mmc_power_on(mmc, ios);
 }
 
 static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
git-series 0.9.1
