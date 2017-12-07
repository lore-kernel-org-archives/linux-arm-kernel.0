From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 7 Dec 2017 20:57:04 +0800
Subject: [PATCH V7 01/12] drivers: move clock common macros out from vendor
 directories
In-Reply-To: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171207125715.16160-2-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros are used by more than one SoC vendor platforms, avoid to
have many copies of these code, this patch moves them to the common
header file which every clock drivers can access to.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sunxi-ng/ccu_common.h | 29 -----------------------------
 drivers/clk/zte/clk.h             | 18 ------------------
 include/linux/clk-provider.h      | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 5d684ce..568cfae 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -31,35 +31,6 @@
 
 struct device_node;
 
-#define CLK_HW_INIT(_name, _parent, _ops, _flags)			\
-	&(struct clk_init_data) {					\
-		.flags		= _flags,				\
-		.name		= _name,				\
-		.parent_names	= (const char *[]) { _parent },		\
-		.num_parents	= 1,					\
-		.ops 		= _ops,					\
-	}
-
-#define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)		\
-	&(struct clk_init_data) {					\
-		.flags		= _flags,				\
-		.name		= _name,				\
-		.parent_names	= _parents,				\
-		.num_parents	= ARRAY_SIZE(_parents),			\
-		.ops 		= _ops,					\
-	}
-
-#define CLK_FIXED_FACTOR(_struct, _name, _parent,			\
-			_div, _mult, _flags)				\
-	struct clk_fixed_factor _struct = {				\
-		.div		= _div,					\
-		.mult		= _mult,				\
-		.hw.init	= CLK_HW_INIT(_name,			\
-					      _parent,			\
-					      &clk_fixed_factor_ops,	\
-					      _flags),			\
-	}
-
 struct ccu_common {
 	void __iomem	*base;
 	u16		reg;
diff --git a/drivers/clk/zte/clk.h b/drivers/clk/zte/clk.h
index 4df0f12..f1041e3 100644
--- a/drivers/clk/zte/clk.h
+++ b/drivers/clk/zte/clk.h
@@ -14,24 +14,6 @@
 
 #define PNAME(x) static const char *x[]
 
-#define CLK_HW_INIT(_name, _parent, _ops, _flags)			\
-	&(struct clk_init_data) {					\
-		.flags		= _flags,				\
-		.name		= _name,				\
-		.parent_names	= (const char *[]) { _parent },		\
-		.num_parents	= 1,					\
-		.ops		= _ops,					\
-	}
-
-#define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)		\
-	&(struct clk_init_data) {					\
-		.flags		= _flags,				\
-		.name		= _name,				\
-		.parent_names	= _parents,				\
-		.num_parents	= ARRAY_SIZE(_parents),			\
-		.ops		= _ops,					\
-	}
-
 struct zx_pll_config {
 	unsigned long rate;
 	u32 cfg0;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7c925e6..26ea037 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -806,6 +806,44 @@ extern struct of_device_id __clk_of_table;
 	}								\
 	OF_DECLARE_1(clk, name, compat, name##_of_clk_init_driver)
 
+#define CLK_HW_INIT(_name, _parent, _ops, _flags)		\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_names	= (const char *[]) { _parent },	\
+		.num_parents	= 1,				\
+		.ops		= _ops,				\
+	})
+
+#define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_names	= _parents,			\
+		.num_parents	= ARRAY_SIZE(_parents),		\
+		.ops		= _ops,				\
+	})
+
+#define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)	\
+	(&(struct clk_init_data) {			\
+		.flags          = _flags,		\
+		.name           = _name,		\
+		.parent_names   = NULL,			\
+		.num_parents    = 0,			\
+		.ops            = _ops,			\
+	})
+
+#define CLK_FIXED_FACTOR(_struct, _name, _parent,			\
+			_div, _mult, _flags)				\
+	struct clk_fixed_factor _struct = {				\
+		.div		= _div,					\
+		.mult		= _mult,				\
+		.hw.init	= CLK_HW_INIT(_name,			\
+					      _parent,			\
+					      &clk_fixed_factor_ops,	\
+					      _flags),			\
+	}
+
 #ifdef CONFIG_OF
 int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *args,
-- 
2.7.4
