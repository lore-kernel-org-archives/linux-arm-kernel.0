From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 10 Nov 2013 00:57:17 +0100
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <87bo1tmibv.fsf@natisbad.org>
References: <87bo1tmibv.fsf@natisbad.org>
Message-ID: <527ECBDD.7050607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2013 09:27 PM, Arnaud Ebalard wrote:
> All hardware parts of the (mv78230 Armada XP based) NETGEAR ReadyNAS
> 2120 are supported by mainline kernel (USB 3.0 and eSATA rear ports,
> USB 2.0 front port, Gigabit controller and PHYs for the two rear ports,
> serial port, LEDs, Buttons, 88SE9170 SATA controllers, three G762 fan
> controllers, G751 temperature sensor) except for:
>
>   - the Intersil ISL12057 I2C RTC Chip,
>   - the Armada NAND controller.
>
> Support for both of those is currently work in progress and does not
> prevent boot.
>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
[...]
>   arch/arm/boot/dts/Makefile                     |   1 +
>   arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 289 +++++++++++++++++++++++++

Arnaud,

thanks for providing this! I do have some comments below.

we recently had a discussion about the naming of new DTS files, which
proposes to name those after vendor,board.dts (or vendor-board.dts).

I personally prefer vendor,board.dts which would give
netgear,readynas-2120.dts based on your compatible below.
The final call for ',' vs '-' has not been made, so I  suggest Jason
makes a call here.

[...]
> diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> new file mode 100644
> index 0000000..2651ba3
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> @@ -0,0 +1,289 @@
> +/*
> + * Device Tree file for NETGEAR ReadyNAS 2120
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
> +#include "armada-xp-mv78230.dtsi"
> +
> +/ {
> +	model = "NETGEAR ReadyNAS 2120";
> +	compatible = "netgear,readynas-2120", "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x00000000 0 0x80000000>; /* 2GB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
> +
[...]
> +		internal-regs {
> +			pinctrl {
> +				poweroff: poweroff {
> +					marvell,pins = "mpp42";
> +					marvell,function = "gpio";
> +				};
> +
> +				power_key_pin: power-key-pin {
> +					marvell,pins = "mpp27";
> +					marvell,function = "gpio";
> +				};
> +
> +				reset_key_pin: reset-key-pin {
> +					marvell,pins = "mpp41";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata1_led_pin: sata1-led-pin {
> +					marvell,pins = "mpp31";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata2_led_pin: sata2-led-pin {
> +					marvell,pins = "mpp40";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata3_led_pin: sata3-led-pin {
> +					marvell,pins = "mpp44";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata4_led_pin: sata4-led-pin {
> +					marvell,pins = "mpp47";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata1_power_pin: sata1-power-pin {
> +					marvell,pins = "mpp24";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata2_power_pin: sata2-power-pin {
> +					marvell,pins = "mpp25";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata3_power_pin: sata3-power-pin {
> +					marvell,pins = "mpp26";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata4_power_pin: sata4-power-pin {
> +					marvell,pins = "mpp28";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata1_pres_pin: sata1-pres-pin {
> +					marvell,pins = "mpp32";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata2_pres_pin: sata2-pres-pin {
> +					marvell,pins = "mpp33";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata3_pres_pin: sata3-pres-pin {
> +					marvell,pins = "mpp34";
> +					marvell,function = "gpio";
> +				};
> +
> +				sata4_pres_pin: sata4-pres-pin {
> +					marvell,pins = "mpp35";
> +					marvell,function = "gpio";
> +				};
> +
> +				err_led_pin: err-led-pin {
> +					marvell,pins = "mpp45";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
> +			serial at 12000 {
> +				clock-frequency = <250000000>;

Where does that 250MHz come from? If it is an internal clock
and we already have a DT clock provider for it, please use
clocks = <&provider num>;

If it is TCLK it can be optained from <&coreclk 0>.

> +				status = "okay";
> +			};
> +
> +			mdio {
> +				phy0: ethernet-phy at 0 {
> +					reg = <0>;

Can you evaluate PHYs compatible from u-boot or post vendor:prodid
from MDIO registers?

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
> +			/* Front USB 2.0 port */
> +			usb at 50000 {
> +				status = "okay";
> +			};
> +
> +			i2c at 11000 {
> +				compatible = "marvell,mv64xxx-i2c";
> +				clock-frequency = <400000>;
> +				status = "okay";
> +
> +				/* Rear fan #1 of 3 (Protechnic MGT4012XB-O20,
> +				 * 8000RPM) near eSATA port */
> +				g762_fan1: g762 at 3e {
> +					compatible = "gmt,g762";
> +					reg = <0x3e>;
> +					clocks = <&g762_clk>; /* input clock */
> +					fan_gear_mode = <0>;
> +					fan_startv = <1>;
> +					pwm_polarity = <0>;
> +				};
> +
> +				/* Rear fan #2 of 3 at the center */
> +				g762_fan2: g762 at 48 {
> +					compatible = "gmt,g762";
> +					reg = <0x48>;
> +					clocks = <&g762_clk>; /* input clock */
> +					fan_gear_mode = <0>;
> +					fan_startv = <1>;
> +					pwm_polarity = <0>;
> +				};
> +
> +				/* Rear fan #3 of 3 */
> +				g762_fan3: g762 at 49 {
> +					compatible = "gmt,g762";
> +					reg = <0x49>;
> +					clocks = <&g762_clk>; /* input clock */
> +					fan_gear_mode = <0>;
> +					fan_startv = <1>;
> +					pwm_polarity = <0>;
> +				};
> +
> +				g751: g751 at 4c {
> +					compatible = "gmt,g751";
> +					reg = <0x4c>;
> +				};
> +			};
> +		};
> +	};
> +
> +	clocks {
> +	       #address-cells = <1>;
> +	       #size-cells = <0>;

Your nodes below neither have a reg property nor can they be
addressed in any way. Both properties above are not required,
so please remove them.

> +	       g762_clk: fixedclk {

s/fixedclk/oscillator/ ?

> +			 compatible = "fixed-clock";
> +			 #clock-cells = <0>;
> +			 clock-frequency = <32768>;
> +	       };
> +	};
> +
> +	gpio_leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&sata1_led_pin &sata2_led_pin &err_led_pin
> +			     &sata3_led_pin &sata4_led_pin>;
> +		pinctrl-names = "default";
> +
> +		red_sata1_led {
> +			label = "rn2120:red:sata1";
> +			gpios = <&gpio0 31 0>;   /* GPIO 31 Active High */

You can

#include <dt-bindings/gpio/gpio.h>

then use

gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>

and get rid of the comments.

> +			default-state = "off";
> +		};
> +
> +		red_sata2_led {
> +			label = "rn2120:red:sata2";
> +			gpios = <&gpio1 8 0>;   /* GPIO 40 Active High */
> +			default-state = "off";
> +		};
> +
> +		red_sata3_led {
> +			label = "rn2120:red:sata3";
> +			gpios = <&gpio1 12 0>;   /* GPIO 44 Active High */
> +			default-state = "off";
> +		};
> +
> +		red_sata4_led {
> +			label = "rn2120:red:sata4";
> +			gpios = <&gpio1 15 0>;   /* GPIO 47 Active High */
> +			default-state = "off";
> +		};
> +
> +		red_err_led {
> +			label = "rn2120:red:err";
> +			gpios = <&gpio1 13 1>;   /* GPIO 45 Active Low */
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Again, no addressing of those buttons possible.

> +		pinctrl-0 = <&power_key_pin
> +			     &reset_key_pin>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {

Instead of button at n you can name the nodes after their function,
e.g. power_button, reset_button, ...

I know both comments above are in the current binding documentation
(at least for gpio-keys-polled.txt, there is no gpio-keys.txt); but
IMHO both "bus-like" structure of gpio_keys and numbering of buttons
just looks so wrong.

Sebastian

> +			label = "Power Button";
> +			linux,code = <116>;     /* KEY_POWER */
> +			gpios = <&gpio0 27 0>;
> +		};
> +
> +		button at 2 {
> +			label = "Reset Button";
> +			linux,code = <0x198>;   /* KEY_RESTART */
> +			gpios = <&gpio1 9 1>;
> +		};
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 10 1>;
> +	};
> +};
>
