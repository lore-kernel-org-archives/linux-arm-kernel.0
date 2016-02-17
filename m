From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 14:28:55 +0100
Subject: [PATCH 09/13] spi: imx: remove unnecessary bit clearing in
 mx51_ecspi_config
In-Reply-To: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1455715739-25161-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts patch:

| commit 1476253cef9dbfc1f7f6a1bd19252ca528cd63bd
| Author: Andrew Y. Kuksov <qxovxp@gmail.com>
| Date:   Tue Jul 14 16:23:25 2015 +0300
|
|     spi: imx: fix ecspi mode setup

The patch tried to fix something by clearing bits in the cfg variable,
but cfg is initialized to zero on function entry. There are no bits to
clear.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6a0e004..2476de7 100644
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
