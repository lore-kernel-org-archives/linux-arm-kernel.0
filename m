From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 7 Feb 2017 14:13:32 +0800
Subject: [PATCH -next 2/3] usb: mtu3: make the reference clock optional
In-Reply-To: <1486448013-8784-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1486448013-8784-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1486448013-8784-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the reference clock optional for DTS backward compatibility
and ignore the error if it does not exist.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 19a345d..c3125da 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -225,10 +225,17 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		return PTR_ERR(ssusb->sys_clk);
 	}
 
+	/*
+	 * reference clock is usually a "fixed-clock", make it optional
+	 * for backward compatibility and ignore the error if it does
+	 * not exist.
+	 */
 	ssusb->ref_clk = devm_clk_get(dev, "ref_ck");
 	if (IS_ERR(ssusb->ref_clk)) {
-		dev_err(dev, "failed to get ref clock\n");
-		return PTR_ERR(ssusb->ref_clk);
+		if (PTR_ERR(ssusb->ref_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		ssusb->ref_clk = NULL;
 	}
 
 	ssusb->num_phys = of_count_phandle_with_args(node,
-- 
1.7.9.5
