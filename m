From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 19 Jul 2017 17:26:06 +0200
Subject: [PATCH 062/102] phy: sun9i-usb: explicitly request exclusive reset
 control
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Message-ID: <20170719152646.25903-63-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/phy/allwinner/phy-sun9i-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun9i-usb.c b/drivers/phy/allwinner/phy-sun9i-usb.c
index 28fce4bce638e..a07aa04a88ed8 100644
--- a/drivers/phy/allwinner/phy-sun9i-usb.c
+++ b/drivers/phy/allwinner/phy-sun9i-usb.c
@@ -146,7 +146,7 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(phy->hsic_clk);
 		}
 
-		phy->reset = devm_reset_control_get(dev, "hsic");
+		phy->reset = devm_reset_control_get_exclusive(dev, "hsic");
 		if (IS_ERR(phy->reset)) {
 			dev_err(dev, "failed to get reset control\n");
 			return PTR_ERR(phy->reset);
@@ -158,7 +158,7 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(phy->clk);
 		}
 
-		phy->reset = devm_reset_control_get(dev, "phy");
+		phy->reset = devm_reset_control_get_exclusive(dev, "phy");
 		if (IS_ERR(phy->reset)) {
 			dev_err(dev, "failed to get reset control\n");
 			return PTR_ERR(phy->reset);
-- 
2.11.0
