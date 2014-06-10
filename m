From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 10 Jun 2014 17:50:09 +0800
Subject: [PATCH v2 1/3] mtd: atmel_nand: add NFC status error check
Message-ID: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new function to read the NFC status. Meantime, this function will
theck if there is any errors in NFC.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c     |   24 +++++++++++++++++++++++-
 drivers/mtd/nand/atmel_nand_nfc.h |    4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index ec97ccb..25d9921 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1572,6 +1572,25 @@ static int atmel_hw_nand_init_params(struct platform_device *pdev,
 	return 0;
 }
 
+static inline u32 nfc_read_status(struct atmel_nand_host *host)
+{
+	u32 err_flags = NFC_SR_DTOE | NFC_SR_UNDEF | NFC_SR_AWB | NFC_SR_ASE;
+	u32 nfc_status = nfc_readl(host->nfc->hsmc_regs, SR);
+
+	if (unlikely(nfc_status & err_flags)) {
+		if (nfc_status & NFC_SR_DTOE)
+			dev_err(host->dev, "NFC: Waiting Nand R/B Timeout Error\n");
+		else if (nfc_status & NFC_SR_UNDEF)
+			dev_err(host->dev, "NFC: Access Undefined Area Error\n");
+		else if (nfc_status & NFC_SR_AWB)
+			dev_err(host->dev, "NFC: Access memory While NFC is busy\n");
+		else if (nfc_status & NFC_SR_ASE)
+			dev_err(host->dev, "NFC: Access memory Size Error\n");
+	}
+
+	return nfc_status;
+}
+
 /* SMC interrupt service routine */
 static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
 {
@@ -1579,7 +1598,7 @@ static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
 	u32 status, mask, pending;
 	irqreturn_t ret = IRQ_HANDLED;
 
-	status = nfc_readl(host->nfc->hsmc_regs, SR);
+	status = nfc_read_status(host);
 	mask = nfc_readl(host->nfc->hsmc_regs, IMR);
 	pending = status & mask;
 
@@ -2210,6 +2229,9 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 		}
 	}
 
+	nfc_writel(nfc->hsmc_regs, IDR, 0xffffffff);
+	nfc_readl(nfc->hsmc_regs, SR);	/* clear the NFC_SR */
+
 	nfc->is_initialized = true;
 	dev_info(&pdev->dev, "NFC is probed.\n");
 	return 0;
diff --git a/drivers/mtd/nand/atmel_nand_nfc.h b/drivers/mtd/nand/atmel_nand_nfc.h
index 4efd117..85b8ca6 100644
--- a/drivers/mtd/nand/atmel_nand_nfc.h
+++ b/drivers/mtd/nand/atmel_nand_nfc.h
@@ -37,6 +37,10 @@
 #define ATMEL_HSMC_NFC_SR	0x08		/* NFC Status Register */
 #define		NFC_SR_XFR_DONE		(1 << 16)
 #define		NFC_SR_CMD_DONE		(1 << 17)
+#define		NFC_SR_DTOE		(1 << 20)
+#define		NFC_SR_UNDEF		(1 << 21)
+#define		NFC_SR_AWB		(1 << 22)
+#define		NFC_SR_ASE		(1 << 23)
 #define		NFC_SR_RB_EDGE		(1 << 24)
 
 #define ATMEL_HSMC_NFC_IER	0x0c
-- 
1.7.9.5
