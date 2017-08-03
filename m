From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Aug 2017 17:20:46 +0900
Subject: [PATCH v2 3/5] phy: phy-bcm-ns2-usbdrd: Replace the deprecated
 extcon API
In-Reply-To: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
References: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170803082050epcas1p179818a40e214e4ab5884f8a3bca657f8@epcas1p1.samsung.com>
Message-ID: <1501748448-26821-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_set_cable_state_() -> extcon_get_state()

Cc: Raviteja Garimella <raviteja.garimella@broadcom.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 9ae59e223131..d099a0c8cee5 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -253,16 +253,16 @@ static void extcon_work(struct work_struct *work)
 	vbus = gpiod_get_value_cansleep(driver->vbus_gpiod);
 
 	if (!id && vbus) { /* Host connected */
-		extcon_set_cable_state_(driver->edev, EXTCON_USB_HOST, true);
+		extcon_set_state_sync(driver->edev, EXTCON_USB_HOST, true);
 		pr_debug("Host cable connected\n");
 		driver->data->new_state = EVT_HOST;
 		connect_change(driver);
 	} else if (id && !vbus) { /* Disconnected */
-		extcon_set_cable_state_(driver->edev, EXTCON_USB_HOST, false);
-		extcon_set_cable_state_(driver->edev, EXTCON_USB, false);
+		extcon_set_state_sync(driver->edev, EXTCON_USB_HOST, false);
+		extcon_set_state_sync(driver->edev, EXTCON_USB, false);
 		pr_debug("Cable disconnected\n");
 	} else if (id && vbus) { /* Device connected */
-		extcon_set_cable_state_(driver->edev, EXTCON_USB, true);
+		extcon_set_state_sync(driver->edev, EXTCON_USB, true);
 		pr_debug("Device cable connected\n");
 		driver->data->new_state = EVT_DEVICE;
 		connect_change(driver);
-- 
1.9.1
