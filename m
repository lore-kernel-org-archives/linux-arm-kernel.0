From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Aug 2010 13:28:37 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <80r5i5z3v1.fsf@merkur.tec.linutronix.de>
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
	<20100811125625.GS27749@pengutronix.de>
	<80r5i5z3v1.fsf@merkur.tec.linutronix.de>
Message-ID: <20100816112837.GO27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 03:16:34PM +0200, John Ogness wrote:
> On 2010-08-11, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> Your version allows a small window between request_irq() and
> >> irq_control() where on the i.MX21 there is a possibility of the
> >> interrupts being disabled twice. Namely, if an interrupt occurs
> >> before irq_control() has had a chance to disable it. IMHO it would be
> >> better to call:
> >> 
> >>     set_irq_flags(host->irq, IRQF_VALID | IRQF_NOAUTOEN);
> >> 
> >> for the i.MX21 before requesting the irq. This closes the window.
> >
> > IIRC it is not allowed to call set_irq_flags before request_irq. We
> > are changing a resource we do not own yet.
> 
> Normally, yes. But the only way the IRQF_NOAUTOEN flag can ever be
> useful is if set_irq_flags() is called before request_irq().
> 
> > I think the worst thing that could happen without this change is that
> > we get an interrupt after request_irq.
> 
> Yes. And this causes a problem on the i.MX21 because the interrupt
> handler will disable the interrupts. The irq_control() after
> request_irq() will _also_ disable the interrupts. This means the
> interrupts are disabled twice, which causes some issues on an RT kernel.
> 
> > Alternatively we could set the interrupt mask bit before requesting
> > the irq.
> 
> Yes. This would be best. But for the i.MX21 it is important that the
> interrupts are unmasked after irq_control() has disabled the interrupts.

Ok, here is an updated version of this patch

Sascha

commit 3a411e6c690654f78bea93dd8cdb14c27ba418a5
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Mon Aug 9 14:21:00 2010 +0200

    mxc_nand: do not depend on disabling the irq in the interrupt handler
    
    This patch reverts the driver to enabling/disabling the NFC interrupt
    mask rather than enabling/disabling the system interrupt. This cleans
    up the driver so that it doesn't rely on interrupts being disabled
    within the interrupt handler.
    For i.MX21 we keep the current behaviour, that is calling
    enable_irq/disable_irq_nosync to enable/disable interrupts.
    This patch is based on earlier work by John Ogness.
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index d58214b..c1a3d04 100644
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
@@ -214,9 +217,12 @@ static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
 {
 	struct mxc_nand_host *host = dev_id;
 
-	disable_irq_nosync(irq);
+	if (!host->check_int(host))
+		return IRQ_NONE;
 
-	wake_up(&host->irq_waitq);
+	host->irq_control(host, 0);
+
+	complete(&host->op_completion);
 
 	return IRQ_HANDLED;
 }
@@ -243,11 +249,54 @@ static int check_int_v1_v2(struct mxc_nand_host *host)
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
@@ -257,10 +306,9 @@ static void wait_op_done(struct mxc_nand_host *host, int useirq)
 
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
@@ -731,9 +779,8 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	struct mxc_nand_host *host = nand_chip->priv;
 	uint16_t tmp;
 
-	/* enable interrupt, disable spare enable */
+	/* disable spare enable */
 	tmp = readw(NFC_V1_V2_CONFIG1);
-	tmp &= ~NFC_V1_V2_CONFIG1_INT_MSK;
 	tmp &= ~NFC_V1_V2_CONFIG1_SP_EN;
 	if (nand_chip->ecc.mode == NAND_ECC_HW) {
 		tmp |= NFC_V1_V2_CONFIG1_ECC_EN;
@@ -1020,6 +1067,10 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->send_read_id = send_read_id_v1_v2;
 		host->get_dev_status = get_dev_status_v1_v2;
 		host->check_int = check_int_v1_v2;
+		if (cpu_is_mx21())
+			host->irq_control = irq_control_mx21;
+		else
+			host->irq_control = irq_control_v1_v2;
 	}
 
 	if (nfc_is_v21()) {
@@ -1058,6 +1109,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->send_read_id = send_read_id_v3;
 		host->check_int = check_int_v3;
 		host->get_dev_status = get_dev_status_v3;
+		host->irq_control = irq_control_v3;
 		oob_smallpage = &nandv2_hw_eccoob_smallpage;
 		oob_largepage = &nandv2_hw_eccoob_largepage;
 	} else
@@ -1089,14 +1141,34 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		this->options |= NAND_USE_FLASH_BBT;
 	}
 
-	init_waitqueue_head(&host->irq_waitq);
+	init_completion(&host->op_completion);
 
 	host->irq = platform_get_irq(pdev, 0);
 
+	/*
+	 * mask the interrupt. For i.MX21 explicitely call
+	 * irq_control_v1_v2 to use the mask bit. We can't call
+	 * disable_irq_nosync() for an interrupt we do not own yet.
+	 */
+	if (cpu_is_mx21())
+		irq_control_v1_v2(host, 0);
+	else
+		host->irq_control(host, 0);
+
 	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
 	if (err)
 		goto eirq;
 
+	host->irq_control(host, 0);
+
+	/*
+	 * Now that the interrupt is disabled make sure the interrupt
+	 * mask bit is cleared on i.MX21. Otherwise we can't read
+	 * the interrupt status bit on this machine.
+	 */
+	if (cpu_is_mx21())
+		irq_control_v1_v2(host, 1);
+
 	/* first scan to find the device and get the page size */
 	if (nand_scan_ident(mtd, 1, NULL)) {
 		err = -ENXIO;

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
