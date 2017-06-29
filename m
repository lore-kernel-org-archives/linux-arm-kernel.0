From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 29 Jun 2017 11:57:05 +0100
Subject: [linux-sunxi] [PATCH v4 5/6] ARM: sun7i: Convert to CCU
In-Reply-To: <ac9cc7f0a67d3e9e5edd0d5eb21cc60820c2b457.1498422562.git-series.plaes@plaes.org>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
 <ac9cc7f0a67d3e9e5edd0d5eb21cc60820c2b457.1498422562.git-series.plaes@plaes.org>
Message-ID: <a08cbe0d-dad4-7d0c-9845-452e0d6e3f03@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/06/17 21:45, Priit Laes wrote:
> Convert sun7i-a20.dtsi to new CCU driver.

I know that some people hat^Wget annoyed by me asking this, but anyway:

Why do we actually need this?

This ultimately makes the DT incompatible with older kernels (as
actually shipped by distros today).
So if we for instance use UEFI boot or otherwise just use "one golden
DT" to drive all kernels (like using the DT from U-Boot), we now don't
have one good DT that fits all. This is really a showstopper for boards
which ship a DT in firmware (in SPI flash, for instance, or on some eMMC).
So:
- Do we actually need to change the .dtsi? The old .dtsi should still work.
- Is there anything that the new and fancy clocks gives us over the
existing clocks? If yes, that should be a  stated in the commit message
or cover letter.
- Why do we change the clocks for those older SoCs in the first place?
Can't we just keep on using what worked for years? I think we really
can't remove the old code anyway.

The new clock driver moves information from the DT into the kernel. That
means it is no longer available for a DT consumer and the SoC details
(which clocks is located where, for instance), have to be replicated to
other DT users (U-Boot, *BSD, you-name-it). We already came across this
issue when looking at converting U-Boot over to use DT clocks.
Also it ultimately requires kernel changes for each new SoC, even if it
only differs in some detail which could be perfectly modelled in DT
(think of H3 vs. H5).

Cheers,
Andre.

> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 719 +++-----------------------------
>  1 file changed, 84 insertions(+), 635 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 96bee77..a5ca5a8 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -46,8 +46,6 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> -
> -#include <dt-bindings/clock/sun4i-a10-pll2.h>
>  #include <dt-bindings/dma/sun4i-a10.h>
>  
>  / {
> @@ -66,9 +64,10 @@
>  			compatible = "allwinner,simple-framebuffer",
>  				     "simple-framebuffer";
>  			allwinner,pipeline = "de_be0-lcd0-hdmi";
> -			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
> -				 <&ahb_gates 44>, <&de_be0_clk>,
> -				 <&tcon0_ch1_clk>, <&dram_gates 26>;
> +			clocks = <&ccu 56>, <&ccu 60>,
> +				 <&ccu 62>, <&ccu 144>,
> +				 <&ccu 155>, <&ccu 140>,
> +				 <&ccu 164>;
>  			status = "disabled";
>  		};
>  
> @@ -76,9 +75,9 @@
>  			compatible = "allwinner,simple-framebuffer",
>  				     "simple-framebuffer";
>  			allwinner,pipeline = "de_be0-lcd0";
> -			clocks = <&ahb_gates 36>, <&ahb_gates 44>,
> -				 <&de_be0_clk>, <&tcon0_ch0_clk>,
> -				 <&dram_gates 26>;
> +			clocks = <&ccu 56>, <&ccu 62>,
> +				 <&ccu 144>, <&ccu 149>,
> +				 <&ccu 140>;
>  			status = "disabled";
>  		};
>  
> @@ -86,10 +85,10 @@
>  			compatible = "allwinner,simple-framebuffer",
>  				     "simple-framebuffer";
>  			allwinner,pipeline = "de_be0-lcd0-tve0";
> -			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
> -				 <&ahb_gates 44>,
> -				 <&de_be0_clk>, <&tcon0_ch1_clk>,
> -				 <&dram_gates 5>, <&dram_gates 26>;
> +			clocks = <&ccu 54>, <&ccu 56>,
> +				 <&ccu 62>,
> +				 <&ccu 144>, <&ccu 155>,
> +				 <&ccu 135>, <&ccu 140>;
>  			status = "disabled";
>  		};
>  	};
> @@ -102,7 +101,7 @@
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <0>;
> -			clocks = <&cpu>;
> +			clocks = <&ccu 20>;
>  			clock-latency = <244144>; /* 8 32k periods */
>  			operating-points = <
>  				/* kHz	  uV */
> @@ -183,21 +182,11 @@
>  
>  		osc24M: clk at 01c20050 {
>  			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-osc-clk";
> -			reg = <0x01c20050 0x4>;
> +			compatible = "fixed-clock";
>  			clock-frequency = <24000000>;
>  			clock-output-names = "osc24M";
>  		};
>  
> -		osc3M: osc3M_clk {
> -			#clock-cells = <0>;
> -			compatible = "fixed-factor-clock";
> -			clock-div = <8>;
> -			clock-mult = <1>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "osc3M";
> -		};
> -
>  		osc32k: clk at 0 {
>  			#clock-cells = <0>;
>  			compatible = "fixed-clock";
> @@ -205,528 +194,6 @@
>  			clock-output-names = "osc32k";
>  		};
>  
> -		pll1: clk at 01c20000 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-pll1-clk";
> -			reg = <0x01c20000 0x4>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "pll1";
> -		};
> -
> -		pll2: clk at 01c20008 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-pll2-clk";
> -			reg = <0x01c20008 0x8>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "pll2-1x", "pll2-2x",
> -					     "pll2-4x", "pll2-8x";
> -		};
> -
> -		pll3: clk at 01c20010 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-pll3-clk";
> -			reg = <0x01c20010 0x4>;
> -			clocks = <&osc3M>;
> -			clock-output-names = "pll3";
> -		};
> -
> -		pll3x2: pll3x2_clk {
> -			#clock-cells = <0>;
> -			compatible = "fixed-factor-clock";
> -			clocks = <&pll3>;
> -			clock-div = <1>;
> -			clock-mult = <2>;
> -			clock-output-names = "pll3-2x";
> -		};
> -
> -		pll4: clk at 01c20018 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun7i-a20-pll4-clk";
> -			reg = <0x01c20018 0x4>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "pll4";
> -		};
> -
> -		pll5: clk at 01c20020 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-pll5-clk";
> -			reg = <0x01c20020 0x4>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "pll5_ddr", "pll5_other";
> -		};
> -
> -		pll6: clk at 01c20028 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-pll6-clk";
> -			reg = <0x01c20028 0x4>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "pll6_sata", "pll6_other", "pll6",
> -					     "pll6_div_4";
> -		};
> -
> -		pll7: clk at 01c20030 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-pll3-clk";
> -			reg = <0x01c20030 0x4>;
> -			clocks = <&osc3M>;
> -			clock-output-names = "pll7";
> -		};
> -
> -		pll7x2: pll7x2_clk {
> -			#clock-cells = <0>;
> -			compatible = "fixed-factor-clock";
> -			clocks = <&pll7>;
> -			clock-div = <1>;
> -			clock-mult = <2>;
> -			clock-output-names = "pll7-2x";
> -		};
> -
> -		pll8: clk at 01c20040 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun7i-a20-pll4-clk";
> -			reg = <0x01c20040 0x4>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "pll8";
> -		};
> -
> -		cpu: cpu at 01c20054 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-cpu-clk";
> -			reg = <0x01c20054 0x4>;
> -			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll6 1>;
> -			clock-output-names = "cpu";
> -		};
> -
> -		axi: axi at 01c20054 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-axi-clk";
> -			reg = <0x01c20054 0x4>;
> -			clocks = <&cpu>;
> -			clock-output-names = "axi";
> -		};
> -
> -		ahb: ahb at 01c20054 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun5i-a13-ahb-clk";
> -			reg = <0x01c20054 0x4>;
> -			clocks = <&axi>, <&pll6 3>, <&pll6 1>;
> -			clock-output-names = "ahb";
> -			/*
> -			 * Use PLL6 as parent, instead of CPU/AXI
> -			 * which has rate changes due to cpufreq
> -			 */
> -			assigned-clocks = <&ahb>;
> -			assigned-clock-parents = <&pll6 3>;
> -		};
> -
> -		ahb_gates: clk at 01c20060 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun7i-a20-ahb-gates-clk";
> -			reg = <0x01c20060 0x8>;
> -			clocks = <&ahb>;
> -			clock-indices = <0>, <1>,
> -					<2>, <3>, <4>,
> -					<5>, <6>, <7>, <8>,
> -					<9>, <10>, <11>, <12>,
> -					<13>, <14>, <16>,
> -					<17>, <18>, <20>, <21>,
> -					<22>, <23>, <25>,
> -					<28>, <32>, <33>, <34>,
> -					<35>, <36>, <37>, <40>,
> -					<41>, <42>, <43>,
> -					<44>, <45>, <46>,
> -					<47>, <49>, <50>,
> -					<52>;
> -			clock-output-names = "ahb_usb0", "ahb_ehci0",
> -				"ahb_ohci0", "ahb_ehci1", "ahb_ohci1",
> -				"ahb_ss", "ahb_dma", "ahb_bist", "ahb_mmc0",
> -				"ahb_mmc1", "ahb_mmc2", "ahb_mmc3", "ahb_ms",
> -				"ahb_nand", "ahb_sdram", "ahb_ace",
> -				"ahb_emac", "ahb_ts", "ahb_spi0", "ahb_spi1",
> -				"ahb_spi2", "ahb_spi3", "ahb_sata",
> -				"ahb_hstimer", "ahb_ve", "ahb_tvd", "ahb_tve0",
> -				"ahb_tve1", "ahb_lcd0", "ahb_lcd1", "ahb_csi0",
> -				"ahb_csi1", "ahb_hdmi1", "ahb_hdmi0",
> -				"ahb_de_be0", "ahb_de_be1", "ahb_de_fe0",
> -				"ahb_de_fe1", "ahb_gmac", "ahb_mp",
> -				"ahb_mali";
> -		};
> -
> -		apb0: apb0 at 01c20054 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-apb0-clk";
> -			reg = <0x01c20054 0x4>;
> -			clocks = <&ahb>;
> -			clock-output-names = "apb0";
> -		};
> -
> -		apb0_gates: clk at 01c20068 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun7i-a20-apb0-gates-clk";
> -			reg = <0x01c20068 0x4>;
> -			clocks = <&apb0>;
> -			clock-indices = <0>, <1>,
> -					<2>, <3>, <4>,
> -					<5>, <6>, <7>,
> -					<8>, <10>;
> -			clock-output-names = "apb0_codec", "apb0_spdif",
> -				"apb0_ac97", "apb0_i2s0", "apb0_i2s1",
> -				"apb0_pio", "apb0_ir0", "apb0_ir1",
> -				"apb0_i2s2", "apb0_keypad";
> -		};
> -
> -		apb1: clk at 01c20058 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-apb1-clk";
> -			reg = <0x01c20058 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
> -			clock-output-names = "apb1";
> -		};
> -
> -		apb1_gates: clk at 01c2006c {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun7i-a20-apb1-gates-clk";
> -			reg = <0x01c2006c 0x4>;
> -			clocks = <&apb1>;
> -			clock-indices = <0>, <1>,
> -					<2>, <3>, <4>,
> -					<5>, <6>, <7>,
> -					<15>, <16>, <17>,
> -					<18>, <19>, <20>,
> -					<21>, <22>, <23>;
> -			clock-output-names = "apb1_i2c0", "apb1_i2c1",
> -				"apb1_i2c2", "apb1_i2c3", "apb1_can",
> -				"apb1_scr", "apb1_ps20", "apb1_ps21",
> -				"apb1_i2c4", "apb1_uart0", "apb1_uart1",
> -				"apb1_uart2", "apb1_uart3", "apb1_uart4",
> -				"apb1_uart5", "apb1_uart6", "apb1_uart7";
> -		};
> -
> -		nand_clk: clk at 01c20080 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c20080 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "nand";
> -		};
> -
> -		ms_clk: clk at 01c20084 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c20084 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "ms";
> -		};
> -
> -		mmc0_clk: clk at 01c20088 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-mmc-clk";
> -			reg = <0x01c20088 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "mmc0",
> -					     "mmc0_output",
> -					     "mmc0_sample";
> -		};
> -
> -		mmc1_clk: clk at 01c2008c {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-mmc-clk";
> -			reg = <0x01c2008c 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "mmc1",
> -					     "mmc1_output",
> -					     "mmc1_sample";
> -		};
> -
> -		mmc2_clk: clk at 01c20090 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-mmc-clk";
> -			reg = <0x01c20090 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "mmc2",
> -					     "mmc2_output",
> -					     "mmc2_sample";
> -		};
> -
> -		mmc3_clk: clk at 01c20094 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-mmc-clk";
> -			reg = <0x01c20094 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "mmc3",
> -					     "mmc3_output",
> -					     "mmc3_sample";
> -		};
> -
> -		ts_clk: clk at 01c20098 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c20098 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "ts";
> -		};
> -
> -		ss_clk: clk at 01c2009c {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c2009c 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "ss";
> -		};
> -
> -		spi0_clk: clk at 01c200a0 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200a0 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "spi0";
> -		};
> -
> -		spi1_clk: clk at 01c200a4 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200a4 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "spi1";
> -		};
> -
> -		spi2_clk: clk at 01c200a8 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200a8 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "spi2";
> -		};
> -
> -		pata_clk: clk at 01c200ac {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200ac 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "pata";
> -		};
> -
> -		ir0_clk: clk at 01c200b0 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200b0 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "ir0";
> -		};
> -
> -		ir1_clk: clk at 01c200b4 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200b4 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "ir1";
> -		};
> -
> -		i2s0_clk: clk at 01c200b8 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod1-clk";
> -			reg = <0x01c200b8 0x4>;
> -			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
> -				 <&pll2 SUN4I_A10_PLL2_4X>,
> -				 <&pll2 SUN4I_A10_PLL2_2X>,
> -				 <&pll2 SUN4I_A10_PLL2_1X>;
> -			clock-output-names = "i2s0";
> -		};
> -
> -		ac97_clk: clk at 01c200bc {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod1-clk";
> -			reg = <0x01c200bc 0x4>;
> -			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
> -				 <&pll2 SUN4I_A10_PLL2_4X>,
> -				 <&pll2 SUN4I_A10_PLL2_2X>,
> -				 <&pll2 SUN4I_A10_PLL2_1X>;
> -			clock-output-names = "ac97";
> -		};
> -
> -		spdif_clk: clk at 01c200c0 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod1-clk";
> -			reg = <0x01c200c0 0x4>;
> -			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
> -				 <&pll2 SUN4I_A10_PLL2_4X>,
> -				 <&pll2 SUN4I_A10_PLL2_2X>,
> -				 <&pll2 SUN4I_A10_PLL2_1X>;
> -			clock-output-names = "spdif";
> -		};
> -
> -		keypad_clk: clk at 01c200c4 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200c4 0x4>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "keypad";
> -		};
> -
> -		usb_clk: clk at 01c200cc {
> -			#clock-cells = <1>;
> -			#reset-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-usb-clk";
> -			reg = <0x01c200cc 0x4>;
> -			clocks = <&pll6 1>;
> -			clock-output-names = "usb_ohci0", "usb_ohci1",
> -					     "usb_phy";
> -		};
> -
> -		spi3_clk: clk at 01c200d4 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod0-clk";
> -			reg = <0x01c200d4 0x4>;
> -			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> -			clock-output-names = "spi3";
> -		};
> -
> -		i2s1_clk: clk at 01c200d8 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod1-clk";
> -			reg = <0x01c200d8 0x4>;
> -			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
> -				 <&pll2 SUN4I_A10_PLL2_4X>,
> -				 <&pll2 SUN4I_A10_PLL2_2X>,
> -				 <&pll2 SUN4I_A10_PLL2_1X>;
> -			clock-output-names = "i2s1";
> -		};
> -
> -		i2s2_clk: clk at 01c200dc {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-mod1-clk";
> -			reg = <0x01c200dc 0x4>;
> -			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
> -				 <&pll2 SUN4I_A10_PLL2_4X>,
> -				 <&pll2 SUN4I_A10_PLL2_2X>,
> -				 <&pll2 SUN4I_A10_PLL2_1X>;
> -			clock-output-names = "i2s2";
> -		};
> -
> -		dram_gates: clk at 01c20100 {
> -			#clock-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-dram-gates-clk";
> -			reg = <0x01c20100 0x4>;
> -			clocks = <&pll5 0>;
> -			clock-indices = <0>,
> -					<1>, <2>,
> -					<3>,
> -					<4>,
> -					<5>, <6>,
> -					<15>,
> -					<24>, <25>,
> -					<26>, <27>,
> -					<28>, <29>;
> -			clock-output-names = "dram_ve",
> -					     "dram_csi0", "dram_csi1",
> -					     "dram_ts",
> -					     "dram_tvd",
> -					     "dram_tve0", "dram_tve1",
> -					     "dram_output",
> -					     "dram_de_fe1", "dram_de_fe0",
> -					     "dram_de_be0", "dram_de_be1",
> -					     "dram_de_mp", "dram_ace";
> -		};
> -
> -		de_be0_clk: clk at 01c20104 {
> -			#clock-cells = <0>;
> -			#reset-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-display-clk";
> -			reg = <0x01c20104 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll5 1>;
> -			clock-output-names = "de-be0";
> -		};
> -
> -		de_be1_clk: clk at 01c20108 {
> -			#clock-cells = <0>;
> -			#reset-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-display-clk";
> -			reg = <0x01c20108 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll5 1>;
> -			clock-output-names = "de-be1";
> -		};
> -
> -		de_fe0_clk: clk at 01c2010c {
> -			#clock-cells = <0>;
> -			#reset-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-display-clk";
> -			reg = <0x01c2010c 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll5 1>;
> -			clock-output-names = "de-fe0";
> -		};
> -
> -		de_fe1_clk: clk at 01c20110 {
> -			#clock-cells = <0>;
> -			#reset-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-display-clk";
> -			reg = <0x01c20110 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll5 1>;
> -			clock-output-names = "de-fe1";
> -		};
> -
> -		tcon0_ch0_clk: clk at 01c20118 {
> -			#clock-cells = <0>;
> -			#reset-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
> -			reg = <0x01c20118 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> -			clock-output-names = "tcon0-ch0-sclk";
> -
> -		};
> -
> -		tcon1_ch0_clk: clk at 01c2011c {
> -			#clock-cells = <0>;
> -			#reset-cells = <1>;
> -			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> -			reg = <0x01c2011c 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> -			clock-output-names = "tcon1-ch0-sclk";
> -
> -		};
> -
> -		tcon0_ch1_clk: clk at 01c2012c {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
> -			reg = <0x01c2012c 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> -			clock-output-names = "tcon0-ch1-sclk";
> -
> -		};
> -
> -		tcon1_ch1_clk: clk at 01c20130 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> -			reg = <0x01c20130 0x4>;
> -			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> -			clock-output-names = "tcon1-ch1-sclk";
> -
> -		};
> -
> -		ve_clk: clk at 01c2013c {
> -			#clock-cells = <0>;
> -			#reset-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-ve-clk";
> -			reg = <0x01c2013c 0x4>;
> -			clocks = <&pll4>;
> -			clock-output-names = "ve";
> -		};
> -
> -		codec_clk: clk at 01c20140 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun4i-a10-codec-clk";
> -			reg = <0x01c20140 0x4>;
> -			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
> -			clock-output-names = "codec";
> -		};
> -
> -		mbus_clk: clk at 01c2015c {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun5i-a13-mbus-clk";
> -			reg = <0x01c2015c 0x4>;
> -			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
> -			clock-output-names = "mbus";
> -		};
> -
>  		/*
>  		 * The following two are dummy clocks, placeholders
>  		 * used in the gmac_tx clock. The gmac driver will
> @@ -736,14 +203,14 @@
>  		 * The actual TX clock rate is not controlled by the
>  		 * gmac_tx clock.
>  		 */
> -		mii_phy_tx_clk: clk at 2 {
> +		mii_phy_tx_clk: clk at 1 {
>  			#clock-cells = <0>;
>  			compatible = "fixed-clock";
>  			clock-frequency = <25000000>;
>  			clock-output-names = "mii_phy_tx";
>  		};
>  
> -		gmac_int_tx_clk: clk at 3 {
> +		gmac_int_tx_clk: clk at 2 {
>  			#clock-cells = <0>;
>  			compatible = "fixed-clock";
>  			clock-frequency = <125000000>;
> @@ -757,34 +224,6 @@
>  			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
>  			clock-output-names = "gmac_tx";
>  		};
> -
> -		/*
> -		 * Dummy clock used by output clocks
> -		 */
> -		osc24M_32k: clk at 1 {
> -			#clock-cells = <0>;
> -			compatible = "fixed-factor-clock";
> -			clock-div = <750>;
> -			clock-mult = <1>;
> -			clocks = <&osc24M>;
> -			clock-output-names = "osc24M_32k";
> -		};
> -
> -		clk_out_a: clk at 01c201f0 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun7i-a20-out-clk";
> -			reg = <0x01c201f0 0x4>;
> -			clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
> -			clock-output-names = "clk_out_a";
> -		};
> -
> -		clk_out_b: clk at 01c201f4 {
> -			#clock-cells = <0>;
> -			compatible = "allwinner,sun7i-a20-out-clk";
> -			reg = <0x01c201f4 0x4>;
> -			clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
> -			clock-output-names = "clk_out_b";
> -		};
>  	};
>  
>  	soc at 01c00000 {
> @@ -841,7 +280,7 @@
>  			compatible = "allwinner,sun4i-a10-dma";
>  			reg = <0x01c02000 0x1000>;
>  			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 6>;
> +			clocks = <&ccu 32>;
>  			#dma-cells = <2>;
>  		};
>  
> @@ -849,7 +288,7 @@
>  			compatible = "allwinner,sun4i-a10-nand";
>  			reg = <0x01c03000 0x1000>;
>  			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 13>, <&nand_clk>;
> +			clocks = <&ccu 39>, <&ccu 96>;
>  			clock-names = "ahb", "mod";
>  			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
>  			dma-names = "rxtx";
> @@ -862,7 +301,7 @@
>  			compatible = "allwinner,sun4i-a10-spi";
>  			reg = <0x01c05000 0x1000>;
>  			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 20>, <&spi0_clk>;
> +			clocks = <&ccu 44>, <&ccu 112>;
>  			clock-names = "ahb", "mod";
>  			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
>  			       <&dma SUN4I_DMA_DEDICATED 26>;
> @@ -877,7 +316,7 @@
>  			compatible = "allwinner,sun4i-a10-spi";
>  			reg = <0x01c06000 0x1000>;
>  			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 21>, <&spi1_clk>;
> +			clocks = <&ccu 45>, <&ccu 113>;
>  			clock-names = "ahb", "mod";
>  			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
>  			       <&dma SUN4I_DMA_DEDICATED 8>;
> @@ -892,7 +331,7 @@
>  			compatible = "allwinner,sun4i-a10-emac";
>  			reg = <0x01c0b000 0x1000>;
>  			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 17>;
> +			clocks = <&ccu 42>;
>  			allwinner,sram = <&emac_sram 1>;
>  			status = "disabled";
>  		};
> @@ -908,10 +347,10 @@
>  		mmc0: mmc at 01c0f000 {
>  			compatible = "allwinner,sun7i-a20-mmc";
>  			reg = <0x01c0f000 0x1000>;
> -			clocks = <&ahb_gates 8>,
> -				 <&mmc0_clk 0>,
> -				 <&mmc0_clk 1>,
> -				 <&mmc0_clk 2>;
> +			clocks = <&ccu 34>,
> +				 <&ccu 98>,
> +				 <&ccu 99>,
> +				 <&ccu 100>;
>  			clock-names = "ahb",
>  				      "mmc",
>  				      "output",
> @@ -925,10 +364,10 @@
>  		mmc1: mmc at 01c10000 {
>  			compatible = "allwinner,sun7i-a20-mmc";
>  			reg = <0x01c10000 0x1000>;
> -			clocks = <&ahb_gates 9>,
> -				 <&mmc1_clk 0>,
> -				 <&mmc1_clk 1>,
> -				 <&mmc1_clk 2>;
> +			clocks = <&ccu 35>,
> +				 <&ccu 101>,
> +				 <&ccu 102>,
> +				 <&ccu 103>;
>  			clock-names = "ahb",
>  				      "mmc",
>  				      "output",
> @@ -942,10 +381,10 @@
>  		mmc2: mmc at 01c11000 {
>  			compatible = "allwinner,sun7i-a20-mmc";
>  			reg = <0x01c11000 0x1000>;
> -			clocks = <&ahb_gates 10>,
> -				 <&mmc2_clk 0>,
> -				 <&mmc2_clk 1>,
> -				 <&mmc2_clk 2>;
> +			clocks = <&ccu 36>,
> +				 <&ccu 104>,
> +				 <&ccu 105>,
> +				 <&ccu 106>;
>  			clock-names = "ahb",
>  				      "mmc",
>  				      "output",
> @@ -959,10 +398,10 @@
>  		mmc3: mmc at 01c12000 {
>  			compatible = "allwinner,sun7i-a20-mmc";
>  			reg = <0x01c12000 0x1000>;
> -			clocks = <&ahb_gates 11>,
> -				 <&mmc3_clk 0>,
> -				 <&mmc3_clk 1>,
> -				 <&mmc3_clk 2>;
> +			clocks = <&ccu 37>,
> +				 <&ccu 107>,
> +				 <&ccu 108>,
> +				 <&ccu 109>;
>  			clock-names = "ahb",
>  				      "mmc",
>  				      "output",
> @@ -976,7 +415,7 @@
>  		usb_otg: usb at 01c13000 {
>  			compatible = "allwinner,sun4i-a10-musb";
>  			reg = <0x01c13000 0x0400>;
> -			clocks = <&ahb_gates 0>;
> +			clocks = <&ccu 26>;
>  			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "mc";
>  			phys = <&usbphy 0>;
> @@ -991,9 +430,11 @@
>  			compatible = "allwinner,sun7i-a20-usb-phy";
>  			reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
>  			reg-names = "phy_ctrl", "pmu1", "pmu2";
> -			clocks = <&usb_clk 8>;
> +			clocks = <&ccu 125>;
>  			clock-names = "usb_phy";
> -			resets = <&usb_clk 0>, <&usb_clk 1>, <&usb_clk 2>;
> +			resets = <&ccu 1>,
> +				 <&ccu 2>,
> +				 <&ccu 3>;
>  			reset-names = "usb0_reset", "usb1_reset", "usb2_reset";
>  			status = "disabled";
>  		};
> @@ -1002,7 +443,7 @@
>  			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
>  			reg = <0x01c14000 0x100>;
>  			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 1>;
> +			clocks = <&ccu 27>;
>  			phys = <&usbphy 1>;
>  			phy-names = "usb";
>  			status = "disabled";
> @@ -1012,7 +453,7 @@
>  			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
>  			reg = <0x01c14400 0x100>;
>  			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&usb_clk 6>, <&ahb_gates 2>;
> +			clocks = <&ccu 123>, <&ccu 28>;
>  			phys = <&usbphy 1>;
>  			phy-names = "usb";
>  			status = "disabled";
> @@ -1023,7 +464,7 @@
>  				     "allwinner,sun4i-a10-crypto";
>  			reg = <0x01c15000 0x1000>;
>  			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 5>, <&ss_clk>;
> +			clocks = <&ccu 31>, <&ccu 111>;
>  			clock-names = "ahb", "mod";
>  		};
>  
> @@ -1031,7 +472,7 @@
>  			compatible = "allwinner,sun4i-a10-spi";
>  			reg = <0x01c17000 0x1000>;
>  			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 22>, <&spi2_clk>;
> +			clocks = <&ccu 46>, <&ccu 114>;
>  			clock-names = "ahb", "mod";
>  			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
>  			       <&dma SUN4I_DMA_DEDICATED 28>;
> @@ -1046,7 +487,7 @@
>  			compatible = "allwinner,sun4i-a10-ahci";
>  			reg = <0x01c18000 0x1000>;
>  			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&pll6 0>, <&ahb_gates 25>;
> +			clocks = <&ccu 49>, <&ccu 122>;
>  			status = "disabled";
>  		};
>  
> @@ -1054,7 +495,7 @@
>  			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
>  			reg = <0x01c1c000 0x100>;
>  			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 3>;
> +			clocks = <&ccu 29>;
>  			phys = <&usbphy 2>;
>  			phy-names = "usb";
>  			status = "disabled";
> @@ -1064,7 +505,7 @@
>  			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
>  			reg = <0x01c1c400 0x100>;
>  			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&usb_clk 7>, <&ahb_gates 4>;
> +			clocks = <&ccu 124>, <&ccu 30>;
>  			phys = <&usbphy 2>;
>  			phy-names = "usb";
>  			status = "disabled";
> @@ -1074,7 +515,7 @@
>  			compatible = "allwinner,sun4i-a10-spi";
>  			reg = <0x01c1f000 0x1000>;
>  			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 23>, <&spi3_clk>;
> +			clocks = <&ccu 47>, <&ccu 127>;
>  			clock-names = "ahb", "mod";
>  			dmas = <&dma SUN4I_DMA_DEDICATED 31>,
>  			       <&dma SUN4I_DMA_DEDICATED 30>;
> @@ -1085,11 +526,20 @@
>  			num-cs = <1>;
>  		};
>  
> +		ccu: clock at 01c20000 {
> +			compatible = "allwinner,sun7i-a20-ccu";
> +			reg = <0x01c20000 0x400>;
> +			clocks = <&osc24M>, <&osc32k>;
> +			clock-names = "hosc", "losc";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
>  		pio: pinctrl at 01c20800 {
>  			compatible = "allwinner,sun7i-a20-pinctrl";
>  			reg = <0x01c20800 0x400>;
>  			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb0_gates 5>, <&osc24M>, <&osc32k>;
> +			clocks = <&ccu 74>, <&osc24M>, <&osc32k>;
>  			clock-names = "apb", "hosc", "losc";
>  			gpio-controller;
>  			interrupt-controller;
> @@ -1360,7 +810,7 @@
>  			compatible = "allwinner,sun4i-a10-spdif";
>  			reg = <0x01c21000 0x400>;
>  			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb0_gates 1>, <&spdif_clk>;
> +			clocks = <&ccu 70>, <&ccu 120>;
>  			clock-names = "apb", "spdif";
>  			dmas = <&dma SUN4I_DMA_NORMAL 2>,
>  			       <&dma SUN4I_DMA_NORMAL 2>;
> @@ -1370,7 +820,7 @@
>  
>  		ir0: ir at 01c21800 {
>  			compatible = "allwinner,sun4i-a10-ir";
> -			clocks = <&apb0_gates 6>, <&ir0_clk>;
> +			clocks = <&ccu 75>, <&ccu 116>;
>  			clock-names = "apb", "ir";
>  			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  			reg = <0x01c21800 0x40>;
> @@ -1379,7 +829,7 @@
>  
>  		ir1: ir at 01c21c00 {
>  			compatible = "allwinner,sun4i-a10-ir";
> -			clocks = <&apb0_gates 7>, <&ir1_clk>;
> +			clocks = <&ccu 76>, <&ccu 117>;
>  			clock-names = "apb", "ir";
>  			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>  			reg = <0x01c21c00 0x40>;
> @@ -1391,7 +841,7 @@
>  			compatible = "allwinner,sun4i-a10-i2s";
>  			reg = <0x01c22000 0x400>;
>  			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb0_gates 4>, <&i2s1_clk>;
> +			clocks = <&ccu 73>, <&ccu 128>;
>  			clock-names = "apb", "mod";
>  			dmas = <&dma SUN4I_DMA_NORMAL 4>,
>  			       <&dma SUN4I_DMA_NORMAL 4>;
> @@ -1404,7 +854,7 @@
>  			compatible = "allwinner,sun4i-a10-i2s";
>  			reg = <0x01c22400 0x400>;
>  			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb0_gates 3>, <&i2s0_clk>;
> +			clocks = <&ccu 71>, <&ccu 118>;
>  			clock-names = "apb", "mod";
>  			dmas = <&dma SUN4I_DMA_NORMAL 3>,
>  			       <&dma SUN4I_DMA_NORMAL 3>;
> @@ -1424,7 +874,7 @@
>  			compatible = "allwinner,sun7i-a20-codec";
>  			reg = <0x01c22c00 0x40>;
>  			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb0_gates 0>, <&codec_clk>;
> +			clocks = <&ccu 69>, <&ccu 160>;
>  			clock-names = "apb", "codec";
>  			dmas = <&dma SUN4I_DMA_NORMAL 19>,
>  			       <&dma SUN4I_DMA_NORMAL 19>;
> @@ -1442,7 +892,7 @@
>  			compatible = "allwinner,sun4i-a10-i2s";
>  			reg = <0x01c24400 0x400>;
>  			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb0_gates 8>, <&i2s2_clk>;
> +			clocks = <&ccu 77>, <&ccu 129>;
>  			clock-names = "apb", "mod";
>  			dmas = <&dma SUN4I_DMA_NORMAL 6>,
>  			       <&dma SUN4I_DMA_NORMAL 6>;
> @@ -1463,7 +913,7 @@
>  			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 16>;
> +			clocks = <&ccu 88>;
>  			status = "disabled";
>  		};
>  
> @@ -1473,7 +923,7 @@
>  			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 17>;
> +			clocks = <&ccu 89>;
>  			status = "disabled";
>  		};
>  
> @@ -1483,7 +933,7 @@
>  			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 18>;
> +			clocks = <&ccu 90>;
>  			status = "disabled";
>  		};
>  
> @@ -1493,7 +943,7 @@
>  			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 19>;
> +			clocks = <&ccu 91>;
>  			status = "disabled";
>  		};
>  
> @@ -1503,7 +953,7 @@
>  			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 20>;
> +			clocks = <&ccu 92>;
>  			status = "disabled";
>  		};
>  
> @@ -1513,7 +963,7 @@
>  			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 21>;
> +			clocks = <&ccu 93>;
>  			status = "disabled";
>  		};
>  
> @@ -1523,7 +973,7 @@
>  			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 22>;
> +			clocks = <&ccu 94>;
>  			status = "disabled";
>  		};
>  
> @@ -1533,7 +983,7 @@
>  			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -			clocks = <&apb1_gates 23>;
> +			clocks = <&ccu 95>;
>  			status = "disabled";
>  		};
>  
> @@ -1541,7 +991,7 @@
>  			compatible = "allwinner,sun4i-a10-ps2";
>  			reg = <0x01c2a000 0x400>;
>  			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 6>;
> +			clocks = <&ccu 85>;
>  			status = "disabled";
>  		};
>  
> @@ -1549,7 +999,7 @@
>  			compatible = "allwinner,sun4i-a10-ps2";
>  			reg = <0x01c2a400 0x400>;
>  			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 7>;
> +			clocks = <&ccu 86>;
>  			status = "disabled";
>  		};
>  
> @@ -1558,7 +1008,7 @@
>  				     "allwinner,sun4i-a10-i2c";
>  			reg = <0x01c2ac00 0x400>;
>  			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 0>;
> +			clocks = <&ccu 79>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1569,7 +1019,7 @@
>  				     "allwinner,sun4i-a10-i2c";
>  			reg = <0x01c2b000 0x400>;
>  			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 1>;
> +			clocks = <&ccu 80>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1580,7 +1030,7 @@
>  				     "allwinner,sun4i-a10-i2c";
>  			reg = <0x01c2b400 0x400>;
>  			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 2>;
> +			clocks = <&ccu 81>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1591,7 +1041,7 @@
>  				     "allwinner,sun4i-a10-i2c";
>  			reg = <0x01c2b800 0x400>;
>  			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 3>;
> +			clocks = <&ccu 82>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1602,7 +1052,7 @@
>  				     "allwinner,sun4i-a10-can";
>  			reg = <0x01c2bc00 0x400>;
>  			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 4>;
> +			clocks = <&ccu 83>;
>  			status = "disabled";
>  		};
>  
> @@ -1611,7 +1061,7 @@
>  				     "allwinner,sun4i-a10-i2c";
>  			reg = <0x01c2c000 0x400>;
>  			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&apb1_gates 15>;
> +			clocks = <&ccu 87>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1622,7 +1072,7 @@
>  			reg = <0x01c50000 0x10000>;
>  			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "macirq";
> -			clocks = <&ahb_gates 49>, <&gmac_tx_clk>;
> +			clocks = <&ccu 66>, <&gmac_tx_clk>;
>  			clock-names = "stmmaceth", "allwinner_gmac_tx";
>  			snps,pbl = <2>;
>  			snps,fixed-burst;
> @@ -1639,7 +1089,7 @@
>  				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ahb_gates 28>;
> +			clocks = <&ccu 51>;
>  		};
>  
>  		gic: interrupt-controller at 01c81000 {
> @@ -1652,6 +1102,5 @@
>  			#interrupt-cells = <3>;
>  			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		};
> -
>  	};
>  };
> 
