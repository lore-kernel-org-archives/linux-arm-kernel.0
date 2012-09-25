From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 25 Sep 2012 13:21:57 +0200
Subject: [PATCH v2] spi/imx: set the inactive state of the clock according to
 the clock polarity
Message-ID: <1348572117-24607-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Knut Wohlrab <knut.wohlrab@de.bosch.com>

There are SPI devices which need a SPI clock with active low polarity and
high inactive state.

Add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL
according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:

DT without "spi-cpol" = 0 = clock active high polarity = inactive state low
DT with    "spi-cpol" = 1 = clock active low  polarity = inactive state high

Signed-off-by: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Changes in v2:
No functional changes on the patch itself. Add Acked-by and Sob tags,
CC to Mark Brown.

 drivers/spi/spi-imx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e834ff8..d64655b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -197,6 +197,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
 #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
 #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
 
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
@@ -287,9 +288,10 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
-	if (config->mode & SPI_CPOL)
+	if (config->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
-
+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
+	}
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
-- 
1.7.0.4
