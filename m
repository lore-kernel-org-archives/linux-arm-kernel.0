From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:23 -0700
Subject: [PATCH v5 10/23] usb: chipidea: Consolidate extcon notifiers
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-11-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two extcon notifiers are almost the same except for the
variable name for the cable structure and the id notifier inverts
the cable->state logic. Make it the same and replace two
functions with one to save some lines. This also makes it so that
the id cable state is true when the id pin is pulled low, so we
change the name of ->state to ->connected to properly reflect
that we're interested in the cable being connected.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/core.c  | 45 ++++++++++++--------------------------------
 drivers/usb/chipidea/otg.c   |  8 ++++----
 include/linux/usb/chipidea.h |  4 ++--
 3 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index f144e1bbcc82..83bc2f2dd6a8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -577,35 +577,14 @@ static irqreturn_t ci_irq(int irq, void *data)
 	return ret;
 }
 
-static int ci_vbus_notifier(struct notifier_block *nb, unsigned long event,
-			    void *ptr)
+static int ci_cable_notifier(struct notifier_block *nb, unsigned long event,
+			     void *ptr)
 {
-	struct ci_hdrc_cable *vbus = container_of(nb, struct ci_hdrc_cable, nb);
-	struct ci_hdrc *ci = vbus->ci;
+	struct ci_hdrc_cable *cbl = container_of(nb, struct ci_hdrc_cable, nb);
+	struct ci_hdrc *ci = cbl->ci;
 
-	if (event)
-		vbus->state = true;
-	else
-		vbus->state = false;
-
-	vbus->changed = true;
-
-	ci_irq(ci->irq, ci);
-	return NOTIFY_DONE;
-}
-
-static int ci_id_notifier(struct notifier_block *nb, unsigned long event,
-			  void *ptr)
-{
-	struct ci_hdrc_cable *id = container_of(nb, struct ci_hdrc_cable, nb);
-	struct ci_hdrc *ci = id->ci;
-
-	if (event)
-		id->state = false;
-	else
-		id->state = true;
-
-	id->changed = true;
+	cbl->connected = event;
+	cbl->changed = true;
 
 	ci_irq(ci->irq, ci);
 	return NOTIFY_DONE;
@@ -714,27 +693,27 @@ static int ci_get_platdata(struct device *dev,
 	}
 
 	cable = &platdata->vbus_extcon;
-	cable->nb.notifier_call = ci_vbus_notifier;
+	cable->nb.notifier_call = ci_cable_notifier;
 	cable->edev = ext_vbus;
 
 	if (!IS_ERR(ext_vbus)) {
 		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB);
 		if (ret)
-			cable->state = true;
+			cable->connected = true;
 		else
-			cable->state = false;
+			cable->connected = false;
 	}
 
 	cable = &platdata->id_extcon;
-	cable->nb.notifier_call = ci_id_notifier;
+	cable->nb.notifier_call = ci_cable_notifier;
 	cable->edev = ext_id;
 
 	if (!IS_ERR(ext_id)) {
 		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB_HOST);
 		if (ret)
-			cable->state = false;
+			cable->connected = true;
 		else
-			cable->state = true;
+			cable->connected = false;
 	}
 	return 0;
 }
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 0cf149edddd8..695f3fe3ae21 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -44,7 +44,7 @@ u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
 		else
 			val &= ~OTGSC_BSVIS;
 
-		if (cable->state)
+		if (cable->connected)
 			val |= OTGSC_BSV;
 		else
 			val &= ~OTGSC_BSV;
@@ -62,10 +62,10 @@ u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
 		else
 			val &= ~OTGSC_IDIS;
 
-		if (cable->state)
-			val |= OTGSC_ID;
+		if (cable->connected)
+			val &= ~OTGSC_ID; /* host */
 		else
-			val &= ~OTGSC_ID;
+			val |= OTGSC_ID; /* device */
 
 		if (cable->enabled)
 			val |= OTGSC_IDIE;
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index d07b162073f7..7e3daa37cf60 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -12,7 +12,7 @@ struct ci_hdrc;
 
 /**
  * struct ci_hdrc_cable - structure for external connector cable state tracking
- * @state: current state of the line
+ * @connected: true if cable is connected, false otherwise
  * @changed: set to true when extcon event happen
  * @enabled: set to true if we've enabled the vbus or id interrupt
  * @edev: device which generate events
@@ -21,7 +21,7 @@ struct ci_hdrc;
  * @conn: used for notification registration
  */
 struct ci_hdrc_cable {
-	bool				state;
+	bool				connected;
 	bool				changed;
 	bool				enabled;
 	struct extcon_dev		*edev;
-- 
2.10.0.297.gf6727b0
