From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 04 Jul 2011 13:39:31 -0400
Subject: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO level
In-Reply-To: <1309801171-19818-1-git-send-email-padma.v@samsung.com>
References: <1309801171-19818-1-git-send-email-padma.v@samsung.com>
Message-ID: <1309801171-19818-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing macro fails for following scenarios.
1) S5P64X0 channel 1
2) S5PV210 channel 1

The FIFO data level supported in the above SoCs either 64 or 256
bytes depending on the channel. Because of this the TX_DONE
is the 25 bit in the status register.

The existing macro works for the following scenarios
1) S3C6410 all channels
2) S5PC100 all channels

The FIFO data level supported in the above SoCs 64 bytes
on all the channels. Because of this the TX_DONE is the 21 bit
in the status register.

So when we use the existing macro for the non-working SoCs
 it is not anding with the TX_DONE bit for transmission status check.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/spi_s3c64xx.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 795828b..8945e20 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -116,9 +116,7 @@
 					(((i)->fifo_lvl_mask + 1))) \
 					? 1 : 0)
 
-#define S3C64XX_SPI_ST_TX_DONE(v, i) ((((v) >> (i)->rx_lvl_offset) & \
-					(((i)->fifo_lvl_mask + 1) << 1)) \
-					? 1 : 0)
+#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_done)) ? 1 : 0)
 #define TX_FIFO_LVL(v, i) (((v) >> 6) & (i)->fifo_lvl_mask)
 #define RX_FIFO_LVL(v, i) (((v) >> (i)->rx_lvl_offset) & (i)->fifo_lvl_mask)
 
-- 
1.7.0.4
