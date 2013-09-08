From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Sun,  8 Sep 2013 10:50:37 +0200
Subject: [PATCH 2/4] power: isp1704_charger: Fix driver to work with changes
 introduced in v3.5
In-Reply-To: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1378630239-10006-3-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* omap musb driver does not report USB_EVENT_ENUMERATED event anymore
* omap musb driver reporting USB_EVENT_VBUS when charger is connected
* read last event from phy->last_event (instead from ulpi register)
* do not call wall charger detection more times

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 drivers/power/isp1704_charger.c |   91 +++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_charger.c
index fc04d19..f726cb6 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -2,6 +2,7 @@
  * ISP1704 USB Charger Detection driver
  *
  * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2012 - 2013 Pali Roh?r <pali.rohar@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -65,10 +66,6 @@ struct isp1704_charger {
 	unsigned		present:1;
 	unsigned		online:1;
 	unsigned		current_max;
-
-	/* temp storage variables */
-	unsigned long		event;
-	unsigned		max_power;
 };
 
 static inline int isp1704_read(struct isp1704_charger *isp, u32 reg)
@@ -231,56 +228,59 @@ static inline int isp1704_charger_detect(struct isp1704_charger *isp)
 	return ret;
 }
 
+static inline int isp1704_charger_detect_dcp(struct isp1704_charger *isp)
+{
+	if (isp1704_charger_detect(isp) &&
+		isp1704_charger_type(isp) == POWER_SUPPLY_TYPE_USB_DCP)
+		return true;
+	else
+		return false;
+}
+
 static void isp1704_charger_work(struct work_struct *data)
 {
-	int			detect;
-	unsigned long		event;
-	unsigned		power;
 	struct isp1704_charger	*isp =
 		container_of(data, struct isp1704_charger, work);
 	static DEFINE_MUTEX(lock);
 
-	event = isp->event;
-	power = isp->max_power;
-
 	mutex_lock(&lock);
 
-	if (event != USB_EVENT_NONE)
-		isp1704_charger_set_power(isp, 1);
-
-	switch (event) {
+	switch (isp->phy->last_event) {
 	case USB_EVENT_VBUS:
-		isp->online = true;
+		/* do not call wall charger detection more times */
+		if (!isp->present) {
+			isp->online = true;
+			isp->present = 1;
+			isp1704_charger_set_power(isp, 1);
+
+			/* detect wall charger */
+			if (isp1704_charger_detect_dcp(isp)) {
+				isp->psy.type = POWER_SUPPLY_TYPE_USB_DCP;
+				isp->current_max = 1800;
+			} else {
+				isp->psy.type = POWER_SUPPLY_TYPE_USB;
+				isp->current_max = 500;
+			}
 
-		/* detect charger */
-		detect = isp1704_charger_detect(isp);
-
-		if (detect) {
-			isp->present = detect;
-			isp->psy.type = isp1704_charger_type(isp);
+			/* enable data pullups */
+			if (isp->phy->otg->gadget)
+				usb_gadget_connect(isp->phy->otg->gadget);
 		}
 
-		switch (isp->psy.type) {
-		case POWER_SUPPLY_TYPE_USB_DCP:
-			isp->current_max = 1800;
-			break;
-		case POWER_SUPPLY_TYPE_USB_CDP:
+		if (isp->psy.type != POWER_SUPPLY_TYPE_USB_DCP) {
 			/*
 			 * Only 500mA here or high speed chirp
 			 * handshaking may break
 			 */
-			isp->current_max = 500;
-			/* FALLTHROUGH */
-		case POWER_SUPPLY_TYPE_USB:
-		default:
-			/* enable data pullups */
-			if (isp->phy->otg->gadget)
-				usb_gadget_connect(isp->phy->otg->gadget);
+			if (isp->current_max > 500)
+				isp->current_max = 500;
+
+			if (isp->current_max > 100)
+				isp->psy.type = POWER_SUPPLY_TYPE_USB_CDP;
 		}
 		break;
 	case USB_EVENT_NONE:
 		isp->online = false;
-		isp->current_max = 0;
 		isp->present = 0;
 		isp->current_max = 0;
 		isp->psy.type = POWER_SUPPLY_TYPE_USB;
@@ -298,12 +298,6 @@ static void isp1704_charger_work(struct work_struct *data)
 
 		isp1704_charger_set_power(isp, 0);
 		break;
-	case USB_EVENT_ENUMERATED:
-		if (isp->present)
-			isp->current_max = 1800;
-		else
-			isp->current_max = power;
-		break;
 	default:
 		goto out;
 	}
@@ -314,16 +308,11 @@ out:
 }
 
 static int isp1704_notifier_call(struct notifier_block *nb,
-		unsigned long event, void *power)
+		unsigned long val, void *v)
 {
 	struct isp1704_charger *isp =
 		container_of(nb, struct isp1704_charger, nb);
 
-	isp->event = event;
-
-	if (power)
-		isp->max_power = *((unsigned *)power);
-
 	schedule_work(&isp->work);
 
 	return NOTIFY_OK;
@@ -462,13 +451,13 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 	if (isp->phy->otg->gadget)
 		usb_gadget_disconnect(isp->phy->otg->gadget);
 
+	if (isp->phy->last_event == USB_EVENT_NONE)
+		isp1704_charger_set_power(isp, 0);
+
 	/* Detect charger if VBUS is valid (the cable was already plugged). */
-	ret = isp1704_read(isp, ULPI_USB_INT_STS);
-	isp1704_charger_set_power(isp, 0);
-	if ((ret & ULPI_INT_VBUS_VALID) && !isp->phy->otg->default_a) {
-		isp->event = USB_EVENT_VBUS;
+	if (isp->phy->last_event == USB_EVENT_VBUS &&
+			!isp->phy->otg->default_a)
 		schedule_work(&isp->work);
-	}
 
 	return 0;
 fail2:
-- 
1.7.10.4
