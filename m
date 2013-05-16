From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 16 May 2013 11:57:07 +0200
Subject: [PATCH v2 2/6] usb: phy: samsung: Use clk_get to get reference clock
In-Reply-To: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
References: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368698231-24268-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to use devm_clk_get to get a clock that is being put
at the end of the function.

This patch changes the code getting reference clock to use clk_get
instead of useless in this case devm_clk_get.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/phy/phy-samsung-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-samsung-usb.c b/drivers/usb/phy/phy-samsung-usb.c
index 7b118ee5..62cdb7e 100644
--- a/drivers/usb/phy/phy-samsung-usb.c
+++ b/drivers/usb/phy/phy-samsung-usb.c
@@ -175,9 +175,9 @@ int samsung_usbphy_get_refclk_freq(struct samsung_usbphy *sphy)
 	 * external crystal clock XXTI
 	 */
 	if (sphy->drv_data->cpu_type == TYPE_EXYNOS5250)
-		ref_clk = devm_clk_get(sphy->dev, "ext_xtal");
+		ref_clk = clk_get(sphy->dev, "ext_xtal");
 	else
-		ref_clk = devm_clk_get(sphy->dev, "xusbxti");
+		ref_clk = clk_get(sphy->dev, "xusbxti");
 	if (IS_ERR(ref_clk)) {
 		dev_err(sphy->dev, "Failed to get reference clock\n");
 		return PTR_ERR(ref_clk);
-- 
1.8.2.1
