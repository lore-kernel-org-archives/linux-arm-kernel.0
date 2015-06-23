From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:28:46 +0530
Subject: [PATCH 01/17] phy: ti-pipe3: use ti_pipe3_power_off to power off the
 PHY during probe
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Previously omap_control_phy_power() was used to power
off the PHY during probe. But once PIPE3 driver is adapted to use syscon,
omap_control_phy_power() cannot be used. Hence used ti_pipe3_power_off
to power off the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-ti-pipe3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index 08020dc..d784426 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -431,8 +431,6 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 	phy->control_dev = &control_pdev->dev;
 
-	omap_control_phy_power(phy->control_dev, 0);
-
 	platform_set_drvdata(pdev, phy);
 	pm_runtime_enable(phy->dev);
 
@@ -451,6 +449,8 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 		return PTR_ERR(generic_phy);
 
 	phy_set_drvdata(generic_phy, phy);
+	ti_pipe3_power_off(generic_phy);
+
 	phy_provider = devm_of_phy_provider_register(phy->dev,
 			of_phy_simple_xlate);
 	if (IS_ERR(phy_provider))
-- 
1.7.9.5
