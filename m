From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:34 +0200
Subject: [PATCH v3 05/21] clk: sunxi-ng: mux: split out the pre-divider
 computation code
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6d3e9ce05c3f58e42975136481a71fa5d556ad1c.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pre-divider retrieval code was merged into the function to apply the
current pre-divider onto the parent clock rate so that we can use that
adjusted value to do our factors computation.

However, since we'll need to do the reverse operation, we need to split out
that code into a function that will be shared.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 58b6e349a0ed..3eb23d4e6534 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -15,24 +15,20 @@
 #include "ccu_gate.h"
 #include "ccu_mux.h"
 
-void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
-					     struct ccu_mux_internal *cm,
-					     int parent_index,
-					     unsigned long *parent_rate)
+static u16 ccu_mux_get_prediv(struct ccu_common *common,
+			      struct ccu_mux_internal *cm,
+			      int parent_index)
 {
 	u16 prediv = 1;
 	u32 reg;
-	int i;
 
 	if (!((common->features & CCU_FEATURE_FIXED_PREDIV) ||
 	      (common->features & CCU_FEATURE_VARIABLE_PREDIV) ||
 	      (common->features & CCU_FEATURE_ALL_PREDIV)))
-		return;
+		return 1;
 
-	if (common->features & CCU_FEATURE_ALL_PREDIV) {
-		*parent_rate = *parent_rate / common->prediv;
-		return;
-	}
+	if (common->features & CCU_FEATURE_ALL_PREDIV)
+		return common->prediv;
 
 	reg = readl(common->base + common->reg);
 	if (parent_index < 0) {
@@ -40,10 +36,13 @@ void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
 		parent_index &= (1 << cm->width) - 1;
 	}
 
-	if (common->features & CCU_FEATURE_FIXED_PREDIV)
+	if (common->features & CCU_FEATURE_FIXED_PREDIV) {
+		int i;
+
 		for (i = 0; i < cm->n_predivs; i++)
 			if (parent_index == cm->fixed_predivs[i].index)
 				prediv = cm->fixed_predivs[i].div;
+	}
 
 	if (common->features & CCU_FEATURE_VARIABLE_PREDIV)
 		if (parent_index == cm->variable_prediv.index) {
@@ -54,7 +53,16 @@ void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
 			prediv = div + 1;
 		}
 
-	*parent_rate = *parent_rate / prediv;
+	return prediv;
+}
+
+void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
+					     struct ccu_mux_internal *cm,
+					     int parent_index,
+					     unsigned long *parent_rate)
+{
+	*parent_rate = *parent_rate / ccu_mux_get_prediv(common, cm,
+							 parent_index);
 }
 
 int ccu_mux_helper_determine_rate(struct ccu_common *common,
-- 
git-series 0.9.1
