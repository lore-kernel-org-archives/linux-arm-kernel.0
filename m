From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu,  8 Mar 2018 15:52:48 +0100
Subject: [PATCH v2 2/8] mmc: sunxi: Move the power off action in a separate
 function
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Message-ID: <bd3c692c488e0e3ee8f4cc169980a74384717ec2.1520520655.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'll need to have the power off behaviour in order to implement
runtime_pm. Move it outside of the .set_ios callback for an easier access.

And it improves readibility as a bonus.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index f9723797a9f8..a53e39d8b07e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -855,6 +855,22 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	return 0;
 }
 
+static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+
+	dev_dbg(mmc_dev(mmc), "Powering off\n");
+
+	sunxi_mmc_reset_host(host);
+	if (!IS_ERR(mmc->supply.vmmc))
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+	if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
+		regulator_disable(mmc->supply.vqmmc);
+
+	host->vqmmc_enabled = false;
+}
+
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -892,14 +908,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_OFF:
-		dev_dbg(mmc_dev(mmc), "power off!\n");
-		sunxi_mmc_reset_host(host);
-		if (!IS_ERR(mmc->supply.vmmc))
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-
-		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
-			regulator_disable(mmc->supply.vqmmc);
-		host->vqmmc_enabled = false;
+		sunxi_mmc_power_off(mmc, ios);
 		break;
 	}
 
-- 
git-series 0.9.1
