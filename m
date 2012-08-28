From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:13 +0800
Subject: [PATCH v2 07/11] USB: chipidea: add vbus detect for udc
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-8-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using vbus valid interrupt to detect vbus.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/ci.h  |    1 +
 drivers/usb/chipidea/udc.c |   39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index d738603..e25d126 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -139,6 +139,7 @@ struct ci13xxx {
 	enum ci_role			role;
 	bool				is_otg;
 	struct work_struct		work;
+	struct work_struct		vbus_work;
 	struct workqueue_struct		*wq;
 
 	struct dma_pool			*qh_pool;
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 9fb6394..2cb4498 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -308,6 +308,18 @@ static u32 hw_test_and_clear_intr_active(struct ci13xxx *ci)
 	return reg;
 }
 
+static void hw_enable_vbus_intr(struct ci13xxx *ci)
+{
+	hw_write(ci, OP_OTGSC, OTGSC_AVVIS, OTGSC_AVVIS);
+	hw_write(ci, OP_OTGSC, OTGSC_AVVIE, OTGSC_AVVIE);
+	queue_work(ci->wq, &ci->vbus_work);
+}
+
+static void hw_disable_vbus_intr(struct ci13xxx *ci)
+{
+	hw_write(ci, OP_OTGSC, OTGSC_AVVIE, 0);
+}
+
 /**
  * hw_test_and_clear_setup_guard: test & clear setup guard (execute without
  *                                interruption)
@@ -374,6 +386,16 @@ static int hw_usb_reset(struct ci13xxx *ci)
 	return 0;
 }
 
+static void vbus_work(struct work_struct *work)
+{
+	struct ci13xxx *ci = container_of(work, struct ci13xxx, vbus_work);
+
+	if (hw_read(ci, OP_OTGSC, OTGSC_AVV))
+		usb_gadget_vbus_connect(&ci->gadget);
+	else
+		usb_gadget_vbus_disconnect(&ci->gadget);
+}
+
 /******************************************************************************
  * UTIL block
  *****************************************************************************/
@@ -1376,6 +1398,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 		if (is_active) {
 			pm_runtime_get_sync(&_gadget->dev);
 			hw_device_reset(ci, USBMODE_CM_DC);
+			hw_enable_vbus_intr(ci);
 			hw_device_state(ci, ci->ep0out->qh.dma);
 		} else {
 			hw_device_state(ci, 0);
@@ -1517,8 +1540,10 @@ static int ci13xxx_start(struct usb_gadget *gadget,
 	pm_runtime_get_sync(&ci->gadget.dev);
 	if (ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) {
 		if (ci->vbus_active) {
-			if (ci->platdata->flags & CI13XXX_REGS_SHARED)
+			if (ci->platdata->flags & CI13XXX_REGS_SHARED) {
 				hw_device_reset(ci, USBMODE_CM_DC);
+				hw_enable_vbus_intr(ci);
+			}
 		} else {
 			pm_runtime_put_sync(&ci->gadget.dev);
 			goto done;
@@ -1624,6 +1649,13 @@ static irqreturn_t udc_irq(struct ci13xxx *ci)
 	} else {
 		retval = IRQ_NONE;
 	}
+
+	intr = hw_read(ci, OP_OTGSC, ~0);
+	hw_write(ci, OP_OTGSC, ~0, intr);
+
+	if (intr & (OTGSC_AVVIE & OTGSC_AVVIS))
+		queue_work(ci->wq, &ci->vbus_work);
+
 	spin_unlock(&ci->lock);
 
 	return retval;
@@ -1699,6 +1731,7 @@ static int udc_start(struct ci13xxx *ci)
 		retval = hw_device_reset(ci, USBMODE_CM_DC);
 		if (retval)
 			goto put_transceiver;
+		hw_enable_vbus_intr(ci);
 	}
 
 	retval = device_register(&ci->gadget.dev);
@@ -1762,6 +1795,9 @@ static void udc_stop(struct ci13xxx *ci)
 	if (ci == NULL)
 		return;
 
+	hw_disable_vbus_intr(ci);
+	cancel_work_sync(&ci->vbus_work);
+
 	usb_del_gadget_udc(&ci->gadget);
 
 	for (i = 0; i < ci->hw_ep_max; i++) {
@@ -1806,6 +1842,7 @@ int ci_hdrc_gadget_init(struct ci13xxx *ci)
 	rdrv->irq	= udc_irq;
 	rdrv->name	= "gadget";
 	ci->roles[CI_ROLE_GADGET] = rdrv;
+	INIT_WORK(&ci->vbus_work, vbus_work);
 
 	return 0;
 }
-- 
1.7.9.5
