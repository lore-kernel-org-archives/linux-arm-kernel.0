From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Nov 2012 10:55:50 +0100
Subject: [PATCH] ARM: sunxi: Add sun4i/cubieboard (A10) support
In-Reply-To: <1353313725-27595-1-git-send-email-sr@denx.de>
References: <1353313725-27595-1-git-send-email-sr@denx.de>
Message-ID: <50AA0226.7050805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Le 19/11/2012 09:28, Stefan Roese a ?crit :
> This patch adds support for the sun4i (A10) SoC to the sunxi
> platforms which currently only supports sun5i devices (A13). Most
> sun4i boards use UART0 as console UART (instead of UART1 as done
> on sun5i). So this patch adds support for debug UART on UART0
> as well.
> 
> Additionally the sunxi dtsi files are re-structured:
> sunxi.dtsi - Devices common to all Allwinner sunXi SoC's
> sun4i.dtsi - sun4i Devices, will include sunxi.dtsi
> sun5i.dtsi - sun5i Devices, will include sunxi.dtsi
> board.dts - will include either sun4i.dtsi or sun5i.dtsi

I'm fine with this changes, however, I'd like to see these changes
splitted into several commits:
  - One splitting sun5i.dtsi into sunxi.dtsi and sun5i.dtsi
  - One adding support for earlyprintk on UART0
  - and one adding support for the cubieboard

Also, I have a few comments below.

> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug                 |  9 +++-
>  arch/arm/boot/dts/Makefile             |  3 +-
>  arch/arm/boot/dts/sun4i-cubieboard.dts | 29 +++++++++++
>  arch/arm/boot/dts/sun4i.dtsi           | 19 ++++++++
>  arch/arm/boot/dts/sun5i-olinuxino.dts  |  2 +-
>  arch/arm/boot/dts/sun5i.dtsi           | 56 +---------------------
>  arch/arm/boot/dts/sunxi.dtsi           | 88 ++++++++++++++++++++++++++++++++++
>  arch/arm/include/debug/sunxi.S         |  5 ++
>  arch/arm/mach-sunxi/sunxi.c            |  1 +
>  9 files changed, 154 insertions(+), 58 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sun4i-cubieboard.dts
>  create mode 100644 arch/arm/boot/dts/sun4i.dtsi
>  create mode 100644 arch/arm/boot/dts/sunxi.dtsi
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index f12bc3a..cc1ed35 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -345,6 +345,13 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on SOCFPGA based platforms.
>  
> +	config DEBUG_SUNXI_UART0
> +		bool "Kernel low-level debugging messages via sunXi UART0"
> +		depends on ARCH_SUNXI
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on Allwinner A1X based platforms on the UART0.
> +
>  	config DEBUG_SUNXI_UART1
>  		bool "Kernel low-level debugging messages via sunXi UART1"
>  		depends on ARCH_SUNXI
> @@ -423,7 +430,7 @@ config DEBUG_LL_INCLUDE
>  	default "debug/mvebu.S" if DEBUG_MVEBU_UART
>  	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
>  	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
> -	default "debug/sunxi.S" if DEBUG_SUNXI_UART1
> +	default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
>  	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
>  		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
>  	default "mach/debug-macro.S"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9b2d3f0..4dd567b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -84,7 +84,8 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
>  	spear310-evb.dtb \
>  	spear320-evb.dtb
>  dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
> -dtb-$(CONFIG_ARCH_SUNXI) += sun5i-olinuxino.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun4i-cubieboard.dtb \
> +	sun5i-olinuxino.dtb
>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>  	tegra20-medcom-wide.dtb \
>  	tegra20-paz00.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-cubieboard.dts b/arch/arm/boot/dts/sun4i-cubieboard.dts
> new file mode 100644
> index 0000000..92e8ee9
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-cubieboard.dts
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright 2012 Stefan Roese
> + * Stefan Roese <sr@denx.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun4i.dtsi"
> +
> +/ {
> +	model = "Cubieboard";

Cubietech Cubieboard here.

> +	compatible = "cubietech,cubieboard", "allwinner,sun4i";
> +
> +	soc {
> +		uart0: uart at 01c28000 {
> +			status = "okay";
> +		};
> +
> +		uart1: uart at 01c28400 {
> +			status = "okay";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/sun4i.dtsi b/arch/arm/boot/dts/sun4i.dtsi
> new file mode 100644
> index 0000000..e61fdd4
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i.dtsi
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright 2012 Stefan Roese
> + * Stefan Roese <sr@denx.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/include/ "sunxi.dtsi"
> +
> +/ {
> +	memory {
> +		reg = <0x40000000 0x80000000>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/sun5i-olinuxino.dts b/arch/arm/boot/dts/sun5i-olinuxino.dts
> index 3b1cce3..50f3794 100644
> --- a/arch/arm/boot/dts/sun5i-olinuxino.dts
> +++ b/arch/arm/boot/dts/sun5i-olinuxino.dts
> @@ -19,7 +19,7 @@
>  	compatible = "olimex,a13-olinuxino", "allwinner,sun5i";
>  
>  	soc {
> -		duart: uart at 01c28400 {
> +		uart1: uart at 01c28400 {
>  			status = "okay";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 4bedf3e..59a2d26 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -11,64 +11,10 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> -/include/ "skeleton.dtsi"
> +/include/ "sunxi.dtsi"
>  
>  / {
> -	interrupt-parent = <&intc>;
> -
> -	cpus {
> -		cpu at 0 {
> -			compatible = "arm,cortex-a8";
> -		};
> -	};
> -
> -	chosen {
> -		bootargs = "earlyprintk console=ttyS0,115200";
> -	};
> -
>  	memory {
>  		reg = <0x40000000 0x20000000>;
>  	};
> -
> -	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		osc: oscillator {
> -			#clock-cells = <0>;
> -			compatible = "fixed-clock";
> -			clock-frequency = <24000000>;
> -		};
> -	};
> -
> -	soc {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		reg = <0x01c20000 0x300000>;
> -		ranges;
> -
> -		timer at 01c20c00 {
> -			compatible = "allwinner,sunxi-timer";
> -			reg = <0x01c20c00 0x400>;
> -			interrupts = <22>;
> -			clocks = <&osc>;
> -		};
> -
> -		intc: interrupt-controller at 01c20400 {
> -			compatible = "allwinner,sunxi-ic";
> -			reg = <0x01c20400 0x400>;
> -			interrupt-controller;
> -			#interrupt-cells = <1>;
> -		};
> -
> -		uart1: uart at 01c28400 {
> -			compatible = "ns8250";
> -			reg = <0x01c28400 0x400>;
> -			interrupts = <2>;
> -			reg-shift = <2>;
> -			clock-frequency = <24000000>;
> -			status = "disabled";
> -		};
> -	};
>  };
> diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
> new file mode 100644
> index 0000000..7e05903
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunxi.dtsi
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright 2012 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,cortex-a8";
> +		};
> +	};
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";
> +	};

This should not be here imho.
I'd rather see a different chosen node in sun4i and sun5i, or even
better, in the boards themselves. The console parameter will change from
one board to another, so we will have to define it in most boards anyway.

> +
> +	memory {
> +		reg = <0x40000000 0x20000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		osc: oscillator {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x01c20000 0x300000>;
> +		ranges;
> +
> +		timer at 01c20c00 {
> +			compatible = "allwinner,sunxi-timer";
> +			reg = <0x01c20c00 0x400>;
> +			interrupts = <22>;
> +			clocks = <&osc>;
> +		};
> +
> +		intc: interrupt-controller at 01c20400 {
> +			compatible = "allwinner,sunxi-ic";
> +			reg = <0x01c20400 0x400>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		uart0: uart at 01c28000 {
> +			compatible = "ns8250";
> +			reg = <0x01c28000 0x400>;
> +			interrupts = <1>;
> +			reg-shift = <2>;
> +			clock-frequency = <24000000>;
> +			status = "disabled";
> +		};
> +
> +		uart1: uart at 01c28400 {
> +			compatible = "ns8250";
> +			reg = <0x01c28400 0x400>;
> +			interrupts = <2>;
> +			reg-shift = <2>;
> +			clock-frequency = <24000000>;
> +			status = "disabled";
> +		};
> +	};
> +};
> diff --git a/arch/arm/include/debug/sunxi.S b/arch/arm/include/debug/sunxi.S
> index 3bf61ca..39ef611 100644
> --- a/arch/arm/include/debug/sunxi.S
> +++ b/arch/arm/include/debug/sunxi.S
> @@ -10,6 +10,11 @@
>   * published by the Free Software Foundation.
>  */
>  
> +#ifdef CONFIG_DEBUG_SUNXI_UART0
> +#define SUNXI_UART_DEBUG_PHYS_BASE 0x01c28000
> +#define SUNXI_UART_DEBUG_VIRT_BASE 0xf1c28000
> +#endif
> +

#elif defined ?

>  #ifdef CONFIG_DEBUG_SUNXI_UART1
>  #define SUNXI_UART_DEBUG_PHYS_BASE 0x01c28400
>  #define SUNXI_UART_DEBUG_VIRT_BASE 0xf1c28400
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 8f42df8..13d4d96 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -46,6 +46,7 @@ static void __init sunxi_dt_init(void)
>  }
>  
>  static const char * const sunxi_board_dt_compat[] = {
> +	"allwinner,sun4i",
>  	"allwinner,sun5i",
>  	NULL,
>  };
> 

Thanks,
Maxime


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
