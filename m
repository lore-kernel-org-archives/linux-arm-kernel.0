From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 16:16:12 +0200
Subject: [PATCH 1/6] clk: sunxi-ng: div: Add mux table macros
In-Reply-To: <20160901141617.9777-1-maxime.ripard@free-electrons.com>
References: <20160901141617.9777-1-maxime.ripard@free-electrons.com>
Message-ID: <20160901141617.9777-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some macros to ease the declaration of clocks that are using them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_div.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 5d98549e23a6..a5c9eaf90e84 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -77,13 +77,16 @@ struct ccu_div {
 				      _shift, _width, _table, 0,	\
 				      _flags)
 
-#define SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
-				  _mshift, _mwidth, _muxshift, _muxwidth, \
-				  _gate, _flags)			\
+#define SUNXI_CCU_M_WITH_MUX_TABLE_GATE(_struct, _name,			\
+					_parents, _table,		\
+					_reg,				\
+					_mshift, _mwidth,		\
+					_muxshift, _muxwidth,		\
+					_gate, _flags)			\
 	struct ccu_div _struct = {					\
 		.enable	= _gate,					\
 		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
-		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.mux	= _SUNXI_CCU_MUX_TABLE(_muxshift, _muxwidth, _table), \
 		.common	= {						\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
@@ -93,12 +96,23 @@ struct ccu_div {
 		},							\
 	}
 
+#define SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				  _mshift, _mwidth, _muxshift, _muxwidth, \
+				  _gate, _flags)			\
+	SUNXI_CCU_M_WITH_MUX_TABLE_GATE(_struct, _name,			\
+					_parents, NULL,			\
+					_reg, _mshift, _mwidth,		\
+					_muxshift, _muxwidth,		\
+					_gate, _flags)
+
 #define SUNXI_CCU_M_WITH_MUX(_struct, _name, _parents, _reg,		\
 			     _mshift, _mwidth, _muxshift, _muxwidth,	\
 			     _flags)					\
-	SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
-				  _mshift, _mwidth, _muxshift, _muxwidth, \
-				  0, _flags)
+	SUNXI_CCU_M_WITH_MUX_TABLE_GATE(_struct, _name,			\
+					_parents, NULL,			\
+					_reg, _mshift, _mwidth,		\
+					_muxshift, _muxwidth,		\
+					0, _flags)
 
 
 #define SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,		\
-- 
2.9.2
