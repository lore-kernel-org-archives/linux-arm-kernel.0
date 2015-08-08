From: manabian@gmail.com (Joachim Eastwood)
Date: Sun,  9 Aug 2015 00:02:41 +0200
Subject: [PATCH] phy: lpc18xx-usb-otg: fix clock order in phy init
Message-ID: <1439071361-23105-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing the frequency of the USB clock must be done before the
PLL is powered on (prepared). This matters when the USB clock
is not setup by either boot ROM or boot loader. Reorder the
function calls to adhere to the order noted in the user manual.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi Kishon,

Here one small fix for lpc18xx-usb-otg which I hope can go in
for 4.3. While not a critical fix it will be needed when I add
support for USB0 clock setup in Linux which I hope to add for
4.4. This patch is prerequisite for that.

Right now USB only works if clocks are setup by either boot ROM
or boot loader.

Patch based on the next branch in your phy tree.

 drivers/phy/phy-lpc18xx-usb-otg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-lpc18xx-usb-otg.c b/drivers/phy/phy-lpc18xx-usb-otg.c
index 3aa8e4de1b03..3b7a71eb5b7e 100644
--- a/drivers/phy/phy-lpc18xx-usb-otg.c
+++ b/drivers/phy/phy-lpc18xx-usb-otg.c
@@ -33,12 +33,12 @@ static int lpc18xx_usb_otg_phy_init(struct phy *phy)
 	struct lpc18xx_usb_otg_phy *lpc = phy_get_drvdata(phy);
 	int ret;
 
-	ret = clk_prepare(lpc->clk);
+	/* The PHY must be clocked at 480 MHz */
+	ret = clk_set_rate(lpc->clk, 480000000);
 	if (ret)
 		return ret;
 
-	/* The PHY must be clocked at 480 MHz */
-	return clk_set_rate(lpc->clk, 480000000);
+	return clk_prepare(lpc->clk);
 }
 
 static int lpc18xx_usb_otg_phy_exit(struct phy *phy)
-- 
1.8.0
