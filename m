From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Sun,  3 Jul 2016 22:01:06 +0100
Subject: [PATCH] phy: rockhip-usb: use devm_add_action_or_reset()
Message-ID: <1467579666-9179-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If devm_add_action() fails we are explicitly calling the cleanup to free
the resources allocated.  Lets use the helper devm_add_action_or_reset()
and return directly in case of error, as we know that the cleanup function
has been already called by the helper if there was any error.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/phy/phy-rockchip-usb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index d60b149..dd58f23 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -236,9 +236,10 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
 			goto err_clk_prov;
 	}
 
-	err = devm_add_action(base->dev, rockchip_usb_phy_action, rk_phy);
+	err = devm_add_action_or_reset(base->dev, rockchip_usb_phy_action,
+				       rk_phy);
 	if (err)
-		goto err_devm_action;
+		return err;
 
 	rk_phy->phy = devm_phy_create(base->dev, child, &ops);
 	if (IS_ERR(rk_phy->phy)) {
@@ -256,9 +257,6 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
 	else
 		return rockchip_usb_phy_power(rk_phy, 1);
 
-err_devm_action:
-	if (!rk_phy->uart_enabled)
-		of_clk_del_provider(child);
 err_clk_prov:
 	if (!rk_phy->uart_enabled)
 		clk_unregister(rk_phy->clk480m);
-- 
1.9.1
