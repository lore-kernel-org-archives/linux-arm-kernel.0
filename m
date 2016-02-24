From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Feb 2016 09:20:30 +0100
Subject: [PATCH 6/9] spi: imx: remove unnecessary bit clearing in
 mx51_ecspi_config
In-Reply-To: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1456302033-25638-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts patch 1476253cef (spi: imx: fix ecspi mode setup)
The patch tried to fix something by clearing bits in the cfg variable,
but cfg is initialized to zero on function entry. There are no bits to
clear.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 15b23f0..287ec0c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -366,20 +366,13 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
-	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
 	if (config->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
 		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
-	} else {
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
 	}
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
-	else
-		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
 	/* CTRL register always go first to bring out controller from reset */
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
-- 
2.7.0
