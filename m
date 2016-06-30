From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 30 Jun 2016 17:31:16 +0800
Subject: [PATCH V3 6/8] clk: imx: add clk api for supporting
 CLK_OPS_PARENT_ENABLE clocks
In-Reply-To: <1467279078-2330-1-git-send-email-aisheng.dong@nxp.com>
References: <1467279078-2330-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467279078-2330-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX SoCs like i.MX7D requires using CLK_OPS_PARENT_ENABLE flags,
adding the corresponding clock APIs variants for easily to use.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 936e235f7c04..a81c0385ed64 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -97,6 +97,14 @@ static inline struct clk *imx_clk_divider_flags(const char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, u8 width)
+{
+	return clk_register_divider(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -133,6 +141,22 @@ static inline struct clk *imx_clk_gate2_cgr(const char *name,
 			shift, cgr_val, 0, &imx_ccm_lock, NULL);
 }
 
+static inline struct clk *imx_clk_gate3(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
@@ -141,6 +165,14 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 			width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
+		u8 shift, u8 width, const char **parents, int num_parents)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux_flags(const char *name,
 		void __iomem *reg, u8 shift, u8 width, const char **parents,
 		int num_parents, unsigned long flags)
-- 
1.9.1
