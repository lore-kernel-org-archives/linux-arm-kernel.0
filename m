From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Nov 2014 03:15:21 +0100
Subject: [PATCHv1 3/3] arm: mvebu: add .dts file for Synology DS414
In-Reply-To: <909a6be242eeafa2cb5f096f3f2fc244f1b0880a.1416095841.git.arno@natisbad.org>
References: <cover.1416095841.git.arno@natisbad.org>
 <909a6be242eeafa2cb5f096f3f2fc244f1b0880a.1416095841.git.arno@natisbad.org>
Message-ID: <20141116021521.GD15870@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 01:04:34AM +0100, Arnaud Ebalard wrote:
> 
> Synology DS414 is a 4-bay NAS powered by a Marvell Armada XP
> (mv78230 dual-core @1.33Ghz). It is very similar on many aspects
> to previous 4-bay synology models based on Marvell kirkwood SoC.
> Here is a short summary of the device:
> 
>  - 1GB RAM
>  - Boot on SPI flash (64Mbit Micron N25Q064)
>  - 2 GbE interfaces (Armada MAC connected to two Marvell 88E1512
>    PHY via RGMII)
>  - 1 front USB 2.0 ports (directly handled by the Armada 370)
>  - 2 rear USB 3.0 ports (handled by an EtronTech EJ168A XHCI
>    controller on the PCIe bus)
>  - 4 internal SATA ports handled by a Marvell 88SX7042 SATA-II
>    controller on the PCIe bus)
>  - Seiko S-35390A I2C RTC chip
>  - UART0 providing serial console
>  - UART1 used for poweroff (connected to a Microchip PIC16F883)
> 
> Additional note: the front LEDs, the two fans and the buzzer are not
> directly connected to the SoC and under its control. The former are
> presumably driven by the SATA controller, the latter by the PIC. 
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/Makefile                     |   3 +-
>  arch/arm/boot/dts/armada-xp-synology-ds414.dts | 343 +++++++++++++++++++++++++
>  2 files changed, 345 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armada-xp-synology-ds414.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 95387b59ebb2..c181ee8055ac 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -509,7 +509,8 @@ dtb-$(CONFIG_MACH_ARMADA_XP) += \
>  	armada-xp-lenovo-ix4-300d.dtb \
>  	armada-xp-matrix.dtb \
>  	armada-xp-netgear-rn2120.dtb \
> -	armada-xp-openblocks-ax3-4.dtb
> +	armada-xp-openblocks-ax3-4.dtb \
> +	armada-xp-synology-ds414.dtb
>  dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
>  	dove-cubox.dtb \
>  	dove-cubox-es.dtb \
> diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
> new file mode 100644
> index 000000000000..1f99e1a27e00
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
> @@ -0,0 +1,343 @@
> +/*
> + * Device Tree file for Synology DS414
> + *
> + * Copyright (C) 2014, Arnaud EBALARD <arno@natisbad.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Note: this Device Tree assumes that the bootloader has remapped the
> + * internal registers to 0xf1000000 (instead of the old 0xd0000000).
> + * The 0xf1000000 is the default used by the recent, DT-capable, U-Boot
> + * bootloaders provided by Marvell. It is used in recent versions of
> + * DSM software provided by Synology. Nonetheless, some earlier boards
> + * were delivered with an older version of u-boot that left internal
> + * registers mapped at 0xd0000000. If you have such a device you will
> + * not be able to directly boot a kernel based on this Device Tree. In
> + * that case, the preferred solution is to update your bootloader (e.g.
> + * by upgrading to latest version of DSM, or building a new one and
> + * installing it from u-boot prompt) or adjust the Devive Tree
> + * (s/0xf1000000/0xd0000000/ in 'ranges' below).
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-xp-mv78230.dtsi"
> +
> +/ {
> +	model = "Synology DS414";
> +	compatible = "synology,ds414", "marvell,armadaxp-mv78230",
> +		     "marvell,armadaxp", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +		stdout-path = &uart0;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x00000000 0 0x40000000>; /* 1GB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/*
> +			 * Connected to Marvell 88SX7042 SATA-II controller
> +			 * handling the four disks.
> +			 */
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			/*
> +			 * Connected to EtronTech EJ168A XHCI controller
> +			 * providing the two rear USB 3.0 ports.
> +			 */
> +			pcie at 5,0 {
> +				/* Port 1, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +
> +		internal-regs {
> +
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
> +				pmx_spi: pmx-spi {
> +					marvell,pins = "mpp36", "mpp37",
> +						       "mpp38", "mpp39";
> +					marvell,function = "spi";
> +				};

It would be good to move these to armada-xp-mv78230.dtsi. I would
suggest following the naming convention used by the 370.

> +
> +				pmx_sata1_pwr: pmx-sata1-pwr {
> +					marvell,pins = "mpp42";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata2_pwr: pmx-sata2-pwr {
> +					marvell,pins = "mpp44";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata3_pwr: pmx-sata3-pwr {
> +					marvell,pins = "mpp45";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata4_pwr: pmx-sata4-pwr {
> +					marvell,pins = "mpp46";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata1_pres: pmx-sata1-pres {
> +					marvell,pins = "mpp34";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata2_pres: pmx-sata2-pres {
> +					marvell,pins = "mpp35";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata3_pres: pmx-sata3-pres {
> +					marvell,pins = "mpp40";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_sata4_pres: pmx-sata4-pres {
> +					marvell,pins = "mpp41";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_syno_id_bit0: pmx_syno_id_bit0 {
> +					marvell,pins = "mpp26";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_syno_id_bit1: pmx_syno_id_bit1 {
> +					marvell,pins = "mpp28";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_syno_id_bit2: pmx_syno_id_bit2 {
> +					marvell,pins = "mpp29";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_fan1_alarm: pmx-fan1-alarm {
> +					marvell,pins = "mpp33";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_fan2_alarm: pmx-fan2-alarm {
> +					marvell,pins = "mpp32";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
> +			mdio {
> +				phy0: ethernet-phy at 0 { /* Marvell 88E1512 */
> +					reg = <0>;
> +				};
> +
> +				phy1: ethernet-phy at 1 { /* Marvell 88E1512 */
> +					reg = <1>;
> +				};
> +			};
> +
> +			ethernet at 70000 {
> +				status = "okay";
> +				pinctrl-0 = <&pmx_ge0>;
> +				pinctrl-names = "default";
> +				phy = <&phy1>;
> +				phy-mode = "rgmii-id";
> +			};
> +
> +			ethernet at 74000 {
> +				pinctrl-0 = <&pmx_ge1>;
> +				pinctrl-names = "default";
> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "rgmii-id";
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
> +					compatible = "micron,n25q064";
> +					reg = <0>; /* Chip select 0 */
> +					spi-max-frequency = <20000000>;
> +
> +					/*
> +					 * Warning!
> +					 *
> +					 * Synology u-boot uses its compiled-in environment
> +					 * and it seems Synology did not care to change u-boot
> +					 * default configuration in order to allow saving a
> +					 * modified environment at a sensible location. So,
> +					 * if you do a 'saveenv' under u-boot, your modified
> +					 * environment be saved will at 1MB after the start
> +					 * of the flash, i.e. in the middle of the uImage.
> +					 * For that reason, it is strongly advised not to
> +					 * change default environment, unless you know what
> +					 * you are doing.
> +					 */

Seems to be a cut/paste of the 370 text. So same comments.

> +					partition at 00000000 { /* u-boot */
> +						label = "RedBoot";
> +						reg = <0x00000000 0x000d0000>; /* 832KB */
> +					};
> +
> +					partition at 000c0000 { /* uImage */
> +						label = "zImage";
> +						reg = <0x000d0000 0x002d0000>; /* 2880KB */
> +					};
> +
> +					partition at 003a0000 { /* uInitramfs */
> +						label = "rd.gz";
> +						reg = <0x003a0000 0x00430000>; /* 4250KB */
> +					};
> +
> +					partition at 007d0000 { /* MAC address and serial number */
> +						label = "vendor";
> +						reg = <0x007d0000 0x00010000>; /* 64KB */
> +					};
> +
> +					partition at 007e0000 {
> +						label = "RedBoot config";
> +						reg = <0x007e0000 0x00010000>; /* 64KB */
> +					};
> +
> +					partition at 007f0000 {
> +						label = "FIS directory";
> +						reg = <0x007f0000 0x00010000>; /* 64KB */
> +					};
> +				};
> +			};
> +
> +			/* Front USB 2.0 port */
> +			usb at 50000 {
> +				status = "okay";
> +			};
> +
> +			i2c at 11000 {
> +				clock-frequency = <400000>;
> +				status = "okay";
> +
> +				s35390a: s35390a at 30 {
> +					 compatible = "ssi,s35390a";

sii

Ah! It is also wrong in kirkwood-synology.dtsi

> +					 reg = <0x30>;
> +				};
> +			};
> +
> +			/* RTC is provided by Seiko S-35390A above */
> +			rtc at 10300 {
> +				status = "disabled";
> +			};
> +
> +			/* Connected to a header on device's PCB */
> +			serial at 12000 {
> +				status = "okay";
> +			};
> +
> +			/* Connected to a Microchip PIC16F883 for power control */
> +			serial at 12100 {
> +				status = "okay";
> +			};
> +
> +			poweroff at 12100 {
> +				compatible = "synology,power-off";
> +				reg = <0x12100 0x100>;
> +				clocks = <&coreclk 0>;
> +			};
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_sata1_pwr &pmx_sata2_pwr
> +			     &pmx_sata3_pwr &pmx_sata4_pwr>;
> +		pinctrl-names = "default";
> +
> +		sata1_regulator: sata1-regulator {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA1 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			startup-delay-us = <2000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		sata2_regulator: sata2-regulator {
> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +			regulator-name = "SATA2 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			startup-delay-us = <4000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		sata3_regulator: sata3-regulator {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
> +			regulator-name = "SATA3 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			startup-delay-us = <6000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		sata4_regulator: sata4-regulator {
> +			compatible = "regulator-fixed";
> +			reg = <4>;
> +			regulator-name = "SATA4 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			startup-delay-us = <8000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> -- 
> 2.1.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
