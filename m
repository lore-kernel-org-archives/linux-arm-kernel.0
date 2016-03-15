From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 15 Mar 2016 14:08:27 +0530
Subject: [RFC PATCH 1/4] usb: chipidea: Do not rely on OTG while using extcon
In-Reply-To: <cover.1458030082.git.maitysanchayan@gmail.com>
References: <cover.1458030082.git.maitysanchayan@gmail.com>
Message-ID: <a3dc1c8adc4266d36267901ce6e975ddfca09abb.1458030082.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing usage of extcon in Chipidea driver relies on OTG
registers. In case of SoC with dual role device but not a true
OTG controller, this does not work. Such SoC's should specify
the existing CI_HDRC_DUAL_ROLE_NOT_OTG flag and do the role
switch without checking any of the OTG registers.

This patch almost reverts most of commit "usb: chipidea: Use
extcon framework for VBUS and ID detect". We do not rely
anymore on emulating an OTG capable controller by faking OTG
controller reads.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/usb/chipidea/core.c  | 64 ++++++++++++++++++++++++--------------------
 drivers/usb/chipidea/otg.c   | 39 +--------------------------
 include/linux/usb/chipidea.h |  2 --
 3 files changed, 36 insertions(+), 69 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 7404064..d29118d 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -607,14 +607,15 @@ static int ci_vbus_notifier(struct notifier_block *nb, unsigned long event,
 	struct ci_hdrc_cable *vbus = container_of(nb, struct ci_hdrc_cable, nb);
 	struct ci_hdrc *ci = vbus->ci;
 
+	pm_runtime_get_sync(ci->dev);
+
 	if (event)
-		vbus->state = true;
+		usb_gadget_vbus_connect(&ci->gadget);
 	else
-		vbus->state = false;
+		usb_gadget_vbus_disconnect(&ci->gadget);
 
-	vbus->changed = true;
+	pm_runtime_put_sync(ci->dev);
 
-	ci_irq(ci->irq, ci);
 	return NOTIFY_DONE;
 }
 
@@ -624,14 +625,19 @@ static int ci_id_notifier(struct notifier_block *nb, unsigned long event,
 	struct ci_hdrc_cable *id = container_of(nb, struct ci_hdrc_cable, nb);
 	struct ci_hdrc *ci = id->ci;
 
-	if (event)
-		id->state = false;
-	else
-		id->state = true;
+	pm_runtime_get_sync(ci->dev);
+
+	ci_role_stop(ci);
+
+	hw_wait_phy_stable();
+
+	if (ci_role_start(ci, event ? CI_ROLE_HOST : CI_ROLE_GADGET))
+		dev_err(ci->dev,
+			"Can't start %s role\n",
+			event ? "host" : "gadget");
 
-	id->changed = true;
+	pm_runtime_put_sync(ci->dev);
 
-	ci_irq(ci->irq, ci);
 	return NOTIFY_DONE;
 }
 
@@ -738,25 +744,10 @@ static int ci_get_platdata(struct device *dev,
 	cable->nb.notifier_call = ci_vbus_notifier;
 	cable->edev = ext_vbus;
 
-	if (!IS_ERR(ext_vbus)) {
-		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB);
-		if (ret)
-			cable->state = true;
-		else
-			cable->state = false;
-	}
-
 	cable = &platdata->id_extcon;
 	cable->nb.notifier_call = ci_id_notifier;
 	cable->edev = ext_id;
 
-	if (!IS_ERR(ext_id)) {
-		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB_HOST);
-		if (ret)
-			cable->state = false;
-		else
-			cable->state = true;
-	}
 	return 0;
 }
 
@@ -896,6 +887,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	void __iomem	*base;
 	int		ret;
 	enum usb_dr_mode dr_mode;
+	struct ci_hdrc_cable *cable;
 
 	if (!dev_get_platdata(dev)) {
 		dev_err(dev, "platform data missing\n");
@@ -963,6 +955,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	ci_get_otg_capable(ci);
 
+	ret = ci_extcon_register(ci);
+	if (ret) {
+		dev_err(dev, "extcon registration failed\n");
+		goto deinit_phy;
+	}
+
 	dr_mode = ci->platdata->dr_mode;
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
@@ -1003,6 +1001,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 			 * user can switch it through debugfs.
 			 */
 			ci->role = CI_ROLE_GADGET;
+			cable = &ci->platdata->id_extcon;
+			if (!IS_ERR(cable->edev)) {
+				if (extcon_get_cable_state(cable->edev,
+						"USB-HOST") == true)
+					ci->role = CI_ROLE_HOST;
+			}
 		}
 	} else {
 		ci->role = ci->roles[CI_ROLE_HOST]
@@ -1021,6 +1025,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 						ci_role(ci)->name);
 			goto stop;
 		}
+		cable = &ci->platdata->vbus_extcon;
+		if (!IS_ERR(cable->edev)) {
+			if ((ci->role == CI_ROLE_GADGET) &&
+			(extcon_get_cable_state(cable->edev, "USB") == true))
+				usb_gadget_vbus_connect(&ci->gadget);
+		}
 	}
 
 	platform_set_drvdata(pdev, ci);
@@ -1029,10 +1039,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto stop;
 
-	ret = ci_extcon_register(ci);
-	if (ret)
-		goto stop;
-
 	if (ci->supports_runtime_pm) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 45f86da..3169c51 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -30,44 +30,7 @@
  */
 u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
 {
-	struct ci_hdrc_cable *cable;
-	u32 val = hw_read(ci, OP_OTGSC, mask);
-
-	/*
-	 * If using extcon framework for VBUS and/or ID signal
-	 * detection overwrite OTGSC register value
-	 */
-	cable = &ci->platdata->vbus_extcon;
-	if (!IS_ERR(cable->edev)) {
-		if (cable->changed)
-			val |= OTGSC_BSVIS;
-		else
-			val &= ~OTGSC_BSVIS;
-
-		cable->changed = false;
-
-		if (cable->state)
-			val |= OTGSC_BSV;
-		else
-			val &= ~OTGSC_BSV;
-	}
-
-	cable = &ci->platdata->id_extcon;
-	if (!IS_ERR(cable->edev)) {
-		if (cable->changed)
-			val |= OTGSC_IDIS;
-		else
-			val &= ~OTGSC_IDIS;
-
-		cable->changed = false;
-
-		if (cable->state)
-			val |= OTGSC_ID;
-		else
-			val &= ~OTGSC_ID;
-	}
-
-	return val;
+	return hw_read(ci, OP_OTGSC, mask);
 }
 
 /**
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 5dd75fa..f70ab21 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -20,8 +20,6 @@ struct ci_hdrc;
  * @conn: used for notification registration
  */
 struct ci_hdrc_cable {
-	bool				state;
-	bool				changed;
 	struct extcon_dev		*edev;
 	struct ci_hdrc			*ci;
 	struct notifier_block		nb;
-- 
2.7.3
