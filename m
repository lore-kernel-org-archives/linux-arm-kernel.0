From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 16 Jan 2017 21:37:00 +0900
Subject: [PATCH v3 4/6] usb: phy: qcom-8x16-usb: Replace the extcon API
In-Reply-To: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
References: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170116123713epcas1p19bc73cb17dae04e8ed087b45accd4f15@epcas1p1.samsung.com>
Message-ID: <1484570222-30522-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/phy/phy-qcom-8x16-usb.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/phy/phy-qcom-8x16-usb.c b/drivers/usb/phy/phy-qcom-8x16-usb.c
index d8593adb3621..fdf686398772 100644
--- a/drivers/usb/phy/phy-qcom-8x16-usb.c
+++ b/drivers/usb/phy/phy-qcom-8x16-usb.c
@@ -187,7 +187,7 @@ static int phy_8x16_init(struct usb_phy *phy)
 	val = ULPI_PWR_OTG_COMP_DISABLE;
 	usb_phy_io_write(phy, val, ULPI_SET(ULPI_PWR_CLK_MNG_REG));
 
-	state = extcon_get_cable_state_(qphy->vbus_edev, EXTCON_USB);
+	state = extcon_get_state(qphy->vbus_edev, EXTCON_USB);
 	if (state)
 		phy_8x16_vbus_on(qphy);
 	else
@@ -316,23 +316,20 @@ static int phy_8x16_probe(struct platform_device *pdev)
 		goto off_clks;
 
 	qphy->vbus_notify.notifier_call = phy_8x16_vbus_notify;
-	ret = extcon_register_notifier(qphy->vbus_edev, EXTCON_USB,
-				       &qphy->vbus_notify);
+	ret = devm_extcon_register_notifier(&pdev->dev, qphy->vbus_edev,
+					EXTCON_USB, &qphy->vbus_notify);
 	if (ret < 0)
 		goto off_power;
 
 	ret = usb_add_phy_dev(&qphy->phy);
 	if (ret)
-		goto off_extcon;
+		goto off_power;
 
 	qphy->reboot_notify.notifier_call = phy_8x16_reboot_notify;
 	register_reboot_notifier(&qphy->reboot_notify);
 
 	return 0;
 
-off_extcon:
-	extcon_unregister_notifier(qphy->vbus_edev, EXTCON_USB,
-				   &qphy->vbus_notify);
 off_power:
 	regulator_bulk_disable(ARRAY_SIZE(qphy->regulator), qphy->regulator);
 off_clks:
@@ -347,8 +344,6 @@ static int phy_8x16_remove(struct platform_device *pdev)
 	struct phy_8x16 *qphy = platform_get_drvdata(pdev);
 
 	unregister_reboot_notifier(&qphy->reboot_notify);
-	extcon_unregister_notifier(qphy->vbus_edev, EXTCON_USB,
-				   &qphy->vbus_notify);
 
 	/*
 	 * Ensure that D+/D- lines are routed to uB connector, so
-- 
1.9.1
