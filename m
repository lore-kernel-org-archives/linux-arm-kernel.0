From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:49 -0700
Subject: [PATCH V2 06/12] spi/mxs: Remove full duplex check,
 spi core already does it
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-6-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the driver sets the SPI_MASTER_HALF_DUPLEX flag, the spi core
will check transfers to insure they are not full duplex.  It's not
necessary to check that in the mxs driver as well.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index ad3fd9c..208de97 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -412,12 +412,6 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		/* De-assert on last transfer, inverted by cs_change flag */
 		flag = (&t->transfer_list == m->transfers.prev) ^ t->cs_change ?
 		       TXRX_DEASSERT_CS : 0;
-		if ((t->rx_buf && t->tx_buf) || (t->rx_dma && t->tx_dma)) {
-			dev_err(ssp->dev,
-				"Cannot send and receive simultaneously\n");
-			status = -EINVAL;
-			break;
-		}
 
 		/*
 		 * Small blocks can be transfered via PIO.
-- 
1.7.10.4
