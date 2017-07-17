From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 17 Jul 2017 10:20:52 +0900
Subject: [PATCH 1/5] phy: qcom-usb-hs: Replace the extcon API
In-Reply-To: <1500254456-6525-1-git-send-email-cw00.choi@samsung.com>
References: <1500254456-6525-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170717012058epcas1p181ca458cd4c80643ee7077e9ee78f7bb@epcas1p1.samsung.com>
Message-ID: <1500254456-6525-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- (deprecated) extcon_get_cable_state_() -> extcon_get_state()

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/phy/qualcomm/phy-qcom-usb-hs.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs.c b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
index 4b20abc3ae2f..2d0c70b5589f 100644
--- a/drivers/phy/qualcomm/phy-qcom-usb-hs.c
+++ b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
@@ -155,12 +155,12 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
 	}
 
 	if (uphy->vbus_edev) {
-		state = extcon_get_cable_state_(uphy->vbus_edev, EXTCON_USB);
+		state = extcon_get_state(uphy->vbus_edev, EXTCON_USB);
 		/* setup initial state */
 		qcom_usb_hs_phy_vbus_notifier(&uphy->vbus_notify, state,
 					      uphy->vbus_edev);
-		ret = extcon_register_notifier(uphy->vbus_edev, EXTCON_USB,
-				&uphy->vbus_notify);
+		ret = devm_extcon_register_notifier(&ulpi->dev, uphy->vbus_edev,
+				EXTCON_USB, &uphy->vbus_notify);
 		if (ret)
 			goto err_ulpi;
 	}
@@ -179,16 +179,8 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
 
 static int qcom_usb_hs_phy_power_off(struct phy *phy)
 {
-	int ret;
 	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
 
-	if (uphy->vbus_edev) {
-		ret = extcon_unregister_notifier(uphy->vbus_edev, EXTCON_USB,
-						 &uphy->vbus_notify);
-		if (ret)
-			return ret;
-	}
-
 	regulator_disable(uphy->v3p3);
 	regulator_disable(uphy->v1p8);
 	clk_disable_unprepare(uphy->sleep_clk);
-- 
1.9.1
