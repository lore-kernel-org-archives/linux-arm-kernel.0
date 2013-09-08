From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Sun,  8 Sep 2013 10:50:38 +0200
Subject: [PATCH 3/4] power: isp1704_charger: Add callback function set_current
In-Reply-To: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1378630239-10006-4-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add callback function set_current to platform data.
Driver will call this function when isp1704 change current
and board provided this callback funtion in platform data.

This patch is needed for Nokia RX-51 to tell bq2415x charging
chip about connected wallcharger events.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 drivers/power/isp1704_charger.c       |   16 ++++++++++++++++
 include/linux/power/isp1704_charger.h |    1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_charger.c
index f726cb6..4f20a1a 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -91,6 +91,18 @@ static void isp1704_charger_set_power(struct isp1704_charger *isp, bool on)
 }
 
 /*
+ * Set charger current from isp1704 if a function for it
+ * has been provided with platform data.
+ */
+static void isp1704_charger_set_current(struct isp1704_charger *isp, int mA)
+{
+	struct isp1704_charger_data *board = isp->dev->platform_data;
+
+	if (board && board->set_current)
+		board->set_current(mA);
+}
+
+/*
  * Determine is the charging port DCP (dedicated charger) or CDP (Host/HUB
  * chargers).
  *
@@ -257,6 +269,7 @@ static void isp1704_charger_work(struct work_struct *data)
 			if (isp1704_charger_detect_dcp(isp)) {
 				isp->psy.type = POWER_SUPPLY_TYPE_USB_DCP;
 				isp->current_max = 1800;
+				isp1704_charger_set_current(isp, 1800);
 			} else {
 				isp->psy.type = POWER_SUPPLY_TYPE_USB;
 				isp->current_max = 500;
@@ -277,6 +290,8 @@ static void isp1704_charger_work(struct work_struct *data)
 
 			if (isp->current_max > 100)
 				isp->psy.type = POWER_SUPPLY_TYPE_USB_CDP;
+
+			isp1704_charger_set_current(isp, isp->current_max);
 		}
 		break;
 	case USB_EVENT_NONE:
@@ -297,6 +312,7 @@ static void isp1704_charger_work(struct work_struct *data)
 			usb_gadget_disconnect(isp->phy->otg->gadget);
 
 		isp1704_charger_set_power(isp, 0);
+		isp1704_charger_set_current(isp, 0);
 		break;
 	default:
 		goto out;
diff --git a/include/linux/power/isp1704_charger.h b/include/linux/power/isp1704_charger.h
index 68096a6..d154b02 100644
--- a/include/linux/power/isp1704_charger.h
+++ b/include/linux/power/isp1704_charger.h
@@ -24,6 +24,7 @@
 
 struct isp1704_charger_data {
 	void		(*set_power)(bool on);
+	void		(*set_current)(int mA);
 };
 
 #endif
-- 
1.7.10.4
