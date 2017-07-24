From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 21:58:59 +0800
Subject: [PATCH v3 04/10] mmc: sunxi: Support controllers that can use both
 old and new timings
In-Reply-To: <20170724135905.28855-1-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
Message-ID: <20170724135905.28855-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the SoCs that introduced the new timing mode for MMC controllers,
both the old (where the clock delays are set in the CCU) and new
(where the clock delays are set in the MMC controller) timing modes
are available, and we have to support them both. However there are
two bits that control which mode is active. One is in the CCU, the
other is in the MMC controller. The settings on both sides must be
the same, or nothing will work.

The sunxi-ng clock driver provides an API to query and set the
active timing mode. At probe time, we try to set the active mode
to the "new timing mode". If it succeeds, we can then use the MMC
controller in the new mode. If not, we fall back to the old mode.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 45 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 0fb4e4c119e1..c8a60e43dc43 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 
 #include <linux/clk.h>
+#include <linux/clk/sunxi-ng.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -259,7 +260,11 @@ struct sunxi_mmc_cfg {
 	/* Does DATA0 needs to be masked while the clock is updated */
 	bool mask_data0;
 
+	/* hardware only supports new timing mode */
 	bool needs_new_timings;
+
+	/* hardware can switch between old and new timing modes */
+	bool has_timings_switch;
 };
 
 struct sunxi_mmc_host {
@@ -293,6 +298,9 @@ struct sunxi_mmc_host {
 
 	/* vqmmc */
 	bool		vqmmc_enabled;
+
+	/* timings */
+	bool		use_new_timings;
 };
 
 static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
@@ -714,7 +722,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 {
 	int index;
 
-	if (!host->cfg->clk_delays)
+	if (host->use_new_timings)
 		return 0;
 
 	/* determine delays */
@@ -765,6 +773,15 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	    ios->bus_width == MMC_BUS_WIDTH_8)
 		clock <<= 1;
 
+	if (host->use_new_timings) {
+		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
+		if (ret) {
+			dev_err(mmc_dev(mmc),
+				"error setting new timing mode\n");
+			return ret;
+		}
+	}
+
 	rate = clk_round_rate(host->clk_mmc, clock);
 	if (rate < 0) {
 		dev_err(mmc_dev(mmc), "error rounding clk to %d: %ld\n",
@@ -793,7 +810,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	}
 	mmc_writel(host, REG_CLKCR, rval);
 
-	if (host->cfg->needs_new_timings) {
+	if (host->use_new_timings) {
 		/* Don't touch the delay bits */
 		rval = mmc_readl(host, REG_SD_NTSR);
 		rval |= SDXC_2X_TIMING_MODE;
@@ -1262,6 +1279,30 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 		goto error_free_host;
 	}
 
+	if (host->cfg->has_timings_switch) {
+		/*
+		 * Supports both old and new timing modes.
+		 * Try setting the clk to new timing mode.
+		 */
+		sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
+
+		/* And check the result */
+		ret = sunxi_ccu_get_mmc_timing_mode(host->clk_mmc);
+		if (ret < 0) {
+			/*
+			 * For whatever reason we were not able to get
+			 * the current active mode. Default to old mode.
+			 */
+			dev_warn(&pdev->dev, "MMC clk timing mode unknown\n");
+			host->use_new_timings = false;
+		} else {
+			host->use_new_timings = !!ret;
+		}
+	} else if (host->cfg->needs_new_timings) {
+		/* Supports new timing mode only */
+		host->use_new_timings = true;
+	}
+
 	mmc->ops		= &sunxi_mmc_ops;
 	mmc->max_blk_count	= 8192;
 	mmc->max_blk_size	= 4096;
-- 
2.13.3
