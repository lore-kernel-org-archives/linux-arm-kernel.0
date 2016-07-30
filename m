From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 30 Jul 2016 16:25:46 +0200
Subject: [PATCH v2 3/5] mmc: sunxi: Factor out clock phase setting code into a
 helper function
In-Reply-To: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1469888748-26085-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a sunxi_mmc_clk_set_phase() helper function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this patch-set
---
 drivers/mmc/host/sunxi-mmc.c | 61 ++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 9f44c83..b631b5c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -657,12 +657,39 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	return 0;
 }
 
+static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
+				   struct mmc_ios *ios, u32 rate)
+{
+	int index;
+
+	/* determine delays */
+	if (rate <= 400000) {
+		index = SDXC_CLK_400K;
+	} else if (rate <= 25000000) {
+		index = SDXC_CLK_25M;
+	} else if (rate <= 52000000) {
+		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
+		    ios->timing != MMC_TIMING_MMC_DDR52) {
+			index = SDXC_CLK_50M;
+		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
+			index = SDXC_CLK_50M_DDR_8BIT;
+		} else {
+			index = SDXC_CLK_50M_DDR;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	clk_set_phase(host->clk_sample, host->cfg->clk_delays[index].sample);
+	clk_set_phase(host->clk_output, host->cfg->clk_delays[index].output);
+
+	return 0;
+}
+
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
-	const struct sunxi_mmc_clk_delay *clk_delays = host->cfg->clk_delays;
-	u32 rate, oclk_dly, rval, sclk_dly;
-	u32 clock = ios->clock;
+	u32 rate, rval, clock = ios->clock;
 	int ret;
 
 	/* 8 bit DDR requires a higher module clock */
@@ -697,31 +724,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	}
 	mmc_writel(host, REG_CLKCR, rval);
 
-	/* determine delays */
-	if (rate <= 400000) {
-		oclk_dly = clk_delays[SDXC_CLK_400K].output;
-		sclk_dly = clk_delays[SDXC_CLK_400K].sample;
-	} else if (rate <= 25000000) {
-		oclk_dly = clk_delays[SDXC_CLK_25M].output;
-		sclk_dly = clk_delays[SDXC_CLK_25M].sample;
-	} else if (rate <= 52000000) {
-		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
-		    ios->timing != MMC_TIMING_MMC_DDR52) {
-			oclk_dly = clk_delays[SDXC_CLK_50M].output;
-			sclk_dly = clk_delays[SDXC_CLK_50M].sample;
-		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
-			oclk_dly = clk_delays[SDXC_CLK_50M_DDR_8BIT].output;
-			sclk_dly = clk_delays[SDXC_CLK_50M_DDR_8BIT].sample;
-		} else {
-			oclk_dly = clk_delays[SDXC_CLK_50M_DDR].output;
-			sclk_dly = clk_delays[SDXC_CLK_50M_DDR].sample;
-		}
-	} else {
-		return -EINVAL;
-	}
-
-	clk_set_phase(host->clk_sample, sclk_dly);
-	clk_set_phase(host->clk_output, oclk_dly);
+	ret = sunxi_mmc_clk_set_phase(host, ios, rate);
+	if (ret)
+		return ret;
 
 	return sunxi_mmc_oclk_onoff(host, 1);
 }
-- 
2.7.4
