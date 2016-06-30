From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Jun 2016 13:15:58 +0100
Subject: Applied "spi: s3c64xx: group the CS signalling writes in a single
 function" to the spi tree
In-Reply-To: <1466150245-2648-3-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bIasw-0001FU-Nj@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: group the CS signalling writes in a single function

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

>From aa4964c4eb3ed38666023bcb805403cb7cf2af63 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 28 Jun 2016 11:41:11 +0900
Subject: [PATCH] spi: s3c64xx: group the CS signalling writes in a single
 function

To enable/disable the CS line, the driver performs a writel in
the S3C64XX_SPI_SLAVE_SEL registers. Group the register's
configuration in a single function.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 5a76a50063b5..972367d5c7f2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -310,6 +310,28 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	dma_async_issue_pending(dma->ch);
 }
 
+static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct s3c64xx_spi_driver_data *sdd =
+					spi_master_get_devdata(spi->master);
+
+	if (enable) {
+		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO)) {
+			writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		} else {
+			u32 ssel = readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+
+			ssel |= (S3C64XX_SPI_SLAVE_AUTO |
+						S3C64XX_SPI_SLAVE_NSC_CNT_2);
+			writel(ssel, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		}
+	} else {
+		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+		writel(S3C64XX_SPI_SLAVE_SIG_INACT,
+		sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	}
+}
+
 static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
@@ -706,12 +728,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	enable_datapath(sdd, spi, xfer, use_dma);
 
 	/* Start the signals */
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
-	else
-		writel(readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL)
-			| S3C64XX_SPI_SLAVE_AUTO | S3C64XX_SPI_SLAVE_NSC_CNT_2,
-			sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, true);
 
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
@@ -861,16 +878,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, false);
+
 	return 0;
 
 setup_exit:
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, false);
 
 	if (gpio_is_valid(spi->cs_gpio))
 		gpio_free(spi->cs_gpio);
-- 
2.8.1
