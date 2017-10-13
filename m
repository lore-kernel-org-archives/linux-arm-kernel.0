From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 17:10:37 +0800
Subject: [PATCH v2 01/13] usb: mtu3: fix error return code in
 ssusb_gadget_init()
Message-ID: <6dc39e99240f25c83f8c36d23361ec89dcfb33ce.1507885126.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When failing to get IRQ number, platform_get_irq() may return
-EPROBE_DEFER, but we ignore it and always return -ENODEV,
so fix it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 99c65b0..9475798 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -774,9 +774,9 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 		return -ENOMEM;
 
 	mtu->irq = platform_get_irq(pdev, 0);
-	if (mtu->irq <= 0) {
+	if (mtu->irq < 0) {
 		dev_err(dev, "fail to get irq number\n");
-		return -ENODEV;
+		return mtu->irq;
 	}
 	dev_info(dev, "irq %d\n", mtu->irq);
 
-- 
1.7.9.5
