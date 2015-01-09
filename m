From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Jan 2015 13:46:27 +0100
Subject: [PATCH] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <1420806710-27619-1-git-send-email-kaloz@openwrt.org>
References: <1420806710-27619-1-git-send-email-kaloz@openwrt.org>
Message-ID: <54AFCDA3.1030601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Imre,

On 09/01/2015 13:31, Imre Kaloz wrote:
> The Linksys WRT1900AC (Mamba) is a router that has
> 
> - 2 mini-PCIe slots with Marvell 88W8864 radios
> - 1 USB 3.0 port
> - 1 USB 2.0/eSATAp port
> - 2 Ethernet interfaces connected to a 88E6172 switch (1x WAN + 4x LAN)
> - 128MB NAND flash
> - 256MB RAM

Thanks for your contribution

> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/arm/boot/dts/Makefile            |   1 +
>  arch/arm/boot/dts/armada-xp-mamba.dts | 264 ++++++++++++++++++++++++++++++++++
>  2 files changed, 265 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-xp-mamba.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 91bd5bd..2914c88 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -542,6 +542,7 @@ dtb-$(CONFIG_MACH_ARMADA_XP) += \
>  	armada-xp-gp.dtb \
>  	armada-xp-lenovo-ix4-300d.dtb \
>  	armada-xp-matrix.dtb \
> +	armada-xp-mamba.dtb \
>  	armada-xp-netgear-rn2120.dtb \
>  	armada-xp-openblocks-ax3-4.dtb \
>  	armada-xp-synology-ds414.dtb
> diff --git a/arch/arm/boot/dts/armada-xp-mamba.dts b/arch/arm/boot/dts/armada-xp-mamba.dts
> new file mode 100644
> index 0000000..1f13e49
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-mamba.dts
> @@ -0,0 +1,264 @@
> +/*
> + * Device Tree file for the Linksys WRT1900AC (Mamba).
> + *
> + * Note: this board is shipped with a new generation boot loader that
> + * remaps internal registers at 0xf1000000. Therefore, if earlyprintk
> + * is used, the CONFIG_DEBUG_MVEBU_UART_ALTERNATE option should be
> + * used.
> + *
> + * Copyright (C) 2014 Imre Kaloz <kaloz@openwrt.org>
> + *
> + * Based on armada-xp-axpwifiap.dts:
> + *
> + *       Copyright (C) 2013 Marvell
> + *
> + *       Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.

We are moving to a dual license GPL/X11:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/380065

Could you consider to use it too?
The file you based on will be converted, all the author of this
file already have given their acked-by.


In meantime, I will review the content of your patch.

Thanks,

Gregory



> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "armada-xp-mv78230.dtsi"
> +
> +/ {
> +	model = "Linksys WRT1900AC (Mamba)";
> +	compatible = "linksys,mamba", "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x10000000>; /* 256MB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/* Etron EJ168 USB 3.0 controller */
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			/* First mini-PCIe port */
> +			pcie at 2,0 {
> +				/* Port 0, Lane 1 */
> +				status = "okay";
> +			};
> +
> +			/* Second mini-PCIe port */
> +			pcie at 3,0 {
> +				/* Port 0, Lane 3 */
> +				status = "okay";
> +			};
> +		};
> +
> +		internal-regs {
> +			pinctrl {
> +				pmx_ge0: pmx-ge0 {
> +					marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
> +						       "mpp4", "mpp5", "mpp6", "mpp7",
> +						       "mpp8", "mpp9", "mpp10", "mpp11";
> +					marvell,function = "ge0";
> +				};
> +
> +				pmx_ge1: pmx-ge1 {
> +					marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15",
> +						       "mpp16", "mpp17", "mpp18", "mpp19",
> +						       "mpp20", "mpp21", "mpp22", "mpp23";
> +					marvell,function = "ge1";
> +				};
> +
> +				pmx_keys: pmx-keys {
> +					marvell,pins = "mpp32", "mpp33";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_spi: pmx-spi {
> +					marvell,pins = "mpp36", "mpp37", "mpp38", "mpp39";
> +					marvell,function = "spi";
> +				};
> +
> +				power_led_pin: power-led-pin {
> +					marvell,pins = "mpp40";
> +					marvell,function = "gpio";
> +				};
> +
> +				gpio_fan_pin: gpio-fan-pin {
> +					marvell,pins = "mpp24";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
> +			serial at 12000 {
> +				clock-frequency = <250000000>;
> +				status = "okay";
> +			};
> +
> +			sata at a0000 {
> +				nr-ports = <1>;
> +				status = "okay";
> +			};
> +
> +			ethernet at 70000 {
> +				pinctrl-0 = <&pmx_ge0>;
> +				pinctrl-names = "default";
> +				status = "okay";
> +				phy-mode = "rgmii-id";
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +
> +			ethernet at 74000 {
> +				pinctrl-0 = <&pmx_ge1>;
> +				pinctrl-names = "default";
> +				status = "okay";
> +				phy-mode = "rgmii-id";
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +
> +			/* USB part of the eSATA/USB 2.0 port */
> +			usb at 50000 {
> +				status = "okay";
> +			};
> +
> +			i2c at 11000 {
> +				status = "okay";
> +				clock-frequency = <100000>;
> +
> +				tmp421 at 4c {
> +					compatible = "ti,tmp421";
> +					reg = <0x4c>;
> +				};
> +			};
> +
> +			nand at d0000 {
> +				status = "okay";
> +				num-cs = <1>;
> +				marvell,nand-keep-config;
> +				marvell,nand-enable-arbiter;
> +				nand-on-flash-bbt;
> +				nand-ecc-strength = <4>;
> +				nand-ecc-step-size = <512>;
> +
> +				partition at 0 {
> +					label = "u-boot";
> +					reg = <0x0000000 0x100000>;  /* 1MB */
> +					read-only;
> +				};
> +
> +				partition at 100000 {
> +					label = "u_env";
> +					reg = <0x100000 0x40000>;    /* 256KB */
> +				};
> +
> +				partition at 140000 {
> +					label = "s_env";
> +					reg = <0x140000 0x40000>;    /* 256KB */
> +				};
> +
> +				partition at 900000 {
> +					label = "devinfo";
> +					reg = <0x900000 0x100000>;    /* 1MB */
> +					read-only;
> +				};
> +
> +				partition at a00000 {
> +					label = "kernel1";
> +					reg = <0xa00000 0x2800000>;    /* 3MB + rootfs1 */
> +				};
> +
> +				partition at d00000 {
> +					label = "rootfs1";
> +					reg = <0xd00000 0x2500000>;    /* 37MB */
> +				};
> +
> +				partition at 3200000 {
> +					label = "kernel2";
> +					reg = <0x3200000 0x2800000>;    /* 3MB + rootfs2 */
> +				};
> +
> +				partition at 3500000 {
> +					label = "rootfs2";
> +					reg = <0x3500000 0x2500000>;    /* 37MB */
> +				};
> +
> +				/* Last MB is for the BBT, i.e. not writable */
> +				partition at 5a00000 {
> +					label = "syscfg";
> +					reg = <0x5a00000 0x2600000>;    /* 38MB */
> +				};
> +			};
> +
> +			spi0: spi at 10600 {
> +				status = "okay";
> +				pinctrl-0 = <&pmx_spi>;
> +				pinctrl-names = "default";
> +
> +				spi-flash at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					compatible = "mr25h256";
> +					reg = <0>; /* Chip select 0 */
> +					spi-max-frequency = <108000000>;
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_keys>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "WPS";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		button at 2 {
> +			label = "Factory Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&power_led_pin>;
> +		pinctrl-names = "default";
> +
> +		power {
> +			label = "mamba:white:power";
> +			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +	};
> +
> +	gpio_fan {
> +		/* SUNON HA4010V4-0000-C99 */
> +		compatible = "gpio-fan";
> +		gpios = <&gpio0 24 0>;
> +
> +		gpio-fan,speed-map = <0    0
> +				      4500 1>;
> +	};
> +};
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
