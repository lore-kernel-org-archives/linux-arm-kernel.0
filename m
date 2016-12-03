From: vlee@freedesktop.org (Vinson Lee)
Date: Sat,  3 Dec 2016 00:37:16 +0000
Subject: [PATCH] clk: uniphier: Fix build with gcc-4.4.
Message-ID: <1480725436-9628-1-git-send-email-vlee@freedesktop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-4.4 has issues with anonymous unions in initializers.

  CC      drivers/clk/uniphier/clk-uniphier-sys.o
drivers/clk/uniphier/clk-uniphier-sys.c:45: error: unknown field ?factor? specified in initializer

Fixes: 1574d5722636 ("clk: uniphier: remove unneeded member name for union")
Signed-off-by: Vinson Lee <vlee@freedesktop.org>
---
 drivers/clk/uniphier/clk-uniphier-mio.c |  4 ++--
 drivers/clk/uniphier/clk-uniphier.h     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
index 4974d38..7441eeb 100644
--- a/drivers/clk/uniphier/clk-uniphier-mio.c
+++ b/drivers/clk/uniphier/clk-uniphier-mio.c
@@ -30,7 +30,7 @@
 		.name = "sd" #ch "-sel",				\
 		.type = UNIPHIER_CLK_TYPE_MUX,				\
 		.idx = -1,						\
-		.mux = {						\
+		{ .mux = {						\
 			.parent_names = {				\
 				"sd-44m",				\
 				"sd-33m",				\
@@ -63,7 +63,7 @@
 				0x00001200,				\
 				0x00001300,				\
 			},						\
-		},							\
+		} },							\
 	},								\
 	UNIPHIER_CLK_GATE("sd" #ch, (_idx), "sd" #ch "-sel", 0x20 + 0x200 * (ch), 8)
 
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index 81d7e5c..8735a7d 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -81,12 +81,12 @@ struct uniphier_clk_data {
 		.name = (_name),				\
 		.type = UNIPHIER_CLK_TYPE_CPUGEAR,		\
 		.idx = (_idx),					\
-		.cpugear = {					\
+		{ .cpugear = {					\
 			.parent_names = { __VA_ARGS__ },	\
 			.num_parents = (_num_parents),		\
 			.regbase = (_regbase),			\
 			.mask = (_mask)				\
-		 },						\
+		 } },						\
 	}
 
 #define UNIPHIER_CLK_FACTOR(_name, _idx, _parent, _mult, _div)	\
@@ -94,11 +94,11 @@ struct uniphier_clk_data {
 		.name = (_name),				\
 		.type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,		\
 		.idx = (_idx),					\
-		.factor = {					\
+		{ .factor = {					\
 			.parent_name = (_parent),		\
 			.mult = (_mult),			\
 			.div = (_div),				\
-		},						\
+		} },						\
 	}
 
 #define UNIPHIER_CLK_GATE(_name, _idx, _parent, _reg, _bit)	\
@@ -106,11 +106,11 @@ struct uniphier_clk_data {
 		.name = (_name),				\
 		.type = UNIPHIER_CLK_TYPE_GATE,			\
 		.idx = (_idx),					\
-		.gate = {					\
+		{ .gate = {					\
 			.parent_name = (_parent),		\
 			.reg = (_reg),				\
 			.bit = (_bit),				\
-		},						\
+		} },						\
 	}
 
 #define UNIPHIER_CLK_DIV(parent, div)				\
-- 
2.7.4
