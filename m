From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 15 Aug 2016 21:21:29 +0200
Subject: [PATCH v2 4/7] phy-sun4i-usb: Add support for phy_set_mode
In-Reply-To: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471288892-21702-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Together with some musb sunxi glue changes this allows run-time dr_mode
switching support via the "mode" musb sysfs attribute.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-sun4i-usb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index fb2d4f3..d369081 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -427,6 +427,29 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
 	return 0;
 }
 
+static int sun4i_usb_phy_set_mode(struct phy *_phy, enum phy_mode mode)
+{
+	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
+	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
+
+	if (phy->index != 0)
+		return -EINVAL;
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
+	case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
+	case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_info(&_phy->dev, "Changing dr_mode to %d\n", (int)data->dr_mode);
+	data->force_session_end = true;
+	queue_delayed_work(system_wq, &data->detect, 0);
+
+	return 0;
+}
+
 void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
 {
 	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
@@ -440,6 +463,7 @@ static const struct phy_ops sun4i_usb_phy_ops = {
 	.exit		= sun4i_usb_phy_exit,
 	.power_on	= sun4i_usb_phy_power_on,
 	.power_off	= sun4i_usb_phy_power_off,
+	.set_mode	= sun4i_usb_phy_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.7.4
