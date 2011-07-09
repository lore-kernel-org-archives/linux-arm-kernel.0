From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 10 Jul 2011 01:16:39 +0800
Subject: [PATCH v2 5/7] spi/imx: use soc name in spi device type naming scheme
In-Reply-To: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310231801-18761-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Software defined version number is not stable enough to be used
in device type naming scheme.  The patch changes it to use implicit
soc name for spi device type definition.  In this way, we can easily
align the naming scheme with device tree binding, which comes later.

It removes fifosize from spi_imx_data and adds devtype there, so that
fifosize can be set in an inline function according to devtype.
Also, cpu_is_mx can be replaced by inline functions checking devtype.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-imx/clock-imx25.c              |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c          |   11 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 +-
 drivers/spi/Kconfig                          |   12 --
 drivers/spi/spi-imx.c                        |  208 ++++++++++++++------------
 5 files changed, 128 insertions(+), 122 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index 9bb9062..17d6d1b 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -283,9 +283,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK("imx25-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx25-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx25-cspi.2", NULL, cspi3_clk)
+	/* i.mx25 has the i.mx35 type cspi */
+	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("imx35-cspi.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("imx35-cspi.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
 	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
 	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index e00c427..31d904c 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1453,7 +1453,8 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK(NULL, "gpt_32k", gpt_32k_clk)
 	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
-	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
+	/* i.mx51 has the i.mx35 type cspi */
+	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx51.0", NULL, esdhc1_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx51.1", NULL, esdhc2_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx51.2", NULL, esdhc3_clk)
@@ -1486,9 +1487,11 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("sdhci-esdhc-imx53.1", NULL, esdhc2_mx53_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx53.2", NULL, esdhc3_mx53_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx53.3", NULL, esdhc4_mx53_clk)
-	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
-	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
-	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
+	/* i.mx53 has the i.mx51 type ecspi */
+	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
+	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
+	/* i.mx53 has the i.mx35 type cspi */
+	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index f97eb36..9bfae8b 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -40,9 +40,10 @@ const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
 #endif
 
 #ifdef CONFIG_SOC_IMX25
+/* i.mx25 has the i.mx35 type cspi */
 const struct imx_spi_imx_data imx25_cspi_data[] __initconst = {
 #define imx25_cspi_data_entry(_id, _hwid)				\
-	imx_spi_imx_data_entry(MX25, CSPI, "imx25-cspi", _id, _hwid, SZ_16K)
+	imx_spi_imx_data_entry(MX25, CSPI, "imx35-cspi", _id, _hwid, SZ_16K)
 	imx25_cspi_data_entry(0, 1),
 	imx25_cspi_data_entry(1, 2),
 	imx25_cspi_data_entry(2, 3),
@@ -79,8 +80,9 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_SOC_IMX51
+/* i.mx51 has the i.mx35 type cspi */
 const struct imx_spi_imx_data imx51_cspi_data __initconst =
-	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 2, , SZ_4K);
+	imx_spi_imx_data_entry_single(MX51, CSPI, "imx35-cspi", 2, , SZ_4K);
 
 const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
 #define imx51_ecspi_data_entry(_id, _hwid)				\
@@ -91,12 +93,14 @@ const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
 #ifdef CONFIG_SOC_IMX53
+/* i.mx53 has the i.mx35 type cspi */
 const struct imx_spi_imx_data imx53_cspi_data __initconst =
-	imx_spi_imx_data_entry_single(MX53, CSPI, "imx53-cspi", 0, , SZ_4K);
+	imx_spi_imx_data_entry_single(MX53, CSPI, "imx35-cspi", 0, , SZ_4K);
 
+/* i.mx53 has the i.mx51 type ecspi */
 const struct imx_spi_imx_data imx53_ecspi_data[] __initconst = {
 #define imx53_ecspi_data_entry(_id, _hwid)				\
-	imx_spi_imx_data_entry(MX53, ECSPI, "imx53-ecspi", _id, _hwid, SZ_4K)
+	imx_spi_imx_data_entry(MX53, ECSPI, "imx51-ecspi", _id, _hwid, SZ_4K)
 	imx53_ecspi_data_entry(0, 1),
 	imx53_ecspi_data_entry(1, 2),
 };
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c327cf3..52e2900 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -154,18 +154,6 @@ config SPI_GPIO
 	  GPIO operations, you should be able to leverage that for better
 	  speed with a custom version of this driver; see the source code.
 
-config SPI_IMX_VER_IMX1
-	def_bool y if SOC_IMX1
-
-config SPI_IMX_VER_0_0
-	def_bool y if SOC_IMX21 || SOC_IMX27
-
-config SPI_IMX_VER_0_4
-	def_bool y if ARCH_MX25 || SOC_IMX31 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
-
-config SPI_IMX_VER_2_3
-	def_bool y if SOC_IMX51 || SOC_IMX53
-
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
 	depends on ARCH_MXC
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b282351..2ed9c32 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -57,10 +57,12 @@ struct spi_imx_config {
 };
 
 enum spi_imx_devtype {
-	SPI_IMX_VER_IMX1,
-	SPI_IMX_VER_0_0,
-	SPI_IMX_VER_0_4,
-	SPI_IMX_VER_2_3,
+	IMX1_CSPI,
+	IMX21_CSPI,
+	IMX27_CSPI,
+	IMX31_CSPI,
+	IMX35_CSPI,	/* CSPI on all i.mx except above */
+	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
 };
 
 struct spi_imx_data;
@@ -71,7 +73,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
-	unsigned int fifosize;
+	enum spi_imx_devtype devtype;
 };
 
 struct spi_imx_data {
@@ -94,6 +96,21 @@ struct spi_imx_data {
 	struct spi_imx_devtype_data *devtype_data;
 };
 
+static inline int is_imx27_cspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX27_CSPI;
+}
+
+static inline int is_imx35_cspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX35_CSPI;
+}
+
+static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
+{
+	return (d->devtype_data->devtype == IMX51_ECSPI) ? 64 : 8;
+}
+
 #define MXC_SPI_BUF_RX(type)						\
 static void spi_imx_buf_rx_##type(struct spi_imx_data *spi_imx)		\
 {									\
@@ -135,14 +152,9 @@ static int mxc_clkdivs[] = {0, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192,
 
 /* MX21, MX27 */
 static unsigned int spi_imx_clkdiv_1(unsigned int fin,
-		unsigned int fspi)
+		unsigned int fspi, unsigned int max)
 {
-	int i, max;
-
-	if (cpu_is_mx21())
-		max = 18;
-	else
-		max = 16;
+	int i;
 
 	for (i = 2; i < max; i++)
 		if (fspi * mxc_clkdivs[i] >= fin)
@@ -348,7 +360,7 @@ static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
 		MX31_CSPICTRL_DR_SHIFT;
 
-	if (cpu_is_mx35()) {
+	if (is_imx35_cspi(spi_imx)) {
 		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
 		reg |= MX31_CSPICTRL_SSCTL;
 	} else {
@@ -363,8 +375,8 @@ static int __maybe_unused mx31_config(struct spi_imx_data *spi_imx,
 		reg |= MX31_CSPICTRL_SSPOL;
 	if (cs < 0)
 		reg |= (cs + 32) <<
-			(cpu_is_mx35() ? MX35_CSPICTRL_CS_SHIFT :
-					 MX31_CSPICTRL_CS_SHIFT);
+			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
+						  MX31_CSPICTRL_CS_SHIFT);
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
@@ -423,8 +435,9 @@ static int __maybe_unused mx21_config(struct spi_imx_data *spi_imx,
 {
 	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
 	int cs = spi_imx->chipselect[config->cs];
+	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
 
-	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz) <<
+	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz, max) <<
 		MX21_CSPICTRL_DR_SHIFT;
 	reg |= config->bpw - 1;
 
@@ -513,51 +526,84 @@ static void __maybe_unused mx1_reset(struct spi_imx_data *spi_imx)
 	writel(1, spi_imx->base + MXC_RESET);
 }
 
-/*
- * These version numbers are taken from the Freescale driver.  Unfortunately it
- * doesn't support i.MX1, so this entry doesn't match the scheme. :-(
- */
-static struct spi_imx_devtype_data spi_imx_devtype_data[] = {
-#ifdef CONFIG_SPI_IMX_VER_IMX1
-	[SPI_IMX_VER_IMX1] = {
-		.intctrl = mx1_intctrl,
-		.config = mx1_config,
-		.trigger = mx1_trigger,
-		.rx_available = mx1_rx_available,
-		.reset = mx1_reset,
-		.fifosize = 8,
-	},
-#endif
-#ifdef CONFIG_SPI_IMX_VER_0_0
-	[SPI_IMX_VER_0_0] = {
-		.intctrl = mx21_intctrl,
-		.config = mx21_config,
-		.trigger = mx21_trigger,
-		.rx_available = mx21_rx_available,
-		.reset = mx21_reset,
-		.fifosize = 8,
-	},
-#endif
-#ifdef CONFIG_SPI_IMX_VER_0_4
-	[SPI_IMX_VER_0_4] = {
-		.intctrl = mx31_intctrl,
-		.config = mx31_config,
-		.trigger = mx31_trigger,
-		.rx_available = mx31_rx_available,
-		.reset = mx31_reset,
-		.fifosize = 8,
-	},
-#endif
-#ifdef CONFIG_SPI_IMX_VER_2_3
-	[SPI_IMX_VER_2_3] = {
-		.intctrl = mx51_ecspi_intctrl,
-		.config = mx51_ecspi_config,
-		.trigger = mx51_ecspi_trigger,
-		.rx_available = mx51_ecspi_rx_available,
-		.reset = mx51_ecspi_reset,
-		.fifosize = 64,
-	},
-#endif
+static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
+	.intctrl = mx1_intctrl,
+	.config = mx1_config,
+	.trigger = mx1_trigger,
+	.rx_available = mx1_rx_available,
+	.reset = mx1_reset,
+	.devtype = IMX1_CSPI,
+};
+
+static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
+	.intctrl = mx21_intctrl,
+	.config = mx21_config,
+	.trigger = mx21_trigger,
+	.rx_available = mx21_rx_available,
+	.reset = mx21_reset,
+	.devtype = IMX21_CSPI,
+};
+
+static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
+	/* i.mx27 cspi shares the functions with i.mx21 one */
+	.intctrl = mx21_intctrl,
+	.config = mx21_config,
+	.trigger = mx21_trigger,
+	.rx_available = mx21_rx_available,
+	.reset = mx21_reset,
+	.devtype = IMX27_CSPI,
+};
+
+static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
+	.intctrl = mx31_intctrl,
+	.config = mx31_config,
+	.trigger = mx31_trigger,
+	.rx_available = mx31_rx_available,
+	.reset = mx31_reset,
+	.devtype = IMX31_CSPI,
+};
+
+static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
+	/* i.mx35 and later cspi shares the functions with i.mx31 one */
+	.intctrl = mx31_intctrl,
+	.config = mx31_config,
+	.trigger = mx31_trigger,
+	.rx_available = mx31_rx_available,
+	.reset = mx31_reset,
+	.devtype = IMX35_CSPI,
+};
+
+static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
+	.intctrl = mx51_ecspi_intctrl,
+	.config = mx51_ecspi_config,
+	.trigger = mx51_ecspi_trigger,
+	.rx_available = mx51_ecspi_rx_available,
+	.reset = mx51_ecspi_reset,
+	.devtype = IMX51_ECSPI,
+};
+
+static struct platform_device_id spi_imx_devtype[] = {
+	{
+		.name = "imx1-cspi",
+		.driver_data = (kernel_ulong_t) &imx1_cspi_devtype_data,
+	}, {
+		.name = "imx21-cspi",
+		.driver_data = (kernel_ulong_t) &imx21_cspi_devtype_data,
+	}, {
+		.name = "imx27-cspi",
+		.driver_data = (kernel_ulong_t) &imx27_cspi_devtype_data,
+	}, {
+		.name = "imx31-cspi",
+		.driver_data = (kernel_ulong_t) &imx31_cspi_devtype_data,
+	}, {
+		.name = "imx35-cspi",
+		.driver_data = (kernel_ulong_t) &imx35_cspi_devtype_data,
+	}, {
+		.name = "imx51-ecspi",
+		.driver_data = (kernel_ulong_t) &imx51_ecspi_devtype_data,
+	}, {
+		/* sentinel */
+	}
 };
 
 static void spi_imx_chipselect(struct spi_device *spi, int is_active)
@@ -575,7 +621,7 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
-	while (spi_imx->txfifo < spi_imx->devtype_data->fifosize) {
+	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
 		if (!spi_imx->count)
 			break;
 		spi_imx->tx(spi_imx);
@@ -691,42 +737,6 @@ static void spi_imx_cleanup(struct spi_device *spi)
 {
 }
 
-static struct platform_device_id spi_imx_devtype[] = {
-	{
-		.name = "imx1-cspi",
-		.driver_data = SPI_IMX_VER_IMX1,
-	}, {
-		.name = "imx21-cspi",
-		.driver_data = SPI_IMX_VER_0_0,
-	}, {
-		.name = "imx25-cspi",
-		.driver_data = SPI_IMX_VER_0_4,
-	}, {
-		.name = "imx27-cspi",
-		.driver_data = SPI_IMX_VER_0_0,
-	}, {
-		.name = "imx31-cspi",
-		.driver_data = SPI_IMX_VER_0_4,
-	}, {
-		.name = "imx35-cspi",
-		.driver_data = SPI_IMX_VER_0_4,
-	}, {
-		.name = "imx51-cspi",
-		.driver_data = SPI_IMX_VER_0_4,
-	}, {
-		.name = "imx51-ecspi",
-		.driver_data = SPI_IMX_VER_2_3,
-	}, {
-		.name = "imx53-cspi",
-		.driver_data = SPI_IMX_VER_0_4,
-	}, {
-		.name = "imx53-ecspi",
-		.driver_data = SPI_IMX_VER_2_3,
-	}, {
-		/* sentinel */
-	}
-};
-
 static int __devinit spi_imx_probe(struct platform_device *pdev)
 {
 	struct spi_imx_master *mxc_platform_info;
@@ -779,7 +789,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	init_completion(&spi_imx->xfer_done);
 
 	spi_imx->devtype_data =
-		&spi_imx_devtype_data[pdev->id_entry->driver_data];
+		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-- 
1.7.4.1
