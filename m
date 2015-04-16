From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Thu, 16 Apr 2015 20:17:30 +0800
Subject: [PATCH] usb: gadget: xudc: fix return value check in xudc_probe()
Message-ID: <1429186650-20465-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns
ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index dd3e9fd..cfe0349 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -2071,8 +2071,8 @@ static int xudc_probe(struct platform_device *pdev)
 	/* Map the registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	udc->addr = devm_ioremap_resource(&pdev->dev, res);
-	if (!udc->addr)
-		return -ENOMEM;
+	if (IS_ERR(udc->addr))
+		return PTR_ERR(udc->addr);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
