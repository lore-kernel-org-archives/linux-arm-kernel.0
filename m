From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 19 Oct 2018 01:05:36 +0000
Subject: [PATCH V2] clk: imx7d: remove UART1 clock setting
Message-ID: <1539910863-2352-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are clock assignments in all i.MX7D dtb files for UART1,
below is the example in imx7d-sdb.dts, so setting UART1 clock
in clock driver is NOT necessary, actually, module clocks setting
should be done in module driver.

&uart1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_uart1>;
	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
	status = "okay";
};

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index adb08f6..06c105d 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -886,9 +886,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
-	/* set uart module clock's parent clock source that must be great then 80MHz */
-	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
-
 	/* Set clock rate for USBPHY, the USB_PLL at CCM is from USBOTG2 */
 	clks[IMX7D_USB1_MAIN_480M_CLK] = imx_clk_fixed_factor("pll_usb1_main_clk", "osc", 20, 1);
 	clks[IMX7D_USB_MAIN_480M_CLK] = imx_clk_fixed_factor("pll_usb_main_clk", "osc", 20, 1);
-- 
2.7.4
