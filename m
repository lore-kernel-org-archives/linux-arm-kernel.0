From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Jan 2017 20:02:52 +0000
Subject: Applied "spi: mediatek: Only do dma for 4-byte aligned buffers" to
 the spi tree
In-Reply-To: <20170126162154.124287-2-djkurtz@chromium.org>
Message-ID: <E1cYedg-0005l9-8F@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: Only do dma for 4-byte aligned buffers

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

>From 1ce24864bff40e11500a699789412115fdf244bf Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Fri, 27 Jan 2017 00:21:54 +0800
Subject: [PATCH] spi: mediatek: Only do dma for 4-byte aligned buffers

Mediatek SPI DMA only works when tx and rx buffer addresses are 4-byte
aligned.

Unaligned DMA transactions appeared to work previously, since we the
spi core was incorrectly using the spi_master device for dma, which
had a 0 dma_mask, and therefore the swiotlb dma map operations were
falling back to using bounce buffers.  Since each DMA transaction would
use its own buffer, the mapped starting address of each transaction was
always aligned.  When doing real DMA, the mapped address will share the
alignment of the raw tx/rx buffer provided by the SPI user, which may or
may not be aligned.

If a buffer is not aligned, we cannot use DMA, and must use FIFO based
transaction instead.

So, this patch implements a scheme that allows using the FIFO for
arbitrary length transactions (larger than the 32-byte FIFO size) by
reloading the FIFO in the interrupt handler.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Cc: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 899d7a8f0889..278867a31950 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -73,7 +73,7 @@
 #define MTK_SPI_IDLE 0
 #define MTK_SPI_PAUSED 1
 
-#define MTK_SPI_MAX_FIFO_SIZE 32
+#define MTK_SPI_MAX_FIFO_SIZE 32U
 #define MTK_SPI_PACKET_SIZE 1024
 
 struct mtk_spi_compatible {
@@ -333,7 +333,7 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	mdata->cur_transfer = xfer;
-	mdata->xfer_len = xfer->len;
+	mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, xfer->len);
 	mtk_spi_prepare_transfer(master, xfer);
 	mtk_spi_setup_packet(master);
 
@@ -410,7 +410,10 @@ static bool mtk_spi_can_dma(struct spi_master *master,
 			    struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
-	return xfer->len > MTK_SPI_MAX_FIFO_SIZE;
+	/* Buffers for DMA transactions must be 4-byte aligned */
+	return (xfer->len > MTK_SPI_MAX_FIFO_SIZE &&
+		(unsigned long)xfer->tx_buf % 4 == 0 &&
+		(unsigned long)xfer->rx_buf % 4 == 0);
 }
 
 static int mtk_spi_setup(struct spi_device *spi)
@@ -451,7 +454,33 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 					&reg_val, remainder);
 			}
 		}
-		spi_finalize_current_transfer(master);
+
+		trans->len -= mdata->xfer_len;
+		if (!trans->len) {
+			spi_finalize_current_transfer(master);
+			return IRQ_HANDLED;
+		}
+
+		if (trans->tx_buf)
+			trans->tx_buf += mdata->xfer_len;
+		if (trans->rx_buf)
+			trans->rx_buf += mdata->xfer_len;
+
+		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, trans->len);
+		mtk_spi_setup_packet(master);
+
+		cnt = trans->len / 4;
+		iowrite32_rep(mdata->base + SPI_TX_DATA_REG, trans->tx_buf, cnt);
+
+		remainder = trans->len % 4;
+		if (remainder > 0) {
+			reg_val = 0;
+			memcpy(&reg_val, trans->tx_buf + (cnt * 4), remainder);
+			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+		}
+
+		mtk_spi_enable_transfer(master);
+
 		return IRQ_HANDLED;
 	}
 
-- 
2.11.0
