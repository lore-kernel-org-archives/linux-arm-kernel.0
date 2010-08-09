From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 15:20:48 +0200
Subject: [PATCH 04/12] mxc_nand: factor out a check_int function
In-Reply-To: <1281360053-8386-1-git-send-email-s.hauer@pengutronix.de>
References: <1281360053-8386-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281360053-8386-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 2d2e2e7..70f64dc 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -122,6 +122,7 @@ struct mxc_nand_host {
 	void			(*send_page)(struct mtd_info *, unsigned int);
 	void			(*send_read_id)(struct mxc_nand_host *);
 	uint16_t		(*get_dev_status)(struct mxc_nand_host *);
+	int			(*check_int)(struct mxc_nand_host *);
 };
 
 /* OOB placement block for use with hardware ecc generation */
@@ -181,34 +182,38 @@ static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int check_int_v1_v2(struct mxc_nand_host *host)
+{
+	uint32_t tmp;
+
+	tmp = readw(host->regs + NFC_CONFIG2);
+	if (!(tmp & NFC_INT))
+		return 0;
+
+	writew(tmp & ~NFC_INT, NFC_CONFIG2);
+
+	return 1;
+}
+
 /* This function polls the NANDFC to wait for the basic operation to
  * complete by checking the INT bit of config2 register.
  */
 static void wait_op_done(struct mxc_nand_host *host, int useirq)
 {
-	uint16_t tmp;
 	int max_retries = 8000;
 
 	if (useirq) {
-		if ((readw(host->regs + NFC_CONFIG2) & NFC_INT) == 0) {
+		if (!host->check_int(host)) {
 
 			enable_irq(host->irq);
 
-			wait_event(host->irq_waitq,
-				readw(host->regs + NFC_CONFIG2) & NFC_INT);
-
-			tmp = readw(host->regs + NFC_CONFIG2);
-			tmp  &= ~NFC_INT;
-			writew(tmp, host->regs + NFC_CONFIG2);
+			wait_event(host->irq_waitq, host->check_int(host));
 		}
 	} else {
 		while (max_retries-- > 0) {
-			if (readw(host->regs + NFC_CONFIG2) & NFC_INT) {
-				tmp = readw(host->regs + NFC_CONFIG2);
-				tmp  &= ~NFC_INT;
-				writew(tmp, host->regs + NFC_CONFIG2);
+			if (host->check_int(host))
 				break;
-			}
+
 			udelay(1);
 		}
 		if (max_retries < 0)
@@ -774,6 +779,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->send_page = send_page_v1_v2;
 		host->send_read_id = send_read_id_v1_v2;
 		host->get_dev_status = get_dev_status_v1_v2;
+		host->check_int = check_int_v1_v2;
 	}
 
 	if (nfc_is_v21()) {
-- 
1.7.1
