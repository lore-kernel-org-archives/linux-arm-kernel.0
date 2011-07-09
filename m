From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 10 Jul 2011 01:16:37 +0800
Subject: [PATCH v2 3/7] spi/imx: do not use spi_imx2_3 to name SPI_IMX_VER_2_3
	function and macro
In-Reply-To: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310231801-18761-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's confusing to use spi_imx2_3 to name SPI_IMX_VER_2_3 function
and macro, as it easily make people think of imx2 and imx3.  It's
better to use specific soc name just like what other SPI_IMX_VER
do.  For SPI_IMX_VER_2_3 case, it will be mx51.  To distinguish it
from CSPI on mx51, mx51_ecspi might be a good choice.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/spi-imx.c |  107 +++++++++++++++++++++++++------------------------
 1 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index ad928b1..052959df 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -171,30 +171,30 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 	return 7;
 }
 
-#define SPI_IMX2_3_CTRL		0x08
-#define SPI_IMX2_3_CTRL_ENABLE		(1 <<  0)
-#define SPI_IMX2_3_CTRL_XCH		(1 <<  2)
-#define SPI_IMX2_3_CTRL_MODE_MASK	(0xf << 4)
-#define SPI_IMX2_3_CTRL_POSTDIV_OFFSET	8
-#define SPI_IMX2_3_CTRL_PREDIV_OFFSET	12
-#define SPI_IMX2_3_CTRL_CS(cs)		((cs) << 18)
-#define SPI_IMX2_3_CTRL_BL_OFFSET	20
-
-#define SPI_IMX2_3_CONFIG	0x0c
-#define SPI_IMX2_3_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
-#define SPI_IMX2_3_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
-#define SPI_IMX2_3_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
-#define SPI_IMX2_3_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
-
-#define SPI_IMX2_3_INT		0x10
-#define SPI_IMX2_3_INT_TEEN		(1 <<  0)
-#define SPI_IMX2_3_INT_RREN		(1 <<  3)
-
-#define SPI_IMX2_3_STAT		0x18
-#define SPI_IMX2_3_STAT_RR		(1 <<  3)
+#define MX51_ECSPI_CTRL		0x08
+#define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
+#define MX51_ECSPI_CTRL_XCH		(1 <<  2)
+#define MX51_ECSPI_CTRL_MODE_MASK	(0xf << 4)
+#define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
+#define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
+#define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
+#define MX51_ECSPI_CTRL_BL_OFFSET	20
+
+#define MX51_ECSPI_CONFIG	0x0c
+#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
+#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
+#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
+#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
+
+#define MX51_ECSPI_INT		0x10
+#define MX51_ECSPI_INT_TEEN		(1 <<  0)
+#define MX51_ECSPI_INT_RREN		(1 <<  3)
+
+#define MX51_ECSPI_STAT		0x18
+#define MX51_ECSPI_STAT_RR		(1 <<  3)
 
 /* MX51 eCSPI */
-static unsigned int spi_imx2_3_clkdiv(unsigned int fin, unsigned int fspi)
+static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi)
 {
 	/*
 	 * there are two 4-bit dividers, the pre-divider divides by
@@ -222,36 +222,37 @@ static unsigned int spi_imx2_3_clkdiv(unsigned int fin, unsigned int fspi)
 
 	pr_debug("%s: fin: %u, fspi: %u, post: %u, pre: %u\n",
 			__func__, fin, fspi, post, pre);
-	return (pre << SPI_IMX2_3_CTRL_PREDIV_OFFSET) |
-		(post << SPI_IMX2_3_CTRL_POSTDIV_OFFSET);
+	return (pre << MX51_ECSPI_CTRL_PREDIV_OFFSET) |
+		(post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
 }
 
-static void __maybe_unused spi_imx2_3_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused
+mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned val = 0;
 
 	if (enable & MXC_INT_TE)
-		val |= SPI_IMX2_3_INT_TEEN;
+		val |= MX51_ECSPI_INT_TEEN;
 
 	if (enable & MXC_INT_RR)
-		val |= SPI_IMX2_3_INT_RREN;
+		val |= MX51_ECSPI_INT_RREN;
 
-	writel(val, spi_imx->base + SPI_IMX2_3_INT);
+	writel(val, spi_imx->base + MX51_ECSPI_INT);
 }
 
-static void __maybe_unused spi_imx2_3_trigger(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
 	u32 reg;
 
-	reg = readl(spi_imx->base + SPI_IMX2_3_CTRL);
-	reg |= SPI_IMX2_3_CTRL_XCH;
-	writel(reg, spi_imx->base + SPI_IMX2_3_CTRL);
+	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	reg |= MX51_ECSPI_CTRL_XCH;
+	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
-static int __maybe_unused spi_imx2_3_config(struct spi_imx_data *spi_imx,
+static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	u32 ctrl = SPI_IMX2_3_CTRL_ENABLE, cfg = 0;
+	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -260,42 +261,42 @@ static int __maybe_unused spi_imx2_3_config(struct spi_imx_data *spi_imx,
 	 * the same time.
 	 * So set master mode for all channels as we do not support slave mode.
 	 */
-	ctrl |= SPI_IMX2_3_CTRL_MODE_MASK;
+	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/* set clock speed */
-	ctrl |= spi_imx2_3_clkdiv(spi_imx->spi_clk, config->speed_hz);
+	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz);
 
 	/* set chip select to use */
-	ctrl |= SPI_IMX2_3_CTRL_CS(config->cs);
+	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
 
-	ctrl |= (config->bpw - 1) << SPI_IMX2_3_CTRL_BL_OFFSET;
+	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
 
-	cfg |= SPI_IMX2_3_CONFIG_SBBCTRL(config->cs);
+	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
 
 	if (config->mode & SPI_CPHA)
-		cfg |= SPI_IMX2_3_CONFIG_SCLKPHA(config->cs);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
 	if (config->mode & SPI_CPOL)
-		cfg |= SPI_IMX2_3_CONFIG_SCLKPOL(config->cs);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
 
 	if (config->mode & SPI_CS_HIGH)
-		cfg |= SPI_IMX2_3_CONFIG_SSBPOL(config->cs);
+		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
-	writel(ctrl, spi_imx->base + SPI_IMX2_3_CTRL);
-	writel(cfg, spi_imx->base + SPI_IMX2_3_CONFIG);
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
 	return 0;
 }
 
-static int __maybe_unused spi_imx2_3_rx_available(struct spi_imx_data *spi_imx)
+static int __maybe_unused mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
 {
-	return readl(spi_imx->base + SPI_IMX2_3_STAT) & SPI_IMX2_3_STAT_RR;
+	return readl(spi_imx->base + MX51_ECSPI_STAT) & MX51_ECSPI_STAT_RR;
 }
 
-static void __maybe_unused spi_imx2_3_reset(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx51_ecspi_reset(struct spi_imx_data *spi_imx)
 {
 	/* drain receive buffer */
-	while (spi_imx2_3_rx_available(spi_imx))
+	while (mx51_ecspi_rx_available(spi_imx))
 		readl(spi_imx->base + MXC_CSPIRXDATA);
 }
 
@@ -583,11 +584,11 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] = {
 #endif
 #ifdef CONFIG_SPI_IMX_VER_2_3
 	[SPI_IMX_VER_2_3] = {
-		.intctrl = spi_imx2_3_intctrl,
-		.config = spi_imx2_3_config,
-		.trigger = spi_imx2_3_trigger,
-		.rx_available = spi_imx2_3_rx_available,
-		.reset = spi_imx2_3_reset,
+		.intctrl = mx51_ecspi_intctrl,
+		.config = mx51_ecspi_config,
+		.trigger = mx51_ecspi_trigger,
+		.rx_available = mx51_ecspi_rx_available,
+		.reset = mx51_ecspi_reset,
 		.fifosize = 64,
 	},
 #endif
-- 
1.7.4.1
