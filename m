From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Jul 2016 15:04:27 +0800
Subject: [PATCH 5/9] clk: sunxi-ng: mux: support fixed pre-dividers on
 multiple parents
In-Reply-To: <1469516671-19377-1-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
Message-ID: <1469516671-19377-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks on the A31 have fixed pre-dividers on multiple parents.
Add support for them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c |  9 +++++----
 drivers/clk/sunxi-ng/ccu_mux.c      |  6 ++++--
 drivers/clk/sunxi-ng/ccu_mux.h      | 10 ++++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 9af359544110..5f5c900c235b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -184,15 +184,16 @@ static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
 			     0);
 
 static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
+static const struct ccu_mux_fixed_prediv ahb2_fixed_predivs[] = {
+	{ .index = 1, .div = 2},
+	{ },
+};
 static struct ccu_mux ahb2_clk = {
 	.mux		= {
 		.shift	= 0,
 		.width	= 1,
 
-		.fixed_prediv	= {
-			.index	= 1,
-			.div	= 2,
-		},
+		.fixed_predivs	= ahb2_fixed_predivs,
 	},
 
 	.common		= {
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 68b32f168a74..f96eabb5d1f3 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -20,6 +20,7 @@ void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
 {
 	u16 prediv = 1;
 	u32 reg;
+	int i;
 
 	if (!((common->features & CCU_FEATURE_FIXED_PREDIV) ||
 	      (common->features & CCU_FEATURE_VARIABLE_PREDIV)))
@@ -32,8 +33,9 @@ void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
 	}
 
 	if (common->features & CCU_FEATURE_FIXED_PREDIV)
-		if (parent_index == cm->fixed_prediv.index)
-			prediv = cm->fixed_prediv.div;
+		for (i = 0; cm->fixed_predivs[i].div; i++)
+			if (parent_index == cm->fixed_predivs[i].index)
+				prediv = cm->fixed_predivs[i].div;
 
 	if (common->features & CCU_FEATURE_VARIABLE_PREDIV)
 		if (parent_index == cm->variable_prediv.index) {
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index f0078de78712..28d16ec18d55 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -5,15 +5,17 @@
 
 #include "ccu_common.h"
 
+struct ccu_mux_fixed_prediv {
+	u8	index;
+	u16	div;
+};
+
 struct ccu_mux_internal {
 	u8		shift;
 	u8		width;
 	const u8	*table;
 
-	struct {
-		u8	index;
-		u16	div;
-	} fixed_prediv;
+	const struct ccu_mux_fixed_prediv	*fixed_predivs;
 
 	struct {
 		u8	index;
-- 
2.8.1
