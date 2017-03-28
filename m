From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 28 Mar 2017 13:38:29 +0900
Subject: [PATCH 2/2] phy: rockchip-inno-usb2: Replace the extcon API
In-Reply-To: <1490675909-2533-1-git-send-email-cw00.choi@samsung.com>
References: <1490675909-2533-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170328043830epcas5p2a949278d79e3741891991a3bbeafb9dc@epcas5p2.samsung.com>
Message-ID: <1490675909-2533-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()
- extcon_set_cable_state_() -> extcon_set_state_sync()

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/phy/phy-rockchip-inno-usb2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index 4ea95c28a66f..02751f70067e 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -540,7 +540,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 			rockchip_usb2phy_power_off(rport->phy);
 		/* fall through */
 	case OTG_STATE_B_IDLE:
-		if (extcon_get_cable_state_(rphy->edev, EXTCON_USB_HOST) > 0) {
+		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) > 0) {
 			dev_dbg(&rport->phy->dev, "usb otg host connect\n");
 			rport->state = OTG_STATE_A_HOST;
 			rockchip_usb2phy_power_on(rport->phy);
@@ -596,7 +596,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 			rport->vbus_attached = vbus_attach;
 
 			if (notify_charger && rphy->edev) {
-				extcon_set_cable_state_(rphy->edev,
+				extcon_set_state_sync(rphy->edev,
 							cable, vbus_attach);
 				if (cable == EXTCON_CHG_USB_SDP)
 					extcon_set_state_sync(rphy->edev,
@@ -617,7 +617,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 		sch_work = true;
 		break;
 	case OTG_STATE_A_HOST:
-		if (extcon_get_cable_state_(rphy->edev, EXTCON_USB_HOST) == 0) {
+		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) == 0) {
 			dev_dbg(&rport->phy->dev, "usb otg host disconnect\n");
 			rport->state = OTG_STATE_B_IDLE;
 			rockchip_usb2phy_power_off(rport->phy);
@@ -1003,8 +1003,8 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
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
