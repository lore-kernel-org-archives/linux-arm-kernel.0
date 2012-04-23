From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:34 +0200
Subject: [PATCH 02/10] mtd: mxc_nand: use a flag to detect if the mx21 quirk
 is necessary
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of several instances of cpu_is_mx21() in the driver.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   72 +++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 7d82cc4..a78e763 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -173,6 +173,13 @@ struct mxc_nand_host {
 	uint16_t		(*get_dev_status)(struct mxc_nand_host *);
 	int			(*check_int)(struct mxc_nand_host *);
 	void			(*irq_control)(struct mxc_nand_host *, int);
+
+	/*
+	 * On i.MX21 the CONFIG2:INT bit cannot be read if interrupts are masked
+	 * (CONFIG1:INT_MSK is set). To handle this the driver uses
+	 * enable_irq/disable_irq_nosync instead of CONFIG1:INT_MSK
+	 */
+	int irqpending_quirk;
 };
 
 /* OOB placement block for use with hardware ecc generation */
@@ -251,7 +258,7 @@ static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
 	if (!host->check_int(host))
 		return IRQ_NONE;
 
-	host->irq_control(host, 0);
+	irq_control(host, 0);
 
 	complete(&host->op_completion);
 
@@ -280,26 +287,12 @@ static int check_int_v1_v2(struct mxc_nand_host *host)
 	if (!(tmp & NFC_V1_V2_CONFIG2_INT))
 		return 0;
 
-	if (!cpu_is_mx21())
+	if (!host->irqpending_quirk)
 		writew(tmp & ~NFC_V1_V2_CONFIG2_INT, NFC_V1_V2_CONFIG2);
 
 	return 1;
 }
 
-/*
- * It has been observed that the i.MX21 cannot read the CONFIG2:INT bit
- * if interrupts are masked (CONFIG1:INT_MSK is set). To handle this, the
- * driver can enable/disable the irq line rather than simply masking the
- * interrupts.
- */
-static void irq_control_mx21(struct mxc_nand_host *host, int activate)
-{
-	if (activate)
-		enable_irq(host->irq);
-	else
-		disable_irq_nosync(host->irq);
-}
-
 static void irq_control_v1_v2(struct mxc_nand_host *host, int activate)
 {
 	uint16_t tmp;
@@ -328,6 +321,18 @@ static void irq_control_v3(struct mxc_nand_host *host, int activate)
 	writel(tmp, NFC_V3_CONFIG2);
 }
 
+static void irq_control(struct mxc_nand_host *host, int activate)
+{
+	if (host->irqpending_quirk) {
+		if (activate)
+			enable_irq(host->irq);
+		else
+			disable_irq_nosync(host->irq);
+	} else {
+		host->irq_control(host, activate);
+	}
+}
+
 /* This function polls the NANDFC to wait for the basic operation to
  * complete by checking the INT bit of config2 register.
  */
@@ -338,7 +343,7 @@ static void wait_op_done(struct mxc_nand_host *host, int useirq)
 	if (useirq) {
 		if (!host->check_int(host)) {
 			INIT_COMPLETION(host->op_completion);
-			host->irq_control(host, 1);
+			irq_control(host, 1);
 			wait_for_completion(&host->op_completion);
 		}
 	} else {
@@ -374,7 +379,7 @@ static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 	writew(cmd, NFC_V1_V2_FLASH_CMD);
 	writew(NFC_CMD, NFC_V1_V2_CONFIG2);
 
-	if (cpu_is_mx21() && (cmd == NAND_CMD_RESET)) {
+	if (host->irqpending_quirk && (cmd == NAND_CMD_RESET)) {
 		int max_retries = 100;
 		/* Reset completion is indicated by NFC_CONFIG2 */
 		/* being set to 0 */
@@ -812,7 +817,7 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	if (nfc_is_v21())
 		config1 |= NFC_V2_CONFIG1_FP_INT;
 
-	if (!cpu_is_mx21())
+	if (!host->irqpending_quirk)
 		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
 
 	if (nfc_is_v21() && mtd->writesize) {
@@ -1103,10 +1108,9 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->send_read_id = send_read_id_v1_v2;
 		host->get_dev_status = get_dev_status_v1_v2;
 		host->check_int = check_int_v1_v2;
+		host->irq_control = irq_control_v1_v2;
 		if (cpu_is_mx21())
-			host->irq_control = irq_control_mx21;
-		else
-			host->irq_control = irq_control_v1_v2;
+			host->irqpending_quirk = 1;
 	}
 
 	if (nfc_is_v21()) {
@@ -1182,28 +1186,24 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	host->irq = platform_get_irq(pdev, 0);
 
 	/*
-	 * mask the interrupt. For i.MX21 explicitely call
-	 * irq_control_v1_v2 to use the mask bit. We can't call
-	 * disable_irq_nosync() for an interrupt we do not own yet.
+	 * Use host->irq_control here instead of irq_control because we must not
+	 * disable_irq_nosync without having requested the irq
 	 */
-	if (cpu_is_mx21())
-		irq_control_v1_v2(host, 0);
-	else
-		host->irq_control(host, 0);
+	host->irq_control(host, 0);
 
 	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
 	if (err)
 		goto eirq;
 
-	host->irq_control(host, 0);
-
 	/*
-	 * Now that the interrupt is disabled make sure the interrupt
-	 * mask bit is cleared on i.MX21. Otherwise we can't read
-	 * the interrupt status bit on this machine.
+	 * Now that we "own" the interrupt make sure the interrupt mask bit is
+	 * cleared on i.MX21. Otherwise we can't read the interrupt status bit
+	 * on this machine.
 	 */
-	if (cpu_is_mx21())
-		irq_control_v1_v2(host, 1);
+	if (host->irqpending_quirk) {
+		disable_irq_nosync(host->irq);
+		host->irq_control(host, 1);
+	}
 
 	/* first scan to find the device and get the page size */
 	if (nand_scan_ident(mtd, nfc_is_v21() ? 4 : 1, NULL)) {
-- 
1.7.10
