From: john.ogness@linutronix.de (John Ogness)
Date: Tue, 10 Aug 2010 13:36:54 +0200
Subject: [PATCH 3/3] mxc_nand: mask instead of disabling (i.MX21 as exception)
In-Reply-To: <80mxsu3dl1.fsf@merkur.tec.linutronix.de> (John Ogness's message
	of "Tue, 10 Aug 2010 13:35:22 +0200")
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<80mxsu3dl1.fsf@merkur.tec.linutronix.de>
Message-ID: <80hbj23dih.fsf_-_@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reverts the driver to using the NFC interrupt mask rather
than enabling/disabling the system interrupt. This cleans up the
driver so that it doesn't rely on interrupts being disabled
within the interrupt handler. The required workaround for the i.MX21
has been encapsulated using the nfc_avoid_masking macro.

This patch is against the latest patches from Sascha Hauer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |  138 ++++++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 29 deletions(-)

Index: linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-2.6-454a740.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
@@ -30,6 +30,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/completion.h>
 
 #include <asm/mach/flash.h>
 #include <mach/mxc_nand.h>
@@ -42,6 +44,13 @@
 #define nfc_is_v3_2()		cpu_is_mx51()
 #define nfc_is_v3()		nfc_is_v3_2()
 
+/* It has been observed that the i.MX21 cannot read its CONFIG2:INT bit
+ * if interrupts are masked (CONFIG1:INT_MSK is set). To handle this, the
+ * driver can enable/disable the irq line rather than simply masking the
+ * interrupts. The nfc_avoid_masking() macro identifies the systems that
+ * should use this workaround. */
+#define nfc_avoid_masking()    (cpu_is_mx21())
+
 /* Addresses for NFC registers */
 #define NFC_V1_V2_BUF_SIZE		(host->regs + 0x00)
 #define NFC_V1_V2_BUF_ADDR		(host->regs + 0x04)
@@ -151,7 +160,7 @@ struct mxc_nand_host {
 	int			irq;
 	int			eccsize;
 
-	wait_queue_head_t	irq_waitq;
+	struct completion	op_completion;
 
 	uint8_t			*data_buf;
 	unsigned int		buf_start;
@@ -163,7 +172,10 @@ struct mxc_nand_host {
 	void			(*send_page)(struct mtd_info *, unsigned int);
 	void			(*send_read_id)(struct mxc_nand_host *);
 	uint16_t		(*get_dev_status)(struct mxc_nand_host *);
-	int			(*check_int)(struct mxc_nand_host *);
+	int			(*isset_int)(struct mxc_nand_host *);
+	void			(*ack_int)(struct mxc_nand_host *);
+	void			(*mask_int)(struct mxc_nand_host *);
+	void			(*unmask_int)(struct mxc_nand_host *);
 };
 
 /* OOB placement block for use with hardware ecc generation */
@@ -216,38 +228,74 @@ static irqreturn_t mxc_nfc_irq(int irq, 
 {
 	struct mxc_nand_host *host = dev_id;
 
-	disable_irq_nosync(irq);
-
-	wake_up(&host->irq_waitq);
+	/* If NFC_INT is not set, we have a spurious interrupt! */
+	if (!host->isset_int(host))
+		return IRQ_NONE;
+
+	/* Even with nfc_avoid_masking() we mask the interrupt
+	 * here to avoid an interrupt flood until the irq line
+	 * is disabled by the driver thread. */
+	host->mask_int(host);
+
+	/* Notify the driver thread that an interrupt has occurred.
+	 * The driver thread will clear the interrupt. */
+	complete(&host->op_completion);
 
 	return IRQ_HANDLED;
 }
 
-static int check_int_v3(struct mxc_nand_host *host)
+static int isset_int_v3(struct mxc_nand_host *host)
 {
-	uint32_t tmp;
-
-	tmp = readl(NFC_V3_IPC);
-	if (!(tmp & NFC_V3_IPC_INT))
-		return 0;
+	uint32_t tmp = readl(NFC_V3_IPC);
+	return (tmp & NFC_V3_IPC_INT);
+}
 
+static void ack_int_v3(struct mxc_nand_host *host)
+{
+	uint32_t tmp = readl(NFC_V3_IPC);
 	tmp &= ~NFC_V3_IPC_INT;
 	writel(tmp, NFC_V3_IPC);
+}
 
-	return 1;
+static void mask_int_v3(struct mxc_nand_host *host)
+{
+	uint32_t tmp = readl(NFC_V3_CONFIG2);
+	tmp |= NFC_V3_CONFIG2_INT_MSK;
+	writel(tmp, NFC_V3_CONFIG2);
 }
 
-static int check_int_v1_v2(struct mxc_nand_host *host)
+static void unmask_int_v3(struct mxc_nand_host *host)
 {
-	uint32_t tmp;
+	uint32_t tmp = readl(NFC_V3_CONFIG2);
+	tmp &= ~NFC_V3_CONFIG2_INT_MSK;
+	writel(tmp, NFC_V3_CONFIG2);
+}
 
-	tmp = readw(NFC_V1_V2_CONFIG2);
-	if (!(tmp & NFC_V1_V2_CONFIG2_INT))
-		return 0;
+static int isset_int_v1_v2(struct mxc_nand_host *host)
+{
+	uint16_t tmp = readw(NFC_V1_V2_CONFIG2);
+	return (tmp & NFC_V1_V2_CONFIG2_INT);
+}
 
-	writew(tmp & ~NFC_V1_V2_CONFIG2_INT, NFC_V1_V2_CONFIG2);
+static void ack_int_v1_v2(struct mxc_nand_host *host)
+{
+	uint16_t tmp = readw(NFC_V1_V2_CONFIG2);
+	tmp &= ~NFC_V1_V2_CONFIG2_INT;
+	writew(tmp, NFC_V1_V2_CONFIG2);
+}
 
-	return 1;
+static void mask_int_v1_v2(struct mxc_nand_host *host)
+{
+	uint16_t tmp = readw(NFC_V1_V2_CONFIG1);
+	tmp |= NFC_V1_V2_CONFIG1_INT_MSK;
+	writew(tmp, NFC_V1_V2_CONFIG1);
+}
+
+static void unmask_int_v1_v2(struct mxc_nand_host *host)
+{
+	uint16_t tmp = readw(NFC_V1_V2_CONFIG1);
+	tmp &= ~NFC_V1_V2_CONFIG1_INT_MSK;
+	writew(tmp, NFC_V1_V2_CONFIG1);
 }
 
 /* This function polls the NANDFC to wait for the basic operation to
@@ -258,16 +306,33 @@ static void wait_op_done(struct mxc_nand
 	int max_retries = 8000;
 
 	if (useirq) {
-		if (!host->check_int(host)) {
-
-			enable_irq(host->irq);
+		if (!host->isset_int(host)) {
+			INIT_COMPLETION(host->op_completion);
 
-			wait_event(host->irq_waitq, host->check_int(host));
+			if (nfc_avoid_masking())
+				enable_irq(host->irq);
+			else
+				host->unmask_int(host);
+
+			/* wait for the interrupt */
+			wait_for_completion(&host->op_completion);
+
+			/* The irq handler masked the interrupt
+			 * and expects us to ack the interrupt. */
+
+			if (nfc_avoid_masking()) {
+				disable_irq(host->irq);
+				host->unmask_int(host);
+			}
 		}
+
+		host->ack_int(host);
 	} else {
 		while (max_retries-- > 0) {
-			if (host->check_int(host))
+			if (host->isset_int(host)) {
+				host->ack_int(host);
 				break;
+			}
 
 			udelay(1);
 		}
@@ -735,7 +800,6 @@ static void preset_v1_v2(struct mtd_info
 
 	/* enable interrupt, disable spare enable */
 	tmp = readw(NFC_V1_V2_CONFIG1);
-	tmp &= ~NFC_V1_V2_CONFIG1_INT_MSK;
 	tmp &= ~NFC_V1_V2_CONFIG1_SP_EN;
 	if (nand_chip->ecc.mode == NAND_ECC_HW) {
 		tmp |= NFC_V1_V2_CONFIG1_ECC_EN;
@@ -828,6 +892,9 @@ static void preset_v3(struct mtd_info *m
 		NFC_V3_CONFIG2_ST_CMD(0x70) |
 		NFC_V3_CONFIG2_NUM_ADDR_PHASE0;
 
+	if (!nfc_avoid_masking())
+		config2 |= NFC_V3_CONFIG2_INT_MSK;
+
 	if (chip->ecc.mode == NAND_ECC_HW)
 		config2 |= NFC_V3_CONFIG2_ECC_EN;
 
@@ -1050,7 +1117,10 @@ static int __init mxcnd_probe(struct pla
 		host->send_page = send_page_v1_v2;
 		host->send_read_id = send_read_id_v1_v2;
 		host->get_dev_status = get_dev_status_v1_v2;
-		host->check_int = check_int_v1_v2;
+		host->isset_int = isset_int_v1_v2;
+		host->ack_int = ack_int_v1_v2;
+		host->mask_int = mask_int_v1_v2;
+		host->unmask_int = unmask_int_v1_v2;
 	}
 
 	if (nfc_is_v21()) {
@@ -1087,7 +1157,10 @@ static int __init mxcnd_probe(struct pla
 		host->send_addr = send_addr_v3;
 		host->send_page = send_page_v3;
 		host->send_read_id = send_read_id_v3;
-		host->check_int = check_int_v3;
+		host->isset_int = isset_int_v3;
+		host->ack_int = ack_int_v3;
+		host->mask_int = mask_int_v3;
+		host->unmask_int = unmask_int_v3;
 		host->get_dev_status = get_dev_status_v3;
 		oob_smallpage = &nandv2_hw_eccoob_smallpage;
 		oob_largepage = &nandv2_hw_eccoob_largepage;
@@ -1120,11 +1193,18 @@ static int __init mxcnd_probe(struct pla
 		this->options |= NAND_USE_FLASH_BBT;
 	}
 
-	init_waitqueue_head(&host->irq_waitq);
+	init_completion(&host->op_completion);
 
 	host->irq = platform_get_irq(pdev, 0);
 
-	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
+	if (nfc_avoid_masking()) {
+		set_irq_flags(host->irq, IRQF_VALID | IRQF_NOAUTOEN);
+		host->unmask_int(host);
+	} else {
+		host->mask_int(host);
+	}
+
+	err = request_irq(host->irq, mxc_nfc_irq, 0, DRIVER_NAME, host);
 	if (err)
 		goto eirq;
 
