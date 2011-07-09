From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 10 Jul 2011 01:16:38 +0800
Subject: [PATCH v2 4/7] spi/imx: merge type SPI_IMX_VER_0_7 into
	SPI_IMX_VER_0_4
In-Reply-To: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310231801-18761-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only difference between SPI_IMX_VER_0_7 and SPI_IMX_VER_0_4 is
.config function.  The patch uses cpu_is_mx35 (to be removed) as the
temporary solution to consolidate functions spi_imx0_4_config and
spi_imx0_7_config into mx31_config.  As a result, type SPI_IMX_VER_0_7
can be merged into SPI_IMX_VER_0_4.

It also renames function spi_imx0_4_reset to mx31_reset to keep
consistency with other function naming.

A couple of redundant macros, MX3_CSPISTAT and MX3_CSPISTAT_RR,
together with the useless type SPI_IMX_VER_0_5 also get cleaned up.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/Kconfig   |    5 +---
 drivers/spi/spi-imx.c |   70 ++++++++++++------------------------------------
 2 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9aafa98..c327cf3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -161,10 +161,7 @@ config SPI_IMX_VER_0_0
 	def_bool y if SOC_IMX21 || SOC_IMX27
 
 config SPI_IMX_VER_0_4
-	def_bool y if SOC_IMX31
-
-config SPI_IMX_VER_0_7
-	def_bool y if ARCH_MX25 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
+	def_bool y if ARCH_MX25 || SOC_IMX31 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
 
 config SPI_IMX_VER_2_3
 	def_bool y if SOC_IMX51 || SOC_IMX53
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 052959df..b282351 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -45,9 +45,6 @@
 #define MXC_CSPIINT		0x0c
 #define MXC_RESET		0x1c
 
-#define MX3_CSPISTAT		0x14
-#define MX3_CSPISTAT_RR		(1 << 3)
-
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
@@ -63,8 +60,6 @@ enum spi_imx_devtype {
 	SPI_IMX_VER_IMX1,
 	SPI_IMX_VER_0_0,
 	SPI_IMX_VER_0_4,
-	SPI_IMX_VER_0_5,
-	SPI_IMX_VER_0_7,
 	SPI_IMX_VER_2_3,
 };
 
@@ -344,32 +339,7 @@ static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
-		struct spi_imx_config *config)
-{
-	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
-	int cs = spi_imx->chipselect[config->cs];
-
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
-		MX31_CSPICTRL_DR_SHIFT;
-
-	reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
-
-	if (config->mode & SPI_CPHA)
-		reg |= MX31_CSPICTRL_PHA;
-	if (config->mode & SPI_CPOL)
-		reg |= MX31_CSPICTRL_POL;
-	if (config->mode & SPI_CS_HIGH)
-		reg |= MX31_CSPICTRL_SSPOL;
-	if (cs < 0)
-		reg |= (cs + 32) << MX31_CSPICTRL_CS_SHIFT;
-
-	writel(reg, spi_imx->base + MXC_CSPICTRL);
-
-	return 0;
-}
-
-static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
+static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
@@ -378,8 +348,12 @@ static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
 		MX31_CSPICTRL_DR_SHIFT;
 
-	reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
-	reg |= MX31_CSPICTRL_SSCTL;
+	if (cpu_is_mx35()) {
+		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
+		reg |= MX31_CSPICTRL_SSCTL;
+	} else {
+		reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
+	}
 
 	if (config->mode & SPI_CPHA)
 		reg |= MX31_CSPICTRL_PHA;
@@ -388,7 +362,9 @@ static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
 	if (cs < 0)
-		reg |= (cs + 32) << MX35_CSPICTRL_CS_SHIFT;
+		reg |= (cs + 32) <<
+			(cpu_is_mx35() ? MX35_CSPICTRL_CS_SHIFT :
+					 MX31_CSPICTRL_CS_SHIFT);
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
@@ -400,10 +376,10 @@ static int __maybe_unused mx31_rx_available(struct spi_imx_data *spi_imx)
 	return readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR;
 }
 
-static void __maybe_unused spi_imx0_4_reset(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx31_reset(struct spi_imx_data *spi_imx)
 {
 	/* drain receive buffer */
-	while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
+	while (readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR)
 		readl(spi_imx->base + MXC_CSPIRXDATA);
 }
 
@@ -565,20 +541,10 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] = {
 #ifdef CONFIG_SPI_IMX_VER_0_4
 	[SPI_IMX_VER_0_4] = {
 		.intctrl = mx31_intctrl,
-		.config = spi_imx0_4_config,
+		.config = mx31_config,
 		.trigger = mx31_trigger,
 		.rx_available = mx31_rx_available,
-		.reset = spi_imx0_4_reset,
-		.fifosize = 8,
-	},
-#endif
-#ifdef CONFIG_SPI_IMX_VER_0_7
-	[SPI_IMX_VER_0_7] = {
-		.intctrl = mx31_intctrl,
-		.config = spi_imx0_7_config,
-		.trigger = mx31_trigger,
-		.rx_available = mx31_rx_available,
-		.reset = spi_imx0_4_reset,
+		.reset = mx31_reset,
 		.fifosize = 8,
 	},
 #endif
@@ -734,7 +700,7 @@ static struct platform_device_id spi_imx_devtype[] = {
 		.driver_data = SPI_IMX_VER_0_0,
 	}, {
 		.name = "imx25-cspi",
-		.driver_data = SPI_IMX_VER_0_7,
+		.driver_data = SPI_IMX_VER_0_4,
 	}, {
 		.name = "imx27-cspi",
 		.driver_data = SPI_IMX_VER_0_0,
@@ -743,16 +709,16 @@ static struct platform_device_id spi_imx_devtype[] = {
 		.driver_data = SPI_IMX_VER_0_4,
 	}, {
 		.name = "imx35-cspi",
-		.driver_data = SPI_IMX_VER_0_7,
+		.driver_data = SPI_IMX_VER_0_4,
 	}, {
 		.name = "imx51-cspi",
-		.driver_data = SPI_IMX_VER_0_7,
+		.driver_data = SPI_IMX_VER_0_4,
 	}, {
 		.name = "imx51-ecspi",
 		.driver_data = SPI_IMX_VER_2_3,
 	}, {
 		.name = "imx53-cspi",
-		.driver_data = SPI_IMX_VER_0_7,
+		.driver_data = SPI_IMX_VER_0_4,
 	}, {
 		.name = "imx53-ecspi",
 		.driver_data = SPI_IMX_VER_2_3,
-- 
1.7.4.1
