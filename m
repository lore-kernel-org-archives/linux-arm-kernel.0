From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Oct 2013 01:28:06 +0200
Subject: [PATCHv1] ARM: mvebu: Add Netgear ReadyNAS 104 board
In-Reply-To: <87fvrtqgmq.fsf@natisbad.org>
References: <87fvrtqgmq.fsf@natisbad.org>
Message-ID: <20131022232806.GF26694@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 08:56:13PM +0200, Arnaud Ebalard wrote:
> 
> Main hardware parts of the (Armada 370 based) NETGEAR ReadyNAS 104 are
> supported by mainline kernel (USB 3.0 rear ports, USB 2.0 front port,
> Gigabit controller and PHYs, serial port, LEDs, buttons, SATA ports,
> G762 fan controller) and referenced in provided .dts file. Some additonal
> work remains for:
> 
>  - Intersil ISL12057 I2C RTC and Alarm chip: working driver but needs
>    to be splitted for submission of RTC part first;
>  - Front LCD (Winstar 1602G): driver needs to be written
>  - Armada NAND controller (to access onboard 128MB of NAND): support
>    being pushed by @free-electrons people
>  - 4 front SATA LEDs controlled via GPIO brought by NXP PCA9554:
>    driver is available upstream. Not referenced/tested yet.
> 
> but the device is usable w/o those.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> 
> Changes since v0, based on comments from Andrew:
> 
>  - removed useless sata nodes w/ disabled status
>  - changed power LED to default-state="keep" and backup LED to "off"

Hi Arnaud

Looks good to me.

Acked-by: Andrew Lunn <andrew@lunn.ch.>

	  Andrew


> 
>  arch/arm/boot/dts/Makefile                     |   1 +
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 193 +++++++++++++++++++++++++
>  2 files changed, 194 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-370-netgear-rn104.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 802720e..be682cb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -108,6 +108,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>  	armada-370-mirabox.dtb \
>  	armada-370-netgear-rn102.dtb \
> +	armada-370-netgear-rn104.dtb \
>  	armada-370-rd.dtb \
>  	armada-xp-axpwifiap.dtb \
>  	armada-xp-db.dtb \
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> new file mode 100644
> index 0000000..2eb855f
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> @@ -0,0 +1,193 @@
> +/*
> + * Device Tree file for NETGEAR ReadyNAS 104
> + *
> + * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +#include "armada-370.dtsi"
> +
> +/ {
> +	model = "NETGEAR ReadyNAS 104";
> +	compatible = "netgear,readynas-104", "marvell,armada370", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
> +			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/* Connected to FL1009 USB 3.0 controller */
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			/* Connected to Marvell 88SE9215 SATA controller */
> +			pcie at 2,0 {
> +				/* Port 1, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +
> +		internal-regs {
> +			serial at 12000 {
> +				clock-frequency = <200000000>;
> +				status = "okay";
> +			};
> +
> +			pinctrl {
> +				poweroff: poweroff {
> +					marvell,pins = "mpp60";
> +					marvell,function = "gpio";
> +				};
> +
> +				backup_key_pin: backup-key-pin {
> +					marvell,pins = "mpp52";
> +					marvell,function = "gpio";
> +				};
> +
> +				power_key_pin: power-key-pin {
> +					marvell,pins = "mpp62";
> +					marvell,function = "gpio";
> +				};
> +
> +				backup_led_pin: backup-led-pin {
> +					marvell,pins = "mpp63";
> +					marvell,function = "gpo";
> +				};
> +
> +				power_led_pin: power-led-pin {
> +					marvell,pins = "mpp64";
> +					marvell,function = "gpio";
> +				};
> +
> +				reset_key_pin: reset-key-pin {
> +					marvell,pins = "mpp65";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
> +			mdio {
> +				phy0: ethernet-phy at 0 {
> +					reg = <0>;
> +				};
> +
> +				phy1: ethernet-phy at 1 {
> +					reg = <1>;
> +				};
> +			};
> +
> +			ethernet at 70000 {
> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "rgmii-id";
> +			};
> +
> +			ethernet at 74000 {
> +				status = "okay";
> +				phy = <&phy1>;
> +				phy-mode = "rgmii-id";
> +			};
> +
> +			usb at 50000 {
> +				status = "okay";
> +			};
> +
> +			i2c at 11000 {
> +				compatible = "marvell,mv64xxx-i2c";
> +				clock-frequency = <100000>;
> +				status = "okay";
> +
> +				g762: g762 at 3e {
> +					compatible = "gmt,g762";
> +					reg = <0x3e>;
> +					clocks = <&g762_clk>; /* input clock */
> +					fan_gear_mode = <0>;
> +					fan_startv = <1>;
> +					pwm_polarity = <0>;
> +				};
> +			};
> +		};
> +	};
> +
> +	clocks {
> +	       #address-cells = <1>;
> +	       #size-cells = <0>;
> +
> +	       g762_clk: fixedclk {
> +			 compatible = "fixed-clock";
> +			 #clock-cells = <0>;
> +			 clock-frequency = <8192>;
> +	       };
> +	};
> +
> +	gpio_leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&backup_led_pin &power_led_pin>;
> +		pinctrl-names = "default";
> +
> +		blue_backup_led {
> +			label = "rn104:blue:backup";
> +			gpios = <&gpio1 31 0>;   /* GPIO 63 Active High */
> +			default-state = "off";
> +		};
> +
> +		blue_power_led {
> +			label = "rn104:blue:pwr";
> +			gpios = <&gpio2 0 1>;    /* GPIO 64 Active Low */
> +			linux,default-trigger = "keep";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&backup_key_pin
> +			     &power_key_pin
> +			     &reset_key_pin>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Backup Button";
> +			linux,code = <133>;     /* KEY_COPY */
> +			gpios = <&gpio1 20 1>;
> +		};
> +
> +		button at 2 {
> +			label = "Power Button";
> +			linux,code = <116>;     /* KEY_POWER */
> +			gpios = <&gpio1 30 0>;
> +		};
> +
> +		button at 3 {
> +			label = "Reset Button";
> +			linux,code = <0x198>;   /* KEY_RESTART */
> +			gpios = <&gpio2 1 1>;
> +		};
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 28 1>;
> +	};
> +};
> -- 
> 1.8.4.rc3
> 
