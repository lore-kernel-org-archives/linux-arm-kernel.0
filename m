From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Jan 2018 15:36:23 +0000
Subject: Applied "spi: a3700: Remove endianness swapping functions when
 accessing FIFOs" to the spi tree
In-Reply-To: <1516803048-26942-2-git-send-email-maxime.chevallier@smile.fr>
Message-ID: <E1eeN67-0004sJ-Dj@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: a3700: Remove endianness swapping functions when accessing FIFOs

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

>From 162f8debc01f48ac984ed6d7291743053ec90271 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@smile.fr>
Date: Wed, 24 Jan 2018 15:10:47 +0100
Subject: [PATCH] spi: a3700: Remove endianness swapping functions when
 accessing FIFOs

Fixes the following sparse warnings :
line 504: warning: incorrect type in assignment (different base types)
line 504:    expected unsigned int [unsigned] [usertype] val
line 504:    got restricted __le32 [usertype] <noident>
line 527: warning: cast to restricted __le32

This is solved by removing endian-converson functions, since the
converted values are going through readl/writel anyway, which take care
of the conversion.

Fixes: 6fd6fd68c9e2 ("spi: armada-3700: Fix padding when sending not 4-byte aligned data")
Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index fdc35dabcda2..f32b83c7209f 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -493,7 +493,7 @@ static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
 	u32 val;
 
 	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
-		val = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
+		val = *(u32 *)a3700_spi->tx_buf;
 		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
 		a3700_spi->buf_len -= 4;
 		a3700_spi->tx_buf += 4;
@@ -516,9 +516,8 @@ static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
 	while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
 		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
 		if (a3700_spi->buf_len >= 4) {
-			u32 data = le32_to_cpu(val);
 
-			memcpy(a3700_spi->rx_buf, &data, 4);
+			memcpy(a3700_spi->rx_buf, &val, 4);
 
 			a3700_spi->buf_len -= 4;
 			a3700_spi->rx_buf += 4;
-- 
2.15.1
