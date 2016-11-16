From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Nov 2016 15:22:38 +0100
Subject: [PATCH 1/2] phy: rockchip-inno-usb2: fix uninitialized tmout variable
Message-ID: <20161116142259.2123506-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added OTG support has an obvious uninitialized variable
access that gcc warns about:

drivers/phy/phy-rockchip-inno-usb2.c: In function 'rockchip_chg_detect_work':
drivers/phy/phy-rockchip-inno-usb2.c:717:7: error: 'tmout' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This replaces the use of the uninitialized variable with what
the value was in the previous USB_CHG_STATE_WAIT_FOR_DCD
state.

Fixes: 0c42fe48fd23 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index eb89de59b68f..2f99ec95079c 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -714,7 +714,7 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 			delay = CHG_SECONDARY_DET_TIME;
 			rphy->chg_state = USB_CHG_STATE_PRIMARY_DONE;
 		} else {
-			if (tmout) {
+			if (rphy->dcd_retries == CHG_DCD_MAX_RETRIES) {
 				/* floating charger found */
 				rphy->chg_type = POWER_SUPPLY_TYPE_USB_DCP;
 				rphy->chg_state = USB_CHG_STATE_DETECTED;
-- 
2.9.0
