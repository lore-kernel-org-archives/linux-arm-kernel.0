From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 13 Nov 2018 11:22:24 +0100
Subject: [PATCH v3 2/6] spi: Deal with slaves that return from transfer_one()
 unfinished
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
Message-ID: <20181113102228.820214-3-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers, such as spi-pxa2xx return from the transfer_one callback
immediately, idicating that the transfer will be finished asynchronously.

Normally, spi_transfer_one_message() synchronously waits for the
transfer to finish with wait_for_completion_timeout(). For slaves, we
don't want the transaction to time out as it can complete in a long time
in future. Use wait_for_completion_interruptible() instead.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changed since v2:
- Corrected the spi_transfer_wait() return value handling to avoid early
  bail out without the necessary cleanup (thanks Geert Uytterhoeven)

 drivers/spi/spi.c | 62 +++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6ca59406b0b7..498d3b9bf3ae 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1037,6 +1037,42 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	return __spi_map_msg(ctlr, msg);
 }
 
+static int spi_transfer_wait(struct spi_controller *ctlr,
+			     struct spi_message *msg,
+			     struct spi_transfer *xfer)
+{
+	struct spi_statistics *statm = &ctlr->statistics;
+	struct spi_statistics *stats = &msg->spi->statistics;
+	unsigned long long ms = 1;
+
+	if (spi_controller_is_slave(ctlr)) {
+		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
+			dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
+			return -EINTR;
+		}
+	} else {
+		ms = 8LL * 1000LL * xfer->len;
+		do_div(ms, xfer->speed_hz);
+		ms += ms + 200; /* some tolerance */
+
+		if (ms > UINT_MAX)
+			ms = UINT_MAX;
+
+		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
+						 msecs_to_jiffies(ms));
+
+		if (ms == 0) {
+			SPI_STATISTICS_INCREMENT_FIELD(statm, timedout);
+			SPI_STATISTICS_INCREMENT_FIELD(stats, timedout);
+			dev_err(&msg->spi->dev,
+				"SPI transfer timed out\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
@@ -1050,7 +1086,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	unsigned long long ms = 1;
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 
@@ -1079,28 +1114,9 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				goto out;
 			}
 
-			if (ret > 0) {
-				ret = 0;
-				ms = 8LL * 1000LL * xfer->len;
-				do_div(ms, xfer->speed_hz);
-				ms += ms + 200; /* some tolerance */
-
-				if (ms > UINT_MAX)
-					ms = UINT_MAX;
-
-				ms = wait_for_completion_timeout(&ctlr->xfer_completion,
-								 msecs_to_jiffies(ms));
-			}
-
-			if (ms == 0) {
-				SPI_STATISTICS_INCREMENT_FIELD(statm,
-							       timedout);
-				SPI_STATISTICS_INCREMENT_FIELD(stats,
-							       timedout);
-				dev_err(&msg->spi->dev,
-					"SPI transfer timed out\n");
-				msg->status = -ETIMEDOUT;
-			}
+			ret = spi_transfer_wait(ctlr, msg, xfer);
+			if (ret < 0)
+				msg->status = ret;
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
-- 
2.19.1
