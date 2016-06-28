From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 28 Jun 2016 11:41:13 +0900
Subject: [PATCH v2 3/5] spi: s3c64xx: do not configure the device twice
In-Reply-To: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467081676-8442-4-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the start of the transfer, the spi_config function is called
twice, the first time when the 3c64xx_spi_prepare_message is
called and the second time with the s3c64xx_spi_transfer_one,
both called from the spi framework.

Remove the first call at the prepare message because in that
point we don't have the imformation about "bit per word" and
frequency.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 14269b0..c65a9e6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -676,16 +676,6 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 
-	/* If Master's(controller) state differs from that needed by Slave */
-	if (sdd->cur_speed != spi->max_speed_hz
-			|| sdd->cur_mode != spi->mode
-			|| sdd->cur_bpw != spi->bits_per_word) {
-		sdd->cur_bpw = spi->bits_per_word;
-		sdd->cur_speed = spi->max_speed_hz;
-		sdd->cur_mode = spi->mode;
-		s3c64xx_spi_config(sdd);
-	}
-
 	/* Configure feedback delay */
 	writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
 
@@ -712,6 +702,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	if (bpw != sdd->cur_bpw || speed != sdd->cur_speed) {
 		sdd->cur_bpw = bpw;
 		sdd->cur_speed = speed;
+		sdd->cur_mode = spi->mode;
 		s3c64xx_spi_config(sdd);
 	}
 
-- 
2.8.1
