From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Thu, 29 Mar 2018 21:59:02 +0300
Subject: [PATCH 1/6] spi: core: handle timeout error from transfer_one()
In-Reply-To: <20180329185907.27281-1-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
Message-ID: <20180329185907.27281-2-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As long as sun4i/sun6i SPI drivers have overriden the default
"wait for completion" procedure then we need to properly
handle -ETIMEDOUT error from transfer_one().

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727..2dcd4f6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1028,7 +1028,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			reinit_completion(&ctlr->xfer_completion);
 
 			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
-			if (ret < 0) {
+			if (ret < 0 && ret != -ETIMEDOUT) {
 				SPI_STATISTICS_INCREMENT_FIELD(statm,
 							       errors);
 				SPI_STATISTICS_INCREMENT_FIELD(stats,
@@ -1051,7 +1051,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 								 msecs_to_jiffies(ms));
 			}
 
-			if (ms == 0) {
+			if (ms == 0 || ret == -ETIMEDOUT) {
 				SPI_STATISTICS_INCREMENT_FIELD(statm,
 							       timedout);
 				SPI_STATISTICS_INCREMENT_FIELD(stats,
@@ -1059,6 +1059,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				dev_err(&msg->spi->dev,
 					"SPI transfer timed out\n");
 				msg->status = -ETIMEDOUT;
+				ret = 0;
 			}
 		} else {
 			if (xfer->len)
-- 
2.16.2
