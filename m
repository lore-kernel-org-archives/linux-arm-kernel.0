From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 20:53:38 +0200
Subject: [PATCH 4/7] phy-sun4i-usb: Add support for boards with broken
 Vusb-detection
In-Reply-To: <1433530421-12197-1-git-send-email-hdegoede@redhat.com>
References: <1433530421-12197-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530421-12197-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some boards we cannot detect the presence of an external Vusb, because
e.g. the 5V of the otg connector is directly connected to the 5V of the board,
and thus is always high.

This commit adds support for using such boards by only looking at the
id-detection pin.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-sun4i-usb.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 7d067ee..4981041 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/extcon.h>
 #include <linux/io.h>
@@ -312,7 +313,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 	phy->regulator_on = true;
 
 	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
-	if (phy->index == 0 && data->phy0_poll)
+	if (phy->index == 0 && data->vbus_det_gpio && data->phy0_poll)
 		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
 
 	return 0;
@@ -333,7 +334,7 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
 	 * phy0 vbus typically slowly discharges, sometimes this causes the
 	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
 	 */
-	if (phy->index == 0 && !data->phy0_poll)
+	if (phy->index == 0 && data->vbus_det_gpio && !data->phy0_poll)
 		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
 
 	return 0;
@@ -362,7 +363,10 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	int id_det, vbus_det, id_notify = 0, vbus_notify = 0;
 
 	id_det = gpiod_get_value_cansleep(data->id_det_gpio);
-	vbus_det = gpiod_get_value_cansleep(data->vbus_det_gpio);
+	if (data->vbus_det_gpio)
+		vbus_det = gpiod_get_value_cansleep(data->vbus_det_gpio);
+	else
+		vbus_det = 1; /* Report vbus as high */
 
 	mutex_lock(&phy0->mutex);
 
@@ -372,6 +376,16 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	}
 
 	if (id_det != data->id_det) {
+		/*
+		 * When a host cable (id == 0) gets plugged in on systems
+		 * without vbus detection report vbus low for long enough for
+		 * the musb-ip to end the current device session.
+		 */
+		if (!data->vbus_det_gpio && id_det == 0) {
+			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
+			msleep(200);
+			sun4i_usb_phy0_set_vbus_detect(phy0, 1);
+		}
 		sun4i_usb_phy0_set_id_detect(phy0, id_det);
 		data->id_det = id_det;
 		id_notify = 1;
@@ -385,10 +399,23 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 
 	mutex_unlock(&phy0->mutex);
 
-	if (id_notify)
+	if (id_notify) {
 		extcon_set_cable_state(&data->extcon,
 				       extcon_cable_name[EXTCON_USB_HOST],
 				       !id_det);
+		/*
+		 * When a host cable gets unplugged (id == 1) on systems
+		 * without vbus detection report vbus low for long enough to
+		 * the musb-ip to end the current host session.
+		 */
+		if (!data->vbus_det_gpio && id_det == 1) {
+			mutex_lock(&phy0->mutex);
+			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
+			msleep(1000);
+			sun4i_usb_phy0_set_vbus_detect(phy0, 1);
+			mutex_unlock(&phy0->mutex);
+		}
+	}
 
 	if (vbus_notify)
 		extcon_set_cable_state(&data->extcon,
@@ -485,9 +512,9 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		data->vbus_det_gpio = NULL;
 	}
 
-	/* We either want both gpio pins or neither (when in host mode) */
-	if (!data->id_det_gpio != !data->vbus_det_gpio) {
-		dev_err(dev, "failed to get id or vbus detect pin\n");
+	/* vbus_det without id_det makes no sense, and is not supported */
+	if (data->vbus_det_gpio && !data->id_det_gpio) {
+		dev_err(dev, "usb0_id_det missing or invalid\n");
 		return -ENODEV;
 	}
 
@@ -550,7 +577,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 
 	data->id_det_irq = gpiod_to_irq(data->id_det_gpio);
 	data->vbus_det_irq = gpiod_to_irq(data->vbus_det_gpio);
-	if (data->id_det_irq  < 0 || data->vbus_det_irq < 0)
+	if ((data->id_det_gpio && data->id_det_irq < 0) ||
+	    (data->vbus_det_gpio && data->vbus_det_irq < 0))
 		data->phy0_poll = true;
 
 	if (data->id_det_irq >= 0) {
-- 
2.4.2
