From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 21 Aug 2016 14:16:35 +0200
Subject: [PATCH v3 3/7] phy-sun4i-usb: Simplify missing dr_mode handling
In-Reply-To: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
References: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471781799-10457-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we cannot get dr_mode or no id gpio is specified simply assume
peripheral mode, as this is always safe.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Keep sun4i_usb_phy0_get_id_det() logic as is rather then re-ordering
 the switch-case
Changes in v3:
-No changes
---
 drivers/phy/phy-sun4i-usb.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 02cb65e..fb2d4f3 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -124,7 +124,6 @@ struct sun4i_usb_phy_data {
 		bool regulator_on;
 		int index;
 	} phys[MAX_PHYS];
-	int first_phy;
 	/* phy0 / otg related variables */
 	struct extcon_dev *extcon;
 	bool phy0_init;
@@ -326,7 +325,10 @@ static int sun4i_usb_phy0_get_id_det(struct sun4i_usb_phy_data *data)
 {
 	switch (data->dr_mode) {
 	case USB_DR_MODE_OTG:
-		return gpiod_get_value_cansleep(data->id_det_gpio);
+		if (data->id_det_gpio)
+			return gpiod_get_value_cansleep(data->id_det_gpio);
+		else
+			return 1; /* Fallback to peripheral mode */
 	case USB_DR_MODE_HOST:
 		return 0;
 	case USB_DR_MODE_PERIPHERAL:
@@ -539,8 +541,7 @@ static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 {
 	struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
 
-	if (args->args[0] < data->first_phy ||
-	    args->args[0] >= data->cfg->num_phys)
+	if (args->args[0] >= data->cfg->num_phys)
 		return ERR_PTR(-ENODEV);
 
 	return data->phys[args->args[0]].phy;
@@ -615,33 +616,18 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	}
 
 	data->dr_mode = of_usb_get_dr_mode_by_phy(np, 0);
-	switch (data->dr_mode) {
-	case USB_DR_MODE_OTG:
-		/* otg without id_det makes no sense, and is not supported */
-		if (!data->id_det_gpio) {
-			dev_err(dev, "usb0_id_det missing or invalid\n");
-			return -ENODEV;
-		}
-		/* fall through */
-	case USB_DR_MODE_HOST:
-	case USB_DR_MODE_PERIPHERAL:
-		data->extcon = devm_extcon_dev_allocate(dev,
-							sun4i_usb_phy0_cable);
-		if (IS_ERR(data->extcon))
-			return PTR_ERR(data->extcon);
 
-		ret = devm_extcon_dev_register(dev, data->extcon);
-		if (ret) {
-			dev_err(dev, "failed to register extcon: %d\n", ret);
-			return ret;
-		}
-		break;
-	default:
-		dev_info(dev, "dr_mode unknown, not registering usb phy0\n");
-		data->first_phy = 1;
+	data->extcon = devm_extcon_dev_allocate(dev, sun4i_usb_phy0_cable);
+	if (IS_ERR(data->extcon))
+		return PTR_ERR(data->extcon);
+
+	ret = devm_extcon_dev_register(dev, data->extcon);
+	if (ret) {
+		dev_err(dev, "failed to register extcon: %d\n", ret);
+		return ret;
 	}
 
-	for (i = data->first_phy; i < data->cfg->num_phys; i++) {
+	for (i = 0; i < data->cfg->num_phys; i++) {
 		struct sun4i_usb_phy *phy = data->phys + i;
 		char name[16];
 
-- 
2.7.4
