From: hl@rock-chips.com (huang lin)
Date: Fri, 17 Jul 2015 15:29:25 +0800
Subject: [PATCH] phy: rockchip-usb: power down phy when rockchip phy probe
Message-ID: <1437118165-20713-1-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip phy are enable when soc reset, to save power consumption,
we disable it when probe, and enable each phy when it use

Signed-off-by: huang lin <hl@rock-chips.com>
---
 drivers/phy/phy-rockchip-usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index 7d4c336..3b92d7f 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -98,6 +98,7 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	struct device_node *child;
 	struct regmap *grf;
 	unsigned int reg_offset;
+	int err;
 
 	grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
 	if (IS_ERR(grf)) {
@@ -129,6 +130,11 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(rk_phy->phy);
 		}
 		phy_set_drvdata(rk_phy->phy, rk_phy);
+
+		/* only power up usb phy when it use, so disable it when init*/
+		err = rockchip_usb_phy_power(rk_phy, 1);
+		if (err)
+			return err;
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
1.9.1
