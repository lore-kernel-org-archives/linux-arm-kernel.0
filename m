From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat,  4 Jul 2015 01:15:15 +0200
Subject: [PATCH v4 2/7] imx35: define two clocks for rtc
In-Reply-To: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1435965320-1478-3-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx35 don't define clocks for rtc.
This patch add two clocks, as needed
by the mxc rtc driver.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/clk/imx/clk-imx35.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 69138ba..c5052b6 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -66,7 +66,7 @@ static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
 enum mx35_clks {
-	ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
+	ckih, ckil, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
 	arm_per_div, ahb_per_div, ipg_per, uart_sel, uart_div, esdhc_sel,
 	esdhc1_div, esdhc2_div, esdhc3_div, spdif_sel, spdif_div_pre,
 	spdif_div_post, ssi_sel, ssi1_div_pre, ssi1_div_post, ssi2_div_pre,
@@ -107,6 +107,7 @@ int __init mx35_clocks_init(void)
 	}
 
 	clk[ckih] = imx_clk_fixed("ckih", 24000000);
+	clk[ckil] = imx_clk_fixed("ckih", 32768);
 	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "mpll", "ckih", base + MX35_CCM_MPCTL);
 	clk[ppll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "ppll", "ckih", base + MX35_CCM_PPCTL);
 
@@ -258,6 +259,9 @@ int __init mx35_clocks_init(void)
 	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.1");
 	clk_register_clkdev(clk[uart3_gate], "per", "imx21-uart.2");
 	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.2");
+	/* i.mx35 has the i.mx21 type rtc */
+	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
+	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.0");
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.0");
 	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.0");
-- 
1.7.4.4
