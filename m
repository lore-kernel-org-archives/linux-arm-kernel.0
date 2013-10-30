From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 30 Oct 2013 18:04:04 +0100
Subject: [PATCH 1/2] ARM: kirkwood: add support for OpenBlocks A7 platform
In-Reply-To: <1383152110-19577-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1383152110-19577-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131030170404.GE7655@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 05:55:09PM +0100, Thomas Petazzoni wrote:
> The OpenBlocks A7 board is designed and sold by PlatHome, and based on
> a Kirkwood 6283 Marvell SoC. It is quite similar to the OpenBlocks A6
> already supported in the kernel, with the following main differences:
> 
>  - The A6 uses a RTC on I2C, while the A7 uses the internal SoC RTC.
> 
>  - The A6 has one Ethernet port, while the A7 has two Ethernet ports
> 
>  - The A6 has only one USB port, while the A7 integrates a USB hub,
>    which provides two front-side USB port, and an internal USB port as
>    well.
> 
>  - The A6 has 512 MB of RAM, while the A7 has 1 GB of RAM.
> 
>  - Slightly different GPIOs for some functions.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile                   |   3 +-
>  arch/arm/boot/dts/kirkwood-openblocks_a7.dts | 223 +++++++++++++++++++++++++++
>  2 files changed, 225 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-openblocks_a7.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 802720e..64783bb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -101,7 +101,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
>  	kirkwood-topkick.dtb \
>  	kirkwood-ts219-6281.dtb \
>  	kirkwood-ts219-6282.dtb \
> -	kirkwood-openblocks_a6.dtb
> +	kirkwood-openblocks_a6.dtb \
> +	kirkwood-openblocks_a7.dtb

Hi Thomas

Could you fix the ordering here? It is wrong to start with that the a6
is at the end. Could you move it, and add your new one, after nsa31a.

Apart from that, it looks good.

Thanks
	Andrew


>  dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
>  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>  	msm8960-cdp.dtb
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
> new file mode 100644
> index 0000000..1864972
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
> @@ -0,0 +1,223 @@
> +/*
> + * Device Tree file for OpenBlocks A7 board
> + *
> + * Copyright (C) 2013 Free Electrons
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6282.dtsi"
> +
> +/ {
> +	model = "Plat'Home OpenBlocksA7";
> +	compatible = "plathome,openblocks-a7", "marvell,kirkwood-88f6283", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>; /* 1 GB */
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			status = "ok";
> +			pinctrl-0 = <&pmx_uart0>;
> +			pinctrl-names = "default";
> +		};
> +
> +		serial at 12100 {
> +			status = "ok";
> +			pinctrl-0 = <&pmx_uart1>;
> +			pinctrl-names = "default";
> +		};
> +
> +		nand at 3000000 {
> +			chip-delay = <25>;
> +			status = "okay";
> +			pinctrl-0 = <&pmx_nand>;
> +			pinctrl-names = "default";
> +
> +			partition at 0 {
> +				label = "uboot";
> +				reg = <0x0 0x1c0000>;
> +			};
> +
> +			partition at 90000 {
> +				label = "env";
> +				reg = <0x1c0000 0x2c0000>;
> +			};
> +
> +			partition at d4000 {
> +				label = "test";
> +				reg = <0x480000 0x160000>;
> +			};
> +
> +			partition at f4000 {
> +				label = "conf";
> +				reg = <0x5e0000 0x540000>;
> +			};
> +
> +			partition at 4f4000 {
> +				label = "linux";
> +				reg = <0xb20000 0x3d40000>;
> +			};
> +
> +			partition at 2214000 {
> +				label = "user";
> +				reg = <0x4860000 0xb7a0000>;
> +			};
> +		};
> +
> +		sata at 80000 {
> +			nr-ports = <1>;
> +			status = "okay";
> +		};
> +
> +		i2c at 11100 {
> +			status = "okay";
> +			pinctrl-0 = <&pmx_twsi1>;
> +			pinctrl-names = "default";
> +
> +			s24c02: s24c02 at 50 {
> +				compatible = "24c02";
> +				reg = <0x50>;
> +			};
> +		};
> +
> +		pinctrl: pinctrl at 10000 {
> +			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header>;
> +			pinctrl-names = "default";
> +
> +			pmx_uart0: pmx-uart0 {
> +				marvell,pins = "mpp10", "mpp11", "mpp15",
> +					"mpp16";
> +				marvell,function = "uart0";
> +			};
> +
> +			pmx_uart1: pmx-uart1 {
> +				marvell,pins = "mpp13", "mpp14", "mpp8",
> +					"mpp9";
> +				marvell,function = "uart1";
> +			};
> +
> +			pmx_sysrst: pmx-sysrst {
> +				marvell,pins = "mpp6";
> +				marvell,function = "sysrst";
> +			};
> +
> +			pmx_dip_switches: pmx-dip-switches {
> +				marvell,pins = "mpp44", "mpp45", "mpp46", "mpp47";
> +				marvell,function = "gpio";
> +			};
> +
> +			/*
> +			 * Accessible on connector J202. The MPP
> +			 * listed below are pin 1-7, pin 8 is unused,
> +			 * pin 9 is external reset input and pin 10 is
> +			 * ground.
> +			 */
> +			pmx_gpio_header: pmx-gpio-header {
> +				marvell,pins = "mpp17", "mpp7", "mpp29", "mpp28",
> +					       "mpp35", "mpp34", "mpp40";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_gpio_init: pmx-init {
> +				marvell,pins = "mpp38";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_usb_oc: pmx-usb-oc {
> +				marvell,pins = "mpp39";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_leds: pmx-leds {
> +				marvell,pins = "mpp41", "mpp42", "mpp43";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_ge1: pmx-ge1 {
> +				marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23",
> +					       "mpp24", "mpp25", "mpp26", "mpp27",
> +					       "mpp30", "mpp31", "mpp32", "mpp33";
> +				marvell,function = "ge1";
> +			};
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_leds>;
> +		pinctrl-names = "default";
> +
> +		led-red {
> +			label = "obsa7:red:stat";
> +			gpios = <&gpio1 9 1>;
> +		};
> +
> +		led-green {
> +			label = "obsa7:green:stat";
> +			gpios = <&gpio1 10 1>;
> +		};
> +
> +		led-yellow {
> +			label = "obsa7:yellow:stat";
> +			gpios = <&gpio1 11 1>;
> +		};
> +        };
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pmx_gpio_init>;
> +		pinctrl-names = "default";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		button at 1 {
> +			label = "Init Button";
> +			linux,code = <116>;
> +			gpios = <&gpio1 6 0>;
> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		device_type = "ethernet-phy";
> +		reg = <0>;
> +	};
> +
> +	ethphy1: ethernet-phy at 1 {
> +		device_type = "ethernet-phy";
> +		reg = <1>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> +
> +&eth1 {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_ge1>;
> +	pinctrl-names = "default";
> +	ethernet1-port at 0 {
> +		phy-handle = <&ethphy1>;
> +	};
> +};
> -- 
> 1.8.1.2
> 
