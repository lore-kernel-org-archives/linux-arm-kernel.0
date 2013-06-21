From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Jun 2013 11:46:05 +0800
Subject: [PATCH 6/6] ARM: dts: Add device tree support for phycard pca100
In-Reply-To: <1371739815-6666-7-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-7-git-send-email-mpa@pengutronix.de>
Message-ID: <20130621034604.GC24268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 04:50:15PM +0200, Markus Pargmann wrote:
> Based on patches from:
> 
> Steffen Trumtrar <s.trumtrar@pengutronix.de>:
>  - Original patch
>  - ARM: dts: Set partition offsets for phycard
>  - ARM: dts: Use CSPI1 instead of CSPI2 on phycard pca100
>  - ARM: imx27-phytec-phycard-S.dts: resize nand partitions
> 
> Jan Luebbe <jlu@pengutronix.de>:
>  - ARM: dts: Enable bad block table in NAND
> 
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Jan Luebbe <jlu@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile                   |   1 +
>  arch/arm/boot/dts/imx27-phytec-phycard-S.dts | 195 +++++++++++++++++++++++++++
>  arch/arm/mach-imx/Kconfig                    |   1 +
>  3 files changed, 197 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-S.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b3a8661..e8fb0bc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx27-pdk.dtb \
>  	imx27-phytec-phycore-som.dtb \
>  	imx27-phytec-phycore-rdk.dtb \
> +	imx27-phytec-phycard-S.dtb \
>  	imx31-bug.dtb \
>  	imx51-apf51.dtb \
>  	imx51-apf51dev.dtb \
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-S.dts b/arch/arm/boot/dts/imx27-phytec-phycard-S.dts
> new file mode 100644
> index 0000000..dc3a93b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx27-phytec-phycard-S.dts
> @@ -0,0 +1,195 @@
> +/*
> + * Copyright 2012 Sascha Hauer, Uwe Kleine-K?nig and Steffen Trumtrar, Pengutronix
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
> +#include "imx27.dtsi"
> +
> +/ {
> +	model = "Phytec pca100";
> +	compatible = "phytec,imx27-pca100", "fsl,imx27";
> +
> +	memory {
> +		device_type = "memory";

It's been covered by skeleton.dtsi.

> +		#address-cells = <1>;
> +		#size-cells = <1>;

They are only needed if there are child nodes with "reg" property.

> +		reg = <0x0 0x08000000>;   // 128MB
> +	};
> +
> +	soc {
> +		aipi at 10000000 { /* aipi */
> +			wdog at 10002000 {
> +				status = "okay";
> +			};

We now use node label in board dts files to refer to the nodes defined
in soc dts.

> +
> +			owire at 10009000 {
> +				status = "okay";
> +			};
> +
> +			serial at 1000a000 {
> +				fsl,uart-has-rtscts;
> +				status = "okay";
> +			};
> +
> +			serial at 1000b000 {
> +				fsl,uart-has-rtscts;
> +				status = "okay";
> +			};
> +
> +			serial at 1000c000 {
> +				fsl,uart-has-rtscts;
> +				status = "okay";
> +			};
> +
> +			cspi at 1000e000 {
> +				fsl,spi-num-chipselects = <2>;
> +				cs-gpios = <&gpio4 28 0>,
> +					<&gpio4 27 0>;
> +				status = "okay";
> +			};
> +
> +			i2c at 10012000 {
> +				status = "okay";
> +				ioexpander at 41 {
> +					compatible = "nxp,pca9536";
> +					reg = <0x41>;
> +				};

Please put blank line before and after node.

> +				rtc at 51 {
> +					compatible = "nxp,pcf8563";
> +					reg = <0x51>;
> +				};
> +				dimmer at 60 {
> +					compatible = "nxp,pca9530";
> +					reg = <0x60>;

> +					pwm = <1 1>;
> +					psc = <1 1>;
> +					leds = <&led0 &led1>;

Are these documented/accepted bindings?

> +					led0: led0 {
> +						label = "pba-lcd_brightness";
> +						default-state = "off";
> +						type = "led";

What is this "type" property used for?  Is it documented?

> +					};
> +					led1: led1 {
> +						label = "pba-free_use";
> +						default-state = "off";
> +						type = "led";
> +					};
> +				};
> +			};
> +
> +			sdhci at 10014000 {
> +				cd-gpios = <&gpio3 29 0>;
> +				status = "okay";
> +			};
> +
> +			gpio at 10015000 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015100 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015200 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015300 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015400 {
> +				status = "okay";
> +			};
> +
> +			gpio at 10015500 {
> +				status = "okay";
> +			};
> +
> +			i2c at 1001d000 {
> +				status = "okay";
> +
> +				lm75 at 4a {
> +					compatible = "national,lm75";
> +					reg = <0x4a>;
> +				};
> +
> +				rtc at 51 {
> +					compatible = "nxp,pcf8563";
> +					reg = <0x51>;
> +				};
> +
> +				at24 at 52 {
> +					compatible = "at,24c32";
> +					pagesize = <32>;
> +					reg = <0x52>;
> +				};
> +			};
> +		};
> +
> +		aipi at 10020000 { /* AIPI2 */
> +			fb at 10021000 {
> +				status = "okay";

Please let it be the last property in the node.

> +				display = <&display0>;
> +			};
> +
> +			ethernet at 1002b000 {
> +				status = "okay";
> +			};
> +		}; /* AIPI */
> +
> +		nand at d8000000 {
> +			status = "okay";

Ditto

> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			nand-on-flash-bbt;
> +
> +			barebox at 0 {
> +				label = "barebox";
> +				reg = <0x0 0x80000>;
> +			};
> +
> +			bareboxenv at 80000 {
> +				label = "bareboxenv";
> +				reg = <0x80000 0x80000>;
> +			};
> +
> +			kernel at 100000 {
> +				label = "kernel";
> +				reg = <0x100000 0x500000>;
> +			};
> +
> +			rootfs at 500000 {
> +				label = "rootfs";
> +				reg = <0x500000 0x7b00000>;
> +			};

People are against the idea of putting partition layout in device tree.

> +		};
> +	};
> +
> +	display0: display0 {
> +		model = "Primeview-PD050VL1";
> +		native-mode = <&timing_disp0>;
> +		bits-per-pixel = <16>;		/* non-standard but required */
> +		fsl,pcr = <0xf0c88080>;	/* non-standard but required */

Has the code/document for these non-standard properties been accepted?

Shawn

> +		display-timings {
> +			timing_disp0: 640x480 {
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <112>;
> +				hfront-porch = <36>;
> +				hsync-len = <32>;
> +				vback-porch = <33>;
> +				vfront-porch = <33>;
> +				vsync-len = <2>;
> +				clock-frequency = <25000000>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index f25cf88..5372337 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -441,6 +441,7 @@ config MACH_IMX27IPCAM
>  config MACH_IMX27_DT
>  	bool "Support i.MX27 platforms from device tree"
>  	select SOC_IMX27
> +	select IMX_HAVE_PLATFORM_MXC_NAND
>  	help
>  	  Include support for Freescale i.MX27 based platforms
>  	  using the device tree for discovery
> -- 
> 1.8.2.1
> 
