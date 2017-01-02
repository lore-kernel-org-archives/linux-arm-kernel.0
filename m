From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  2 Jan 2017 23:03:42 +0000
Subject: [PATCH 1/5] drivers: mmc: sunxi: fix A64 calibration routine
In-Reply-To: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1483398226-29321-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The calibration facility in the A64 MMC block seems to have been
misunderstood: the result value is not the value to program into the
delay bits, but is the number of delay cells that result in a full clock
cycle delay. So this value has to be scaled by the desired phase, which
we still have to know and program.
Change the calibration routine to take a phase parameter and scale the
calibration value accordingly.
Also introduce sun50i-a64 delay parameters to store the required phase.
Looking at the BSP kernel the sample delay for anything below HS200 is
0, so we go with that value.
Once the driver supports HS200 and faster modes, we can enter confirmed
working values in there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mmc/host/sunxi-mmc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b1d1303..1e156e8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -681,15 +681,13 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	return 0;
 }
 
-static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off)
+static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off,
+			       int degrees)
 {
 	u32 reg = readl(host->reg_base + reg_off);
 	u32 delay;
 	unsigned long timeout;
 
-	if (!host->cfg->can_calibrate)
-		return 0;
-
 	reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
 	reg &= ~SDXC_CAL_DL_SW_EN;
 
@@ -711,6 +709,7 @@ static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off)
 	}
 
 	delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
+	delay = degrees * delay / 360;
 
 	reg &= ~SDXC_CAL_START;
 	reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
@@ -748,6 +747,11 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 		return -EINVAL;
 	}
 
+	if (host->cfg->can_calibrate)
+		return sunxi_mmc_calibrate(host, SDXC_REG_SAMP_DL_REG,
+					   host->cfg->clk_delays[index].sample);
+	/* TODO: calibrate data strobe delay once HS-400 is supported. */
+
 	clk_set_phase(host->clk_sample, host->cfg->clk_delays[index].sample);
 	clk_set_phase(host->clk_output, host->cfg->clk_delays[index].output);
 
@@ -802,12 +806,6 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
-	ret = sunxi_mmc_calibrate(host, SDXC_REG_SAMP_DL_REG);
-	if (ret)
-		return ret;
-
-	/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
-
 	return sunxi_mmc_oclk_onoff(host, 1);
 }
 
@@ -1061,6 +1059,14 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  72, .sample =  72 },
 };
 
+static const struct sunxi_mmc_clk_delay sun50i_mmc_clk_delays[] = {
+	[SDXC_CLK_400K]		= { .output = 90, .sample = 0 },
+	[SDXC_CLK_25M]		= { .output = 90, .sample = 0 },
+	[SDXC_CLK_50M]		= { .output = 90, .sample = 0 },
+	[SDXC_CLK_50M_DDR]	= { .output = 90, .sample = 0 },
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output = 90, .sample = 0 },
+};
+
 static const struct sunxi_mmc_cfg sun4i_a10_cfg = {
 	.idma_des_size_bits = 13,
 	.clk_delays = NULL,
@@ -1087,7 +1093,7 @@ static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
 
 static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.idma_des_size_bits = 16,
-	.clk_delays = NULL,
+	.clk_delays = sun50i_mmc_clk_delays,
 	.can_calibrate = true,
 };
 
@@ -1134,7 +1140,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return PTR_ERR(host->clk_mmc);
 	}
 
-	if (host->cfg->clk_delays) {
+	if (host->cfg->clk_delays && !host->cfg->can_calibrate) {
 		host->clk_output = devm_clk_get(&pdev->dev, "output");
 		if (IS_ERR(host->clk_output)) {
 			dev_err(&pdev->dev, "Could not get output clock\n");
-- 
2.8.2
