From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 18 Jan 2017 14:08:22 +0800
Subject: [PATCH 1/6] usb: mtu3: get resources that cause deferred probe earlier
Message-ID: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some resources such as regulator, clock usually cause deferred
probe, get them earlier to avoid more ineffective processing.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 7833678..6344859 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -204,6 +204,18 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	int i;
 	int ret;
 
+	ssusb->vusb33 = devm_regulator_get(&pdev->dev, "vusb33");
+	if (IS_ERR(ssusb->vusb33)) {
+		dev_err(dev, "failed to get vusb33\n");
+		return PTR_ERR(ssusb->vusb33);
+	}
+
+	ssusb->sys_clk = devm_clk_get(dev, "sys_ck");
+	if (IS_ERR(ssusb->sys_clk)) {
+		dev_err(dev, "failed to get sys clock\n");
+		return PTR_ERR(ssusb->sys_clk);
+	}
+
 	ssusb->num_phys = of_count_phandle_with_args(node,
 			"phys", "#phy-cells");
 	if (ssusb->num_phys > 0) {
@@ -230,18 +242,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		return PTR_ERR(ssusb->ippc_base);
 	}
 
-	ssusb->vusb33 = devm_regulator_get(&pdev->dev, "vusb33");
-	if (IS_ERR(ssusb->vusb33)) {
-		dev_err(dev, "failed to get vusb33\n");
-		return PTR_ERR(ssusb->vusb33);
-	}
-
-	ssusb->sys_clk = devm_clk_get(dev, "sys_ck");
-	if (IS_ERR(ssusb->sys_clk)) {
-		dev_err(dev, "failed to get sys clock\n");
-		return PTR_ERR(ssusb->sys_clk);
-	}
-
 	ssusb->dr_mode = usb_get_dr_mode(dev);
 	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN) {
 		dev_err(dev, "dr_mode is error\n");
-- 
1.7.9.5
