From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:04 +0200
Subject: [PATCH 04/20] clk: sunxi: display: Add per-clock flags
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TCON channel 0 clock that is the parent clock of our pixel clock is
expected to change its rate depending on the resolution we want to output
in our display engine.

However, since it's only a mux, the only way it can do that is by changing
its parents rate.

Allow to give flags in our display clocks description, and add the
CLK_SET_RATE_PARENT flag for the TCON channel 0 flag.

Fixes: a3b4956ee6d9 ("clk: sunxi: display: Add per-clock flags")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sun4i-display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun4i-display.c b/drivers/clk/sunxi/clk-sun4i-display.c
index 445a7498d6df..9780fac6d029 100644
--- a/drivers/clk/sunxi/clk-sun4i-display.c
+++ b/drivers/clk/sunxi/clk-sun4i-display.c
@@ -33,6 +33,8 @@ struct sun4i_a10_display_clk_data {
 
 	u8	width_div;
 	u8	width_mux;
+
+	u32	flags;
 };
 
 struct reset_data {
@@ -166,7 +168,7 @@ static void __init sun4i_a10_display_init(struct device_node *node,
 				     data->has_div ? &div->hw : NULL,
 				     data->has_div ? &clk_divider_ops : NULL,
 				     &gate->hw, &clk_gate_ops,
-				     0);
+				     data->flags);
 	if (IS_ERR(clk)) {
 		pr_err("%s: Couldn't register the clock\n", clk_name);
 		goto free_div;
@@ -232,6 +234,7 @@ static const struct sun4i_a10_display_clk_data sun4i_a10_tcon_ch0_data __initcon
 	.offset_rst	= 29,
 	.offset_mux	= 24,
 	.width_mux	= 2,
+	.flags		= CLK_SET_RATE_PARENT,
 };
 
 static void __init sun4i_a10_tcon_ch0_setup(struct device_node *node)
-- 
2.8.2
