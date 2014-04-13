From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 Apr 2014 17:47:15 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140413154715.GE10033@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 13, 2014 at 04:40:03PM +0200, Thomas Petazzoni wrote:
> This commit converts the RD-88F5182 platform to the Device Tree. All
> devices except the PCI are converted to the Device Tree.
> 
> It is worth noting that:
> 
>  * The PCI description for the DT case is kept in board-rd88f5182.c.
> 
>  * The existing non-DT support in rd88f5182-setup.c is kept as is, in
>    order to allow testing of a given platform in both DT and non-DT
>    cases. It will ultimately be removed, once we no longer care about
>    non-DT support for Orion5x.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   3 +-
>  arch/arm/boot/dts/orion5x-rd88f5182-nas.dts | 153 ++++++++++++++++++++++++++++
>  arch/arm/mach-orion5x/Kconfig               |   8 ++
>  arch/arm/mach-orion5x/Makefile              |   1 +
>  arch/arm/mach-orion5x/board-rd88f5182.c     | 116 +++++++++++++++++++++
>  5 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
>  create mode 100644 arch/arm/mach-orion5x/board-rd88f5182.c
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 35c146f..f7943a8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -289,7 +289,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	am43x-epos-evm.dtb \
>  	am437x-gp-evm.dtb \
>  	dra7-evm.dtb
> -dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
> +dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb \
> +	orion5x-rd88f5182-nas.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
>  dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
> new file mode 100644
> index 0000000..b5fd087
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
> @@ -0,0 +1,153 @@
> +/*
> + * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "orion5x-mv88f5182.dtsi"
> +
> +/ {
> +	model = "Marvell Reference Design 88F5182 NAS";
> +	compatible = "marvell,rd-88f5182-nas", "marvell,orion5x-88f5182", "marvell,orion5x";
> +
> +	memory {
> +		reg = <0x00000000 0x4000000>; /* 64 MB */
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
> +		         <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
> +			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x80000>,
> +			 <MBUS_ID(0x01, 0x1d) 0 0xfc000000 0x1000000>;
> +
> +		devbus-bootcs {
> +			status = "okay";
> +			/* TODO: Device Bus parameters */
> +			nor at 0 {
> +				compatible = "cfi-flash";
> +				reg = <0 0x80000>;
> +				bank-width = <1>;
> +			};
> +		};
> +
> +		devbus-cs1 {
> +			status = "okay";
> +			/* TODO: Device Bus parameters */
> +			nor at 0 {
> +				compatible = "cfi-flash";
> +				reg = <0 0x1000000>;
> +				bank-width = <1>;
> +			};
> +		};
> +
> +		internal-regs {
> +			pinctrl at 10000 {
> +				pinctrl-0 = <&pmx_reset_switch &pmx_misc_gpios
> +					     &pmx_pci_gpios>;
> +				pinctrl-names = "default";
> +
> +				/*
> +				 * MPP[20] PCI Clock to MV88F5182
> +				 * MPP[21] PCI Clock to mini PCI CON11
> +				 * MPP[22] USB 0 over current indication
> +				 * MPP[23] USB 1 over current indication
> +				 * MPP[24] USB 1 over current enable
> +				 * MPP[25] USB 0 over current enable
> +				 */
> +
> +				pmx_debug_led: pmx-debug_led {
> +					marvell,pins = "mpp0";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_reset_switch: pmx-reset-switch {
> +					marvell,pins = "mpp1";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_rtc: pmx-rtc {
> +					marvell,pins = "mpp3";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_misc_gpios: pmx-misc-gpios {
> +					marvell,pins = "mpp4", "mpp5";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_pci_gpios: pmx-pci-gpios {
> +					marvell,pins = "mpp6", "mpp7";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
> +			i2c at 11000 {
> +				status = "okay";
> +				clock-frequency = <100000>;
> +				#address-cells = <1>;
> +
> +				rtc at 68 {
> +					pinctrl-0 = <&pmx_rtc>;
> +					pinctrl-names = "default";
> +					compatible = "ds1338";

Hi Thomas

Vendor prefix again.

> +					reg = <0x68>;
> +				};
> +			};
> +
> +			serial at 12000 {
> +				clock-frequency = <166666667>;

I don't think you need this, so long as there is tclk in the node.


> +	gpio_leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_debug_led>;
> +		pinctrl-names = "default";
> +
> +		led at 0 {
> +			label = "rd88f5182:cpu";
> +			linux,default-trigger = "heartbeat";

Jason probably won't like that.

> +			gpios = <&gpio0 0 0>;

gpio.h defines?

> +static int __init rd88f5182_pci_init(void)
> +{
> +	if (of_machine_is_compatible("marvell,rd-88f5182-nas"))
> +		pci_common_init(&rd88f5182_pci);
> +
> +	return 0;
> +}
> +
> +subsys_initcall(rd88f5182_pci_init);

Nice to see you are checking for compatibility in the initcall. How
far do you think this from a multi_v5 kernel?

    Andrew
