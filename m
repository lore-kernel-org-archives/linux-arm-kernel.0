From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Apr 2018 12:40:49 +0100
Subject: Applied "spi: spi-s3c64xx: Add missing s3c64xx_ prefix to function
 names" to the spi tree
In-Reply-To: <20180417142954.5507-5-s.nawrocki@samsung.com>
Message-ID: <E1f8lSD-00026j-Na@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-s3c64xx: Add missing s3c64xx_ prefix to function names

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 3655d30c054816331820842b0a1db75f58aeadc9 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 17 Apr 2018 16:29:51 +0200
Subject: [PATCH] spi: spi-s3c64xx: Add missing s3c64xx_ prefix to function
 names

Add a s3c64xx_ prefix to remaining generic function names so it is clear
the code is part of the driver when grepping or looking at debug logs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 38a5e9ce5f11..db33bc9b4147 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -188,7 +188,7 @@ struct s3c64xx_spi_driver_data {
 	unsigned int			port_id;
 };
 
-static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
+static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long loops;
@@ -348,8 +348,8 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 }
 
-static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-			    struct spi_transfer *xfer, int dma_mode)
+static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
+				    struct spi_transfer *xfer, int dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
@@ -439,8 +439,8 @@ static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 	return RX_FIFO_LVL(status, sdd);
 }
 
-static int wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
-			struct spi_transfer *xfer)
+static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
+				struct spi_transfer *xfer)
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
@@ -482,8 +482,8 @@ static int wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 	return 0;
 }
 
-static int wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
-			struct spi_transfer *xfer)
+static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
+				struct spi_transfer *xfer)
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
@@ -666,7 +666,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	sdd->state &= ~RXBUSY;
 	sdd->state &= ~TXBUSY;
 
-	enable_datapath(sdd, xfer, use_dma);
+	s3c64xx_enable_datapath(sdd, xfer, use_dma);
 
 	/* Start the signals */
 	s3c64xx_spi_set_cs(spi, true);
@@ -674,9 +674,9 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
 	if (use_dma)
-		status = wait_for_dma(sdd, xfer);
+		status = s3c64xx_wait_for_dma(sdd, xfer);
 	else
-		status = wait_for_pio(sdd, xfer);
+		status = s3c64xx_wait_for_pio(sdd, xfer);
 
 	if (status) {
 		dev_err(&spi->dev, "I/O Error: rx-%d tx-%d res:rx-%c tx-%c len-%d\n",
@@ -694,7 +694,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 				dmaengine_terminate_all(sdd->rx_dma.ch);
 		}
 	} else {
-		flush_fifo(sdd);
+		s3c64xx_flush_fifo(sdd);
 	}
 
 	return status;
@@ -928,7 +928,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 	val |= (S3C64XX_SPI_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-	flush_fifo(sdd);
+	s3c64xx_flush_fifo(sdd);
 }
 
 #ifdef CONFIG_OF
-- 
2.17.0
