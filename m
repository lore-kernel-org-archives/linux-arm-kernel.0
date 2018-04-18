From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Apr 2018 12:40:42 +0100
Subject: Applied "spi: spi-s3c64xx: Use local variable for FIFO length" to the
 spi tree
In-Reply-To: <20180417142954.5507-7-s.nawrocki@samsung.com>
Message-ID: <E1f8lS6-00024O-GC@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-s3c64xx: Use local variable for FIFO length

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

>From f6364e66c66135f40709635849620411f3f8a2ff Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 17 Apr 2018 16:29:53 +0200
Subject: [PATCH] spi: spi-s3c64xx: Use local variable for FIFO length

More references to fifo_len are added in subsequent patch.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index db33bc9b4147..27cd8c59eabf 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -634,6 +634,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 				    struct spi_transfer *xfer)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	const unsigned int fifo_len = (FIFO_LVL_MASK(sdd) >> 1) + 1;
 	int status;
 	u32 speed;
 	u8 bpw;
@@ -655,9 +656,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 
 	/* Polling method for xfers not bigger than FIFO capacity */
 	use_dma = 0;
-	if (!is_polling(sdd) &&
-	    (sdd->rx_dma.ch && sdd->tx_dma.ch &&
-	     (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1))))
+	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
+	    sdd->rx_dma.ch && sdd->tx_dma.ch)
 		use_dma = 1;
 
 	spin_lock_irqsave(&sdd->lock, flags);
-- 
2.17.0
