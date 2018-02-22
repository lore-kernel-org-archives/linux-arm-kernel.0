From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Fri, 23 Feb 2018 00:40:11 +0300
Subject: [PATCH] phy: lpc18xx-usb-otg: error handling in
 lpc18xx_usb_otg_phy_power_on()
Message-ID: <1519335611-28644-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If regmap_update_bits() fails in lpc18xx_usb_otg_phy_power_on(),
lpc->clk is left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/phy/phy-lpc18xx-usb-otg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-lpc18xx-usb-otg.c b/drivers/phy/phy-lpc18xx-usb-otg.c
index 3b7a71eb5b7e..7de280a45421 100644
--- a/drivers/phy/phy-lpc18xx-usb-otg.c
+++ b/drivers/phy/phy-lpc18xx-usb-otg.c
@@ -60,8 +60,14 @@ static int lpc18xx_usb_otg_phy_power_on(struct phy *phy)
 		return ret;
 
 	/* The bit in CREG is cleared to enable the PHY */
-	return regmap_update_bits(lpc->reg, LPC18XX_CREG_CREG0,
+	ret = regmap_update_bits(lpc->reg, LPC18XX_CREG_CREG0,
 				  LPC18XX_CREG_CREG0_USB0PHY, 0);
+	if (ret) {
+		clk_disable(lpc->clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int lpc18xx_usb_otg_phy_power_off(struct phy *phy)
-- 
2.7.4
