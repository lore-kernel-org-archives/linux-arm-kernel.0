From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Aug 2010 14:14:32 +0200
Subject: [PATCH 11/12] mxc_nand: do not depend on disabling the irq in the
	interrupt handler
In-Reply-To: <1281442473-31428-1-git-send-email-s.hauer@pengutronix.de>
References: <1281442473-31428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281442473-31428-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reverts the driver to enabling/disabling the NFC interrupt
mask rather than enabling/disabling the system interrupt. This cleans
up the driver so that it doesn't rely on interrupts being disabled
within the interrupt handler.
This patch is based on earlier work by John Ogness.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   78 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 3767dcc..0cc4343 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -30,6 +30,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/completion.h>
 
 #include <asm/mach/flash.h>
 #include <mach/mxc_nand.h>
@@ -149,7 +151,7 @@ struct mxc_nand_host {
 	int			irq;
 	int			eccsize;
 
-	wait_queue_head_t	irq_waitq;
+	struct completion	op_completion;
 
 	uint8_t			*data_buf;
 	unsigned int		buf_start;
@@ -162,6 +164,7 @@ struct mxc_nand_host {
 	void			(*send_read_id)(struct mxc_nand_host *);
 	uint16_t		(*get_dev_status)(struct mxc_nand_host *);
 	int			(*check_int)(struct mxc_nand_host *);
+	void			(*irq_control)(struct mxc_nand_host *, int);
 };
 
 /* OOB placement block for use with hardware ecc generation */
@@ -214,9 +217,14 @@ static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
 {
 	struct mxc_nand_host *host = dev_id;
 
-	disable_irq_nosync(irq);
+	if (!host->check_int(host)) {
+		printk("none?\n");
+		return IRQ_NONE;
+	}
+
+	host->irq_control(host, 0);
 
-	wake_up(&host->irq_waitq);
+	complete(&host->op_completion);
 
 	return IRQ_HANDLED;
 }
@@ -243,11 +251,54 @@ static int check_int_v1_v2(struct mxc_nand_host *host)
 	if (!(tmp & NFC_V1_V2_CONFIG2_INT))
 		return 0;
 
-	writew(tmp & ~NFC_V1_V2_CONFIG2_INT, NFC_V1_V2_CONFIG2);
+	if (!cpu_is_mx21())
+		writew(tmp & ~NFC_V1_V2_CONFIG2_INT, NFC_V1_V2_CONFIG2);
 
 	return 1;
 }
 
+/*
+ * It has been observed that the i.MX21 cannot read the CONFIG2:INT bit
+ * if interrupts are masked (CONFIG1:INT_MSK is set). To handle this, the
+ * driver can enable/disable the irq line rather than simply masking the
+ * interrupts.
+ */
+static void irq_control_mx21(struct mxc_nand_host *host, int activate)
+{
+	if (activate)
+		enable_irq(host->irq);
+	else
+		disable_irq_nosync(host->irq);
+}
+
+static void irq_control_v1_v2(struct mxc_nand_host *host, int activate)
+{
+	uint16_t tmp;
+
+	tmp = readw(NFC_V1_V2_CONFIG1);
+
+	if (activate)
+		tmp &= ~NFC_V1_V2_CONFIG1_INT_MSK;
+	else
+		tmp |= NFC_V1_V2_CONFIG1_INT_MSK;
+
+	writew(tmp, NFC_V1_V2_CONFIG1);
+}
+
+static void irq_control_v3(struct mxc_nand_host *host, int activate)
+{
+	uint32_t tmp;
+
+	tmp = readl(NFC_V3_CONFIG2);
+
+	if (activate)
+		tmp &= ~NFC_V3_CONFIG2_INT_MSK;
+	else
+		tmp |= NFC_V3_CONFIG2_INT_MSK;
+
+	writel(tmp, NFC_V3_CONFIG2);
+}
+
 /* This function polls the NANDFC to wait for the basic operation to
  * complete by checking the INT bit of config2 register.
  */
@@ -257,10 +308,9 @@ static void wait_op_done(struct mxc_nand_host *host, int useirq)
 
 	if (useirq) {
 		if (!host->check_int(host)) {
-
-			enable_irq(host->irq);
-
-			wait_event(host->irq_waitq, host->check_int(host));
+			INIT_COMPLETION(host->op_completion);
+			host->irq_control(host, 1);
+			wait_for_completion(&host->op_completion);
 		}
 	} else {
 		while (max_retries-- > 0) {
@@ -731,9 +781,8 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	struct mxc_nand_host *host = nand_chip->priv;
 	uint16_t tmp;
 
-	/* enable interrupt, disable spare enable */
+	/* disable spare enable */
 	tmp = readw(NFC_V1_V2_CONFIG1);
-	tmp &= ~NFC_V1_V2_CONFIG1_INT_MSK;
 	tmp &= ~NFC_V1_V2_CONFIG1_SP_EN;
 	if (nand_chip->ecc.mode == NAND_ECC_HW) {
 		tmp |= NFC_V1_V2_CONFIG1_ECC_EN;
@@ -1019,6 +1068,10 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->send_read_id = send_read_id_v1_v2;
 		host->get_dev_status = get_dev_status_v1_v2;
 		host->check_int = check_int_v1_v2;
+		if (cpu_is_mx21())
+			host->irq_control = irq_control_mx21;
+		else
+			host->irq_control = irq_control_v1_v2;
 	}
 
 	if (nfc_is_v21()) {
@@ -1057,6 +1110,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->send_read_id = send_read_id_v3;
 		host->check_int = check_int_v3;
 		host->get_dev_status = get_dev_status_v3;
+		host->irq_control = irq_control_v3;
 		oob_smallpage = &nandv2_hw_eccoob_smallpage;
 		oob_largepage = &nandv2_hw_eccoob_largepage;
 	} else
@@ -1088,7 +1142,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		this->options |= NAND_USE_FLASH_BBT;
 	}
 
-	init_waitqueue_head(&host->irq_waitq);
+	init_completion(&host->op_completion);
 
 	host->irq = platform_get_irq(pdev, 0);
 
@@ -1096,6 +1150,8 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	if (err)
 		goto eirq;
 
+	host->irq_control(host, 0);
+
 	/* first scan to find the device and get the page size */
 	if (nand_scan_ident(mtd, 1, NULL)) {
 		err = -ENXIO;
-- 
1.7.1
