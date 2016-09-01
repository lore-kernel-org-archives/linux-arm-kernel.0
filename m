From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 31 Aug 2016 17:40:24 -0700
Subject: [PATCH v3 10/22] usb: chipidea: Consolidate extcon notifiers
In-Reply-To: <20160901004036.23936-1-stephen.boyd@linaro.org>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
Message-ID: <20160901004036.23936-11-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two extcon notifiers are almost the same except for the
variable name for the cable structure and the id notifier inverts
the cable->state logic. Make it the same and replace two
functions with one to save some lines. This also makes it so that
the id cable state is true when the id pin is pulled low.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/core.c | 41 ++++++++++-------------------------------
 drivers/usb/chipidea/otg.c  |  4 ++--
 2 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index f144e1bbcc82..f3b8d7488648 100644
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
+	cbl->state = event;
+	cbl->changed = true;
 
 	ci_irq(ci->irq, ci);
 	return NOTIFY_DONE;
@@ -714,7 +693,7 @@ static int ci_get_platdata(struct device *dev,
 	}
 
 	cable = &platdata->vbus_extcon;
-	cable->nb.notifier_call = ci_vbus_notifier;
+	cable->nb.notifier_call = ci_cable_notifier;
 	cable->edev = ext_vbus;
 
 	if (!IS_ERR(ext_vbus)) {
@@ -726,15 +705,15 @@ static int ci_get_platdata(struct device *dev,
 	}
 
 	cable = &platdata->id_extcon;
-	cable->nb.notifier_call = ci_id_notifier;
+	cable->nb.notifier_call = ci_cable_notifier;
 	cable->edev = ext_id;
 
 	if (!IS_ERR(ext_id)) {
 		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB_HOST);
 		if (ret)
-			cable->state = false;
-		else
 			cable->state = true;
+		else
+			cable->state = false;
 	}
 	return 0;
 }
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 0cf149edddd8..fb58d6b312c2 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -63,9 +63,9 @@ u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
 			val &= ~OTGSC_IDIS;
 
 		if (cable->state)
-			val |= OTGSC_ID;
+			val &= ~OTGSC_ID; /* A device */
 		else
-			val &= ~OTGSC_ID;
+			val |= OTGSC_ID; /* B device */
 
 		if (cable->enabled)
 			val |= OTGSC_IDIE;
-- 
2.9.0.rc2.8.ga28705d
