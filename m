From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 20 Apr 2016 17:34:37 +0800
Subject: [RESEND PATCH 5/8] clk: imx: re-order and concentrate the same type
 of clk api
In-Reply-To: <1461144880-8724-1-git-send-email-aisheng.dong@nxp.com>
References: <1461144880-8724-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1461144880-8724-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-order and concentrate the same type of clk api for better
code maintenance.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk.h | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 508d0fa..df87d88 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -51,28 +51,6 @@ struct clk * imx_obtain_fixed_clock(
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
 
-static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
-{
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0, &imx_ccm_lock, NULL);
-}
-
-static inline struct clk *imx_clk_gate2_shared(const char *name,
-		const char *parent, void __iomem *reg, u8 shift,
-		unsigned int *share_count)
-{
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0, &imx_ccm_lock, share_count);
-}
-
-static inline struct clk *imx_clk_gate2_cgr(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, u8 cgr_val)
-{
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, cgr_val, 0, &imx_ccm_lock, NULL);
-}
-
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
@@ -97,6 +75,13 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
+static inline struct clk *imx_clk_fixed_factor(const char *name,
+		const char *parent, unsigned int mult, unsigned int div)
+{
+	return clk_register_fixed_factor(NULL, name, parent,
+			CLK_SET_RATE_PARENT, mult, div);
+}
+
 static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
@@ -126,6 +111,28 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
+static inline struct clk *imx_clk_gate2_shared(const char *name,
+		const char *parent, void __iomem *reg, u8 shift,
+		unsigned int *share_count)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0x3, 0, &imx_ccm_lock, share_count);
+}
+
+static inline struct clk *imx_clk_gate2_cgr(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, u8 cgr_val)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, cgr_val, 0, &imx_ccm_lock, NULL);
+}
+
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
@@ -143,13 +150,6 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_fixed_factor(const char *name,
-		const char *parent, unsigned int mult, unsigned int div)
-{
-	return clk_register_fixed_factor(NULL, name, parent,
-			CLK_SET_RATE_PARENT, mult, div);
-}
-
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
1.9.1
