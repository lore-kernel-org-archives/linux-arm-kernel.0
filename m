From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 26 Nov 2012 17:11:05 +0800
Subject: [PATCH v3 4/7] usb: chipidea: consolidate ci_role_driver's API for
 both roles
In-Reply-To: <1353921068-15673-1-git-send-email-peter.chen@freescale.com>
References: <1353921068-15673-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1353921068-15673-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Create init/destroy API for probe and remove
- start/stop API are only used otg id switch process
- Create the gadget at ci_hdrc_probe if the gadget is supported
at that port, the main purpose for this is to avoid gadget module
load fail at init.rc

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
Changes for v3:
- Create init/destroy API for probe and remove
- start/stop API are only used otg id switch process

 drivers/usb/chipidea/ci.h   |   19 ++++++++++-
 drivers/usb/chipidea/core.c |   75 +++++++++++++++++++++----------------------
 drivers/usb/chipidea/host.c |    2 +
 drivers/usb/chipidea/udc.c  |   22 +++++++++++-
 4 files changed, 76 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 12665fa..bc9e4e1 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -67,14 +67,18 @@ enum ci_role {
 
 /**
  * struct ci_role_driver - host/gadget role driver
- * start: start this role
- * stop: stop this role
+ * init: init this role (used at module probe)
+ * start: start this role (used at id switch)
+ * stop: stop this role (used at id switch)
+ * destroy: destroy this role (used at module remove)
  * irq: irq handler for this role
  * name: role name string (host/gadget)
  */
 struct ci_role_driver {
+	int		(*init)(struct ci13xxx *);
 	int		(*start)(struct ci13xxx *);
 	void		(*stop)(struct ci13xxx *);
+	void		(*destroy)(struct ci13xxx *);
 	irqreturn_t	(*irq)(struct ci13xxx *);
 	const char	*name;
 };
@@ -207,6 +211,17 @@ static inline void ci_role_stop(struct ci13xxx *ci)
 	ci->roles[role]->stop(ci);
 }
 
+static inline void ci_role_destroy(struct ci13xxx *ci)
+{
+	enum ci_role role = ci->role;
+
+	if (role == CI_ROLE_END)
+		return;
+
+	ci->role = CI_ROLE_END;
+
+	ci->roles[role]->destroy(ci);
+}
 /******************************************************************************
  * REGISTERS
  *****************************************************************************/
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index e0392fa..f0d3691 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -307,27 +307,16 @@ static void ci_handle_id_switch(struct ci13xxx *ci)
 			ci_role(ci)->name, ci->roles[role]->name);
 
 		/* 1. Finish the current role */
-		if (ci->role == CI_ROLE_GADGET) {
-			usb_gadget_vbus_disconnect(&ci->gadget);
-			/* host doesn't care B_SESSION_VALID event */
-			hw_write(ci, OP_OTGSC, OTGSC_BSVIE, ~OTGSC_BSVIE);
-			hw_write(ci, OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
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
@@ -335,13 +324,7 @@ static void ci_handle_id_switch(struct ci13xxx *ci)
 		}
 
 		/* 3. Begin the new role */
-		if (ci_otg_role(ci) == CI_ROLE_GADGET) {
-			ci->role = role;
-			hw_write(ci, OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
-			hw_write(ci, OP_OTGSC, OTGSC_BSVIE, OTGSC_BSVIE);
-		} else if (ci_otg_role(ci) == CI_ROLE_HOST) {
-			ci_role_start(ci, role);
-		}
+		ci_role_start(ci, role);
 	}
 }
 
@@ -584,7 +567,7 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 
 	ret = ci_hdrc_gadget_init(ci);
 	if (ret)
-		dev_info(dev, "doesn't support gadget\n");
+		dev_info(dev, "doesn't support gadget, ret=%d\n", ret);
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
@@ -608,23 +591,39 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 		/* if otg is supported, create struct usb_otg */
 		ci_hdrc_otg_init(ci);
 
-	ret = ci_role_start(ci, ci->role);
-	if (ret) {
-		dev_err(dev, "can't start %s role, ret=%d\n",
-				ci_role(ci)->name, ret);
-		ret = -ENODEV;
-		goto rm_wq;
-	}
-
 	otgsc = hw_read(ci, OP_OTGSC, ~0);
+
 	/*
-	 * if it is device mode:
-	 * - Enable vbus detect
-	 * - If it has already connected to host, notify udc
+	 * If the gadget is supported, call its init unconditionally,
+	 * We need to support load gadget module at init.rc.
 	 */
-	if (ci->role == CI_ROLE_GADGET) {
-		hw_write(ci, OP_OTGSC, OTGSC_BSVIE, OTGSC_BSVIE);
-		ci_handle_vbus_change(ci);
+	if (ci->roles[CI_ROLE_GADGET]) {
+		ret = ci->roles[CI_ROLE_GADGET]->init(ci);
+		if (ret) {
+			dev_err(dev, "can't init %s role, ret=%d\n",
+					ci_role(ci)->name, ret);
+			ret = -ENODEV;
+			goto rm_wq;
+		}
+		/*
+		 * if it is device mode:
+		 * - Enable vbus detect
+		 * - If it has already connected to host, notify udc
+		 */
+		if (ci->role == CI_ROLE_GADGET) {
+			hw_write(ci, OP_OTGSC, OTGSC_BSVIE, OTGSC_BSVIE);
+			ci_handle_vbus_change(ci);
+		}
+	}
+
+	if (ci->role == CI_ROLE_HOST) {
+		ret = ci->roles[CI_ROLE_HOST]->init(ci);
+		if (ret) {
+			dev_err(dev, "can't init %s role, ret=%d\n",
+					ci_role(ci)->name, ret);
+			ret = -ENODEV;
+			goto rm_wq;
+		}
 	}
 
 	platform_set_drvdata(pdev, ci);
@@ -662,7 +661,7 @@ static int __devexit ci_hdrc_remove(struct platform_device *pdev)
 	destroy_workqueue(ci->wq);
 	device_remove_file(ci->dev, &dev_attr_role);
 	free_irq(ci->irq, ci);
-	ci_role_stop(ci);
+	ci_role_destroy(ci);
 
 	return 0;
 }
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index caecad9..6024a4f 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -92,8 +92,10 @@ int ci_hdrc_host_init(struct ci13xxx *ci)
 	if (!rdrv)
 		return -ENOMEM;
 
+	rdrv->init	= host_start;
 	rdrv->start	= host_start;
 	rdrv->stop	= host_stop;
+	rdrv->destroy	= host_stop;
 	rdrv->irq	= host_irq;
 	rdrv->name	= "host";
 	ci->roles[CI_ROLE_HOST] = rdrv;
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index b52cb10..ae4755c 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1780,6 +1780,22 @@ free_qh_pool:
 	return retval;
 }
 
+static int udc_id_switch_for_device(struct ci13xxx *ci)
+{
+	hw_write(ci, OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
+	hw_write(ci, OP_OTGSC, OTGSC_BSVIE, OTGSC_BSVIE);
+
+	return 0;
+}
+
+static void udc_id_switch_for_host(struct ci13xxx *ci)
+{
+	usb_gadget_vbus_disconnect(&ci->gadget);
+	/* host doesn't care B_SESSION_VALID event */
+	hw_write(ci, OP_OTGSC, OTGSC_BSVIE, ~OTGSC_BSVIE);
+	hw_write(ci, OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
+}
+
 /**
  * udc_remove: parent remove must call this to remove UDC
  *
@@ -1825,8 +1841,10 @@ int ci_hdrc_gadget_init(struct ci13xxx *ci)
 	if (!rdrv)
 		return -ENOMEM;
 
-	rdrv->start	= udc_start;
-	rdrv->stop	= udc_stop;
+	rdrv->init	= udc_start;
+	rdrv->start	= udc_id_switch_for_device;
+	rdrv->stop	= udc_id_switch_for_host;
+	rdrv->destroy	= udc_stop;
 	rdrv->irq	= udc_irq;
 	rdrv->name	= "gadget";
 	ci->roles[CI_ROLE_GADGET] = rdrv;
-- 
1.7.0.4
