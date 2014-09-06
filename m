From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Sep 2014 12:06:51 +0800
Subject: [PATCH] clk: sunxi: fix mux clk takes register bit mask instead of
 width
Message-ID: <1409976411-22855-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_register_mux takes both register bit shift and mask as parameters
to which bits it should use to control the clock mux.

sunxi_mux_clk_setup incorrectly passed the width of effective bits,
instead of the bit mask. This would result in incorrect values being
read or set.

Fixes: e874a6697710 ("clk: arm: sunxi: Add a new clock driver for sunxi SOCs")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Cc: stable at vger.kernel.org
---

We never ran into this because the mux clks do not have auto-reparenting
enabled, and the only time we did reparent was in the sun6i dma driver.
Luckily the new value is the same as the mask there.

---
 drivers/clk/sunxi/clk-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index b654b7b..df61199 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -674,7 +674,7 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
  * sunxi_mux_clk_setup() - Setup function for muxes
  */
 
-#define SUNXI_MUX_GATE_WIDTH	2
+#define SUNXI_MUX_GATE_MASK	0x3
 
 struct mux_data {
 	u8 shift;
@@ -711,7 +711,7 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 
 	clk = clk_register_mux(NULL, clk_name, parents, i,
 			       CLK_SET_RATE_NO_REPARENT, reg,
-			       data->shift, SUNXI_MUX_GATE_WIDTH,
+			       data->shift, SUNXI_MUX_GATE_MASK,
 			       0, &clk_lock);
 
 	if (clk) {
-- 
2.1.0
