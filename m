From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Fri, 2 Nov 2012 18:02:33 +0530
Subject: [PATCH 02/15] ARM: OMAP2+: mailbox: Add support for AM33XX
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1351859566-24818-3-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mailbox IP on AM33XX, is the same as that present
in OMAP4. The single instance of Mailbox module
contains 8 sub-modules and facilitates communication
between MPU, PRUs and WKUP_M3.

The first mailbox sub-module is assigned for
communication between MPU and WKUP-M3.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index f38b4fa..7a343aa 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -155,7 +155,7 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	struct omap_mbox2_priv *p = mbox->priv;
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
 
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap44xx() || !soc_is_am33xx())
 		bit = mbox_read_reg(p->irqdisable) & ~bit;
 
 	mbox_write_reg(bit, p->irqdisable);
@@ -358,6 +358,32 @@ struct omap_mbox mbox_2_info = {
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
 
+#if defined(CONFIG_SOC_AM33XX)
+static struct omap_mbox2_priv omap2_mbox_wkup_m3_priv = {
+	.tx_fifo = {
+		.msg		= MAILBOX_MESSAGE(0),
+		.fifo_stat	= MAILBOX_FIFOSTATUS(0),
+		.msg_stat	= MAILBOX_MSGSTATUS(0),
+	},
+	.rx_fifo = {
+		.msg		= MAILBOX_MESSAGE(1),
+		.msg_stat	= MAILBOX_MSGSTATUS(1),
+	},
+	.irqenable	= OMAP4_MAILBOX_IRQENABLE(3),
+	.irqstatus	= OMAP4_MAILBOX_IRQSTATUS(3),
+	.irqdisable	= OMAP4_MAILBOX_IRQENABLE_CLR(3),
+	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
+	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(0),
+};
+
+struct omap_mbox mbox_wkup_m3_info = {
+	.name	= "wkup_m3",
+	.ops	= &omap2_mbox_ops,
+	.priv	= &omap2_mbox_wkup_m3_priv,
+};
+struct omap_mbox *am33xx_mboxes[] = { &mbox_wkup_m3_info, NULL };
+#endif
+
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
@@ -392,6 +418,13 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		list[0]->irq = list[1]->irq = platform_get_irq(pdev, 0);
 	}
 #endif
+#if defined(CONFIG_SOC_AM33XX)
+	else if (soc_is_am33xx()) {
+		list = am33xx_mboxes;
+
+		list[0]->irq = platform_get_irq(pdev, 0);
+	}
+#endif
 	else {
 		pr_err("%s: platform not supported\n", __func__);
 		return -ENODEV;
-- 
1.7.0.4
