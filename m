From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  5 Jun 2012 15:16:43 +0800
Subject: [PATCH 2/2] ARM: imx6q: fix suspend regression caused by common clk
 migration
In-Reply-To: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
References: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1338880603-24333-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When moving to common clk framework, the imx6q clks rom and mmdc_ch1_axi
get different on/off states than old clk driver, which breaks suspend
function.  There might be a better way to manage these clocks, but let's
takes the old clk driver approach to fix the regression first.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 34b89e9..abb42e7 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -152,13 +152,14 @@ enum mx6q_clks {
 	ssi2, ssi3, uart_ipg, uart_serial, usboh3, usdhc1, usdhc2, usdhc3,
 	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
 	pll4_audio, pll5_video, pll6_mlb, pll7_usb_host, pll8_enet, ssi1_ipg,
-	ssi2_ipg, ssi3_ipg, clk_max
+	ssi2_ipg, ssi3_ipg, rom,
+	clk_max
 };
 
 static struct clk *clk[clk_max];
 
 static enum mx6q_clks const clks_init_on[] __initconst = {
-	mmdc_ch0_axi, mmdc_ch1_axi,
+	mmdc_ch0_axi, rom,
 };
 
 int __init mx6q_clocks_init(void)
@@ -364,6 +365,7 @@ int __init mx6q_clocks_init(void)
 	clk[gpmi_bch]     = imx_clk_gate2("gpmi_bch",      "usdhc4",            base + 0x78, 26);
 	clk[gpmi_io]      = imx_clk_gate2("gpmi_io",       "enfc",              base + 0x78, 28);
 	clk[gpmi_apb]     = imx_clk_gate2("gpmi_apb",      "usdhc3",            base + 0x78, 30);
+	clk[rom]          = imx_clk_gate2("rom",           "ahb",               base + 0x7c, 0);
 	clk[sata]         = imx_clk_gate2("sata",          "ipg",               base + 0x7c, 4);
 	clk[sdma]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clk[spba]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
-- 
1.7.5.4
