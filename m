From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  8 Nov 2015 17:04:34 +0100
Subject: [PATCH v2 1/8] phy: rockchip-usb: fix clock get-put mismatch
In-Reply-To: <1446998681-26436-1-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
Message-ID: <1446998681-26436-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the phy driver only gets the optional clock reference but
never puts it again, neither during error handling nor on remove.
Fix that by moving the clk_put to a devm-action that gets called at
the right time when all other devm actions are done.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/phy/phy-rockchip-usb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index 91d6f34..dfc056b 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -90,6 +90,14 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static void rockchip_usb_phy_action(void *data)
+{
+	struct rockchip_usb_phy *rk_phy = data;
+
+	if (rk_phy->clk)
+		clk_put(rk_phy->clk);
+}
+
 static int rockchip_usb_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -124,6 +132,13 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 		if (IS_ERR(rk_phy->clk))
 			rk_phy->clk = NULL;
 
+		err = devm_add_action(dev, rockchip_usb_phy_action, rk_phy);
+		if (err) {
+			if (rk_phy->clk)
+				clk_put(rk_phy->clk);
+			return err;
+		}
+
 		rk_phy->phy = devm_phy_create(dev, child, &ops);
 		if (IS_ERR(rk_phy->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-- 
2.6.2
