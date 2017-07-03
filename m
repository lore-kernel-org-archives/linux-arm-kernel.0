From: adriana.reus@nxp.com (Adriana Reus)
Date: Mon,  3 Jul 2017 17:28:02 +0300
Subject: [RFC 1/2] clk: imx: Add CLK_SET_RATE_GATE for imx7d clocks
In-Reply-To: <1499092083-2852-1-git-send-email-adriana.reus@nxp.com>
References: <1499092083-2852-1-git-send-email-adriana.reus@nxp.com>
Message-ID: <1499092083-2852-2-git-send-email-adriana.reus@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three main types of clock slices on imx7d ccm:
"Core clock slice", "Bus clock slice (AXI/AHB)", and "Peripheral clock
slice".
Documentation and general overview: [0]
Vast majority of clock roots fall in the peripheral slice category:

    8:1 mux -> gate -> div -> div -> gate

The root clocks that derive from peripheral slices are expected to be
gated when changing frequency.[1]

Introduce imx_clk_gate2_flags for clocks where it is not necessary to
set RATE_GATE and add the CLK_SET_RATE flag to imx_clk_gate4 for the
rest of the clocks.

[0]: http://www.nxp.com/docs/en/reference-manual/IMX7DRM.pdf
     Relevant sections: 5.2.4
[1]: Relevant sections: 5.1.3.5.3; 5.2.6.4 [5.2.6.4.3]

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 16 +++++++++++-----
 drivers/clk/imx/clk.h       | 18 +++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 3da1218..e1c31f5 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -791,11 +791,17 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CLKO1_ROOT_DIV] = imx_clk_divider2("clko1_post_div", "clko1_pre_div", base + 0xbd80, 0, 6);
 	clks[IMX7D_CLKO2_ROOT_DIV] = imx_clk_divider2("clko2_post_div", "clko2_pre_div", base + 0xbe00, 0, 6);
 
-	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0);
-	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
-	clks[IMX7D_ARM_M0_ROOT_CLK] = imx_clk_gate4("arm_m0_root_clk", "arm_m0_div", base + 0x4020, 0);
-	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate4("main_axi_root_clk", "axi_post_div", base + 0x4040, 0);
-	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk", "disp_axi_post_div", base + 0x4050, 0);
+	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate2_flags("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0,
+							  CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate2_flags("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0,
+							  CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_ARM_M0_ROOT_CLK] = imx_clk_gate2_flags("arm_m0_root_clk", "arm_m0_div", base + 0x4020, 0,
+							  CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate2_flags("main_axi_root_clk", "axi_post_div", base + 0x4040, 0,
+							    CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate2_flags("disp_axi_root_clk", "disp_axi_post_div",
+							    base + 0x4050, 0,
+							    CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_ENET_AXI_ROOT_CLK] = imx_clk_gate4("enet_axi_root_clk", "enet_axi_post_div", base + 0x4060, 0);
 	clks[IMX7D_OCRAM_CLK] = imx_clk_gate4("ocram_clk", "axi_post_div", base + 0x4110, 0);
 	clks[IMX7D_OCRAM_S_CLK] = imx_clk_gate4("ocram_s_clk", "ahb_root_clk", base + 0x4120, 0);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d54f072..d0bc094 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -149,8 +149,9 @@ static inline struct clk *imx_clk_gate2_shared2(const char *name,
 		unsigned int *share_count)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
-				  &imx_ccm_lock, share_count);
+				  CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_GATE,
+				  reg, shift, 0x3, 0, &imx_ccm_lock,
+				  share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
@@ -171,9 +172,16 @@ static inline struct clk *imx_clk_gate3(const char *name, const char *parent,
 static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
+				  CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_GATE,
+				  reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
+static inline struct clk *imx_clk_gate2_flags(const char *name, const char *parent,
+               void __iomem *reg, u8 shift, unsigned long flags)
+{
+        return clk_register_gate2(NULL, name, parent, flags, reg, shift, 0x3,
+				  0, &imx_ccm_lock, NULL);
 }
 
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
-- 
2.7.4
