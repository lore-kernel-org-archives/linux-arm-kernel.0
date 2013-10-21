From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 21 Oct 2013 23:57:46 +0200
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 104 board
In-Reply-To: <87txgapcas.fsf@natisbad.org>
References: <87txgapcas.fsf@natisbad.org>
Message-ID: <20131021215746.GF23593@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> @@ -0,0 +1,197 @@
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
> +			sata at a0000 {
> +				status = "disabled";
> +			};

It should be disabled by default, so you can skip this.

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

You can also skip these. The gpio driver will put the pin into gpio
mode when the leds/keys driver claims it. It is a case of, i didn't
know that, put entries like this into a number of files, and people
have been copying my mistake ever since. Thomas made an effort to
correct this for some boards.

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
> +			gpios = <&gpio1 31 1>;  /* GPIO 63 Active Low */
> +			default-state = "on";
> +		};
> +
> +		blue_power_led {
> +			label = "rn104:blue:pwr";
> +			gpios = <&gpio2 0 1>;   /* GPIO 64 Active Low */
> +			linux,default-trigger = "heartbeat";

Jason might not like this. He submitted a patch a few days ago
removing all blinking LEDs.

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
> 
