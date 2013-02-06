From: chao.xie@marvell.com (Chao Xie)
Date: Wed,  6 Feb 2013 02:23:47 -0500
Subject: [V6 PATCH 12/16] usb: gadget: mv_udc: add extern chip support
In-Reply-To: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
References: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1360135431-27280-13-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because arch-mmp will make use of irq domain for irq
allocation, the irqs allocated for PMIC is dynamical.
The vbus/idpin irqs from PMIC can not be passed by platform data.
Using the extern chip APIs provides by PHY driver can solve this
problem.
Marvell usb PHY driver provides a middle layer.
The PMIC usb drivers will help to register the callbacks in the
marvell usb PHY driver.
udc/otg/ehci driver will call the callbacks.
Then we do not need pass the information in platform data. It will
remove another block in the way of enabling device tree for usb.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_udc.h      |    3 ++
 drivers/usb/gadget/mv_udc_core.c |   47 ++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
index 4851b2b..50ae7c7 100644
--- a/drivers/usb/gadget/mv_udc.h
+++ b/drivers/usb/gadget/mv_udc.h
@@ -178,6 +178,9 @@ struct mv_udc {
 	struct platform_device		*dev;
 	int				irq;
 
+	unsigned int			extern_attr;
+	struct notifier_block		notifier;
+
 	struct mv_cap_regs __iomem	*cap_regs;
 	struct mv_op_regs __iomem	*op_regs;
 	unsigned int			max_eps;
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 76fcfc7..2e5907f 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2077,27 +2077,30 @@ static irqreturn_t mv_udc_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t mv_udc_vbus_irq(int irq, void *dev)
+static int mv_udc_vbus_notifier_call(struct notifier_block *nb,
+				unsigned long val, void *v)
 {
-	struct mv_udc *udc = (struct mv_udc *)dev;
+	struct mv_udc *udc = container_of(nb, struct mv_udc, notifier);
 
 	/* polling VBUS and init phy may cause too much time*/
-	if (udc->qwork)
+	if (udc->qwork && val == EVENT_VBUS)
 		queue_work(udc->qwork, &udc->vbus_work);
 
-	return IRQ_HANDLED;
+	return 0;
 }
 
 static void mv_udc_vbus_work(struct work_struct *work)
 {
 	struct mv_udc *udc;
-	unsigned int vbus;
+	unsigned int vbus = VBUS_LOW;
 
 	udc = container_of(work, struct mv_udc, vbus_work);
-	if (!udc->pdata->vbus)
+	if (!(udc->extern_attr & MV_USB_HAS_VBUS_DETECTION))
+		return;
+
+	if (mv_usb2_extern_call(udc->phy, vbus, get_vbus, &vbus))
 		return;
 
-	vbus = udc->pdata->vbus->poll();
 	dev_info(&udc->dev->dev, "vbus is %d\n", vbus);
 
 	if (vbus == VBUS_HIGH)
@@ -2124,6 +2127,9 @@ static int mv_udc_remove(struct platform_device *pdev)
 
 	usb_del_gadget_udc(&udc->gadget);
 
+	if (udc->extern_attr & MV_USB_HAS_VBUS_DETECTION)
+		mv_usb2_unregister_notifier(udc->phy, &udc->notifier);
+
 	if (udc->qwork) {
 		flush_workqueue(udc->qwork);
 		destroy_workqueue(udc->qwork);
@@ -2169,6 +2175,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 	}
 
 	udc->done = &release_done;
+	udc->extern_attr = pdata->extern_attr;
 	udc->pdata = pdev->dev.platform_data;
 	spin_lock_init(&udc->lock);
 
@@ -2319,17 +2326,8 @@ static int mv_udc_probe(struct platform_device *pdev)
 	/* VBUS detect: we can disable/enable clock on demand.*/
 	if (udc->transceiver)
 		udc->clock_gating = 1;
-	else if (pdata->vbus) {
+	else if (udc->extern_attr & MV_USB_HAS_VBUS_DETECTION) {
 		udc->clock_gating = 1;
-		retval = devm_request_threaded_irq(&pdev->dev,
-				pdata->vbus->irq, NULL,
-				mv_udc_vbus_irq, IRQF_ONESHOT, "vbus", udc);
-		if (retval) {
-			dev_info(&pdev->dev,
-				"Can not request irq for VBUS, "
-				"disable clock gating\n");
-			udc->clock_gating = 0;
-		}
 
 		udc->qwork = create_singlethread_workqueue("mv_udc_queue");
 		if (!udc->qwork) {
@@ -2339,6 +2337,8 @@ static int mv_udc_probe(struct platform_device *pdev)
 		}
 
 		INIT_WORK(&udc->vbus_work, mv_udc_vbus_work);
+		udc->notifier.notifier_call = mv_udc_vbus_notifier_call;
+		mv_usb2_register_notifier(udc->phy, &udc->notifier);
 	}
 
 	/*
@@ -2362,6 +2362,9 @@ static int mv_udc_probe(struct platform_device *pdev)
 	return 0;
 
 err_create_workqueue:
+	if (!udc->transceiver
+		&& (udc->extern_attr & MV_USB_HAS_VBUS_DETECTION))
+		mv_usb2_unregister_notifier(udc->phy, &udc->notifier);
 	destroy_workqueue(udc->qwork);
 err_unregister:
 	device_unregister(&udc->gadget.dev);
@@ -2380,6 +2383,7 @@ err_disable_clock:
 static int mv_udc_suspend(struct device *dev)
 {
 	struct mv_udc *udc;
+	unsigned int vbus;
 
 	udc = dev_get_drvdata(dev);
 
@@ -2387,11 +2391,16 @@ static int mv_udc_suspend(struct device *dev)
 	if (udc->transceiver)
 		return 0;
 
-	if (udc->pdata->vbus && udc->pdata->vbus->poll)
-		if (udc->pdata->vbus->poll() == VBUS_HIGH) {
+	if ((udc->extern_attr & MV_USB_HAS_VBUS_DETECTION) &&
+		mv_usb2_has_extern_call(udc->phy, vbus, get_vbus)) {
+		if (mv_usb2_extern_call(udc->phy, vbus, get_vbus, &vbus))
+			return -EAGAIN;
+
+		if (vbus == VBUS_HIGH) {
 			dev_info(&udc->dev->dev, "USB cable is connected!\n");
 			return -EAGAIN;
 		}
+	}
 
 	/*
 	 * only cable is unplugged, udc can suspend.
-- 
1.7.4.1
