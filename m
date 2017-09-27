From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 27 Sep 2017 18:58:38 +0800
Subject: [PATCH 09/12] usb: mtu3: set invalid dr_mode as dual-role mode
In-Reply-To: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
References: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
Message-ID: <59bcbb013fbb44a8fb594db02bfb5ee59206eb3b.1506509659.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Treat dr_mode of USB_DR_MODE_UNKNOWN as USB_DR_MODE_OTG to
enhance functional robustness.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 7ca81f4e..9ff3357 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -283,10 +283,8 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		return PTR_ERR(ssusb->ippc_base);
 
 	ssusb->dr_mode = usb_get_dr_mode(dev);
-	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN) {
-		dev_err(dev, "dr_mode is error\n");
-		return -EINVAL;
-	}
+	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN)
+		ssusb->dr_mode = USB_DR_MODE_OTG;
 
 	if (ssusb->dr_mode == USB_DR_MODE_PERIPHERAL)
 		return 0;
-- 
1.7.9.5
