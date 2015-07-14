From: qxovxp@gmail.com (Andrew Y. Kuksov)
Date: Tue, 14 Jul 2015 16:23:25 +0300
Subject: [PATCH] spi: imx: fix ecspi mode setup
Message-ID: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3

Signed-off-by: Andrew Y. Kuksov <qxovxp@gmail.com>
---
 drivers/spi/spi-imx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index eb7d3a6..36b6ece 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -335,13 +335,20 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
 	if (config->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
 		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
+	} else {
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
 	}
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
-- 
2.1.0
