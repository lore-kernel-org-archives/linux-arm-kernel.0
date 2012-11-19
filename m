From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 19 Nov 2012 12:12:26 +0100
Subject: [RFC] ARM: mx5: Replace clk_register_clkdev with clock DT lookup
In-Reply-To: <1353087415-10442-1-git-send-email-festevam@gmail.com>
References: <1353087415-10442-1-git-send-email-festevam@gmail.com>
Message-ID: <1353323546.2697.22.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 16.11.2012, 15:36 -0200 schrieb Fabio Estevam:
> From: Fabio Estevam fabio.estevam at freescale.com>
> 
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Shawn/Sascha,
> 
> I do not have access to any mx5 hardware at the moment to try it, so that's
> why I marked it as RFC.

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

After adding the IPU clock lookups, as below, on top of Sascha's latest
IPUv3 patches (in staging-next).

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index bcdfabc..3f86a5e 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -73,6 +73,8 @@
 			compatible = "fsl,imx53-ipu";
 			reg = <0x18000000 0x080000000>;
 			interrupts = <11 10>;
+			clocks = <&clks 59>, <&clks 120>, <&clks 61>;
+			clock-names = "bus", "di0", "di1";
 			reset = <&src 2>;
 		};
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c
b/arch/arm/mach-imx/clk-imx51-imx53.c
index 473bcdc..031c967 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -458,10 +458,6 @@ int __init mx53_clocks_init(unsigned long
rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[vpu_gate], NULL, "63ff4000.vpu");
 	clk_register_clkdev(clk[i2c3_gate], NULL, "imx-i2c.2");
 	clk_register_clkdev(clk[fec_gate], NULL, "imx25-fec.0");
-	clk_register_clkdev(clk[ipu_gate], "bus", "18000000.ipu");
-	clk_register_clkdev(clk[ipu_di0_gate], "di0", "18000000.ipu");
-	clk_register_clkdev(clk[ipu_di1_gate], "di1", "18000000.ipu");
-	clk_register_clkdev(clk[ipu_gate], "hsp", "18000000.ipu");
 	clk_register_clkdev(clk[usb_phy1_gate], "usb_phy1", "mxc-ehci.0");
 	clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg",
"sdhci-esdhc-imx53.0");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx53.0");
-- 
1.7.10.4

regards
Philipp
