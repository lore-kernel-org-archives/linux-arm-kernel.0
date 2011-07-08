From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  8 Jul 2011 16:27:30 +0800
Subject: [PATCH 2/6] spi/imx: use soc name in spi device type naming scheme
In-Reply-To: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310113654-25887-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Software defined version number is not stable enough to be used
in device type naming scheme.  The patch changes it to use implicit
soc name for spi device type definition.  In this way, we can easily
align the naming scheme with device tree binding, which comes later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-imx/clock-imx25.c              |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c          |   11 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 +-
 drivers/spi/Kconfig                          |   15 -
 drivers/spi/spi-imx.c                        |  423 ++++++++++++--------------
 5 files changed, 219 insertions(+), 249 deletions(-)

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
index 9aafa98..52e2900 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -154,21 +154,6 @@ config SPI_GPIO
 	  GPIO operations, you should be able to leverage that for better
 	  speed with a custom version of this driver; see the source code.
 
-config SPI_IMX_VER_IMX1
-	def_bool y if SOC_IMX1
-
-config SPI_IMX_VER_0_0
-	def_bool y if SOC_IMX21 || SOC_IMX27
-
-config SPI_IMX_VER_0_4
-	def_bool y if SOC_IMX31
-
-config SPI_IMX_VER_0_7
-	def_bool y if ARCH_MX25 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
-
-config SPI_IMX_VER_2_3
-	def_bool y if SOC_IMX51 || SOC_IMX53
-
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
 	depends on ARCH_MXC
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7097d43..3d4efae 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -36,7 +36,6 @@
 #include <linux/types.h>
 
 #include <mach/spi.h>
-#include <mach/hardware.h>
 
 #define DRIVER_NAME "spi_imx"
 
@@ -46,9 +45,6 @@
 #define MXC_CSPIINT		0x0c
 #define MXC_RESET		0x1c
 
-#define MX3_CSPISTAT		0x14
-#define MX3_CSPISTAT_RR		(1 << 3)
-
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
@@ -61,12 +57,12 @@ struct spi_imx_config {
 };
 
 enum spi_imx_devtype {
-	SPI_IMX_VER_IMX1,
-	SPI_IMX_VER_0_0,
-	SPI_IMX_VER_0_4,
-	SPI_IMX_VER_0_5,
-	SPI_IMX_VER_0_7,
-	SPI_IMX_VER_2_3,
+	IMX1_CSPI,
+	IMX21_CSPI,
+	IMX27_CSPI,
+	IMX31_CSPI,
+	IMX35_CSPI,	/* CSPI on all i.mx except above */
+	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
 };
 
 struct spi_imx_data;
@@ -77,7 +73,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
-	unsigned int fifosize;
+	enum spi_imx_devtype devtype;
 };
 
 struct spi_imx_data {
@@ -97,9 +93,24 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
-	struct spi_imx_devtype_data devtype_data;
+	struct spi_imx_devtype_data *devtype_data;
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
@@ -141,14 +152,9 @@ static int mxc_clkdivs[] = {0, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96, 128, 192,
 
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
@@ -172,30 +178,30 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
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
+#define MX51_ECSPI_CTRL		0x08
+#define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
+#define MX51_ECSPI_CTRL_XCH		(1 <<  2)
+#define MX51_ECSPI_CTRL_MODE_MASK	(0xf << 4)
+#define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
+#define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
+#define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
+#define MX51_ECSPI_CTRL_BL_OFFSET	20
 
-#define SPI_IMX2_3_CONFIG	0x0c
-#define SPI_IMX2_3_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
-#define SPI_IMX2_3_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
-#define SPI_IMX2_3_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
-#define SPI_IMX2_3_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
+#define MX51_ECSPI_CONFIG	0x0c
+#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
+#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
+#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
+#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
 
-#define SPI_IMX2_3_INT		0x10
-#define SPI_IMX2_3_INT_TEEN		(1 <<  0)
-#define SPI_IMX2_3_INT_RREN		(1 <<  3)
+#define MX51_ECSPI_INT		0x10
+#define MX51_ECSPI_INT_TEEN		(1 <<  0)
+#define MX51_ECSPI_INT_RREN		(1 <<  3)
 
-#define SPI_IMX2_3_STAT		0x18
-#define SPI_IMX2_3_STAT_RR		(1 <<  3)
+#define MX51_ECSPI_STAT		0x18
+#define MX51_ECSPI_STAT_RR		(1 <<  3)
 
 /* MX51 eCSPI */
-static unsigned int spi_imx2_3_clkdiv(unsigned int fin, unsigned int fspi)
+static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi)
 {
 	/*
 	 * there are two 4-bit dividers, the pre-divider divides by
@@ -223,36 +229,37 @@ static unsigned int spi_imx2_3_clkdiv(unsigned int fin, unsigned int fspi)
 
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
@@ -261,42 +268,42 @@ static int __maybe_unused spi_imx2_3_config(struct spi_imx_data *spi_imx,
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
 
@@ -344,32 +351,7 @@ static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
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
@@ -378,8 +360,12 @@ static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
 		MX31_CSPICTRL_DR_SHIFT;
 
-	reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
-	reg |= MX31_CSPICTRL_SSCTL;
+	if (is_imx35_cspi(spi_imx)) {
+		reg |= (config->bpw - 1) << MX35_CSPICTRL_BL_SHIFT;
+		reg |= MX31_CSPICTRL_SSCTL;
+	} else {
+		reg |= (config->bpw - 1) << MX31_CSPICTRL_BC_SHIFT;
+	}
 
 	if (config->mode & SPI_CPHA)
 		reg |= MX31_CSPICTRL_PHA;
@@ -388,7 +374,9 @@ static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
 	if (cs < 0)
-		reg |= (cs + 32) << MX35_CSPICTRL_CS_SHIFT;
+		reg |= (cs + 32) <<
+			(is_imx35_cspi(spi_imx) ?  MX35_CSPICTRL_CS_SHIFT :
+						   MX31_CSPICTRL_CS_SHIFT);
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
@@ -400,77 +388,79 @@ static int __maybe_unused mx31_rx_available(struct spi_imx_data *spi_imx)
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
 
-#define MX27_INTREG_RR		(1 << 4)
-#define MX27_INTREG_TEEN	(1 << 9)
-#define MX27_INTREG_RREN	(1 << 13)
+#define MX21_INTREG_RR		(1 << 4)
+#define MX21_INTREG_TEEN	(1 << 9)
+#define MX21_INTREG_RREN	(1 << 13)
 
-#define MX27_CSPICTRL_POL	(1 << 5)
-#define MX27_CSPICTRL_PHA	(1 << 6)
-#define MX27_CSPICTRL_SSPOL	(1 << 8)
-#define MX27_CSPICTRL_XCH	(1 << 9)
-#define MX27_CSPICTRL_ENABLE	(1 << 10)
-#define MX27_CSPICTRL_MASTER	(1 << 11)
-#define MX27_CSPICTRL_DR_SHIFT	14
-#define MX27_CSPICTRL_CS_SHIFT	19
+#define MX21_CSPICTRL_POL	(1 << 5)
+#define MX21_CSPICTRL_PHA	(1 << 6)
+#define MX21_CSPICTRL_SSPOL	(1 << 8)
+#define MX21_CSPICTRL_XCH	(1 << 9)
+#define MX21_CSPICTRL_ENABLE	(1 << 10)
+#define MX21_CSPICTRL_MASTER	(1 << 11)
+#define MX21_CSPICTRL_DR_SHIFT	14
+#define MX21_CSPICTRL_CS_SHIFT	19
 
-static void __maybe_unused mx27_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused
+mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned int val = 0;
 
 	if (enable & MXC_INT_TE)
-		val |= MX27_INTREG_TEEN;
+		val |= MX21_INTREG_TEEN;
 	if (enable & MXC_INT_RR)
-		val |= MX27_INTREG_RREN;
+		val |= MX21_INTREG_RREN;
 
 	writel(val, spi_imx->base + MXC_CSPIINT);
 }
 
-static void __maybe_unused mx27_trigger(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
 {
 	unsigned int reg;
 
 	reg = readl(spi_imx->base + MXC_CSPICTRL);
-	reg |= MX27_CSPICTRL_XCH;
+	reg |= MX21_CSPICTRL_XCH;
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx27_config(struct spi_imx_data *spi_imx,
+static int __maybe_unused mx21_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	unsigned int reg = MX27_CSPICTRL_ENABLE | MX27_CSPICTRL_MASTER;
+	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
 	int cs = spi_imx->chipselect[config->cs];
+	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
 
-	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz) <<
-		MX27_CSPICTRL_DR_SHIFT;
+	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz, max) <<
+		MX21_CSPICTRL_DR_SHIFT;
 	reg |= config->bpw - 1;
 
 	if (config->mode & SPI_CPHA)
-		reg |= MX27_CSPICTRL_PHA;
+		reg |= MX21_CSPICTRL_PHA;
 	if (config->mode & SPI_CPOL)
-		reg |= MX27_CSPICTRL_POL;
+		reg |= MX21_CSPICTRL_POL;
 	if (config->mode & SPI_CS_HIGH)
-		reg |= MX27_CSPICTRL_SSPOL;
+		reg |= MX21_CSPICTRL_SSPOL;
 	if (cs < 0)
-		reg |= (cs + 32) << MX27_CSPICTRL_CS_SHIFT;
+		reg |= (cs + 32) << MX21_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
 	return 0;
 }
 
-static int __maybe_unused mx27_rx_available(struct spi_imx_data *spi_imx)
+static int __maybe_unused mx21_rx_available(struct spi_imx_data *spi_imx)
 {
-	return readl(spi_imx->base + MXC_CSPIINT) & MX27_INTREG_RR;
+	return readl(spi_imx->base + MXC_CSPIINT) & MX21_INTREG_RR;
 }
 
-static void __maybe_unused spi_imx0_0_reset(struct spi_imx_data *spi_imx)
+static void __maybe_unused mx21_reset(struct spi_imx_data *spi_imx)
 {
 	writel(1, spi_imx->base + MXC_RESET);
 }
@@ -536,61 +526,84 @@ static void __maybe_unused mx1_reset(struct spi_imx_data *spi_imx)
 	writel(1, spi_imx->base + MXC_RESET);
 }
 
-/*
- * These version numbers are taken from the Freescale driver.  Unfortunately it
- * doesn't support i.MX1, so this entry doesn't match the scheme. :-(
- */
-static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
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
-		.intctrl = mx27_intctrl,
-		.config = mx27_config,
-		.trigger = mx27_trigger,
-		.rx_available = mx27_rx_available,
-		.reset = spi_imx0_0_reset,
-		.fifosize = 8,
-	},
-#endif
-#ifdef CONFIG_SPI_IMX_VER_0_4
-	[SPI_IMX_VER_0_4] = {
-		.intctrl = mx31_intctrl,
-		.config = spi_imx0_4_config,
-		.trigger = mx31_trigger,
-		.rx_available = mx31_rx_available,
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
-		.fifosize = 8,
-	},
-#endif
-#ifdef CONFIG_SPI_IMX_VER_2_3
-	[SPI_IMX_VER_2_3] = {
-		.intctrl = spi_imx2_3_intctrl,
-		.config = spi_imx2_3_config,
-		.trigger = spi_imx2_3_trigger,
-		.rx_available = spi_imx2_3_rx_available,
-		.reset = spi_imx2_3_reset,
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
@@ -608,21 +621,21 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
-	while (spi_imx->txfifo < spi_imx->devtype_data.fifosize) {
+	while (spi_imx->txfifo < spi_imx_get_fifosize(spi_imx)) {
 		if (!spi_imx->count)
 			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
 	}
 
-	spi_imx->devtype_data.trigger(spi_imx);
+	spi_imx->devtype_data->trigger(spi_imx);
 }
 
 static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 {
 	struct spi_imx_data *spi_imx = dev_id;
 
-	while (spi_imx->devtype_data.rx_available(spi_imx)) {
+	while (spi_imx->devtype_data->rx_available(spi_imx)) {
 		spi_imx->rx(spi_imx);
 		spi_imx->txfifo--;
 	}
@@ -636,12 +649,12 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 		/* No data left to push, but still waiting for rx data,
 		 * enable receive data available interrupt.
 		 */
-		spi_imx->devtype_data.intctrl(
+		spi_imx->devtype_data->intctrl(
 				spi_imx, MXC_INT_RR);
 		return IRQ_HANDLED;
 	}
 
-	spi_imx->devtype_data.intctrl(spi_imx, 0);
+	spi_imx->devtype_data->intctrl(spi_imx, 0);
 	complete(&spi_imx->xfer_done);
 
 	return IRQ_HANDLED;
@@ -678,7 +691,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	} else
 		BUG();
 
-	spi_imx->devtype_data.config(spi_imx, &config);
+	spi_imx->devtype_data->config(spi_imx, &config);
 
 	return 0;
 }
@@ -697,7 +710,7 @@ static int spi_imx_transfer(struct spi_device *spi,
 
 	spi_imx_push(spi_imx);
 
-	spi_imx->devtype_data.intctrl(spi_imx, MXC_INT_TE);
+	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
 
 	wait_for_completion(&spi_imx->xfer_done);
 
@@ -724,42 +737,6 @@ static void spi_imx_cleanup(struct spi_device *spi)
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
-		.driver_data = SPI_IMX_VER_0_7,
-	}, {
-		.name = "imx27-cspi",
-		.driver_data = SPI_IMX_VER_0_0,
-	}, {
-		.name = "imx31-cspi",
-		.driver_data = SPI_IMX_VER_0_4,
-	}, {
-		.name = "imx35-cspi",
-		.driver_data = SPI_IMX_VER_0_7,
-	}, {
-		.name = "imx51-cspi",
-		.driver_data = SPI_IMX_VER_0_7,
-	}, {
-		.name = "imx51-ecspi",
-		.driver_data = SPI_IMX_VER_2_3,
-	}, {
-		.name = "imx53-cspi",
-		.driver_data = SPI_IMX_VER_0_7,
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
@@ -812,7 +789,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	init_completion(&spi_imx->xfer_done);
 
 	spi_imx->devtype_data =
-		spi_imx_devtype_data[pdev->id_entry->driver_data];
+		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -855,9 +832,9 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	clk_enable(spi_imx->clk);
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk);
 
-	spi_imx->devtype_data.reset(spi_imx);
+	spi_imx->devtype_data->reset(spi_imx);
 
-	spi_imx->devtype_data.intctrl(spi_imx, 0);
+	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
-- 
1.7.4.1
