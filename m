From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 22 May 2013 10:24:16 +0800
Subject: [RESEND][PATCH 2/2] clk: wm831x: Fix wm831x_clkout_get_parent
In-Reply-To: <1369189396.19416.0.camel@phoenix>
References: <1369189396.19416.0.camel@phoenix>
Message-ID: <1369189456.19416.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code looks strange because calling wm831x_clkout_set_parent() with 0 as
parent parameter, wm831x_clkout_get_parent() will return 1.

According to the datasheet:
R16528 (4090h) Clock Control1
        BIT 0: CLKOUT output source select
                0 = FLL output
                1 = 32.768kHz oscillator

Thus fix the entry order in wm831x_clkout_parents[] to make it has
the same meaning as the datasheet and make the return value
of wm831x_clkout_get_parent() consistent with the parent pass to
wm831x_clkout_set_parent().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk-wm831x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index 4bdf0b0..58d08a6 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -299,8 +299,8 @@ static void wm831x_clkout_unprepare(struct clk_hw *hw)
 }
 
 static const char *wm831x_clkout_parents[] = {
-	"xtal",
 	"fll",
+	"xtal",
 };
 
 static u8 wm831x_clkout_get_parent(struct clk_hw *hw)
@@ -318,9 +318,9 @@ static u8 wm831x_clkout_get_parent(struct clk_hw *hw)
 	}
 
 	if (ret & WM831X_CLKOUT_SRC)
-		return 0;
-	else
 		return 1;
+	else
+		return 0;
 }
 
 static int wm831x_clkout_set_parent(struct clk_hw *hw, u8 parent)
-- 
1.8.1.2
