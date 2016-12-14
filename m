From: eric@anholt.net (Eric Anholt)
Date: Wed, 14 Dec 2016 11:46:11 -0800
Subject: [PATCH 01/11] clk: bcm2835: Don't rate change PLLs on behalf of DSI
 PLL dividers.
In-Reply-To: <20161214194621.16499-1-eric@anholt.net>
References: <20161214194621.16499-1-eric@anholt.net>
Message-ID: <20161214194621.16499-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our core PLLs are intended to be configured once and left alone.  With
the SET_RATE_PARENT, asking to set the PLLD_DSI1 clock rate would
change PLLD just to get closer to the requested DSI clock, thus
changing PLLD_PER, the UART and ethernet PHY clock rates downstream of
it, and breaking ethernet.

We *do* want PLLH to change so that PLLH_AUX can be exactly the value
we want, though.  Thus, we need to have a per-divider policy of
whether to pass rate changes up.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/bcm/clk-bcm2835.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index b68bf573dcfb..6641030e8eae 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -428,6 +428,7 @@ struct bcm2835_pll_divider_data {
 	u32 load_mask;
 	u32 hold_mask;
 	u32 fixed_divider;
+	u32 flags;
 };
 
 struct bcm2835_clock_data {
@@ -1201,7 +1202,7 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	init.num_parents = 1;
 	init.name = divider_name;
 	init.ops = &bcm2835_pll_divider_clk_ops;
-	init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
+	init.flags = data->flags | CLK_IGNORE_UNUSED;
 
 	divider = devm_kzalloc(cprman->dev, sizeof(*divider), GFP_KERNEL);
 	if (!divider)
@@ -1408,7 +1409,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLA_CORE,
 		.load_mask = CM_PLLA_LOADCORE,
 		.hold_mask = CM_PLLA_HOLDCORE,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLA_PER]	= REGISTER_PLL_DIV(
 		.name = "plla_per",
 		.source_pll = "plla",
@@ -1416,7 +1418,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLA_PER,
 		.load_mask = CM_PLLA_LOADPER,
 		.hold_mask = CM_PLLA_HOLDPER,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLA_DSI0]	= REGISTER_PLL_DIV(
 		.name = "plla_dsi0",
 		.source_pll = "plla",
@@ -1432,7 +1435,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLA_CCP2,
 		.load_mask = CM_PLLA_LOADCCP2,
 		.hold_mask = CM_PLLA_HOLDCCP2,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 
 	/* PLLB is used for the ARM's clock. */
 	[BCM2835_PLLB]		= REGISTER_PLL(
@@ -1456,7 +1460,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLB_ARM,
 		.load_mask = CM_PLLB_LOADARM,
 		.hold_mask = CM_PLLB_HOLDARM,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 
 	/*
 	 * PLLC is the core PLL, used to drive the core VPU clock.
@@ -1485,7 +1490,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLC_CORE0,
 		.load_mask = CM_PLLC_LOADCORE0,
 		.hold_mask = CM_PLLC_HOLDCORE0,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLC_CORE1]	= REGISTER_PLL_DIV(
 		.name = "pllc_core1",
 		.source_pll = "pllc",
@@ -1493,7 +1499,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLC_CORE1,
 		.load_mask = CM_PLLC_LOADCORE1,
 		.hold_mask = CM_PLLC_HOLDCORE1,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLC_CORE2]	= REGISTER_PLL_DIV(
 		.name = "pllc_core2",
 		.source_pll = "pllc",
@@ -1501,7 +1508,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLC_CORE2,
 		.load_mask = CM_PLLC_LOADCORE2,
 		.hold_mask = CM_PLLC_HOLDCORE2,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLC_PER]	= REGISTER_PLL_DIV(
 		.name = "pllc_per",
 		.source_pll = "pllc",
@@ -1509,7 +1517,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLC_PER,
 		.load_mask = CM_PLLC_LOADPER,
 		.hold_mask = CM_PLLC_HOLDPER,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 
 	/*
 	 * PLLD is the display PLL, used to drive DSI display panels.
@@ -1538,7 +1547,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLD_CORE,
 		.load_mask = CM_PLLD_LOADCORE,
 		.hold_mask = CM_PLLD_HOLDCORE,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLD_PER]	= REGISTER_PLL_DIV(
 		.name = "plld_per",
 		.source_pll = "plld",
@@ -1546,7 +1556,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLD_PER,
 		.load_mask = CM_PLLD_LOADPER,
 		.hold_mask = CM_PLLD_HOLDPER,
-		.fixed_divider = 1),
+		.fixed_divider = 1,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLD_DSI0]	= REGISTER_PLL_DIV(
 		.name = "plld_dsi0",
 		.source_pll = "plld",
@@ -1591,7 +1602,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLH_RCAL,
 		.load_mask = CM_PLLH_LOADRCAL,
 		.hold_mask = 0,
-		.fixed_divider = 10),
+		.fixed_divider = 10,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLH_AUX]	= REGISTER_PLL_DIV(
 		.name = "pllh_aux",
 		.source_pll = "pllh",
@@ -1599,7 +1611,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLH_AUX,
 		.load_mask = CM_PLLH_LOADAUX,
 		.hold_mask = 0,
-		.fixed_divider = 10),
+		.fixed_divider = 10,
+		.flags = CLK_SET_RATE_PARENT),
 	[BCM2835_PLLH_PIX]	= REGISTER_PLL_DIV(
 		.name = "pllh_pix",
 		.source_pll = "pllh",
@@ -1607,7 +1620,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLH_PIX,
 		.load_mask = CM_PLLH_LOADPIX,
 		.hold_mask = 0,
-		.fixed_divider = 10),
+		.fixed_divider = 10,
+		.flags = CLK_SET_RATE_PARENT),
 
 	/* the clocks */
 
-- 
2.11.0
