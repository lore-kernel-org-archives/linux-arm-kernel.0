From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 22 May 2013 10:23:16 +0800
Subject: [RESEND][PATCH 1/2] clk: wm831x: Fix update wrong register for
 enable/disable FLL
Message-ID: <1369189396.19416.0.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheet, FLL Enable is controlled by
R16530 (4092h) FLL Control1
        BIT 0: FLL Enable
                0 = Disable
                1 = Enable

Thus the code should update WM831X_FLL_CONTROL_1 register rather than
WM831X_FLL_CONTROL_2 register.

Also fixes a trivial typo in dev_crit message.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Hi Mike,
This patch serial was sent on http://lkml.org/lkml/2013/5/1/152
With Mark's Ack.

Regards,
Axel
 drivers/clk/clk-wm831x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index 16ed068..4bdf0b0 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -97,7 +97,7 @@ static int wm831x_fll_prepare(struct clk_hw *hw)
 	struct wm831x *wm831x = clkdata->wm831x;
 	int ret;
 
-	ret = wm831x_set_bits(wm831x, WM831X_FLL_CONTROL_2,
+	ret = wm831x_set_bits(wm831x, WM831X_FLL_CONTROL_1,
 			      WM831X_FLL_ENA, WM831X_FLL_ENA);
 	if (ret != 0)
 		dev_crit(wm831x->dev, "Failed to enable FLL: %d\n", ret);
@@ -114,9 +114,9 @@ static void wm831x_fll_unprepare(struct clk_hw *hw)
 	struct wm831x *wm831x = clkdata->wm831x;
 	int ret;
 
-	ret = wm831x_set_bits(wm831x, WM831X_FLL_CONTROL_2, WM831X_FLL_ENA, 0);
+	ret = wm831x_set_bits(wm831x, WM831X_FLL_CONTROL_1, WM831X_FLL_ENA, 0);
 	if (ret != 0)
-		dev_crit(wm831x->dev, "Failed to disaable FLL: %d\n", ret);
+		dev_crit(wm831x->dev, "Failed to disable FLL: %d\n", ret);
 }
 
 static unsigned long wm831x_fll_recalc_rate(struct clk_hw *hw,
-- 
1.8.1.2
