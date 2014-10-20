From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Oct 2014 22:10:26 +0800
Subject: [PATCH v2 1/5] clk: sunxi: make factors clock mux mask configurable
In-Reply-To: <1413814230-13735-1-git-send-email-wens@csie.org>
References: <1413814230-13735-1-git-send-email-wens@csie.org>
Message-ID: <1413814230-13735-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the factors-style clocks on the A80 have different widths
for the mux values in the registers.

Add a .muxmask field to clk_factors_config to make it configurable.
Passing a bitmask instead of a width parameter will allow reuse
in case we support table-based muxes in the future.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-factors.c    | 2 +-
 drivers/clk/sunxi/clk-factors.h    | 3 +--
 drivers/clk/sunxi/clk-mod0.c       | 1 +
 drivers/clk/sunxi/clk-sun8i-mbus.c | 1 +
 drivers/clk/sunxi/clk-sunxi.c      | 1 +
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index f83ba09..5521e86 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -224,7 +224,7 @@ struct clk * __init sunxi_factors_register(struct device_node *node,
 		/* set up gate properties */
 		mux->reg = reg;
 		mux->shift = data->mux;
-		mux->mask = SUNXI_FACTORS_MUX_MASK;
+		mux->mask = data->muxmask;
 		mux->lock = factors->lock;
 		mux_hw = &mux->hw;
 	}
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 9913840..912238f 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -7,8 +7,6 @@
 
 #define SUNXI_FACTORS_NOT_APPLICABLE	(0)
 
-#define SUNXI_FACTORS_MUX_MASK 0x3
-
 struct clk_factors_config {
 	u8 nshift;
 	u8 nwidth;
@@ -24,6 +22,7 @@ struct clk_factors_config {
 struct factors_data {
 	int enable;
 	int mux;
+	int muxmask;
 	struct clk_factors_config *table;
 	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
 	const char *name;
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 4a56385..da0524ea 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -70,6 +70,7 @@ static struct clk_factors_config sun4i_a10_mod0_config = {
 static const struct factors_data sun4i_a10_mod0_data __initconst = {
 	.enable = 31,
 	.mux = 24,
+	.muxmask = BIT(1) | BIT(0),
 	.table = &sun4i_a10_mod0_config,
 	.getter = sun4i_a10_get_mod0_factors,
 };
diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
index 8e49b44..ef49786 100644
--- a/drivers/clk/sunxi/clk-sun8i-mbus.c
+++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
@@ -60,6 +60,7 @@ static struct clk_factors_config sun8i_a23_mbus_config = {
 static const struct factors_data sun8i_a23_mbus_data __initconst = {
 	.enable = 31,
 	.mux = 24,
+	.muxmask = BIT(1) | BIT(0),
 	.table = &sun8i_a23_mbus_config,
 	.getter = sun8i_a23_get_mbus_factors,
 };
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index d5dc951..636b8d7 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -514,6 +514,7 @@ static const struct factors_data sun4i_apb1_data __initconst = {
 static const struct factors_data sun7i_a20_out_data __initconst = {
 	.enable = 31,
 	.mux = 24,
+	.muxmask = BIT(1) | BIT(0),
 	.table = &sun7i_a20_out_config,
 	.getter = sun7i_a20_get_out_factors,
 };
-- 
2.1.1
