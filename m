From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:49 -0000
Subject: [PATCH v3 03/13] spi: sun4i: fix FIFO limit
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <6495575d7c7e14da06f86d88a6a15042b4c6b96a.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When testing SPI without DMA I noticed that filling the FIFO on the
spi controller causes timeout.

Always leave room for one byte in the FIFO.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

---
v2:
use EMSGSIZE instead of EINVAL
v3:
fix comment style
---
 drivers/spi/spi-sun4i.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 0c2216a..f2848b7 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -180,7 +180,10 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
-		return -EINVAL;
+		return -EMSGSIZE;
+
+	if (tfr->tx_buf && tfr->len >= SUN4I_FIFO_DEPTH)
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
@@ -270,8 +273,12 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_write(sspi, SUN4I_BURST_CNT_REG, SUN4I_BURST_CNT(tfr->len));
 	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
 
-	/* Fill the TX FIFO */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+	/*
+	 * Fill the TX FIFO
+	 * Filling the FIFO fully causes timeout for some reason
+	 * at least on spi2 on A10s
+	 */
+	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
 
 	/* Enable the interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
-- 
2.8.1
