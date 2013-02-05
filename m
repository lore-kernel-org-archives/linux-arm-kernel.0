From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Feb 2013 16:00:11 +0800
Subject: [PATCH v8 4/8] usb: chipidea: consolidate kinds of APIs for both roles
In-Reply-To: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1360051215-27722-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Create/destroy the gadget at udc's init and destory function
- start/stop API are used at otg id switch and probe routine
- Defer some gadget operations at ci's delayed work queue

Signed-off-by: Peter Chen <peter.chen@freescale.com>

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 325d790..3ebe87a 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -205,7 +205,6 @@ static inline void ci_role_stop(struct ci13xxx *ci)
 
 	ci->roles[role]->stop(ci);
 }
-
 /******************************************************************************
  * REGISTERS
  *****************************************************************************/
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index fbb6984..eacaf9f 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -360,27 +360,16 @@ static void ci_handle_id_switch(struct ci13xxx *ci)
 			ci_role(ci)->name, ci->roles[role]->name);
 
 		/* 1. Finish the current role */
-		if (ci->role == CI_ROLE_GADGET) {
-			usb_gadget_vbus_disconnect(&ci->gadget);
-			/* host doesn't care B_SESSION_VALID event */
-			ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
-			ci_disable_otg_interrupt(ci, OTGSC_BSVIE);
-			ci->role = CI_ROLE_END;
-			/* reset controller */
-			hw_device_reset(ci, USBMODE_CM_IDLE);
-		} else if (ci->role == CI_ROLE_HOST) {
-			ci_role_stop(ci);
-			/* reset controller */
-			hw_device_reset(ci, USBMODE_CM_IDLE);
-		}
+		ci_role_stop(ci);
+		hw_device_reset(ci, USBMODE_CM_IDLE);
 
 		/* 2. Turn on/off vbus according to coming role */
-		if (ci_otg_role(ci) == CI_ROLE_GADGET) {
+		if (role == CI_ROLE_GADGET) {
 			otg_set_vbus(&ci->otg, false);
 			/* wait vbus lower than OTGSC_BSV */
 			hw_wait_reg(ci, OP_OTGSC, OTGSC_BSV, 0,
 					CI_VBUS_STABLE_TIMEOUT);
-		} else if (ci_otg_role(ci) == CI_ROLE_HOST) {
+		} else if (role == CI_ROLE_HOST) {
 			otg_set_vbus(&ci->otg, true);
 			/* wait vbus higher than OTGSC_AVV */
 			hw_wait_reg(ci, OP_OTGSC, OTGSC_AVV, OTGSC_AVV,
@@ -388,13 +377,7 @@ static void ci_handle_id_switch(struct ci13xxx *ci)
 		}
 
 		/* 3. Begin the new role */
-		if (ci_otg_role(ci) == CI_ROLE_GADGET) {
-			ci->role = role;
-			ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
-			ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
-		} else if (ci_otg_role(ci) == CI_ROLE_HOST) {
-			ci_role_start(ci, role);
-		}
+		ci_role_start(ci, role);
 	}
 }
 
@@ -433,8 +416,24 @@ static void ci_delayed_work(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct ci13xxx *ci = container_of(dwork, struct ci13xxx, dwork);
 
-	otg_set_vbus(&ci->otg, true);
+	if (ci->role == CI_ROLE_GADGET) {
+		/*
+		 * if it is device mode:
+		 * - Enable vbus detect
+		 * - If it has already connected to host, notify udc
+		 */
+		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
+		ci_handle_vbus_change(ci);
+	} else if (ci->is_otg && (ci->role == CI_ROLE_HOST)) {
+		/* USB Device at the MicroB to A cable */
+		otg_set_vbus(&ci->otg, true);
+	}
+}
 
+static inline void ci_role_destroy(struct ci13xxx *ci)
+{
+	ci_hdrc_gadget_destroy(ci);
+	ci_hdrc_host_destroy(ci);
 }
 
 static ssize_t show_role(struct device *dev, struct device_attribute *attr,
@@ -577,7 +576,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	void __iomem	*base;
 	int		ret;
 	enum usb_dr_mode dr_mode;
-	u32		otgsc;
 
 	if (!dev->platform_data) {
 		dev_err(dev, "platform data missing\n");
@@ -674,18 +672,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
 		ret = -ENODEV;
-		goto rm_wq;
-	}
-
-	otgsc = hw_read(ci, OP_OTGSC, ~0);
-	/*
-	 * if it is device mode:
-	 * - Enable vbus detect
-	 * - If it has already connected to host, notify udc
-	 */
-	if (ci->role == CI_ROLE_GADGET) {
-		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
-		ci_handle_vbus_change(ci);
+		goto free_memory;
 	}
 
 	platform_set_drvdata(pdev, ci);
@@ -696,18 +683,22 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	ret = device_create_file(dev, &dev_attr_role);
 	if (ret)
-		goto rm_attr;
+		goto free_irq;
 
-	/* Handle the situation that usb device at the MicroB to A cable */
-	if (ci->is_otg && !(otgsc & OTGSC_ID))
-		queue_delayed_work(ci->wq, &ci->dwork, msecs_to_jiffies(500));
+	/* Defer some operations */
+	queue_delayed_work(ci->wq, &ci->dwork, msecs_to_jiffies(200));
 
 	return ret;
 
-rm_attr:
-	device_remove_file(dev, &dev_attr_role);
+free_irq:
+	free_irq(ci->irq, ci);
 stop:
-	ci_role_stop(ci);
+	ci_role_destroy(ci);
+free_memory:
+	if (ci->roles[CI_ROLE_HOST])
+		devm_kfree(dev, ci->roles[CI_ROLE_HOST]);
+	if (ci->roles[CI_ROLE_GADGET])
+		devm_kfree(dev, ci->roles[CI_ROLE_GADGET]);
 rm_wq:
 	flush_workqueue(ci->wq);
 	destroy_workqueue(ci->wq);
@@ -723,7 +714,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	destroy_workqueue(ci->wq);
 	device_remove_file(ci->dev, &dev_attr_role);
 	free_irq(ci->irq, ci);
-	ci_role_stop(ci);
+	ci_role_destroy(ci);
 
 	return 0;
 }
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 8e9d312..ead3158 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -105,3 +105,9 @@ int ci_hdrc_host_init(struct ci13xxx *ci)
 
 	return 0;
 }
+
+void ci_hdrc_host_destroy(struct ci13xxx *ci)
+{
+	if (ci->role == CI_ROLE_HOST)
+		host_stop(ci);
+}
diff --git a/drivers/usb/chipidea/host.h b/drivers/usb/chipidea/host.h
index 761fb1f..5fd03a4 100644
--- a/drivers/usb/chipidea/host.h
+++ b/drivers/usb/chipidea/host.h
@@ -4,13 +4,15 @@
 #ifdef CONFIG_USB_CHIPIDEA_HOST
 
 int ci_hdrc_host_init(struct ci13xxx *ci);
-
+void ci_hdrc_host_destroy(struct ci13xxx *ci);
 #else
 
 static inline int ci_hdrc_host_init(struct ci13xxx *ci)
 {
 	return -ENXIO;
 }
+static void ci_hdrc_host_destroy(struct ci13xxx *ci)
+{}
 
 #endif
 
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 83e54bb..e82dae4 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -31,6 +31,7 @@
 
 #include "ci.h"
 #include "udc.h"
+#include "otg.h"
 #include "bits.h"
 #include "debug.h"
 
@@ -1743,7 +1744,12 @@ static int udc_start(struct ci13xxx *ci)
 	if (!IS_ERR_OR_NULL(ci->transceiver)) {
 		retval = otg_set_peripheral(ci->transceiver->otg,
 						&ci->gadget);
-		if (retval)
+		/* 
+		 * If we implement all USB functions using chipidea drivers,
+		 * it doesn't need to call above API, meanwhile, if we only
+		 * use gadget function, calling above API is useless.
+		 */
+		if (retval && retval != -ENOTSUPP)
 			goto remove_dbg;
 	}
 
@@ -1780,12 +1786,27 @@ free_qh_pool:
 	return retval;
 }
 
+static int udc_id_switch_for_device(struct ci13xxx *ci)
+{
+	ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
+	ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
+
+	return 0;
+}
+
+static void udc_id_switch_for_host(struct ci13xxx *ci)
+{
+	/* host doesn't care B_SESSION_VALID event */
+	ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
+	ci_disable_otg_interrupt(ci, OTGSC_BSVIE);
+}
+
 /**
- * udc_remove: parent remove must call this to remove UDC
+ * ci_hdrc_gadget_destroy: parent remove must call this to remove UDC
  *
  * No interrupts active, the IRQ has been released
  */
-static void udc_stop(struct ci13xxx *ci)
+void ci_hdrc_gadget_destroy(struct ci13xxx *ci)
 {
 	if (ci == NULL)
 		return;
@@ -1804,15 +1825,13 @@ static void udc_stop(struct ci13xxx *ci)
 	}
 	dbg_remove_files(&ci->gadget.dev);
 	device_unregister(&ci->gadget.dev);
-	/* my kobject is dynamic, I swear! */
-	memset(&ci->gadget, 0, sizeof(ci->gadget));
 }
 
 /**
  * ci_hdrc_gadget_init - initialize device related bits
  * ci: the controller
  *
- * This function enables the gadget role, if the device is "device capable".
+ * This function initializes gadget, if the device is "device capable".
  */
 int ci_hdrc_gadget_init(struct ci13xxx *ci)
 {
@@ -1825,11 +1844,11 @@ int ci_hdrc_gadget_init(struct ci13xxx *ci)
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
index 4ff2384..6c42d49 100644
--- a/drivers/usb/chipidea/udc.h
+++ b/drivers/usb/chipidea/udc.h
@@ -80,6 +80,7 @@ struct ci13xxx_req {
 #ifdef CONFIG_USB_CHIPIDEA_UDC
 
 int ci_hdrc_gadget_init(struct ci13xxx *ci);
+void ci_hdrc_gadget_destroy(struct ci13xxx *ci);
 
 #else
 
@@ -87,7 +88,8 @@ static inline int ci_hdrc_gadget_init(struct ci13xxx *ci)
 {
 	return -ENXIO;
 }
-
+static void ci_hdrc_gadget_destroy(struct ci13xxx *ci)
+{}
 #endif
 
 #endif /* __DRIVERS_USB_CHIPIDEA_UDC_H */
-- 
1.7.0.4
