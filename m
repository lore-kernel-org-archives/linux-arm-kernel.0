From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 22 Mar 2018 16:39:20 +0800
Subject: [usb-next, v2 PATCH] usb: xhci: skip phys initialization of shared hcd
Message-ID: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phys has already been initialized when add primary hcd,
including usb2 phys and usb3 phys also if exist, so needn't
re-parse "phys" property again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 5a92d8f..777036a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2757,7 +2757,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		}
 	}
 
-	if (!hcd->skip_phy_initialization) {
+	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
 		if (IS_ERR(hcd->phy_roothub)) {
 			retval = PTR_ERR(hcd->phy_roothub);
-- 
1.9.1
