From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:47 -0700
Subject: [PATCH V2 04/12] spi/mxs: Fix extra CS pulses and read mode in
 multi-transfer messages
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-4-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two bits which control the CS line in the CTRL0 register:
LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
in SPI mode.

Setting DEASSERT_CS causes CS to be de-asserted at the end of the
transfer.  It would normally be set on the final segment of the final
transfer.  The DMA code explicitly sets it in this case, but because
it never clears the bit from the ctrl0 register is will remain set for
all transfers in subsequent messages.  This results in a CS pulse
between transfers.

There is a similar problem with the read mode bit never being cleared
in DMA mode.

This patch fixes DEASSERT_CS and READ being left on in DMA mode.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 3064304..86a714b 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -230,7 +230,8 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	INIT_COMPLETION(spi->c);
 
 	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
-	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
+	ctrl0 &= ~(BM_SSP_CTRL0_XFER_COUNT | BM_SSP_CTRL0_IGNORE_CRC |
+		 BM_SSP_CTRL0_READ);
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
 	if (!(flags & TXRX_WRITE))
-- 
1.7.10.4
