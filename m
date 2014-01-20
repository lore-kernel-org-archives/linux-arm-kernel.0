From: b20788@freescale.com (Anson Huang)
Date: Mon, 20 Jan 2014 18:44:50 +0800
Subject: [PATCH] ARM: imx: correct usecount of IPG, ARM and MMDC clk on i.mx6sl
Message-ID: <1390214690-13564-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IPG, ARM and MMDC's clock should be enabled during kernel boot up,
so we need to maintain their use count, otherwise, they may be
disabled unexpectedly if their children's clock are turned off,
which is not allowed.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sl.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index 78f3bd6..8d720f9 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -291,6 +291,21 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 		pr_warn("%s: failed to set AHB clock rate %d!\n",
 			__func__, ret);
 
+	/* Correct usecount of IPG clk */
+	ret = clk_prepare_enable(clks[IMX6SL_CLK_IPG]);
+	if (ret)
+		pr_warn("%s: failed to enable IPG clock %d\n", __func__, ret);
+
+	/* Correct usecount of ARM clk */
+	ret = clk_prepare_enable(clks[IMX6SL_CLK_ARM]);
+	if (ret)
+		pr_warn("%s: failed to enable ARM clock %d\n", __func__, ret);
+
+	/* Correct usecount of MMDC clk */
+	ret = clk_prepare_enable(clks[IMX6SL_CLK_MMDC_ROOT]);
+	if (ret)
+		pr_warn("%s: failed to enable MMDC clock %d\n", __func__, ret);
+
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
-- 
1.7.9.5
