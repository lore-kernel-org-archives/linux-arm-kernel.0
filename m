From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:58 +0200
Subject: [PATCH 22/40] spi/imx: add support for imx51's eCSPI and CSPI
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-22-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX51 comes with two eCSPI interfaces (that are quite different from
what was known before---the tried and tested Freescale way) and a CSPI
interface that is identical to the devices found on i.MX25 and i.MX35.

This patch is a merge of two very similar patches (by Jason Wang and Sascha
Hauer resp.) plus a (now hopefully correct) reimplementation of the
clock calculation.

Acked-by: Jason Wang <jason77.wang@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/Kconfig   |    5 ++-
 drivers/spi/spi_imx.c |  140 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4e9d77b..7e631fa 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -153,7 +153,10 @@ config SPI_IMX_VER_0_4
 	def_bool y if ARCH_MX31
 
 config SPI_IMX_VER_0_7
-	def_bool y if ARCH_MX25 || ARCH_MX35
+	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51
+
+config SPI_IMX_VER_2_3
+	def_bool y if ARCH_MX51
 
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 23db984..6bab2cf 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -65,6 +65,7 @@ enum spi_imx_devtype {
 	SPI_IMX_VER_0_4,
 	SPI_IMX_VER_0_5,
 	SPI_IMX_VER_0_7,
+	SPI_IMX_VER_2_3,
 	SPI_IMX_VER_AUTODETECT,
 };
 
@@ -155,7 +156,7 @@ static unsigned int spi_imx_clkdiv_1(unsigned int fin,
 	return max;
 }
 
-/* MX1, MX31, MX35 */
+/* MX1, MX31, MX35, MX51 CSPI */
 static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 		unsigned int fspi)
 {
@@ -170,6 +171,128 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 	return 7;
 }
 
+#define SPI_IMX2_3_CTRL		0x08
+#define SPI_IMX2_3_CTRL_ENABLE		(1 <<  0)
+#define SPI_IMX2_3_CTRL_XCH		(1 <<  2)
+#define SPI_IMX2_3_CTRL_MODE(cs)	(1 << ((cs) +  4))
+#define SPI_IMX2_3_CTRL_POSTDIV_OFFSET	8
+#define SPI_IMX2_3_CTRL_PREDIV_OFFSET	12
+#define SPI_IMX2_3_CTRL_CS(cs)		((cs) << 18)
+#define SPI_IMX2_3_CTRL_BL_OFFSET	20
+
+#define SPI_IMX2_3_CONFIG	0x0c
+#define SPI_IMX2_3_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
+#define SPI_IMX2_3_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
+#define SPI_IMX2_3_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
+#define SPI_IMX2_3_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
+
+#define SPI_IMX2_3_INT		0x10
+#define SPI_IMX2_3_INT_TEEN		(1 <<  0)
+#define SPI_IMX2_3_INT_RREN		(1 <<  3)
+
+#define SPI_IMX2_3_STAT		0x18
+#define SPI_IMX2_3_STAT_RR		(1 <<  3)
+
+/* MX51 eCSPI */
+static unsigned int spi_imx2_3_clkdiv(unsigned int fin, unsigned int fspi)
+{
+	/*
+	 * there are two 4-bit dividers, the pre-divider divides by
+	 * $pre, the post-divider by 2^$post
+	 */
+	unsigned int pre, post;
+
+	if (unlikely(fspi > fin))
+		return 0;
+
+	post = fls(fin) - fls(fspi);
+	if (fin > fspi << post)
+		post++;
+
+	/* now we have: (fin <= fspi << post) with post being minimal */
+
+	post = max(4U, post) - 4;
+	if (unlikely(post > 0xf)) {
+		pr_err("%s: cannot set clock freq: %u (base freq: %u)\n",
+				__func__, fspi, fin);
+		return 0xff;
+	}
+
+	pre = DIV_ROUND_UP(fin, fspi << post) - 1;
+
+	pr_debug("%s: fin: %u, fspi: %u, post: %u, pre: %u\n",
+			__func__, fin, fspi, post, pre);
+	return (pre << SPI_IMX2_3_CTRL_PREDIV_OFFSET) |
+		(post << SPI_IMX2_3_CTRL_POSTDIV_OFFSET);
+}
+
+static void __maybe_unused spi_imx2_3_intctrl(struct spi_imx_data *spi_imx, int enable)
+{
+	unsigned val = 0;
+
+	if (enable & MXC_INT_TE)
+		val |= SPI_IMX2_3_INT_TEEN;
+
+	if (enable & MXC_INT_RR)
+		val |= SPI_IMX2_3_INT_RREN;
+
+	writel(val, spi_imx->base + SPI_IMX2_3_INT);
+}
+
+static void __maybe_unused spi_imx2_3_trigger(struct spi_imx_data *spi_imx)
+{
+	u32 reg;
+
+	reg = readl(spi_imx->base + SPI_IMX2_3_CTRL);
+	reg |= SPI_IMX2_3_CTRL_XCH;
+	writel(reg, spi_imx->base + SPI_IMX2_3_CTRL);
+}
+
+static int __maybe_unused spi_imx2_3_config(struct spi_imx_data *spi_imx,
+		struct spi_imx_config *config)
+{
+	u32 ctrl = SPI_IMX2_3_CTRL_ENABLE, cfg = 0;
+
+	/* set master mode */
+	ctrl |= SPI_IMX2_3_CTRL_MODE(config->cs);
+
+	/* set clock speed */
+	ctrl |= spi_imx2_3_clkdiv(spi_imx->spi_clk, config->speed_hz);
+
+	/* set chip select to use */
+	ctrl |= SPI_IMX2_3_CTRL_CS(config->cs);
+
+	ctrl |= (config->bpw - 1) << SPI_IMX2_3_CTRL_BL_OFFSET;
+
+	cfg |= SPI_IMX2_3_CONFIG_SBBCTRL(config->cs);
+
+	if (config->mode & SPI_CPHA)
+		cfg |= SPI_IMX2_3_CONFIG_SCLKPHA(config->cs);
+
+	if (config->mode & SPI_CPOL)
+		cfg |= SPI_IMX2_3_CONFIG_SCLKPOL(config->cs);
+
+	if (config->mode & SPI_CS_HIGH)
+		cfg |= SPI_IMX2_3_CONFIG_SSBPOL(config->cs);
+
+	writel(ctrl, spi_imx->base + SPI_IMX2_3_CTRL);
+	writel(cfg, spi_imx->base + SPI_IMX2_3_CONFIG);
+
+	return 0;
+}
+
+static int __maybe_unused spi_imx2_3_rx_available(struct spi_imx_data *spi_imx)
+{
+	return readl(spi_imx->base + SPI_IMX2_3_STAT) & SPI_IMX2_3_STAT_RR;
+}
+
+static void __maybe_unused spi_imx2_3_reset(struct spi_imx_data *spi_imx)
+{
+	/* drain receive buffer */
+	while (spi_imx2_3_rx_available(spi_imx))
+		readl(spi_imx->base + MXC_CSPIRXDATA);
+}
+
 #define MX31_INTREG_TEEN	(1 << 0)
 #define MX31_INTREG_RREN	(1 << 3)
 
@@ -447,6 +570,15 @@ static struct spi_imx_devtype_data spi_imx_devtype_data[] __devinitdata = {
 		.reset = spi_imx0_4_reset,
 	},
 #endif
+#ifdef CONFIG_SPI_IMX_VER_2_3
+	[SPI_IMX_VER_2_3] = {
+		.intctrl = spi_imx2_3_intctrl,
+		.config = spi_imx2_3_config,
+		.trigger = spi_imx2_3_trigger,
+		.rx_available = spi_imx2_3_rx_available,
+		.reset = spi_imx2_3_reset,
+	},
+#endif
 };
 
 static void spi_imx_chipselect(struct spi_device *spi, int is_active)
@@ -603,6 +735,12 @@ static struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx35-cspi",
 		.driver_data = SPI_IMX_VER_0_7,
 	}, {
+		.name = "imx51-cspi",
+		.driver_data = SPI_IMX_VER_0_7,
+	}, {
+		.name = "imx51-ecspi",
+		.driver_data = SPI_IMX_VER_2_3,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.7.2.3
