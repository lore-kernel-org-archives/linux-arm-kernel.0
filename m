From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 20:14:10 +0200
Subject: [PATCH v5 resend 2/2] phy-sun4i-usb: Add workaround for missing Vbus
 det interrupts on A31
In-Reply-To: <1467224050-7480-1-git-send-email-hdegoede@redhat.com>
References: <1467224050-7480-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467224050-7480-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 companion pmic (axp221) does not generate vbus change interrupts
when the board is driving vbus, so we must poll when using the pmic for
vbus-det _and_ we're driving vbus.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes in v2:
-No changes
Changes in v3:
-No changes
Changes in v4:
-No changes
Changes in v5:
-Rebase on top of latest linux-phy/fixes
-Added Kishon's Acked-by
---
 drivers/phy/phy-sun4i-usb.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index f4d1178..8c7eb33 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -95,6 +95,7 @@
 
 enum sun4i_usb_phy_type {
 	sun4i_a10_phy,
+	sun6i_a31_phy,
 	sun8i_a33_phy,
 	sun8i_h3_phy,
 };
@@ -125,7 +126,6 @@ struct sun4i_usb_phy_data {
 	/* phy0 / otg related variables */
 	struct extcon_dev *extcon;
 	bool phy0_init;
-	bool phy0_poll;
 	struct gpio_desc *id_det_gpio;
 	struct gpio_desc *vbus_det_gpio;
 	struct power_supply *vbus_power_supply;
@@ -353,6 +353,24 @@ static bool sun4i_usb_phy0_have_vbus_det(struct sun4i_usb_phy_data *data)
 	return data->vbus_det_gpio || data->vbus_power_supply;
 }
 
+static bool sun4i_usb_phy0_poll(struct sun4i_usb_phy_data *data)
+{
+	if ((data->id_det_gpio && data->id_det_irq <= 0) ||
+	    (data->vbus_det_gpio && data->vbus_det_irq <= 0))
+		return true;
+
+	/*
+	 * The A31 companion pmic (axp221) does not generate vbus change
+	 * interrupts when the board is driving vbus, so we must poll
+	 * when using the pmic for vbus-det _and_ we're driving vbus.
+	 */
+	if (data->cfg->type == sun6i_a31_phy &&
+	    data->vbus_power_supply && data->phys[0].regulator_on)
+		return true;
+
+	return false;
+}
+
 static int sun4i_usb_phy_power_on(struct phy *_phy)
 {
 	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
@@ -374,7 +392,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 	phy->regulator_on = true;
 
 	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
-	if (phy->index == 0 && data->vbus_det_gpio && data->phy0_poll)
+	if (phy->index == 0 && sun4i_usb_phy0_poll(data))
 		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
 
 	return 0;
@@ -395,7 +413,7 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
 	 * phy0 vbus typically slowly discharges, sometimes this causes the
 	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
 	 */
-	if (phy->index == 0 && data->vbus_det_gpio && !data->phy0_poll)
+	if (phy->index == 0 && !sun4i_usb_phy0_poll(data))
 		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
 
 	return 0;
@@ -483,7 +501,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	if (vbus_notify)
 		extcon_set_cable_state_(data->extcon, EXTCON_USB, vbus_det);
 
-	if (data->phy0_poll)
+	if (sun4i_usb_phy0_poll(data))
 		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
 }
 
@@ -668,11 +686,6 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	}
 
 	data->id_det_irq = gpiod_to_irq(data->id_det_gpio);
-	data->vbus_det_irq = gpiod_to_irq(data->vbus_det_gpio);
-	if ((data->id_det_gpio && data->id_det_irq <= 0) ||
-	    (data->vbus_det_gpio && data->vbus_det_irq <= 0))
-		data->phy0_poll = true;
-
 	if (data->id_det_irq > 0) {
 		ret = devm_request_irq(dev, data->id_det_irq,
 				sun4i_usb_phy0_id_vbus_det_irq,
@@ -684,6 +697,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		}
 	}
 
+	data->vbus_det_irq = gpiod_to_irq(data->vbus_det_gpio);
 	if (data->vbus_det_irq > 0) {
 		ret = devm_request_irq(dev, data->vbus_det_irq,
 				sun4i_usb_phy0_id_vbus_det_irq,
@@ -735,7 +749,7 @@ static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
 
 static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
 	.num_phys = 3,
-	.type = sun4i_a10_phy,
+	.type = sun6i_a31_phy,
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
-- 
2.7.4
