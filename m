From: hramrach@gmail.com (Michal Suchanek)
Date: 20 Aug 2015 14:19:46 -0000
Subject: [PATCH 2/9] spi: sun4i: fix FIFO limit
In-Reply-To: <cover.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
Message-ID: <a40fbf7ca8bd36f08f5e9d3fb6f6de2454066af7.1440080122.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When testing SPI without DMA I noticed that filling the FIFO on the
spi controller causes timeout.

Always leave room for one byte in the FIFO.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 48532ec..707f61b 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -178,6 +178,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
 		return -EINVAL;
+	if (tfr->tx_buf && tfr->len => SUN4I_FIFO_DEPTH)
+		return -EINVAL;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
@@ -271,7 +273,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
 
 	/* Fill the TX FIFO */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+	/* Filling the fifo fully causes timeout for some reason
+	 * at least on spi2 on a10s */
+	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
 
 	/* Enable the interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
-- 
2.1.4
