From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:56 +0200
Subject: [PATCH 20/40] spi/imx: get rid of more ifs depending on the used cpu
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-20-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nearly everything that is needed is provided by the version of the SPI IP.
Now the only checks left using cpu_is_... are clk divider tuning on mx21/mx27
and autodetection (which will die soon).

Acked-by: Jason Wang <jason77.wang@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi_imx.c |   73 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 20cdee3..60a52d1 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -75,6 +75,7 @@ struct spi_imx_devtype_data {
 	int (*config)(struct spi_imx_data *, struct spi_imx_config *);
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
+	void (*reset)(struct spi_imx_data *);
 };
 
 struct spi_imx_data {
@@ -213,7 +214,7 @@ static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
+static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
@@ -221,12 +222,7 @@ static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
 		MX31_CSPICTRL_DR_SHIFT;
 
-	if (cpu_is_mx31())
-		reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
-	else if (cpu_is_mx25() || cpu_is_mx35()) {
-		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
-		reg |= MX31_CSPICTRL_SSCTL;
-	}
+	reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
 
 	if (config->mode & SPI_CPHA)
 		reg |= MX31_CSPICTRL_PHA;
@@ -235,10 +231,7 @@ static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
 	if (config->cs < 0) {
-		if (cpu_is_mx31())
-			reg |= (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
-		else if (cpu_is_mx25() || cpu_is_mx35())
-			reg |= (config->cs + 32) << MX35_CSPICTRL_CS_SHIFT;
+		reg |= (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
 	}
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
@@ -246,11 +239,43 @@ static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 	return 0;
 }
 
+static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
+		struct spi_imx_config *config)
+{
+	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
+
+	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
+		MX31_CSPICTRL_DR_SHIFT;
+
+	reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
+	reg |= MX31_CSPICTRL_SSCTL;
+
+	if (config->mode & SPI_CPHA)
+		reg |= MX31_CSPICTRL_PHA;
+	if (config->mode & SPI_CPOL)
+		reg |= MX31_CSPICTRL_POL;
+	if (config->mode & SPI_CS_HIGH)
+		reg |= MX31_CSPICTRL_SSPOL;
+	if (config->cs < 0)
+		reg |= (config->cs + 32) << MX35_CSPICTRL_CS_SHIFT;
+
+	writel(reg, spi_imx->base + MXC_CSPICTRL);
+
+	return 0;
+}
+
 static int __maybe_unused mx31_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR;
 }
 
+static void __maybe_unused spi_imx0_4_reset(struct spi_imx_data *spi_imx)
+{
+	/* drain receive buffer */
+	while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
+		readl(spi_imx->base + MXC_CSPIRXDATA);
+}
+
 #define MX27_INTREG_RR		(1 << 4)
 #define MX27_INTREG_TEEN	(1 << 9)
 #define MX27_INTREG_RREN	(1 << 13)
@@ -313,6 +338,11 @@ static int __maybe_unused mx27_rx_available(struct spi_imx_data *spi_imx)
 	return readl(spi_imx->base + MXC_CSPIINT) & MX27_INTREG_RR;
 }
 
+static void __maybe_unused spi_imx0_0_reset(struct spi_imx_data *spi_imx)
+{
+	writel(1, spi_imx->base + MXC_RESET);
+}
+
 #define MX1_INTREG_RR		(1 << 3)
 #define MX1_INTREG_TEEN		(1 << 8)
 #define MX1_INTREG_RREN		(1 << 11)
@@ -369,6 +399,11 @@ static int __maybe_unused mx1_rx_available(struct spi_imx_data *spi_imx)
 	return readl(spi_imx->base + MXC_CSPIINT) & MX1_INTREG_RR;
 }
 
+static void __maybe_unused mx1_reset(struct spi_imx_data *spi_imx)
+{
+	writel(1, spi_imx->base + MXC_RESET);
+}
+
 /*
  * These version numbers are taken from the Freescale driver.  Unfortunately it
  * doesn't support i.MX1, so this entry doesn't match the scheme. :-(
@@ -380,6 +415,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.config = mx1_config,
 		.trigger = mx1_trigger,
 		.rx_available = mx1_rx_available,
+		.reset = mx1_reset,
 	},
 #endif
 #ifdef CONFIG_SPI_IMX_VER_0_0
@@ -388,22 +424,25 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.config = mx27_config,
 		.trigger = mx27_trigger,
 		.rx_available = mx27_rx_available,
+		.reset = spi_imx0_0_reset,
 	},
 #endif
 #ifdef CONFIG_SPI_IMX_VER_0_4
 	[SPI_IMX_VER_0_4] = {
 		.intctrl = mx31_intctrl,
-		.config = mx31_config,
+		.config = spi_imx0_4_config,
 		.trigger = mx31_trigger,
 		.rx_available = mx31_rx_available,
+		.reset = spi_imx0_4_reset,
 	},
 #endif
 #ifdef CONFIG_SPI_IMX_VER_0_7
 	[SPI_IMX_VER_0_7] = {
 		.intctrl = mx31_intctrl,
-		.config = mx31_config,
+		.config = spi_imx0_7_config,
 		.trigger = mx31_trigger,
 		.rx_available = mx31_rx_available,
+		.reset = spi_imx0_4_reset,
 	},
 #endif
 };
@@ -683,13 +722,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	clk_enable(spi_imx->clk);
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk);
 
-	if (cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
-		writel(1, spi_imx->base + MXC_RESET);
-
-	/* drain receive buffer */
-	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35())
-		while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
-			readl(spi_imx->base + MXC_CSPIRXDATA);
+	spi_imx->devtype_data.reset(spi_imx);
 
 	spi_imx->devtype_data.intctrl(spi_imx, 0);
 
-- 
1.7.2.3
