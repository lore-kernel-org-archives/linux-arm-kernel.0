From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 21:59:00 +0800
Subject: [PATCH v3 05/10] mmc: sunxi: Support MMC DDR52 transfer mode with new
 timing mode
In-Reply-To: <20170724135905.28855-1-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
Message-ID: <20170724135905.28855-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC controller can support DDR52 transfers under the new timing
mode. According to the BSP kernel, the module clock has to be double
the card clock, regardless of the bus width. The default timings in
the hardware can be used.

This also reworks the code setting the internal divider, getting rid
of a extra conditional.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c8a60e43dc43..11587a69a1fd 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -755,7 +755,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 {
 	struct mmc_host *mmc = host->mmc;
 	long rate;
-	u32 rval, clock = ios->clock;
+	u32 rval, clock = ios->clock, div = 1;
 	int ret;
 
 	ret = sunxi_mmc_oclk_onoff(host, 0);
@@ -768,10 +768,21 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (!ios->clock)
 		return 0;
 
-	/* 8 bit DDR requires a higher module clock */
+	/*
+	 * Under the old timing mode, 8 bit DDR requires the module
+	 * clock to be double the card clock. Under the new timing
+	 * mode, all DDR modes require a doubled module clock.
+	 *
+	 * We currently only support the standard MMC DDR52 mode.
+	 * This block should be updated once support for other DDR
+	 * modes is added.
+	 */
 	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
-	    ios->bus_width == MMC_BUS_WIDTH_8)
+	    (host->use_new_timings ||
+	     ios->bus_width == MMC_BUS_WIDTH_8)) {
+		div = 2;
 		clock <<= 1;
+	}
 
 	if (host->use_new_timings) {
 		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
@@ -799,15 +810,10 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return ret;
 	}
 
-	/* clear internal divider */
+	/* set internal divider */
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~0xff;
-	/* set internal divider for 8 bit eMMC DDR, so card clock is right */
-	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
-	    ios->bus_width == MMC_BUS_WIDTH_8) {
-		rval |= 1;
-		rate >>= 1;
-	}
+	rval |= div - 1;
 	mmc_writel(host, REG_CLKCR, rval);
 
 	if (host->use_new_timings) {
@@ -838,7 +844,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return ret;
 
 	/* And we just enabled our clock back */
-	mmc->actual_clock = rate;
+	mmc->actual_clock = rate / div;
 
 	return 0;
 }
@@ -1315,7 +1321,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-	if (host->cfg->clk_delays)
+	if (host->cfg->clk_delays || host->use_new_timings)
 		mmc->caps      |= MMC_CAP_1_8V_DDR;
 
 	ret = mmc_of_parse(mmc);
-- 
2.13.3
