From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 17 Jun 2016 16:57:23 +0900
Subject: [PATCH 3/5] spi: s3c64xx: consider the case where the CS line is not
 connected
In-Reply-To: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1466150245-2648-4-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the CS line is not connected, it is not needed to enable or
disable the chip selection functionality from the s3c64xx
devices. Keep et enable already at the initialization (by writing
'0' in the S3C64XX_SPI_SLAVE_SEL register) and never disable it.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 972367d..3d54c5f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -315,6 +315,9 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 	struct s3c64xx_spi_driver_data *sdd =
 					spi_master_get_devdata(spi->master);
 
+	if (!sdd->master->num_chipselect)
+		return;
+
 	if (enable) {
 		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO)) {
 			writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
@@ -960,7 +963,9 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 
 	sdd->cur_speed = 0;
 
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+	if (!sdd->master->num_chipselect)
+		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	else if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
 		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 	/* Disable Interrupts - we use Polling if not DMA mode */
-- 
2.8.1
