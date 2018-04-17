From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 17 Apr 2018 16:29:47 +0200
Subject: [PATCH v2 1/8] spi: spi-s3c64xx: Do not ignore timeout errors in
 polling I/O mode
References: <CGME20180417143022epcas2p1185d48998a1659ce6580180ea6725607@epcas2p1.samsung.com>
Message-ID: <20180417142954.5507-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently timeout errors in polling I/O mode transfer are silently ignored.
Fix it by returning an error when we time out waiting on the RX FIFO level
to reach the transfer length.

Reviewed-by: Andi Shyti <andi@etezian.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index baa3a9fa2638..9a990bc3138a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -505,6 +505,8 @@ static int wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 		status = readl(regs + S3C64XX_SPI_STATUS);
 	} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
 
+	if (!val)
+		return -EIO;
 
 	/* If it was only Tx */
 	if (!xfer->rx_buf) {
-- 
2.14.2
