From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Aug 2017 17:20:45 +0900
Subject: [PATCH v2 2/5] phy: rockchip-inno-usb2: Replace the extcon API
In-Reply-To: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
References: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170803082050epcas1p3040420e1fef2186519f50a68f865e006@epcas1p3.samsung.com>
Message-ID: <1501748448-26821-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()
- extcon_set_cable_state_() -> extcon_set_state_sync()

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 626883d9d176..ef033089b7a0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -545,7 +545,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 			rockchip_usb2phy_power_off(rport->phy);
 		/* fall through */
 	case OTG_STATE_B_IDLE:
-		if (extcon_get_cable_state_(rphy->edev, EXTCON_USB_HOST) > 0) {
+		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) > 0) {
 			dev_dbg(&rport->phy->dev, "usb otg host connect\n");
 			rport->state = OTG_STATE_A_HOST;
 			rockchip_usb2phy_power_on(rport->phy);
@@ -598,7 +598,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 			rport->vbus_attached = vbus_attach;
 
 			if (notify_charger && rphy->edev) {
-				extcon_set_cable_state_(rphy->edev,
+				extcon_set_state_sync(rphy->edev,
 							cable, vbus_attach);
 				if (cable == EXTCON_CHG_USB_SDP)
 					extcon_set_state_sync(rphy->edev,
@@ -619,7 +619,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 		sch_work = true;
 		break;
 	case OTG_STATE_A_HOST:
-		if (extcon_get_cable_state_(rphy->edev, EXTCON_USB_HOST) == 0) {
+		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) == 0) {
 			dev_dbg(&rport->phy->dev, "usb otg host disconnect\n");
 			rport->state = OTG_STATE_B_IDLE;
 			rockchip_usb2phy_power_off(rport->phy);
@@ -1006,8 +1006,8 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	if (!IS_ERR(rphy->edev)) {
 		rport->event_nb.notifier_call = rockchip_otg_event;
 
-		ret = extcon_register_notifier(rphy->edev, EXTCON_USB_HOST,
-					       &rport->event_nb);
+		ret = devm_extcon_register_notifier(rphy->dev, rphy->edev,
+					EXTCON_USB_HOST, &rport->event_nb);
 		if (ret)
 			dev_err(rphy->dev, "register USB HOST notifier failed\n");
 	}
-- 
1.9.1
