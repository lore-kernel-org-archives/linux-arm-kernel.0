From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 2 Aug 2013 16:33:58 +0800
Subject: [PATCH v14 05/12] usb: chipidea: Add role init and destory APIs
In-Reply-To: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
References: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1375432445-31918-6-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- The role's init will be called at probe procedure.
- The role's destory will be called at fail patch
at probe and driver's removal.
- The role's start/stop will be called when specific
role has started.

Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c |   10 ++++++++--
 drivers/usb/chipidea/host.c |    7 +++++++
 drivers/usb/chipidea/host.h |    6 ++++++
 drivers/usb/chipidea/udc.c  |   36 +++++++++++++++++++++++++++---------
 drivers/usb/chipidea/udc.h  |    6 ++++++
 5 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index a4be8a5..bfc9aef 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -420,6 +420,12 @@ void ci_hdrc_remove_device(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ci_hdrc_remove_device);
 
+static inline void ci_role_destroy(struct ci_hdrc *ci)
+{
+	ci_hdrc_gadget_destroy(ci);
+	ci_hdrc_host_destroy(ci);
+}
+
 static int ci_hdrc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
@@ -539,7 +545,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	free_irq(ci->irq, ci);
 stop:
-	ci_role_stop(ci);
+	ci_role_destroy(ci);
 rm_wq:
 	flush_workqueue(ci->wq);
 	destroy_workqueue(ci->wq);
@@ -555,7 +561,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	flush_workqueue(ci->wq);
 	destroy_workqueue(ci->wq);
 	free_irq(ci->irq, ci);
-	ci_role_stop(ci);
+	ci_role_destroy(ci);
 
 	return 0;
 }
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index e94e52b..382be5b 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -105,6 +105,13 @@ static void host_stop(struct ci_hdrc *ci)
 		regulator_disable(ci->platdata->reg_vbus);
 }
 
+
+void ci_hdrc_host_destroy(struct ci_hdrc *ci)
+{
+	if (ci->role == CI_ROLE_HOST)
+		host_stop(ci);
+}
+
 int ci_hdrc_host_init(struct ci_hdrc *ci)
 {
 	struct ci_role_driver *rdrv;
diff --git a/drivers/usb/chipidea/host.h b/drivers/usb/chipidea/host.h
index 058875c..5707bf3 100644
--- a/drivers/usb/chipidea/host.h
+++ b/drivers/usb/chipidea/host.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_USB_CHIPIDEA_HOST
 
 int ci_hdrc_host_init(struct ci_hdrc *ci);
+void ci_hdrc_host_destroy(struct ci_hdrc *ci);
 
 #else
 
@@ -12,6 +13,11 @@ static inline int ci_hdrc_host_init(struct ci_hdrc *ci)
 	return -ENXIO;
 }
 
+static inline void ci_hdrc_host_destroy(struct ci_hdrc *ci)
+{
+
+}
+
 #endif
 
 #endif /* __DRIVERS_USB_CHIPIDEA_HOST_H */
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 116c762..24a100d 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -27,6 +27,7 @@
 #include "udc.h"
 #include "bits.h"
 #include "debug.h"
+#include "otg.h"
 
 /* control endpoint description */
 static const struct usb_endpoint_descriptor
@@ -1844,13 +1845,13 @@ free_qh_pool:
 }
 
 /**
- * udc_remove: parent remove must call this to remove UDC
+ * ci_hdrc_gadget_destroy: parent remove must call this to remove UDC
  *
  * No interrupts active, the IRQ has been released
  */
-static void udc_stop(struct ci_hdrc *ci)
+void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
 {
-	if (ci == NULL)
+	if (!ci->roles[CI_ROLE_GADGET])
 		return;
 
 	usb_del_gadget_udc(&ci->gadget);
@@ -1865,15 +1866,32 @@ static void udc_stop(struct ci_hdrc *ci)
 		if (ci->global_phy)
 			usb_put_phy(ci->transceiver);
 	}
-	/* my kobject is dynamic, I swear! */
-	memset(&ci->gadget, 0, sizeof(ci->gadget));
+}
+
+static int udc_id_switch_for_device(struct ci_hdrc *ci)
+{
+	if (ci->is_otg) {
+		ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
+		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
+	}
+
+	return 0;
+}
+
+static void udc_id_switch_for_host(struct ci_hdrc *ci)
+{
+	if (ci->is_otg) {
+		/* host doesn't care B_SESSION_VALID event */
+		ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
+		ci_disable_otg_interrupt(ci, OTGSC_BSVIE);
+	}
 }
 
 /**
  * ci_hdrc_gadget_init - initialize device related bits
  * ci: the controller
  *
- * This function enables the gadget role, if the device is "device capable".
+ * This function initializes the gadget, if the device is "device capable".
  */
 int ci_hdrc_gadget_init(struct ci_hdrc *ci)
 {
@@ -1886,11 +1904,11 @@ int ci_hdrc_gadget_init(struct ci_hdrc *ci)
 	if (!rdrv)
 		return -ENOMEM;
 
-	rdrv->start	= udc_start;
-	rdrv->stop	= udc_stop;
+	rdrv->start	= udc_id_switch_for_device;
+	rdrv->stop	= udc_id_switch_for_host;
 	rdrv->irq	= udc_irq;
 	rdrv->name	= "gadget";
 	ci->roles[CI_ROLE_GADGET] = rdrv;
 
-	return 0;
+	return udc_start(ci);
 }
diff --git a/drivers/usb/chipidea/udc.h b/drivers/usb/chipidea/udc.h
index 455ac21..e66df00 100644
--- a/drivers/usb/chipidea/udc.h
+++ b/drivers/usb/chipidea/udc.h
@@ -84,6 +84,7 @@ struct ci_hw_req {
 #ifdef CONFIG_USB_CHIPIDEA_UDC
 
 int ci_hdrc_gadget_init(struct ci_hdrc *ci);
+void ci_hdrc_gadget_destroy(struct ci_hdrc *ci);
 
 #else
 
@@ -92,6 +93,11 @@ static inline int ci_hdrc_gadget_init(struct ci_hdrc *ci)
 	return -ENXIO;
 }
 
+static inline void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
+{
+
+}
+
 #endif
 
 #endif /* __DRIVERS_USB_CHIPIDEA_UDC_H */
-- 
1.7.0.4
