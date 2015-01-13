From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 15:25:11 +0100
Subject: [PATCH] usb: phy: mv-usb: fix usb_phy build errors
Message-ID: <1707713.rDByqtApOc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver was recently adapted to a core API change, but the
change was incomplete, missing out the suspend helper and
leaving an extraneous local variable around:

usb/phy/phy-mv-usb.c: In function 'mv_otg_update_state':
usb/phy/phy-mv-usb.c:341:18: warning: unused variable 'phy' [-Wunused-variable]

usb/phy/phy-mv-usb.c: In function 'mv_otg_suspend':
usb/phy/phy-mv-usb.c:861:16: error: 'struct usb_phy' has no member named 'state'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e47d92545c297 ("usb: move the OTG state from the USB PHY to the OTG structure")
---
diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
index 699e38c73d82..697a741a0cb1 100644
--- a/drivers/usb/phy/phy-mv-usb.c
+++ b/drivers/usb/phy/phy-mv-usb.c
@@ -338,7 +338,6 @@ static void mv_otg_update_inputs(struct mv_otg *mvotg)
 static void mv_otg_update_state(struct mv_otg *mvotg)
 {
 	struct mv_otg_ctrl *otg_ctrl = &mvotg->otg_ctrl;
-	struct usb_phy *phy = &mvotg->phy;
 	int old_state = mvotg->phy.otg->state;
 
 	switch (old_state) {
@@ -858,10 +857,10 @@ static int mv_otg_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct mv_otg *mvotg = platform_get_drvdata(pdev);
 
-	if (mvotg->phy.state != OTG_STATE_B_IDLE) {
+	if (mvotg->phy.otg->state != OTG_STATE_B_IDLE) {
 		dev_info(&pdev->dev,
 			 "OTG state is not B_IDLE, it is %d!\n",
-			 mvotg->phy.state);
+			 mvotg->phy.otg->state);
 		return -EAGAIN;
 	}
 
