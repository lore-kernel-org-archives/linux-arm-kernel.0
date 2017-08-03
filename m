From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Aug 2017 17:20:47 +0900
Subject: [PATCH v2 4/5] usb: gadget: udc: Replace the deprecated extcon API
In-Reply-To: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
References: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170803082050epcas1p2491eedf2f26510f55cd15ce777356fce@epcas1p2.samsung.com>
Message-ID: <1501748448-26821-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Raviteja Garimella <raviteja.garimella@broadcom.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/usb/gadget/udc/snps_udc_plat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 2e11f19e07ae..0ce7b3ba60ff 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -184,7 +184,7 @@ static int udc_plat_probe(struct platform_device *pdev)
 			goto exit_phy;
 		}
 
-		ret = extcon_get_cable_state_(udc->edev, EXTCON_USB);
+		ret = extcon_get_state(udc->edev, EXTCON_USB);
 		if (ret < 0) {
 			dev_err(dev, "Can't get cable state\n");
 			goto exit_extcon;
@@ -273,7 +273,7 @@ static int udc_plat_suspend(struct device *dev)
 	udc = dev_get_drvdata(dev);
 	stop_udc(udc);
 
-	if (extcon_get_cable_state_(udc->edev, EXTCON_USB) > 0) {
+	if (extcon_get_state(udc->edev, EXTCON_USB) > 0) {
 		dev_dbg(udc->dev, "device -> idle\n");
 		stop_udc(udc);
 	}
@@ -303,7 +303,7 @@ static int udc_plat_resume(struct device *dev)
 		return ret;
 	}
 
-	if (extcon_get_cable_state_(udc->edev, EXTCON_USB) > 0) {
+	if (extcon_get_state(udc->edev, EXTCON_USB) > 0) {
 		dev_dbg(udc->dev, "idle -> device\n");
 		start_udc(udc);
 	}
-- 
1.9.1
