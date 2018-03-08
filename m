From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu,  8 Mar 2018 15:52:49 +0100
Subject: [PATCH v2 3/8] mmc: sunxi: Move the power on action in a separate
 function
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Message-ID: <cff8ee6d63b8e48881fc2c9d81a1a2d383fbbc5f.1520520655.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'll need to have the power on behaviour in order to implement runtime_pm.
Move it outside of the .set_ios callback for an easier access.

And it improves readibility as a bonus.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 62 ++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index a53e39d8b07e..4e81fe171532 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -855,6 +855,39 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	return 0;
 }
 
+static void sunxi_mmc_power_on(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+	u32 rval;
+
+	dev_dbg(mmc_dev(mmc), "Powering on\n");
+
+	/* set bus width */
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_1:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH1);
+		break;
+	case MMC_BUS_WIDTH_4:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH4);
+		break;
+	case MMC_BUS_WIDTH_8:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH8);
+		break;
+	}
+
+	/* set ddr mode */
+	rval = mmc_readl(host, REG_GCTRL);
+	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
+	    ios->timing == MMC_TIMING_MMC_DDR52)
+		rval |= SDXC_DDR_MODE;
+	else
+		rval &= ~SDXC_DDR_MODE;
+	mmc_writel(host, REG_GCTRL, rval);
+
+	host->ferror = sunxi_mmc_clk_set_rate(host, ios);
+	/* Android code had a usleep_range(50000, 55000); here */
+}
+
 static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -874,7 +907,6 @@ static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
-	u32 rval;
 
 	/* Set the power state */
 	switch (ios->power_mode) {
@@ -912,33 +944,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	/* set bus width */
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_1:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH1);
-		break;
-	case MMC_BUS_WIDTH_4:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH4);
-		break;
-	case MMC_BUS_WIDTH_8:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH8);
-		break;
-	}
-
-	/* set ddr mode */
-	rval = mmc_readl(host, REG_GCTRL);
-	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_DDR52)
-		rval |= SDXC_DDR_MODE;
-	else
-		rval &= ~SDXC_DDR_MODE;
-	mmc_writel(host, REG_GCTRL, rval);
-
-	/* set up clock */
-	if (ios->power_mode) {
-		host->ferror = sunxi_mmc_clk_set_rate(host, ios);
-		/* Android code had a usleep_range(50000, 55000); here */
-	}
+	sunxi_mmc_power_on(mmc, ios);
 }
 
 static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
git-series 0.9.1
