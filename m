From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 21 Dec 2016 14:10:49 +0800
Subject: [PATCH 3/3] phy: rockchip-inno-usb2: Set EXTCON_USB when
 EXTCON_CHG_USB_SDP was set
In-Reply-To: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
References: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
Message-ID: <767c3dfccde4807e3645951d4aeebca0ab5cc5e4.1482300213.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the documentation, we should set the EXTCON_USB when
one SDP charger connector was reported.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/phy/phy-rockchip-inno-usb2.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index 2f99ec9..71fbe0f 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -595,9 +595,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 		if (rport->vbus_attached != vbus_attach) {
 			rport->vbus_attached = vbus_attach;
 
-			if (notify_charger && rphy->edev)
+			if (notify_charger && rphy->edev) {
 				extcon_set_cable_state_(rphy->edev,
 							cable, vbus_attach);
+				if (cable == EXTCON_CHG_USB_SDP)
+					extcon_set_cable_state_(rphy->edev,
+								EXTCON_USB,
+								vbus_attach);
+			}
 		}
 		break;
 	case OTG_STATE_B_PERIPHERAL:
-- 
1.7.9.5
