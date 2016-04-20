From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 20 Apr 2016 17:34:38 +0800
Subject: [RESEND PATCH 6/8] clk: imx: add clk api for supporting
 clk_OPS_PARENT_ON clocks
In-Reply-To: <1461144880-8724-1-git-send-email-aisheng.dong@nxp.com>
References: <1461144880-8724-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1461144880-8724-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some IMX SoCs like i.MX7D requires using clk_OPS_PARENT_ON flags,
adding the corresponding clock APIs variants for easily to use.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index df87d88..6736e85 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -97,6 +97,14 @@ static inline struct clk *imx_clk_divider_flags(const char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, u8 width)
+{
+	return clk_register_divider(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -133,6 +141,22 @@ static inline struct clk *imx_clk_gate2_cgr(const char *name, const char *parent
 			shift, cgr_val, 0, &imx_ccm_lock, NULL);
 }
 
+static inline struct clk *imx_clk_gate3(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
+			reg, shift, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
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
+			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ON,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux_flags(const char *name,
 		void __iomem *reg, u8 shift, u8 width, const char **parents,
 		int num_parents, unsigned long flags)
-- 
1.9.1
