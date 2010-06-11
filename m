From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 11 Jun 2010 18:51:47 +0300
Subject: [PATCH v4 12/14] omap: mailbox: only compile for configured archs
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1276271509-11983-13-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 55d8b77..4c0c112 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -284,6 +284,7 @@ static struct omap_mbox_ops omap2_mbox_ops = {
 
 /* FIXME: the following structs should be filled automatically by the user id */
 
+#if defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_ARCH_OMAP2420)
 /* DSP */
 static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.tx_fifo = {
@@ -306,11 +307,13 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_dsp_priv,
 };
+#endif
 
+#if defined(CONFIG_ARCH_OMAP3430)
 struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
+#endif
 
 #if defined(CONFIG_ARCH_OMAP2420)
-
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
@@ -337,6 +340,7 @@ static struct omap_mbox mbox_iva_info = {
 struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info, NULL };
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4)
 /* OMAP4 */
 static struct omap_mbox2_priv omap2_mbox_1_priv = {
 	.tx_fifo = {
@@ -383,6 +387,7 @@ struct omap_mbox mbox_2_info = {
 };
 
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
+#endif
 
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
@@ -390,11 +395,15 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 	int ret;
 	struct omap_mbox **list;
 
-	if (cpu_is_omap3430()) {
+	if (false)
+		;
+#if defined(CONFIG_ARCH_OMAP3430)
+	else if (cpu_is_omap3430()) {
 		list = omap3_mboxes;
 
 		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
 	}
+#endif
 #if defined(CONFIG_ARCH_OMAP2420)
 	else if (cpu_is_omap2420()) {
 		list = omap2_mboxes;
@@ -403,12 +412,14 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		list[1]->irq = platform_get_irq_byname(pdev, "iva");
 	}
 #endif
+#if defined(CONFIG_ARCH_OMAP4)
 	else if (cpu_is_omap44xx()) {
 		list = omap4_mboxes;
 
 		list[0]->irq = list[1]->irq =
 			platform_get_irq_byname(pdev, "mbox");
 	}
+#endif
 	else {
 		pr_err("%s: platform not supported\n", __func__);
 		return -ENODEV;
-- 
1.7.1
