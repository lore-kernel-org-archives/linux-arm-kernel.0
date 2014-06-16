From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 16 Jun 2014 09:44:16 +0800
Subject: [PATCH 2/2] ARM: dts: imx6qdl: use DT macro for clock ID
In-Reply-To: <539DF957.5080603@gmail.com>
References: <1402836147-29625-1-git-send-email-shawn.guo@freescale.com>
 <1402836147-29625-2-git-send-email-shawn.guo@freescale.com>
 <539DF957.5080603@gmail.com>
Message-ID: <20140616014415.GC8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 15, 2014 at 08:51:51PM +0100, Iain Paton wrote:
> On 15/06/14 13:42, Shawn Guo wrote:
> > Switch to use DT macro for clock ID, so that device tree source is more
> > readable.
> 
> [...]
> >  		aips1: aips-bus at 02000000 {
> > @@ -87,7 +90,8 @@
> >  				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
> >  				reg = <0x021f8000 0x4000>;
> >  				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clks 116>;
> > +				/* Same clock as i.MX6Q ECSPI5 */
> > +				clocks = <&clks IMX6QDL_CLK_ECSPI5>;
> >  				status = "disabled";
> >  			};
> >  		};
> 
> Do you think it would it be worthwhile to define
> 
> +#define IMX6Q_CLK_ECSPI5	116
> +#define IMX6DL_CLK_I2C4	116
> 
> in imx6qdl-clock.h from the first patch and use it here ?
> 
> I'm not particularly bothered either way, I just remember thinking the 
> name in the enum could become a cause of confusion when I was looking 
> at the changes for i2c4.

Yeah, point taken.  Here is the change what I'm amending.

Shawn

--8<---------

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 74e978841d77..b453e0e28aee 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -90,8 +90,7 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
 				reg = <0x021f8000 0x4000>;
 				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
-				/* Same clock as i.MX6Q ECSPI5 */
-				clocks = <&clks IMX6QDL_CLK_ECSPI5>;
+				clocks = <&clks IMX6DL_CLK_I2C4>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 4a6cbd086da9..e9f3646d1760 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -92,8 +92,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6QDL_CLK_ECSPI5>,
-						 <&clks IMX6QDL_CLK_ECSPI5>;
+					clocks = <&clks IMX6Q_CLK_ECSPI5>,
+						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 84101911f1e3..e3cc1c8a1b4c 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -321,10 +321,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_ECSPI3]       = imx_clk_gate2("ecspi3",        "ecspi_root",        base + 0x6c, 4);
 	clk[IMX6QDL_CLK_ECSPI4]       = imx_clk_gate2("ecspi4",        "ecspi_root",        base + 0x6c, 6);
 	if (cpu_is_imx6dl())
-		/* ecspi5 is replaced with i2c4 on imx6dl & imx6s */
-		clk[IMX6QDL_CLK_ECSPI5] = imx_clk_gate2("i2c4",        "ipg_per",           base + 0x6c, 8);
+		clk[IMX6DL_CLK_I2C4]  = imx_clk_gate2("i2c4",          "ipg_per",           base + 0x6c, 8);
 	else
-		clk[IMX6QDL_CLK_ECSPI5] = imx_clk_gate2("ecspi5",      "ecspi_root",        base + 0x6c, 8);
+		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
 	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
 	clk[IMX6QDL_CLK_ESAI]         = imx_clk_gate2_shared("esai",   "esai_podf",         base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_AHB]     = imx_clk_gate2_shared("esai_ahb", "ahb",             base + 0x6c, 16, &share_count_esai);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 94700a773fe3..654151e24288 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -125,7 +125,8 @@
 #define IMX6QDL_CLK_ECSPI2			113
 #define IMX6QDL_CLK_ECSPI3			114
 #define IMX6QDL_CLK_ECSPI4			115
-#define IMX6QDL_CLK_ECSPI5			116
+#define IMX6Q_CLK_ECSPI5			116
+#define IMX6DL_CLK_I2C4				116
 #define IMX6QDL_CLK_ENET			117
 #define IMX6QDL_CLK_ESAI			118
 #define IMX6QDL_CLK_GPT_IPG			119
