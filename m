From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:28:49 +0530
Subject: [PATCH 04/17] phy: omap-usb2: use omap_usb_power_off to power off the
 PHY during probe
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Previously omap_control_phy_power() was used to power
off the PHY during probe. But once phy-omap-usb2 driver is adapted to
use syscon, omap_control_phy_power() cannot be used. Hence used
omap_usb_power_off to power off the PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-omap-usb2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index c1a4686..b5c266a 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -241,7 +241,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy->control_dev = &control_pdev->dev;
-	omap_control_phy_power(phy->control_dev, 0);
 
 	otg->set_host		= omap_usb_set_host;
 	otg->set_peripheral	= omap_usb_set_peripheral;
@@ -261,6 +260,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	}
 
 	phy_set_drvdata(generic_phy, phy);
+	omap_usb_power_off(generic_phy);
 
 	phy_provider = devm_of_phy_provider_register(phy->dev,
 			of_phy_simple_xlate);
-- 
1.7.9.5
