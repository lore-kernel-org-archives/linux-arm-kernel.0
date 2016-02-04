From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 4 Feb 2016 16:25:45 +0100
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <20160204120507.GC4270@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <20160204120507.GC4270@lukather>
Message-ID: <20160204162545.f806fcb64a826d2c3313985b@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Feb 2016 13:05:07 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Mon, Feb 01, 2016 at 09:20:00PM +0100, Maxime Ripard wrote:
> > Remove the fixed dividers from the PLL6 driver to be able to have a
> > reusable driver that can be used across several SoCs that share the same
> > controller, but don't have the same set of dividers for this clock, and to
> > also be reused multiple times in the same SoC, since we're droping the
> > clock name.
> > 
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Applied.
> 
> Maxime

I don't agree:
- you changed the DTs of many SoCs without any valid reason,
- you complexified the treatment of the pll6 in clk-sunxi.c while
  defining a x2 rate instead of the single rate would also work for
  the other pll periphs (pll8).

Here is a simpler patch:

--- a/arch/arm/boot/dts/sun8i-h3.dtsi	2016-02-01 08:24:06.179396522 +0100
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi	2016-02-04 16:18:05.911509291 +0100
@@ -137,12 +137,23 @@
 			clock-output-names = "pll6d2";
 		};
 
-		/* dummy clock until pll6 can be reused */
+		pll8x2: clk at 01c20044 {			/* PLL_PERIPH1 */
+			#clock-cells = <0>;
+			compatible = "allwinner,pll-periphx2-clk";
+			reg = <0x01c20044 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll8x2";
+		};
+
 		pll8: pll8_clk {
 			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <1>;
+			compatible = "fixed-factor-clock";
+			clock-div = <2>;
+			clock-mult = <1>;
+			clocks = <&pll8x2>;
 			clock-output-names = "pll8";
+			assigned-clocks = <&pll8x2>;
+			assigned-clock-rates = <1200000000>;
 		};
 
 		cpu: cpu_clk at 01c20050 {
--- a/drivers/clk/sunxi/clk-sunxi.c	2016-02-01 08:24:06.199396132 +0100
+++ b/drivers/clk/sunxi/clk-sunxi.c	2016-02-04 16:03:41.056322804 +0100
@@ -714,6 +714,12 @@
 	.name = "pll6",
 };
 
+static const struct factors_data pll_periphx2_data __initconst = {
+	.enable = 31,
+	.table = &sun6i_a31_pll6_config,
+	.getter = sun6i_a31_get_pll6_factors,
+};
+
 static const struct factors_data sun6i_a31_pll6_data __initconst = {
 	.enable = 31,
 	.table = &sun6i_a31_pll6_config,
@@ -1110,6 +1116,7 @@
 	{.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
 	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
+	{.compatible = "allwinner,pll-periphx2-clk", .data = &pll_periphx2_data,},
 	{}
 };
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
