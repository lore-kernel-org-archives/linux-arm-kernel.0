From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jan 2018 11:24:12 +0000
Subject: Applied "spi: a3700: Clear DATA_OUT when performing a read" to the
 spi tree
In-Reply-To: <1516205728-3256-2-git-send-email-maxime.chevallier@smile.fr>
Message-ID: <E1ec8Im-0003vW-Gx@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: a3700: Clear DATA_OUT when performing a read

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

>From 44a5f423e70374e5b42cecd85e78f2d79334e0f2 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@smile.fr>
Date: Wed, 17 Jan 2018 17:15:25 +0100
Subject: [PATCH] spi: a3700: Clear DATA_OUT when performing a read

When performing a read using FIFO mode, the spi controller shifts out
the last 2 bytes that were written in a previous transfer on MOSI.

This undocumented behaviour can cause devices to misinterpret the
transfer, so we explicitly clear the WFIFO before each read.

This behaviour was noticed on EspressoBin.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 77fe55ce790c..4857b0119556 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -607,6 +607,11 @@ static int a3700_spi_transfer_one(struct spi_master *master,
 	a3700_spi_header_set(a3700_spi);
 
 	if (xfer->rx_buf) {
+		/* Clear WFIFO, since it's last 2 bytes are shifted out during
+		 * a read operation
+		 */
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, 0);
+
 		/* Set read data length */
 		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
 			     a3700_spi->buf_len);
-- 
2.15.1
