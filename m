From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 11 Nov 2013 21:33:41 +0100
Subject: [PATCHv2] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <87bo1qhfnf.fsf@natisbad.org>
References: <87bo1qhfnf.fsf@natisbad.org>
Message-ID: <52813F25.40703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 09:01 PM, Arnaud Ebalard wrote:
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
> diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> new file mode 100644
> index 0000000..ba1e0de
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> @@ -0,0 +1,288 @@
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
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>

nit: order includes global before local, i.e. {gpio,input}.h before .dtsi

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
[...]
> +			serial at 12000 {
> +				clocks = <&coreclk 0>;
> +				status = "okay";
> +			};

For your possible cleanup later: move clocks = <&coreclk 0> to
armada-370-xp.dtsi and remove this then.

Also for cleanup later: It would be great if most SoC nodes get
a node label. That way you can just write:

uart0: { status = "okay" };

without replaying node hierarchy over and over again.

> +			mdio {
> +				phy0: ethernet-phy at 0 {
> +					compatible = "marvell,88e1318s";
> +					reg = <0>;
> +				};
> +
> +				phy1: ethernet-phy at 1 {
> +					compatible = "marvell,88e1318s";
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
> +				compatible = "marvell,mv78230-i2c";
> +				clock-frequency = <400000>;
> +				status = "okay";
> +
> +				/* Controller for rear fan #1 of 3 (Protechnic
> +				 * MGT4012XB-O20, 8000RPM) near eSATA port */
> +				g762_fan1: g762 at 3e {
> +					compatible = "gmt,g762";
> +					reg = <0x3e>;
> +					clocks = <&g762_clk>; /* input clock */
> +					fan_gear_mode = <0>;
> +					fan_startv = <1>;
> +					pwm_polarity = <0>;

I haven't looked at g762 dt-bindings, but above properties should have
s/_/- and possibly also vendor prefix if device specific,
e.g. gmt,fan-hear-mode. Depends on your g762 binding review.

> +				};
> +
> +				/*  Controller for rear (center) fan #2 of 3 */
> +				g762_fan2: g762 at 48 {
> +					compatible = "gmt,g762";
> +					reg = <0x48>;
> +					clocks = <&g762_clk>; /* input clock */
> +					fan_gear_mode = <0>;
> +					fan_startv = <1>;
> +					pwm_polarity = <0>;
> +				};
> +
> +				/*  Controller for rear fan #3 of 3 */
> +				g762_fan3: g762 at 49 {
> +					compatible = "gmt,g762";
> +					reg = <0x49>;
> +					clocks = <&g762_clk>; /* input clock */
> +					fan_gear_mode = <0>;
> +					fan_startv = <1>;
> +					pwm_polarity = <0>;
> +				};
> +
> +				/* Temperature sensor */
> +				g751: g751 at 4c {
> +					compatible = "gmt,g751";
> +					reg = <0x4c>;
> +				};
> +			};
> +		};
> +	};
> +
> +	clocks {
> +	       g762_clk: g762_oscillator {

While node labels have '_', node names usually have '-'.

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

ditto here and below.

> +			label = "rn2120:red:sata1";
> +			gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		red_sata2_led {
> +			label = "rn2120:red:sata2";
> +			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		red_sata3_led {
> +			label = "rn2120:red:sata3";
> +			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		red_sata4_led {
> +			label = "rn2120:red:sata4";
> +			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		red_err_led {
> +			label = "rn2120:red:err";
> +			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&power_button_pin &reset_button_pin>;
> +		pinctrl-names = "default";
> +
> +		power_button {

ditto here and below.

> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		reset_button {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio_poweroff {

ditto.

Besides the nits,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +	};
> +};
>
