From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Jun 2016 13:15:47 +0100
Subject: Applied "spi: s3c64xx: do not configure the device twice" to the spi
 tree
In-Reply-To: <1466150245-2648-5-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bIasl-0001D9-IA@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: do not configure the device twice

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 11f66f0927bd044c17b2c2884d5103f8eb6cab38 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 28 Jun 2016 11:41:13 +0900
Subject: [PATCH] spi: s3c64xx: do not configure the device twice

At the start of the transfer, the spi_config function is called
twice, the first time when the 3c64xx_spi_prepare_message is
called and the second time with the s3c64xx_spi_transfer_one,
both called from the spi framework.

Remove the first call at the prepare message because in that
point we don't have the imformation about "bit per word" and
frequency.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 14269b07804c..c65a9e6baefd 100644
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
