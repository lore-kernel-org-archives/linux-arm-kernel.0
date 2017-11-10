From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat, 11 Nov 2017 00:55:32 +0300
Subject: [PATCH] phy: rockchip-inno-usb2: fix error handling in
 rockchip_usb2phy_probe()
Message-ID: <1510350932-3461-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip_usb2phy_probe() does not disable clock in case of failure in
devm_of_phy_provider_register() and it ignores if clk_prepare_enable() fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index ee7ce5ee53f9..ada1ff33cad3 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1150,7 +1150,12 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 	rphy->clk = of_clk_get_by_name(np, "phyclk");
 	if (!IS_ERR(rphy->clk)) {
-		clk_prepare_enable(rphy->clk);
+		ret = clk_prepare_enable(rphy->clk);
+		if (ret) {
+			dev_info(&pdev->dev, "failed to prepare phyclk\n");
+			clk_put(rphy->clk);
+			rphy->clk = NULL;
+		}
 	} else {
 		dev_info(&pdev->dev, "no phyclk specified\n");
 		rphy->clk = NULL;
@@ -1202,7 +1207,11 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	return PTR_ERR_OR_ZERO(provider);
+	if (IS_ERR(provider)) {
+		ret = PTR_ERR(provider);
+		goto disable_clks;
+	}
+	return 0;
 
 put_child:
 	of_node_put(child_np);
-- 
2.7.4
