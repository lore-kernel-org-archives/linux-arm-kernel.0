From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:30 +0200
Subject: [PATCH 02/13] clk: sunxi-ng: mux: Add mux table support
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the table based muxes, and add macros to register them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 14 ++++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.h | 27 ++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 58fc36e7dcce..f942044b038a 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -100,6 +100,7 @@ out:
 u8 ccu_mux_helper_get_parent(struct ccu_common *common,
 			     struct ccu_mux_internal *cm)
 {
+	int num_parents = clk_hw_get_num_parents(&common->hw);
 	u32 reg;
 	u8 parent;
 
@@ -107,6 +108,16 @@ u8 ccu_mux_helper_get_parent(struct ccu_common *common,
 	parent = reg >> cm->shift;
 	parent &= (1 << cm->width) - 1;
 
+	if (cm->table) {
+		int i;
+
+		for (i = 0; i < num_parents; i++)
+			if (cm->table[i] == parent)
+				return i;
+
+		return -EINVAL;
+	}
+
 	return parent;
 }
 
@@ -117,6 +128,9 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 	unsigned long flags;
 	u32 reg;
 
+	if (cm->table)
+		index = cm->table[index];
+
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 95cfecec3c39..00cec8ac6ae3 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -9,6 +9,8 @@ struct ccu_mux_internal {
 	u8	shift;
 	u8	width;
 
+	const u8	*table;
+
 	struct {
 		u8	index;
 		u8	div;
@@ -21,12 +23,16 @@ struct ccu_mux_internal {
 	} variable_prediv;
 };
 
-#define _SUNXI_CCU_MUX(_shift, _width)		\
-	{					\
-		.shift	= _shift,		\
-		.width	= _width,		\
+#define _SUNXI_CCU_MUX_TABLE(_shift, _width, _table)	\
+	{						\
+		.shift	= _shift,			\
+		.width	= _width,			\
+		.table	= _table,			\
 	}
 
+#define _SUNXI_CCU_MUX(_shift, _width)			\
+	_SUNXI_CCU_MUX_TABLE(_shift, _width, NULL)
+
 struct ccu_mux {
 	u16			reg;
 	u32			enable;
@@ -47,11 +53,12 @@ struct ccu_mux {
 		}							\
 	}
 
-#define SUNXI_CCU_MUX_WITH_GATE(_struct, _name, _parents, _reg,		\
-				_shift, _width, _gate, _flags)		\
+#define SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, _table,	\
+				      _reg,  _shift, _width, _gate,	\
+				      _flags)				\
 	struct ccu_mux _struct = {					\
 		.enable	= _gate,					\
-		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
+		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),	\
 		.common	= {						\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
@@ -61,6 +68,12 @@ struct ccu_mux {
 		}							\
 	}
 
+#define SUNXI_CCU_MUX_WITH_GATE(_struct, _name, _parents, _reg,		\
+				_shift, _width, _gate, _flags)		\
+	SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, NULL,	\
+				      _reg,  _shift, _width, _gate,	\
+				      _flags)
+
 static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.9.2
