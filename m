From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 Aug 2016 14:21:56 +0800
Subject: [PATCH v3 2/6] clk: sunxi-ng: mux: Add support for mux tables
In-Reply-To: <20160825062200.17206-1-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
Message-ID: <20160825062200.17206-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clock muxes have holes, i.e. invalid or unconnected inputs,
between parent mux values.

Add support for specifying a mux table to map clock parents to
mux values.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2:

  - Update macro names as changed in commit ad4578dc4cfa ("clk: sunxi-ng:
    mux: Rename mux macro to be consistent")
  - Use _SUNXI_CLK_MUX_TABLE to expand _SUNXI_CLK_MUX

Changes since v1: none
---
 drivers/clk/sunxi-ng/ccu_mux.c | 12 ++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.h | 17 +++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 1329b9ab481e..68b32f168a74 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -107,6 +107,15 @@ u8 ccu_mux_helper_get_parent(struct ccu_common *common,
 	parent = reg >> cm->shift;
 	parent &= (1 << cm->width) - 1;
 
+	if (cm->table) {
+		int num_parents = clk_hw_get_num_parents(&common->hw);
+		int i;
+
+		for (i = 0; i < num_parents; i++)
+			if (cm->table[i] == parent)
+				return i;
+	}
+
 	return parent;
 }
 
@@ -117,6 +126,9 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 	unsigned long flags;
 	u32 reg;
 
+	if (cm->table)
+		index = cm->table[index];
+
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 83737c2facd4..b1e085612e5e 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -6,8 +6,9 @@
 #include "ccu_common.h"
 
 struct ccu_mux_internal {
-	u8	shift;
-	u8	width;
+	u8		shift;
+	u8		width;
+	const u8	*table;
 
 	struct {
 		u8	index;
@@ -21,12 +22,16 @@ struct ccu_mux_internal {
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
 
+#define _SUNXI_CCU_MUX(_shift, _width) \
+	_SUNXI_CCU_MUX_TABLE(_shift, _width, NULL)
+
 struct ccu_mux {
 	u16			reg;
 	u32			enable;
-- 
2.9.3
