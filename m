From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 17:10:44 +0800
Subject: [PATCH v2 08/13] usb: mtu3: get optional vbus for host only mode
In-Reply-To: <6dc39e99240f25c83f8c36d23361ec89dcfb33ce.1507885126.git.chunfeng.yun@mediatek.com>
References: <6dc39e99240f25c83f8c36d23361ec89dcfb33ce.1507885126.git.chunfeng.yun@mediatek.com>
Message-ID: <a0927da253e9994e9854d7bd3f486548f96a18f2.1507885127.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When dr_mode is set as USB_DR_MODE_HOST, it's better to try to
get optional vbus, this can increase flexibility, although we
can set vbus as always on for regulator or put it in host driver
to turn it on.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 1e473b0..7ca81f4e 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -300,10 +300,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	of_property_read_u32(node, "mediatek,u3p-dis-msk",
 			     &ssusb->u3p_dis_msk);
 
-	if (ssusb->dr_mode != USB_DR_MODE_OTG)
-		return 0;
-
-	/* if dual-role mode is supported */
 	vbus = devm_regulator_get(&pdev->dev, "vbus");
 	if (IS_ERR(vbus)) {
 		dev_err(dev, "failed to get vbus\n");
@@ -311,6 +307,10 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	}
 	otg_sx->vbus = vbus;
 
+	if (ssusb->dr_mode == USB_DR_MODE_HOST)
+		return 0;
+
+	/* if dual-role mode is supported */
 	otg_sx->is_u3_drd = of_property_read_bool(node, "mediatek,usb3-drd");
 	otg_sx->manual_drd_enabled =
 		of_property_read_bool(node, "enable-manual-drd");
-- 
1.7.9.5
