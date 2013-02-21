From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 20 Feb 2013 23:07:24 -0500
Subject: [V8 PATCH 14/16] usb: otg: mv_otg: add extern chip support
In-Reply-To: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361419646-9052-15-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It does the similar things as what we do for udc driver.
Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/otg/mv_otg.c |   72 +++++++++++++++++++++++----------------------
 drivers/usb/otg/mv_otg.h |    3 ++
 2 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/otg/mv_otg.c
index 7282b0d..9b3789a 100644
--- a/drivers/usb/otg/mv_otg.c
+++ b/drivers/usb/otg/mv_otg.c
@@ -59,10 +59,13 @@ static char *state_string[] = {
 static int mv_otg_set_vbus(struct usb_otg *otg, bool on)
 {
 	struct mv_otg *mvotg = container_of(otg->phy, struct mv_otg, phy);
-	if (mvotg->pdata->set_vbus == NULL)
+	struct mv_usb2_phy *mv_phy = container_of(mvotg->outer_phy,
+					struct mv_usb2_phy, phy);
+
+	if (!mv_usb2_has_extern_call(mv_phy, vbus, set_vbus))
 		return -ENODEV;
 
-	return mvotg->pdata->set_vbus(on);
+	return mv_usb2_extern_call(mv_phy, vbus, set_vbus, on);
 }
 
 static int mv_otg_set_host(struct usb_otg *otg,
@@ -184,14 +187,14 @@ static void mv_otg_init_irq(struct mv_otg *mvotg)
 	mvotg->irq_status = OTGSC_INTSTS_A_SESSION_VALID
 	    | OTGSC_INTSTS_A_VBUS_VALID;
 
-	if (mvotg->pdata->vbus == NULL) {
+	if (!(mvotg->extern_attr & MV_USB_HAS_VBUS_DETECTION)) {
 		mvotg->irq_en |= OTGSC_INTR_B_SESSION_VALID
 		    | OTGSC_INTR_B_SESSION_END;
 		mvotg->irq_status |= OTGSC_INTSTS_B_SESSION_VALID
 		    | OTGSC_INTSTS_B_SESSION_END;
 	}
 
-	if (mvotg->pdata->id == NULL) {
+	if (!(mvotg->extern_attr & MV_USB_HAS_IDPIN_DETECTION)) {
 		mvotg->irq_en |= OTGSC_INTR_USB_ID;
 		mvotg->irq_status |= OTGSC_INTSTS_USB_ID;
 	}
@@ -303,11 +306,16 @@ static void mv_otg_update_inputs(struct mv_otg *mvotg)
 {
 	struct mv_otg_ctrl *otg_ctrl = &mvotg->otg_ctrl;
 	u32 otgsc;
+	unsigned int vbus, idpin;
+	struct mv_usb2_phy *mv_phy = container_of(mvotg->outer_phy,
+					struct mv_usb2_phy, phy);
 
 	otgsc = readl(&mvotg->op_regs->otgsc);
 
-	if (mvotg->pdata->vbus) {
-		if (mvotg->pdata->vbus->poll() == VBUS_HIGH) {
+	if (mvotg->extern_attr & MV_USB_HAS_VBUS_DETECTION) {
+		if (mv_usb2_extern_call(mv_phy, vbus, get_vbus, &vbus))
+			return;
+		if (vbus == VBUS_HIGH) {
 			otg_ctrl->b_sess_vld = 1;
 			otg_ctrl->b_sess_end = 0;
 		} else {
@@ -319,8 +327,11 @@ static void mv_otg_update_inputs(struct mv_otg *mvotg)
 		otg_ctrl->b_sess_end = !!(otgsc & OTGSC_STS_B_SESSION_END);
 	}
 
-	if (mvotg->pdata->id)
-		otg_ctrl->id = !!mvotg->pdata->id->poll();
+	if (mvotg->extern_attr & MV_USB_HAS_IDPIN_DETECTION) {
+		if (mv_usb2_extern_call(mv_phy, idpin, get_idpin, &idpin))
+			return;
+		otg_ctrl->id = !!idpin;
+	}
 	else
 		otg_ctrl->id = !!(otgsc & OTGSC_STS_USB_ID);
 
@@ -502,7 +513,7 @@ static irqreturn_t mv_otg_irq(int irq, void *dev)
 	 * if we have vbus, then the vbus detection for B-device
 	 * will be done by mv_otg_inputs_irq().
 	 */
-	if (mvotg->pdata->vbus)
+	if (mvotg->extern_attr & MV_USB_HAS_VBUS_DETECTION)
 		if ((otgsc & OTGSC_STS_USB_ID) &&
 		    !(otgsc & OTGSC_INTSTS_USB_ID))
 			return IRQ_NONE;
@@ -515,9 +526,10 @@ static irqreturn_t mv_otg_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t mv_otg_inputs_irq(int irq, void *dev)
+static int mv_otg_notifier_call(struct notifier_block *nb,
+				unsigned long val, void *v)
 {
-	struct mv_otg *mvotg = dev;
+	struct mv_otg *mvotg = container_of(nb, struct mv_otg, notifier);
 
 	/* The clock may disabled at this time */
 	if (!mvotg->active) {
@@ -527,7 +539,7 @@ static irqreturn_t mv_otg_inputs_irq(int irq, void *dev)
 
 	mv_otg_run_state_machine(mvotg, 0);
 
-	return IRQ_HANDLED;
+	return 0;
 }
 
 static ssize_t
@@ -660,9 +672,15 @@ static struct attribute_group inputs_attr_group = {
 int mv_otg_remove(struct platform_device *pdev)
 {
 	struct mv_otg *mvotg = platform_get_drvdata(pdev);
+	struct mv_usb2_phy *mv_phy = container_of(mvotg->outer_phy,
+					struct mv_usb2_phy, phy);
 
 	sysfs_remove_group(&mvotg->pdev->dev.kobj, &inputs_attr_group);
 
+	if ((mvotg->extern_attr & MV_USB_HAS_VBUS_DETECTION) ||
+		(mvotg->extern_attr & MV_USB_HAS_IDPIN_DETECTION))
+		mv_usb2_unregister_notifier(mv_phy, &mvotg->notifier);
+
 	if (mvotg->qwork) {
 		flush_workqueue(mvotg->qwork);
 		destroy_workqueue(mvotg->qwork);
@@ -682,6 +700,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	struct mv_otg *mvotg;
 	struct usb_otg *otg;
 	struct resource *r;
+	struct mv_usb2_phy *mv_phy;
 	int retval = 0, clk_i, i;
 	size_t size;
 
@@ -704,6 +723,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mvotg);
 
 	mvotg->pdev = pdev;
+	mvotg->extern_attr = pdata->extern_attr;
 	mvotg->pdata = pdata;
 
 	mvotg->clknum = pdata->clknum;
@@ -760,6 +780,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 		retval = PTR_ERR(mvotg->outer_phy);
 		goto err_destroy_workqueue;
 	}
+	mv_phy = container_of(mvotg->outer_phy, struct mv_usb2_phy, phy);
 
 	/* we will acces controller register, so enable the udc controller */
 	retval = mv_otg_enable_internal(mvotg);
@@ -772,29 +793,10 @@ static int mv_otg_probe(struct platform_device *pdev)
 		(struct mv_otg_regs __iomem *) ((unsigned long) mvotg->cap_regs
 			+ (readl(mvotg->cap_regs) & CAPLENGTH_MASK));
 
-	if (pdata->id) {
-		retval = devm_request_threaded_irq(&pdev->dev, pdata->id->irq,
-						NULL, mv_otg_inputs_irq,
-						IRQF_ONESHOT, "id", mvotg);
-		if (retval) {
-			dev_info(&pdev->dev,
-				 "Failed to request irq for ID\n");
-			pdata->id = NULL;
-		}
-	}
-
-	if (pdata->vbus) {
-		mvotg->clock_gating = 1;
-		retval = devm_request_threaded_irq(&pdev->dev, pdata->vbus->irq,
-						NULL, mv_otg_inputs_irq,
-						IRQF_ONESHOT, "vbus", mvotg);
-		if (retval) {
-			dev_info(&pdev->dev,
-				 "Failed to request irq for VBUS, "
-				 "disable clock gating\n");
-			mvotg->clock_gating = 0;
-			pdata->vbus = NULL;
-		}
+	if ((mvotg->extern_attr & MV_USB_HAS_VBUS_DETECTION) ||
+		(mvotg->extern_attr & MV_USB_HAS_IDPIN_DETECTION)) {
+		mvotg->notifier.notifier_call = mv_otg_notifier_call;
+		mv_usb2_register_notifier(mv_phy, &mvotg->notifier);
 	}
 
 	if (pdata->disable_otg_clock_gating)
diff --git a/drivers/usb/otg/mv_otg.h b/drivers/usb/otg/mv_otg.h
index 65e7fd1..2a9ecae 100644
--- a/drivers/usb/otg/mv_otg.h
+++ b/drivers/usb/otg/mv_otg.h
@@ -149,6 +149,9 @@ struct mv_otg {
 	u32 irq_status;
 	u32 irq_en;
 
+	unsigned int extern_attr;
+	struct notifier_block notifier;
+
 	struct delayed_work work;
 	struct workqueue_struct *qwork;
 
-- 
1.7.4.1
