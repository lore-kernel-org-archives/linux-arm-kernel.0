From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 22 Sep 2016 14:18:59 +0300
Subject: [PATCH v2 1/3] phy_sun4i_usb: set_mode: Allow using set_mode to force
 end the current session
Message-ID: <20160922111901.15337-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi musb has a bug where sometimes it will generate a babble
error on device disconnect instead of a disconnect irq. When this
happens the musb-controller switches from host mode to device mode
(it clears MUSB_DEVCTL_SESSION and sets MUSB_DEVCTL_BDEVICE) and
gets stuck in this state.

Clearing this requires reporting Vbus low for 200 or more ms, but
on some devices Vbus is simply always high (host-only mode, no Vbus
control).

This commit modifies sun4i_usb_phy_set_mode so that it will force
end the current session when called with the current mode, before this
commit calling set_mode with the current mode was a nop since id_det
would stay the same resulting in the detect_work not doing anything.

This allows the sunxi-musb glue to use sun4i_usb_phy_set_mode to force
end the current session without changing the mode, to fixup the stuck
state after a babble error.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this series replacing the
 "phy-sun4i-usb: Add sun4i_usb_phy_force_session_end() function"
 from v1
---
 drivers/phy/phy-sun4i-usb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 43c0d98..d76538c 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -437,25 +437,32 @@ static int sun4i_usb_phy_set_mode(struct phy *_phy, enum phy_mode mode)
 {
 	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
 	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
+	enum usb_dr_mode new_mode;
 
 	if (phy->index != 0)
 		return -EINVAL;
 
 	switch (mode) {
 	case PHY_MODE_USB_HOST:
-		data->dr_mode = USB_DR_MODE_HOST;
+		new_mode = USB_DR_MODE_HOST;
 		break;
 	case PHY_MODE_USB_DEVICE:
-		data->dr_mode = USB_DR_MODE_PERIPHERAL;
+		new_mode = USB_DR_MODE_PERIPHERAL;
 		break;
 	case PHY_MODE_USB_OTG:
-		data->dr_mode = USB_DR_MODE_OTG;
+		new_mode = USB_DR_MODE_OTG;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	dev_info(&_phy->dev, "Changing dr_mode to %d\n", (int)data->dr_mode);
+	if (new_mode != data->dr_mode) {
+		dev_info(&_phy->dev, "Changing dr_mode to %d\n",
+			 (int)data->dr_mode);
+		data->dr_mode = new_mode;
+	}
+
+	data->id_det = -1; /* Force reprocessing of id */
 	data->force_session_end = true;
 	queue_delayed_work(system_wq, &data->detect, 0);
 
-- 
2.9.3
