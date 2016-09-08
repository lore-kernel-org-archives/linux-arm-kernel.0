From: zyw@rock-chips.com (Chris Zhong)
Date: Thu,  8 Sep 2016 10:38:11 -0700
Subject: [PATCH] phy: rockchip-typec: add pm_runtime_disable in err case
Message-ID: <1473356291-19247-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm_runtime_disable in err case to make the pm_runtime_enable/disable
is invoked balanced.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 drivers/phy/phy-rockchip-typec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
index 7cfb0f8..dd257c7 100644
--- a/drivers/phy/phy-rockchip-typec.c
+++ b/drivers/phy/phy-rockchip-typec.c
@@ -977,6 +977,7 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create phy: %s\n",
 				child_np->name);
+			pm_runtime_disable(dev);
 			return PTR_ERR(phy);
 		}
 
@@ -986,6 +987,7 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
 		dev_err(dev, "Failed to register phy provider\n");
+		pm_runtime_disable(dev);
 		return PTR_ERR(phy_provider);
 	}
 
-- 
1.9.1
