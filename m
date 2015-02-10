From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 10 Feb 2015 19:59:55 +0100
Subject: [PATCH 1/6] mtd: mxc-nand: Add a timeout when waiting for interrupt
In-Reply-To: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423594800-24214-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While extending the mxc-nand driver it happend to me a few times that
the device was stuck and this made the machine hang during boot. So
implement a timeout and print a stack trace the first time this happens
to make it debuggable. The return type of the waiting function is also
changed to int to be able to handle the timeout in the caller.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c | 47 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index a8f550fec35e..27ba07c07966 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -386,26 +386,51 @@ static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
 /* This function polls the NANDFC to wait for the basic operation to
  * complete by checking the INT bit of config2 register.
  */
-static void wait_op_done(struct mxc_nand_host *host, int useirq)
+static int wait_op_done(struct mxc_nand_host *host, int useirq)
 {
-	int max_retries = 8000;
+	int ret = 0;
+
+	/*
+	 * If operation is already complete, don't bother to setup an irq or a
+	 * loop.
+	 */
+	if (host->devtype_data->check_int(host))
+		return 0;
 
 	if (useirq) {
-		if (!host->devtype_data->check_int(host)) {
-			reinit_completion(&host->op_completion);
-			irq_control(host, 1);
-			wait_for_completion(&host->op_completion);
+		unsigned long timeout;
+
+		reinit_completion(&host->op_completion);
+
+		irq_control(host, 1);
+
+		timeout = wait_for_completion_timeout(&host->op_completion, HZ);
+		if (!timeout && !host->devtype_data->check_int(host)) {
+			dev_dbg(host->dev, "timeout waiting for irq\n");
+			ret = -ETIMEDOUT;
 		}
 	} else {
-		while (max_retries-- > 0) {
-			if (host->devtype_data->check_int(host))
-				break;
+		int max_retries = 8000;
+		int done;
 
+		do {
 			udelay(1);
+
+			done = host->devtype_data->check_int(host);
+			if (done)
+				break;
+
+		} while (--max_retries);
+
+		if (!done) {
+			dev_dbg(host->dev, "timeout polling for completion\n");
+			ret = -ETIMEDOUT;
 		}
-		if (max_retries < 0)
-			pr_debug("%s: INT not set\n", __func__);
 	}
+
+	WARN_ONCE(ret < 0, "timeout! useirq=%d\n", useirq);
+
+	return ret;
 }
 
 static void send_cmd_v3(struct mxc_nand_host *host, uint16_t cmd, int useirq)
-- 
2.1.4
