From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 17 Apr 2018 16:29:53 +0200
Subject: [PATCH v2 7/8] spi: spi-s3c64xx: Use local variable for FIFO length
In-Reply-To: <20180417142954.5507-1-s.nawrocki@samsung.com>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143053epcas1p2a1bf34ea178d1f20fee3c6ade18bf17d@epcas1p2.samsung.com>
Message-ID: <20180417142954.5507-7-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More references to fifo_len are added in subsequent patch.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index db33bc9b4147..27cd8c59eabf 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -634,6 +634,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 				    struct spi_transfer *xfer)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+	const unsigned int fifo_len = (FIFO_LVL_MASK(sdd) >> 1) + 1;
 	int status;
 	u32 speed;
 	u8 bpw;
@@ -655,9 +656,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 
 	/* Polling method for xfers not bigger than FIFO capacity */
 	use_dma = 0;
-	if (!is_polling(sdd) &&
-	    (sdd->rx_dma.ch && sdd->tx_dma.ch &&
-	     (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1))))
+	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
+	    sdd->rx_dma.ch && sdd->tx_dma.ch)
 		use_dma = 1;
 
 	spin_lock_irqsave(&sdd->lock, flags);
-- 
2.14.2
