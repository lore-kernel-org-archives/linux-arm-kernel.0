From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 21 Dec 2016 14:10:48 +0800
Subject: [PATCH 2/3] extcon: axp288: Set EXTCON_USB when EXTCON_CHG_USB_SDP
 was set
In-Reply-To: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
References: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
Message-ID: <11fb7adc2982a9134faee9abb1de4dcfb253f2d2.1482300213.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the documentation, we should set the EXTCON_USB when
one SDP charger connector was reported.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/extcon/extcon-axp288.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 42f41e8..4490726 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -102,6 +102,7 @@ enum axp288_extcon_irq {
 };
 
 static const unsigned int axp288_extcon_cables[] = {
+	EXTCON_USB,
 	EXTCON_CHG_USB_SDP,
 	EXTCON_CHG_USB_CDP,
 	EXTCON_CHG_USB_DCP,
@@ -225,8 +226,12 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 			vbus_attach ? USB_EVENT_VBUS : USB_EVENT_NONE, NULL);
 	}
 
-	if (notify_charger)
+	if (notify_charger) {
 		extcon_set_state_sync(info->edev, cable, vbus_attach);
+		if (cable == EXTCON_CHG_USB_SDP)
+			extcon_set_state_sync(info->edev, EXTCON_USB,
+					      vbus_attach);
+	}
 
 	/* Clear the flags on disconnect event */
 	if (!vbus_attach)
-- 
1.7.9.5
