From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Nov 2012 16:28:36 +0100
Subject: [PATCH] ARM: mx5: Replace clk_register_clkdev with clock DT lookup
In-Reply-To: <1353350425-1075-1-git-send-email-fabio.estevam@freescale.com>
References: <1353350425-1075-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121120152836.GM10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 04:40:25PM -0200, Fabio Estevam wrote:
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  .../devicetree/bindings/clock/imx5-clock.txt       |  197 ++++++++++++++++++++
>  arch/arm/boot/dts/imx51.dtsi                       |   39 ++++
>  arch/arm/boot/dts/imx53.dtsi                       |   48 +++++
>  arch/arm/mach-imx/clk-imx51-imx53.c                |   26 +--
>  arch/arm/mach-imx/imx51-dt.c                       |   28 +--
>  arch/arm/mach-imx/mach-imx53.c                     |   31 +--
>  6 files changed, 299 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
> new file mode 100644
> index 0000000..a6fb29e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
> @@ -0,0 +1,197 @@
> +* Clock bindings for Freescale i.MX5
> +
> +Required properties:
> +- compatible: Should be "fsl,<soc>-ccm" , where <soc> can be mx51 or mx53

s/mx51/imx51/
s/mx53/iMX53/

> +	epit2_hf_gate		165
> +	can_sel			166
> +	can1_serial_gate	167
> +	can1_ipg_gate		168
> +	clk_max			169
> +	uart4_ipg_gate		170
> +	uart4_per_gate		171
> +	uart5_ipg_gate		172
> +	uart5_per_gate		173
> +	cspi_per_gate		174

What has happened here? clk_max should be the last clock. The addtional
gates are duplicates of other clocks. They are also referenced in the
devicetree. clk_max can be removed from the list, it's not a clock but
only a number used internally in the clock code.

I gave it a test on i.MX53. Here is a fixup needed to make the ESDHCs
work on i.MX53, otherwise it seems to work well.

I can test it on i.MX51 aswell, but haven't done yet.

Sascha


8<-------------------------------------------------

>From 7b1c7a6a25cd3c52cf0eedfe49eb7592bed2fdc9 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Nov 2012 16:22:46 +0100
Subject: [PATCH] fixup! ARM: mx5: Replace clk_register_clkdev with clock DT
 lookup

---
 arch/arm/boot/dts/imx51.dtsi |    8 ++++----
 arch/arm/boot/dts/imx53.dtsi |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fa8b2c0..397502e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -80,7 +80,7 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70004000 0x4000>;
 					interrupts = <1>;
-					clocks = <&clks 44>, <&clks 44>, <&clks 44>;
+					clocks = <&clks 44>, <&clks 0>, <&clks 71>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
@@ -89,7 +89,7 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70008000 0x4000>;
 					interrupts = <2>;
-					clocks = <&clks 45>, <&clks 45>, <&clks 45>;
+					clocks = <&clks 45>, <&clks 0>, <&clks 72>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
@@ -128,7 +128,7 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70020000 0x4000>;
 					interrupts = <3>;
-					clocks = <&clks 46>, <&clks 46>, <&clks 46>;
+					clocks = <&clks 46>, <&clks 0>, <&clks 73>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
@@ -137,7 +137,7 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70024000 0x4000>;
 					interrupts = <4>;
-					clocks = <&clks 47>, <&clks 47>, <&clks 47>;
+					clocks = <&clks 47>, <&clks 0>, <&clks 74>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 8c71004..6a97862 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -85,7 +85,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
-					clocks = <&clks 44>, <&clks 44>, <&clks 44>;
+					clocks = <&clks 44>, <&clks 0>, <&clks 71>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
@@ -94,7 +94,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
-					clocks = <&clks 45>, <&clks 45>, <&clks 45>;
+					clocks = <&clks 45>, <&clks 0>, <&clks 72>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
@@ -133,7 +133,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
-					clocks = <&clks 46>, <&clks 46>, <&clks 46>;
+					clocks = <&clks 46>, <&clks 0>, <&clks 73>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
@@ -142,7 +142,7 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
-					clocks = <&clks 47>, <&clks 47>, <&clks 47>;
+					clocks = <&clks 47>, <&clks 0>, <&clks 74>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
-- 
1.7.10.4


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
