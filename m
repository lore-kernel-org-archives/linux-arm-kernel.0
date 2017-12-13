From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Dec 2017 12:57:48 +0100
Subject: [PATCH] clk: imx51: uart4, uart5 gates only exist on imx50, imx53
Message-ID: <20171213115748.14106-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX51 only has 3 UARTs and no CCGR7 register. In place of the CCGR7
register on i.MX50/i.MX53 that contains the ipg and per clock gates
for UARTs 4 and 5, on i.MX51 there is the CMEOR register.

Without this patch, the code disabling the UART clocks would also clear
the mod_en_ov_vpu bit in the CMEOR register, among others, which causes
register accesses to the VPU to lock up the system.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/clk/imx/clk-imx51-imx53.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index 7bcaf270db117..c864992e6983f 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -257,10 +257,6 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_VPU_SEL]		= imx_clk_mux("vpu_sel", MXC_CCM_CBCMR, 14, 2, vpu_sel, ARRAY_SIZE(vpu_sel));
 	clk[IMX5_CLK_VPU_GATE]		= imx_clk_gate2("vpu_gate", "vpu_sel", MXC_CCM_CCGR5, 6);
 	clk[IMX5_CLK_VPU_REFERENCE_GATE] = imx_clk_gate2("vpu_reference_gate", "osc", MXC_CCM_CCGR5, 8);
-	clk[IMX5_CLK_UART4_IPG_GATE]	= imx_clk_gate2("uart4_ipg_gate", "ipg", MXC_CCM_CCGR7, 8);
-	clk[IMX5_CLK_UART4_PER_GATE]	= imx_clk_gate2("uart4_per_gate", "uart_root", MXC_CCM_CCGR7, 10);
-	clk[IMX5_CLK_UART5_IPG_GATE]	= imx_clk_gate2("uart5_ipg_gate", "ipg", MXC_CCM_CCGR7, 12);
-	clk[IMX5_CLK_UART5_PER_GATE]	= imx_clk_gate2("uart5_per_gate", "uart_root", MXC_CCM_CCGR7, 14);
 	clk[IMX5_CLK_GPC_DVFS]		= imx_clk_gate2("gpc_dvfs", "dummy", MXC_CCM_CCGR5, 24);
 
 	clk[IMX5_CLK_SSI_APM]		= imx_clk_mux("ssi_apm", MXC_CCM_CSCMR1, 8, 2, ssi_apm_sels, ARRAY_SIZE(ssi_apm_sels));
@@ -361,6 +357,10 @@ static void __init mx50_clocks_init(struct device_node *np)
 	clk[IMX5_CLK_USB_PHY1_GATE]	= imx_clk_gate2("usb_phy1_gate", "usb_phy_sel", MXC_CCM_CCGR4, 10);
 	clk[IMX5_CLK_USB_PHY2_GATE]	= imx_clk_gate2("usb_phy2_gate", "usb_phy_sel", MXC_CCM_CCGR4, 12);
 	clk[IMX5_CLK_I2C3_GATE]		= imx_clk_gate2("i2c3_gate", "per_root", MXC_CCM_CCGR1, 22);
+	clk[IMX5_CLK_UART4_IPG_GATE]	= imx_clk_gate2("uart4_ipg_gate", "ipg", MXC_CCM_CCGR7, 8);
+	clk[IMX5_CLK_UART4_PER_GATE]	= imx_clk_gate2("uart4_per_gate", "uart_root", MXC_CCM_CCGR7, 10);
+	clk[IMX5_CLK_UART5_IPG_GATE]	= imx_clk_gate2("uart5_ipg_gate", "ipg", MXC_CCM_CCGR7, 12);
+	clk[IMX5_CLK_UART5_PER_GATE]	= imx_clk_gate2("uart5_per_gate", "uart_root", MXC_CCM_CCGR7, 14);
 
 	clk[IMX5_CLK_CKO1_SEL]		= imx_clk_mux("cko1_sel", MXC_CCM_CCOSR, 0, 4,
 						mx53_cko1_sel, ARRAY_SIZE(mx53_cko1_sel));
@@ -562,6 +562,10 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk[IMX5_CLK_IEEE1588_PRED]	= imx_clk_divider("ieee1588_pred", "ieee1588_sel", MXC_CCM_CSCDR2, 6, 3);
 	clk[IMX5_CLK_IEEE1588_PODF]	= imx_clk_divider("ieee1588_podf", "ieee1588_pred", MXC_CCM_CSCDR2, 0, 6);
 	clk[IMX5_CLK_IEEE1588_GATE]	= imx_clk_gate2("ieee1588_serial_gate", "ieee1588_podf", MXC_CCM_CCGR7, 6);
+	clk[IMX5_CLK_UART4_IPG_GATE]	= imx_clk_gate2("uart4_ipg_gate", "ipg", MXC_CCM_CCGR7, 8);
+	clk[IMX5_CLK_UART4_PER_GATE]	= imx_clk_gate2("uart4_per_gate", "uart_root", MXC_CCM_CCGR7, 10);
+	clk[IMX5_CLK_UART5_IPG_GATE]	= imx_clk_gate2("uart5_ipg_gate", "ipg", MXC_CCM_CCGR7, 12);
+	clk[IMX5_CLK_UART5_PER_GATE]	= imx_clk_gate2("uart5_per_gate", "uart_root", MXC_CCM_CCGR7, 14);
 
 	clk[IMX5_CLK_CKO1_SEL]		= imx_clk_mux("cko1_sel", MXC_CCM_CCOSR, 0, 4,
 						mx53_cko1_sel, ARRAY_SIZE(mx53_cko1_sel));
-- 
2.11.0
