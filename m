From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 30 Jan 2016 01:21:46 +0800
Subject: [PATCH 1/3] mmc: sunxi: Support MMC_DDR52 timing modes
In-Reply-To: <1454088108-2332-1-git-send-email-wens@csie.org>
References: <1454088108-2332-1-git-send-email-wens@csie.org>
Message-ID: <1454088108-2332-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DDR transfer modes include UHS-1 DDR50 and MMC HS-DDR (or MMC_DDR52).
Consider MMC_DDR52 when setting clock delays.

Since MMC high speed mode goes up to 52 MHz instead of 50 MHz for SD,
and this number is visible in the capability macro, increase the
clock rate upper limit to 52 MHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 765dfb9f77ec..fe6c171fd135 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -686,8 +686,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	} else if (rate <= 25000000) {
 		oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
 		sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
-	} else if (rate <= 50000000) {
-		if (ios->timing == MMC_TIMING_UHS_DDR50) {
+	} else if (rate <= 52000000) {
+		if (ios->timing == MMC_TIMING_UHS_DDR50 ||
+		    ios->timing == MMC_TIMING_MMC_DDR52) {
 			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
 			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
 		} else {
@@ -762,7 +763,8 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* set ddr mode */
 	rval = mmc_readl(host, REG_GCTRL);
-	if (ios->timing == MMC_TIMING_UHS_DDR50)
+	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
+	    ios->timing == MMC_TIMING_MMC_DDR52)
 		rval |= SDXC_DDR_MODE;
 	else
 		rval &= ~SDXC_DDR_MODE;
@@ -1106,9 +1108,9 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
 	mmc->max_seg_size	= (1 << host->idma_des_size_bits);
 	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
-	/* 400kHz ~ 50MHz */
+	/* 400kHz ~ 52MHz */
 	mmc->f_min		=   400000;
-	mmc->f_max		= 50000000;
+	mmc->f_max		= 52000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-- 
2.7.0
