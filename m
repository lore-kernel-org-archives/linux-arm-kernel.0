From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 19 Nov 2015 22:22:22 +0100
Subject: [PATCH v3 1/8] phy: rockchip-usb: fix clock get-put mismatch
In-Reply-To: <1447968149-10979-1-git-send-email-heiko@sntech.de>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
Message-ID: <1447968149-10979-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the phy driver only gets the optional clock reference but
never puts it again, neither during error handling nor on remove.
Fix that by moving the clk_put to a devm-action that gets called at
the right time when all other devm actions are done.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/phy/phy-rockchip-usb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index 62c43c4..e941444 100644
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
@@ -123,6 +131,10 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 		rk_phy->reg_offset = reg_offset;
 		rk_phy->reg_base = grf;
 
+		err = devm_add_action(dev, rockchip_usb_phy_action, rk_phy);
+		if (err)
+			return err;
+
 		rk_phy->clk = of_clk_get_by_name(child, "phyclk");
 		if (IS_ERR(rk_phy->clk))
 			rk_phy->clk = NULL;
-- 
2.6.2
