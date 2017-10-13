From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 17:10:45 +0800
Subject: [PATCH v2 09/13] usb: mtu3: set invalid dr_mode as dual-role mode
In-Reply-To: <6dc39e99240f25c83f8c36d23361ec89dcfb33ce.1507885126.git.chunfeng.yun@mediatek.com>
References: <6dc39e99240f25c83f8c36d23361ec89dcfb33ce.1507885126.git.chunfeng.yun@mediatek.com>
Message-ID: <64fa4eddb0dc3394e746eb02b5b395ee15626f86.1507885127.git.chunfeng.yun@mediatek.com>
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
