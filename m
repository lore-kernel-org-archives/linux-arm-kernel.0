From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 28 Mar 2018 09:46:35 +0300
Subject: [RESEND 1/4] clk: imx7d: Add USB clock information
In-Reply-To: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <1522219599-10831-2-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@freescale.com>

Add USB clock information, the pll_usb_main_clk is USB_PLL at CCM
which is the output of USBOTG2 PHY.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 89bfa75..39d110b 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -801,7 +801,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_OCOTP_CLK] = imx_clk_gate4("ocotp_clk", "ipg_root_clk", base + 0x4230, 0);
 	clks[IMX7D_SNVS_CLK] = imx_clk_gate4("snvs_clk", "ipg_root_clk", base + 0x4250, 0);
 	clks[IMX7D_CAAM_CLK] = imx_clk_gate4("caam_clk", "ipg_root_clk", base + 0x4240, 0);
-	clks[IMX7D_USB_HSIC_ROOT_CLK] = imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4420, 0);
+	clks[IMX7D_USB_HSIC_ROOT_CLK] = imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4690, 0);
 	clks[IMX7D_SDMA_CORE_CLK] = imx_clk_gate4("sdma_root_clk", "ahb_root_clk", base + 0x4480, 0);
 	clks[IMX7D_PCIE_CTRL_ROOT_CLK] = imx_clk_gate4("pcie_ctrl_root_clk", "pcie_ctrl_post_div", base + 0x4600, 0);
 	clks[IMX7D_PCIE_PHY_ROOT_CLK] = imx_clk_gate4("pcie_phy_root_clk", "pcie_phy_post_div", base + 0x4600, 0);
@@ -867,6 +867,9 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CSI_MCLK_ROOT_CLK] = imx_clk_gate4("csi_mclk_root_clk", "csi_mclk_post_div", base + 0x4490, 0);
 	clks[IMX7D_AUDIO_MCLK_ROOT_CLK] = imx_clk_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base + 0x4790, 0);
 	clks[IMX7D_WRCLK_ROOT_CLK] = imx_clk_gate4("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
+	clks[IMX7D_USB_CTRL_CLK] = imx_clk_gate4("usb_ctrl_clk", "ahb_root_clk", base + 0x4680, 0);
+	clks[IMX7D_USB_PHY1_CLK] = imx_clk_gate4("usb_phy1_clk", "pll_usb1_main_clk", base + 0x46a0, 0);
+	clks[IMX7D_USB_PHY2_CLK] = imx_clk_gate4("usb_phy2_clk", "pll_usb_main_clk", base + 0x46b0, 0);
 	clks[IMX7D_ADC_ROOT_CLK] = imx_clk_gate4("adc_root_clk", "ipg_root_clk", base + 0x4200, 0);
 
 	clks[IMX7D_GPT_3M_CLK] = imx_clk_fixed_factor("gpt_3m", "osc", 1, 8);
@@ -892,6 +895,10 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	/* set uart module clock's parent clock source that must be great then 80MHz */
 	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
+	/* Set clock rate for USBPHY, the USB_PLL at CCM is from USBOTG2 */
+	clks[IMX7D_USB1_MAIN_480M_CLK] = imx_clk_fixed_factor("pll_usb1_main_clk", "osc", 20, 1);
+	clks[IMX7D_USB_MAIN_480M_CLK] = imx_clk_fixed_factor("pll_usb_main_clk", "osc", 20, 1);
+
 	imx_register_uart_clocks(uart_clks);
 
 }
-- 
2.7.4
