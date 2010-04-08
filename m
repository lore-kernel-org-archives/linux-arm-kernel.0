From: ivo.clarysse@gmail.com (Ivo Clarysse)
Date: Thu, 8 Apr 2010 16:16:51 +0200
Subject: [PATCH v3 2/2] MXC: mxc_nand: support i.MX21
Message-ID: <p2gba216b431004080716na31c9a27re2dc8621679401ba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX21 SoCs, if the NFC_CONFIG1:NFC_INT_MASK bit is set,
NFC_CONFIG2:NFC_INT always reads out zero, even if an
operation is completed.  This patch uses enable_irq and
disable_irq_nosync instead of NFC_CONFIG1:NFC_INT_MASK to
mask NFC interrupts.  This allows NFC_CONFIG2:NFC_INT to also
be used to detect operation completion on i.MX21.

The i.MX21 NFC does not signal reset completion using
NFC_CONFIG1:NFC_INT_MASK, so instead reset completion is
tested by checking if NFC_CONFIG2 becomes 0.

Signed-off-by: Ivo Clarysse <ivo.clarysse@gmail.com>
---
diff -u -r -N linux-2.6.33.2-reset/drivers/mtd/nand/mxc_nand.c
linux-2.6.33.2-mine/drivers/mtd/nand/mxc_nand.c
--- linux-2.6.33.2-reset/drivers/mtd/nand/mxc_nand.c	2010-04-08
15:54:10.000000000 +0200
+++ linux-2.6.33.2-mine/drivers/mtd/nand/mxc_nand.c	2010-04-08
14:01:58.000000000 +0200
@@ -38,7 +38,7 @@
 #define DRIVER_NAME "mxc_nand"

 #define nfc_is_v21()		(cpu_is_mx25() || cpu_is_mx35())
-#define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27())
+#define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())

 /* Addresses for NFC registers */
 #define NFC_BUF_SIZE		0xE00
@@ -168,11 +168,7 @@
 {
 	struct mxc_nand_host *host = dev_id;

-	uint16_t tmp;
-
-	tmp = readw(host->regs + NFC_CONFIG1);
-	tmp |= NFC_INT_MSK; /* Disable interrupt */
-	writew(tmp, host->regs + NFC_CONFIG1);
+	disable_irq_nosync(irq);

 	wake_up(&host->irq_waitq);

@@ -184,15 +180,13 @@
  */
 static void wait_op_done(struct mxc_nand_host *host, int useirq)
 {
-	uint32_t tmp;
-	int max_retries = 2000;
+	uint16_t tmp;
+	int max_retries = 8000;

 	if (useirq) {
 		if ((readw(host->regs + NFC_CONFIG2) & NFC_INT) == 0) {

-			tmp = readw(host->regs + NFC_CONFIG1);
-			tmp  &= ~NFC_INT_MSK;	/* Enable interrupt */
-			writew(tmp, host->regs + NFC_CONFIG1);
+			enable_irq(host->irq);

 			wait_event(host->irq_waitq,
 				readw(host->regs + NFC_CONFIG2) & NFC_INT);
@@ -226,8 +220,23 @@
 	writew(cmd, host->regs + NFC_FLASH_CMD);
 	writew(NFC_CMD, host->regs + NFC_CONFIG2);

-	/* Wait for operation to complete */
-	wait_op_done(host, useirq);
+	if (cpu_is_mx21() && (cmd == NAND_CMD_RESET)) {
+		int max_retries = 100;
+		/* Reset completion is indicated by NFC_CONFIG2 */
+		/* being set to 0 */
+		while (max_retries-- > 0) {
+			if (readw(host->regs + NFC_CONFIG2) == 0) {
+				break;
+			}
+			udelay(1);
+		}
+		if (max_retries < 0)
+			DEBUG(MTD_DEBUG_LEVEL0, "%s: RESET failed\n",
+			      __func__);
+	} else {
+		/* Wait for operation to complete */
+		wait_op_done(host, useirq);
+	}
 }

 /* This function sends an address (or partial address) to the
@@ -548,9 +557,9 @@
 	struct mxc_nand_host *host = nand_chip->priv;
 	uint16_t tmp;

-	/* disable interrupt, disable spare enable */
+	/* enable interrupt, disable spare enable */
 	tmp = readw(host->regs + NFC_CONFIG1);
-	tmp |= NFC_INT_MSK;
+	tmp &= ~NFC_INT_MSK;
 	tmp &= ~NFC_SP_EN;
 	if (nand_chip->ecc.mode == NAND_ECC_HW) {
 		tmp |= NFC_ECC_EN;
@@ -819,7 +828,7 @@

 	host->irq = platform_get_irq(pdev, 0);

-	err = request_irq(host->irq, mxc_nfc_irq, 0, DRIVER_NAME, host);
+	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
 	if (err)
 		goto eirq;
