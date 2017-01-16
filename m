From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 16 Jan 2017 21:37:01 +0900
Subject: [PATCH v3 5/6] usb: phy: tahvo: Replace the deprecated extcon API
In-Reply-To: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
References: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170116123714epcas1p11e40ca467ede326b0cf8d094045db1ab@epcas1p1.samsung.com>
Message-ID: <1484570222-30522-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_set_cable_state_() -> extcon_set_state_sync()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/phy/phy-tahvo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index ab5d364f6e8c..a31c8682e998 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -121,7 +121,7 @@ static void check_vbus_state(struct tahvo_usb *tu)
 	prev_state = tu->vbus_state;
 	tu->vbus_state = reg & TAHVO_STAT_VBUS;
 	if (prev_state != tu->vbus_state) {
-		extcon_set_cable_state_(tu->extcon, EXTCON_USB, tu->vbus_state);
+		extcon_set_state_sync(tu->extcon, EXTCON_USB, tu->vbus_state);
 		sysfs_notify(&tu->pt_dev->dev.kobj, NULL, "vbus_state");
 	}
 }
@@ -130,7 +130,7 @@ static void tahvo_usb_become_host(struct tahvo_usb *tu)
 {
 	struct retu_dev *rdev = dev_get_drvdata(tu->pt_dev->dev.parent);
 
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB_HOST, true);
+	extcon_set_state_sync(tu->extcon, EXTCON_USB_HOST, true);
 
 	/* Power up the transceiver in USB host mode */
 	retu_write(rdev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
@@ -149,7 +149,7 @@ static void tahvo_usb_become_peripheral(struct tahvo_usb *tu)
 {
 	struct retu_dev *rdev = dev_get_drvdata(tu->pt_dev->dev.parent);
 
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB_HOST, false);
+	extcon_set_state_sync(tu->extcon, EXTCON_USB_HOST, false);
 
 	/* Power up transceiver and set it in USB peripheral mode */
 	retu_write(rdev, TAHVO_REG_USBR, USBR_SLAVE_CONTROL | USBR_REGOUT |
@@ -379,9 +379,9 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 	}
 
 	/* Set the initial cable state. */
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB_HOST,
+	extcon_set_state_sync(tu->extcon, EXTCON_USB_HOST,
 			       tu->tahvo_mode == TAHVO_MODE_HOST);
-	extcon_set_cable_state_(tu->extcon, EXTCON_USB, tu->vbus_state);
+	extcon_set_state_sync(tu->extcon, EXTCON_USB, tu->vbus_state);
 
 	/* Create OTG interface */
 	tahvo_usb_power_off(tu);
-- 
1.9.1
