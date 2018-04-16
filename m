From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 16 Apr 2018 17:40:19 +0200
Subject: [PATCH 4/6] spi: spi-s3c64xx: Do not ignore timeout errors in
 polling I/O mode
In-Reply-To: <20180416154021.25626-1-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154130epcas1p492c86e911db645acf32d960281e8b297@epcas1p4.samsung.com>
Message-ID: <20180416154021.25626-4-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently timeout errors in polling I/O mode transfer are silently ignored.
Fix it by returning an error when we time out waiting on the RX FIFO level
to reach the transfer length.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e90e60bc1ecc..d87fa7d9fad3 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -502,6 +502,8 @@ static int wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 		status = readl(regs + S3C64XX_SPI_STATUS);
 	} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
 
+	if (!val)
+		return -EIO;
 
 	/* If it was only Tx */
 	if (!xfer->rx_buf) {
-- 
2.14.2
