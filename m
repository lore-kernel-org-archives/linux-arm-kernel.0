From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  4 Jul 2016 23:17:33 +0200
Subject: [PATCH v6] phy-sun4i-usb: Add support for peripheral-only mode
In-Reply-To: <1467667053-15122-1-git-send-email-hdegoede@redhat.com>
References: <1467667053-15122-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467667053-15122-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new of_usb_get_dr_mode_by_phy() function to get the dr_mode
from the musb controller node instead of assuming that having an id_det
gpio means otg mode, and not having one means host mode.

Implement peripheral-only mode by adding a sun4i_usb_phy0_get_id_det
helper which looks at the dr_mode, always registering our extcon and
always monitoring vbus.

If dr_mode is not specified in the dts, do not register phy0 as we then
do not know how to treat it. This is actually a good thing as this means
we will not be registering phy0 on devices where the otg controller is
not enabled in the devicetree.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes in v2:
-Adjust for of_usb_get_dr_mode_by_phy now taking an args0 parameter
Changes in v3:
-Only toggle the phy vbus-det bit on id-change on systems without vbus-det
 when in otg mode
Changes in v4:
-No changes
Changes in v5:
-Added Kishon's Acked-by
Changes in v6:
-Rebase on top of latest linux-phy/next
---
 drivers/phy/phy-sun4i-usb.c | 68 ++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 0a45bc6..8c7eb33 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -40,6 +40,7 @@
 #include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/usb/of.h>
 #include <linux/workqueue.h>
 
 #define REG_ISCR			0x00
@@ -110,6 +111,7 @@ struct sun4i_usb_phy_cfg {
 struct sun4i_usb_phy_data {
 	void __iomem *base;
 	const struct sun4i_usb_phy_cfg *cfg;
+	enum usb_dr_mode dr_mode;
 	struct mutex mutex;
 	struct sun4i_usb_phy {
 		struct phy *phy;
@@ -120,6 +122,7 @@ struct sun4i_usb_phy_data {
 		bool regulator_on;
 		int index;
 	} phys[MAX_PHYS];
+	int first_phy;
 	/* phy0 / otg related variables */
 	struct extcon_dev *extcon;
 	bool phy0_init;
@@ -285,16 +288,10 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		sun4i_usb_phy0_update_iscr(_phy, 0, ISCR_DPDM_PULLUP_EN);
 		sun4i_usb_phy0_update_iscr(_phy, 0, ISCR_ID_PULLUP_EN);
 
-		if (data->id_det_gpio) {
-			/* OTG mode, force ISCR and cable state updates */
-			data->id_det = -1;
-			data->vbus_det = -1;
-			queue_delayed_work(system_wq, &data->detect, 0);
-		} else {
-			/* Host only mode */
-			sun4i_usb_phy0_set_id_detect(_phy, 0);
-			sun4i_usb_phy0_set_vbus_detect(_phy, 1);
-		}
+		/* Force ISCR and cable state updates */
+		data->id_det = -1;
+		data->vbus_det = -1;
+		queue_delayed_work(system_wq, &data->detect, 0);
 	}
 
 	return 0;
@@ -319,6 +316,19 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
 	return 0;
 }
 
+static int sun4i_usb_phy0_get_id_det(struct sun4i_usb_phy_data *data)
+{
+	switch (data->dr_mode) {
+	case USB_DR_MODE_OTG:
+		return gpiod_get_value_cansleep(data->id_det_gpio);
+	case USB_DR_MODE_HOST:
+		return 0;
+	case USB_DR_MODE_PERIPHERAL:
+	default:
+		return 1;
+	}
+}
+
 static int sun4i_usb_phy0_get_vbus_det(struct sun4i_usb_phy_data *data)
 {
 	if (data->vbus_det_gpio)
@@ -432,7 +442,10 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	struct phy *phy0 = data->phys[0].phy;
 	int id_det, vbus_det, id_notify = 0, vbus_notify = 0;
 
-	id_det = gpiod_get_value_cansleep(data->id_det_gpio);
+	if (phy0 == NULL)
+		return;
+
+	id_det = sun4i_usb_phy0_get_id_det(data);
 	vbus_det = sun4i_usb_phy0_get_vbus_det(data);
 
 	mutex_lock(&phy0->mutex);
@@ -448,7 +461,8 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		 * without vbus detection report vbus low for long enough for
 		 * the musb-ip to end the current device session.
 		 */
-		if (!sun4i_usb_phy0_have_vbus_det(data) && id_det == 0) {
+		if (data->dr_mode == USB_DR_MODE_OTG &&
+		    !sun4i_usb_phy0_have_vbus_det(data) && id_det == 0) {
 			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
 			msleep(200);
 			sun4i_usb_phy0_set_vbus_detect(phy0, 1);
@@ -474,7 +488,8 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		 * without vbus detection report vbus low for long enough to
 		 * the musb-ip to end the current host session.
 		 */
-		if (!sun4i_usb_phy0_have_vbus_det(data) && id_det == 1) {
+		if (data->dr_mode == USB_DR_MODE_OTG &&
+		    !sun4i_usb_phy0_have_vbus_det(data) && id_det == 1) {
 			mutex_lock(&phy0->mutex);
 			sun4i_usb_phy0_set_vbus_detect(phy0, 0);
 			msleep(1000);
@@ -519,7 +534,8 @@ static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 {
 	struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
 
-	if (args->args[0] >= data->cfg->num_phys)
+	if (args->args[0] < data->first_phy ||
+	    args->args[0] >= data->cfg->num_phys)
 		return ERR_PTR(-ENODEV);
 
 	return data->phys[args->args[0]].phy;
@@ -593,13 +609,17 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 			return -EPROBE_DEFER;
 	}
 
-	/* vbus_det without id_det makes no sense, and is not supported */
-	if (sun4i_usb_phy0_have_vbus_det(data) && !data->id_det_gpio) {
-		dev_err(dev, "usb0_id_det missing or invalid\n");
-		return -ENODEV;
-	}
-
-	if (data->id_det_gpio) {
+	data->dr_mode = of_usb_get_dr_mode_by_phy(np, 0);
+	switch (data->dr_mode) {
+	case USB_DR_MODE_OTG:
+		/* otg without id_det makes no sense, and is not supported */
+		if (!data->id_det_gpio) {
+			dev_err(dev, "usb0_id_det missing or invalid\n");
+			return -ENODEV;
+		}
+		/* fall through */
+	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_PERIPHERAL:
 		data->extcon = devm_extcon_dev_allocate(dev,
 							sun4i_usb_phy0_cable);
 		if (IS_ERR(data->extcon))
@@ -610,9 +630,13 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 			dev_err(dev, "failed to register extcon: %d\n", ret);
 			return ret;
 		}
+		break;
+	default:
+		dev_info(dev, "dr_mode unknown, not registering usb phy0\n");
+		data->first_phy = 1;
 	}
 
-	for (i = 0; i < data->cfg->num_phys; i++) {
+	for (i = data->first_phy; i < data->cfg->num_phys; i++) {
 		struct sun4i_usb_phy *phy = data->phys + i;
 		char name[16];
 
-- 
2.7.4
