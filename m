From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Oct 2018 10:26:45 +0000 (GMT)
Subject: Applied "spi: mediatek: use correct mata->xfer_len when in fifo
 transfer" to the spi tree
In-Reply-To: <1540975756-2021-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20181031102645.E196E440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: use correct mata->xfer_len when in fifo transfer

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

>From a4d8f64f7267a88d4688f5c216926f5f6cafbae6 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Wed, 31 Oct 2018 16:49:16 +0800
Subject: [PATCH] spi: mediatek: use correct mata->xfer_len when in fifo
 transfer

when xfer_len is greater than 64 bytes and use fifo mode
to transfer, the actual length from the third time is mata->xfer_len
but not len in mtk_spi_interrupt().

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3dc31627c655..0c2867deb36f 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -522,11 +522,11 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(master);
 
-		cnt = len / 4;
+		cnt = mdata->xfer_len / 4;
 		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
 				trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = len % 4;
+		remainder = mdata->xfer_len % 4;
 		if (remainder > 0) {
 			reg_val = 0;
 			memcpy(&reg_val,
-- 
2.19.0
