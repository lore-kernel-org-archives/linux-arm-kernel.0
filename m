From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:22 +0200
Subject: [PATCH 04/16] spi/imx: save the spi chip select in config struct,
	not the gpio to use
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares adding support for imx51's eCSPI.  This IP has seperate
control and config bits for all four supported chip selects, so the
config routine needs to know which chip select is being used even if
the chipselect is realized by a gpio.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi_imx.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 60a52d1..23db984 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -56,7 +56,7 @@ struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
 	unsigned int mode;
-	int cs;
+	u8 cs;
 };
 
 enum spi_imx_devtype {
@@ -218,6 +218,7 @@ static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
+	int cs = spi_imx->chipselect[config->cs];
 
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
 		MX31_CSPICTRL_DR_SHIFT;
@@ -230,9 +231,8 @@ static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
 		reg |= MX31_CSPICTRL_POL;
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (config->cs < 0) {
-		reg |= (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
-	}
+	if (cs < 0)
+		reg |= (cs + 32) << MX31_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
@@ -243,6 +243,7 @@ static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
+	int cs = spi_imx->chipselect[config->cs];
 
 	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
 		MX31_CSPICTRL_DR_SHIFT;
@@ -256,8 +257,8 @@ static int __maybe_unused spi_imx0_7_config(struct spi_imx_data *spi_imx,
 		reg |= MX31_CSPICTRL_POL;
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (config->cs < 0)
-		reg |= (config->cs + 32) << MX35_CSPICTRL_CS_SHIFT;
+	if (cs < 0)
+		reg |= (cs + 32) << MX35_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
@@ -314,6 +315,7 @@ static int __maybe_unused mx27_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	unsigned int reg = MX27_CSPICTRL_ENABLE | MX27_CSPICTRL_MASTER;
+	int cs = spi_imx->chipselect[config->cs];
 
 	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz) <<
 		MX27_CSPICTRL_DR_SHIFT;
@@ -325,8 +327,8 @@ static int __maybe_unused mx27_config(struct spi_imx_data *spi_imx,
 		reg |= MX27_CSPICTRL_POL;
 	if (config->mode & SPI_CS_HIGH)
 		reg |= MX27_CSPICTRL_SSPOL;
-	if (config->cs < 0)
-		reg |= (config->cs + 32) << MX27_CSPICTRL_CS_SHIFT;
+	if (cs < 0)
+		reg |= (cs + 32) << MX27_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
@@ -510,7 +512,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
 	config.mode = spi->mode;
-	config.cs = spi_imx->chipselect[spi->chip_select];
+	config.cs = spi->chip_select;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
-- 
1.7.2.3
