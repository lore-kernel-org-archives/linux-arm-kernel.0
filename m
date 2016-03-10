From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 10 Mar 2016 08:15:02 +0100
Subject: [PATCH] clk: sunxi: Accept a greater rate when setting a parent clock
Message-ID: <mailman.11.1457597843.1636.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The best rate of a clock may be a bit greater than the requested one.
In such a case, the rate setting from a child clock was rejected.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
I don't know exactly why the rate constraint existed nor what can be
the impact of setting the rate of other clocks.

I had the problem when setting the PLL2 clock of the H3 (patch to come).
It has 4 outputs, so, it is composed of a base clock and 4 children
clocks pll2, pll2x2, pll2x4 and pll2x8 with a fixed factor (/4, /2, 1
and *2).
The pll2 clock rate may be only 24576000 (for the audio family 48000Hz)
or 22579200 (for the audio family 44100Hz).

Setting 24576000 asks for mul=86 and div=21,4 giving 24571428 as the
best rate, i.e. a bit slower than requested: good.

Setting 22579200 asks for mul=64 and div=17,4 giving 22588235, i.e.
a bit greater: then, the rate setting was rejected (no parent clock),
preventing audio streaming at 44100Hz.
---
 drivers/clk/sunxi/clk-factors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 59428db..d0774c2 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -86,7 +86,7 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
 	int i, num_parents;
 	unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
 
-	/* find the parent that can help provide the fastest rate <= rate */
+	/* find the parent that can help provide the fastest rate */
 	num_parents = clk_hw_get_num_parents(hw);
 	for (i = 0; i < num_parents; i++) {
 		parent = clk_hw_get_parent_by_index(hw, i);
@@ -100,7 +100,7 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
 		child_rate = clk_factors_round_rate(hw, req->rate,
 						    &parent_rate);
 
-		if (child_rate <= req->rate && child_rate > best_child_rate) {
+		if (child_rate > best_child_rate) {
 			best_parent = parent;
 			best = parent_rate;
 			best_child_rate = child_rate;
-- 
2.7.2
