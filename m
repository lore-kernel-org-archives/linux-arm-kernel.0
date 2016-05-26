From: hramrach@gmail.com (Michal Suchanek)
Date: 26 May 2016 19:25:24 -0000
Subject: [PATCH 2/5] spi: sun4i: fix FIFO limit
In-Reply-To: <cover.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
Message-ID: <e315008b5e9dc3f1490507508fd2f6e94767dfbb.1464130597.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When testing SPI without DMA I noticed that filling the FIFO on the
spi controller causes timeout.

Always leave room for one byte in the FIFO.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

---
v2:
use EMSGSIZE instead of EINVAL
---
 drivers/spi/spi-sun4i.c | 8 ++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fe63bbd..04f1b77 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -180,7 +180,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
-		return -EINVAL;
+		return -EMSGSIZE;
+	if (tfr->tx_buf && tfr->len >= SUN4I_FIFO_DEPTH)
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
@@ -271,7 +273,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
 
 	/* Fill the TX FIFO */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+	/* Filling the FIFO fully causes timeout for some reason
+	 * at least on spi2 on A10s */
+	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
 
 	/* Enable the interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
