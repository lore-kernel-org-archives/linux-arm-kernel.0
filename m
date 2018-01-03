From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 3 Jan 2018 16:53:17 +0800
Subject: [v2 PATCH 1/6] usb: mtu3: fix error code for getting extcon device
Message-ID: <41c6b0f2e959c07eff261060e57fd180a750071a.1514967463.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When failing to get extcon device, extcon_get_edev_by_phandle()
may return different error codes, but not only -EPROBE_DEFER,
so can't always return -EPROBE_DEFER, and fix it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 3650fd1..5b2110b 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -308,7 +308,7 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		otg_sx->edev = extcon_get_edev_by_phandle(ssusb->dev, 0);
 		if (IS_ERR(otg_sx->edev)) {
 			dev_err(ssusb->dev, "couldn't get extcon device\n");
-			return -EPROBE_DEFER;
+			return PTR_ERR(otg_sx->edev);
 		}
 	}
 
-- 
1.9.1
