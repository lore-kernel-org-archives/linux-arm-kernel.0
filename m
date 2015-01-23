From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 23 Jan 2015 17:08:38 +0100
Subject: [PATCH 06/18] spi/xilinx: Code cleanup
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422029330-10971-7-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial fix

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 408a842..978fbdd 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -248,7 +248,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	xspi->remaining_bytes = t->len;
 	reinit_completion(&xspi->done);
 
-	for (;;) {
+	while (xspi->remaining_bytes) {
 		u16 cr;
 		int n_words;
 
@@ -278,10 +278,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		/* Read out all the data from the Rx FIFO */
 		while (n_words--)
 			xspi->rx_fn(xspi);
-
-		/* See if there is more data to send */
-		if (xspi->remaining_bytes <= 0)
-			break;
 	}
 
 	return t->len - xspi->remaining_bytes;
-- 
2.1.4
