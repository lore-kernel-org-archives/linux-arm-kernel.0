From: abel.vesa@nxp.com (Abel Vesa)
Date: Thu, 22 Mar 2018 11:55:26 +0200
Subject: [PATCH 1/4] arm: imx: Update clk driver API
In-Reply-To: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the following new wrappers:
 - imx_clk_gate2_flag
 - imx_clk_set_parent

It also updates the flags for the old wrappers.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d69c4bb..466c37f3 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
+#include <linux/clk.h>
 
 extern spinlock_t imx_ccm_lock;
 
@@ -54,6 +55,15 @@ struct clk * imx_obtain_fixed_clock(
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
 
+static inline void imx_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret = clk_set_parent(clk, parent);
+
+	if (ret)
+		pr_err("failed to set parent of clk %s to %s: %d\n",
+			__clk_get_name(clk), __clk_get_name(parent), ret);
+}
+
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
@@ -96,7 +106,8 @@ static inline struct clk *imx_clk_fixed_factor(const char *name,
 static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+	return clk_register_divider(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
@@ -112,7 +123,7 @@ static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
 	return clk_register_divider(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
@@ -133,7 +144,15 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
+			shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
+static inline struct clk *imx_clk_gate2_flags(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, unsigned long flags)
+{
+	return clk_register_gate2(NULL, name, parent, flags, reg,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
@@ -141,7 +160,8 @@ static inline struct clk *imx_clk_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
@@ -150,8 +170,8 @@ static inline struct clk *imx_clk_gate2_shared2(const char *name,
 		unsigned int *share_count)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
-				  &imx_ccm_lock, share_count);
+			CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
@@ -173,7 +193,7 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
@@ -181,8 +201,8 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT, reg, shift,
-			width, 0, &imx_ccm_lock);
+			CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
@@ -198,8 +218,8 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-			&imx_ccm_lock);
+			flags | CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
-- 
2.7.4
