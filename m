From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 16:16:13 +0200
Subject: [PATCH 2/6] clk: sunxi-ng: mux: Add mux table macro
In-Reply-To: <20160901141617.9777-1-maxime.ripard@free-electrons.com>
References: <20160901141617.9777-1-maxime.ripard@free-electrons.com>
Message-ID: <20160901141617.9777-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new macro to declare muxes based on a table and a gate.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_mux.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index f5123a1a6603..47aba3a48245 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -43,9 +43,12 @@ struct ccu_mux {
 	struct ccu_common	common;
 };
 
-#define SUNXI_CCU_MUX(_struct, _name, _parents, _reg, _shift, _width, _flags) \
+#define SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, _table,	\
+				     _reg, _shift, _width, _gate,	\
+				     _flags)				\
 	struct ccu_mux _struct = {					\
-		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
+		.enable	= _gate,					\
+		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),	\
 		.common	= {						\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
@@ -57,17 +60,14 @@ struct ccu_mux {
 
 #define SUNXI_CCU_MUX_WITH_GATE(_struct, _name, _parents, _reg,		\
 				_shift, _width, _gate, _flags)		\
-	struct ccu_mux _struct = {					\
-		.enable	= _gate,					\
-		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
-		.common	= {						\
-			.reg		= _reg,				\
-			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
-							      _parents, \
-							      &ccu_mux_ops, \
-							      _flags),	\
-		}							\
-	}
+	SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, NULL,	\
+				      _reg, _shift, _width, _gate,	\
+				      _flags)
+
+#define SUNXI_CCU_MUX(_struct, _name, _parents, _reg, _shift, _width,	\
+		      _flags)						\
+	SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, NULL,	\
+				      _reg, _shift, _width, 0, _flags)
 
 static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
 {
-- 
2.9.2
