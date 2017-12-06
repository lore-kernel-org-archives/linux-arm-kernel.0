From: Stefan.Potyra@elektrobit.com (Stefan Potyra)
Date: Wed, 6 Dec 2017 15:26:11 +0100
Subject: [PATCH] phy: rockchip-inno-usb2: disable clock on error
Message-ID: <20171206142611.qmbxbx5pxpwubhj6@agrajag.zerfleddert.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In devm_of_phy_provider_register, the previously enabled clock rphy->clk
is now disabled, if devm_of_phy_provider_register() failed.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: e08d2a727e6 phy: rockchip-inno-usb2: add a new driver for Rockchip usb2phy
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 5049dac79bd0..06827f4f49b3 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1202,10 +1202,11 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	return PTR_ERR_OR_ZERO(provider);
+	ret = PTR_ERR_OR_ZERO(provider);
 
 put_child:
-	of_node_put(child_np);
+	if (child_np)
+		of_node_put(child_np);
 disable_clks:
 	if (rphy->clk) {
 		clk_disable_unprepare(rphy->clk);
-- 
2.15.1
