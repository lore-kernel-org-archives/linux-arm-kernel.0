From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 13 Jun 2015 14:37:51 +0200
Subject: [PATCH v5 7/7] phy-sun4i-usb: Add support for monitoring vbus via a
 power-supply
In-Reply-To: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
References: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1434199071-22127-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some boards there is no vbus_det gpio pin, instead vbus-detection for
otg can be done via the pmic.

This commit adds support for monitoring vbus_det via the power_supply
exported by the pmic, enabling support for otg on these boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  1 +
 drivers/phy/Kconfig                                |  1 +
 drivers/phy/phy-sun4i-usb.c                        | 76 ++++++++++++++++++++--
 3 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 5f48979..0cebf74 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -29,6 +29,7 @@ Required properties:
 Optional properties:
 - usb0_id_det-gpios : gpio phandle for reading the otg id pin value
 - usb0_vbus_det-gpios : gpio phandle for detecting the presence of usb0 vbus
+- usb0_vbus_power-supply: power-supply phandle for usb0 vbus presence detect
 - usb0_vbus-supply : regulator phandle for controller usb0 vbus
 - usb1_vbus-supply : regulator phandle for controller usb1 vbus
 - usb2_vbus-supply : regulator phandle for controller usb2 vbus
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 9841780..4e71765 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -174,6 +174,7 @@ config PHY_SUN4I_USB
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
 	depends on RESET_CONTROLLER
 	depends on EXTCON
+	depends on POWER_SUPPLY
 	select GENERIC_PHY
 	help
 	  Enable this to support the transceiver that is part of Allwinner
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 0681641..1010519 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-sun4i-usb.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/workqueue.h>
@@ -108,6 +109,9 @@ struct sun4i_usb_phy_data {
 	bool phy0_poll;
 	struct gpio_desc *id_det_gpio;
 	struct gpio_desc *vbus_det_gpio;
+	struct power_supply *vbus_power_supply;
+	struct notifier_block vbus_power_nb;
+	bool vbus_power_nb_registered;
 	int id_det_irq;
 	int vbus_det_irq;
 	int id_det;
@@ -352,6 +356,30 @@ static struct phy_ops sun4i_usb_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int sun4i_usb_phy0_get_vbus_det(struct sun4i_usb_phy_data *data)
+{
+	if (data->vbus_det_gpio)
+		return gpiod_get_value_cansleep(data->vbus_det_gpio);
+
+	if (data->vbus_power_supply) {
+		union power_supply_propval val;
+		int r;
+
+		r = power_supply_get_property(data->vbus_power_supply,
+					      POWER_SUPPLY_PROP_PRESENT, &val);
+		if (r == 0)
+			return val.intval;
+	}
+
+	/* Fallback: report vbus as high */
+	return 1;
+}
+
+static bool sun4i_usb_phy0_have_vbus_det(struct sun4i_usb_phy_data *data)
+{
+	return data->vbus_det_gpio || data->vbus_power_supply;
+}
+
 static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 {
 	struct sun4i_usb_phy_data *data =
@@ -360,10 +388,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	int id_det, vbus_det, id_notify = 0, vbus_notify = 0;
 
 	id_det = gpiod_get_value_cansleep(data->id_det_gpio);
-	if (data->vbus_det_gpio)
-		vbus_det = gpiod_get_value_cansleep(data->vbus_det_gpio);
-	else
-		vbus_det = 1; /* Report vbus as high */
+	vbus_det = sun4i_usb_phy0_get_vbus_det(data);
 
 	mutex_lock(&phy0->mutex);
 
@@ -378,7 +403,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		 * without vbus detection report vbus low for long enough for
 		 * the musb-ip to end the current device session.
 		 */
-		if (!data->vbus_det_gpio && id_det == 0) {
+		if (!sun4i_usb_phy0_have_vbus_det(data) && id_det == 0) {
 			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
 			msleep(200);
 			sun4i_usb_phy0_set_vbus_detect(phy0, 1);
@@ -404,7 +429,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		 * without vbus detection report vbus low for long enough to
 		 * the musb-ip to end the current host session.
 		 */
-		if (!data->vbus_det_gpio && id_det == 1) {
+		if (!sun4i_usb_phy0_have_vbus_det(data) && id_det == 1) {
 			mutex_lock(&phy0->mutex);
 			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
 			msleep(1000);
@@ -430,6 +455,20 @@ static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int sun4i_usb_phy0_vbus_notify(struct notifier_block *nb,
+				      unsigned long val, void *v)
+{
+	struct sun4i_usb_phy_data *data = 
+		container_of(nb, struct sun4i_usb_phy_data, vbus_power_nb);
+	struct power_supply *psy = v;
+
+	/* Properties on the vbus_power_supply changed, scan vbus_det */
+	if (val == PSY_EVENT_PROP_CHANGED && psy == data->vbus_power_supply)
+		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+
+	return NOTIFY_OK;
+}
+
 static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 					struct of_phandle_args *args)
 {
@@ -446,6 +485,8 @@ static int sun4i_usb_phy_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
 
+	if (data->vbus_power_nb_registered)
+		power_supply_unreg_notifier(&data->vbus_power_nb);
 	if (data->id_det_irq >= 0)
 		devm_free_irq(dev, data->id_det_irq, data);
 	if (data->vbus_det_irq >= 0)
@@ -522,8 +563,18 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		data->vbus_det_gpio = NULL;
 	}
 
+	if (of_find_property(np, "usb0_vbus_power-supply", NULL)) {
+		data->vbus_power_supply = devm_power_supply_get_by_phandle(dev,
+						     "usb0_vbus_power-supply");
+		if (IS_ERR(data->vbus_power_supply))
+			return PTR_ERR(data->vbus_power_supply);
+
+		if (!data->vbus_power_supply)
+			return -EPROBE_DEFER;
+	}
+
 	/* vbus_det without id_det makes no sense, and is not supported */
-	if (data->vbus_det_gpio && !data->id_det_gpio) {
+	if (sun4i_usb_phy0_have_vbus_det(data) && !data->id_det_gpio) {
 		dev_err(dev, "usb0_id_det missing or invalid\n");
 		return -ENODEV;
 	}
@@ -620,6 +671,17 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (data->vbus_power_supply) {
+		data->vbus_power_nb.notifier_call = sun4i_usb_phy0_vbus_notify;
+		data->vbus_power_nb.priority = 0;
+		ret = power_supply_reg_notifier(&data->vbus_power_nb);
+		if (ret) {
+			sun4i_usb_phy_remove(pdev); /* Stop detect work */
+			return ret;
+		}
+		data->vbus_power_nb_registered = true;
+	}
+
 	phy_provider = devm_of_phy_provider_register(dev, sun4i_usb_phy_xlate);
 	if (IS_ERR(phy_provider)) {
 		sun4i_usb_phy_remove(pdev); /* Stop detect work */
-- 
2.4.3
