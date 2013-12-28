From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 28 Dec 2013 12:01:14 -0500
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
Message-ID: <20131228170114.GH19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sat, Dec 28, 2013 at 05:12:11PM +0100, Andrew Lunn wrote:
> The Excito Bubba B3 is a home server, single driver NAS box, Wifi

nit, s/driver/drive/

> access point, etc.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/Makefile        |    3 +-
>  arch/arm/boot/dts/kirkwood-b3.dts |  199 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-b3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index adcc6067eb13..0447d726a6bc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -71,7 +71,8 @@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
>  	integratorcp.dtb
>  dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
> -dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
> +dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-b3.dtb \
> +	kirkwood-cloudbox.dtb \
>  	kirkwood-db-88f6281.dtb \
>  	kirkwood-db-88f6282.dtb \
>  	kirkwood-dns320.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/kirkwood-b3.dts
> new file mode 100644
> index 000000000000..7c675db24b6b
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-b3.dts
> @@ -0,0 +1,199 @@
> +/*
> + * Device Tree file for Excito Bubba B3
> + *
> + * Copyright (C) 2013, Andrew Lunn <andrew@lunn.ch>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * Note: This requires a new'ish version of u-boot, which disables the
> + * L2 cache. If your B3 silently fails to boot, u-boot is probably too
> + * old. Either upgrade, or consider the following email:
> + *
> + * http://lists.debian.org/debian-arm/2012/08/msg00128.html

Nice, thanks for adding this.

> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "Excito B3";
> +	compatible = "excito,b3", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +	memory { /* 512 MB */
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			/* Wifi model has Atheros chipset on pcie port */
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ocp at f1000000 {

I plan on going though and sorting the nodes under the ocp bus for all
the dts files during the next cycle.  Would you mind sorting these so we
have one less to worry about?

> +		pinctrl: pinctrl at 10000 {
> +			pmx_button_power: pmx-button-power {
> +				marvell,pins = "mpp39";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_green: pmx-led-green {
> +				marvell,pins = "mpp38";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_red: pmx-led-red {
> +				marvell,pins = "mpp41";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_blue: pmx-led-blue {
> +				marvell,pins = "mpp42";
> +				marvell,function = "gpio";
> +			};
> +			pmx_beeper: pmx-beeper {
> +				marvell,pins = "mpp40";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		i2c at 11000 {
> +			status = "okay";
> +			/*
> +			 * There is something on the bus at address 0x64.
> +			 * Not yet identified what it is, maybe the eeprom
> +			 * for the Atheros WiFi chip?
> +			 */

Not related to accepting this patch, have you found anything in the
stock kernel?

> +		};
> +
> +		serial at 12000 {
> +			/* Internal on test pins, 3.3v TTL */

Do you have a pointer to a pin layout?

> +			pinctrl-0 = <&pmx_uart0>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +			pinctrl-0 = <&pmx_spi>;
> +			pinctrl-names = "default";
> +
> +			m25p16 at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "m25p16";
> +				reg = <0>;
> +				spi-max-frequency = <40000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0xc0000>;
> +					label = "u-boot";
> +				};
> +
> +				partition at c0000 {
> +					reg = <0xc0000 0x20000>;
> +					label = "u-boot env";
> +				};
> +
> +				partition at e0000 {
> +					reg = <0xe0000 0x120000>;
> +					label = "data";
> +				};
> +			};
> +		};
> +
> +		sata at 80000 {
> +			/* One internal, the second as eSATA */
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		/*
> +		 * There is one LED "port" on the front and the colours
> +		 * mix together giving some interesting combinations.
> +		 */
> +		compatible = "gpio-leds";
> +		pinctrl-0 = < &pmx_led_green &pmx_led_red
> +			      &pmx_led_blue >;
> +		pinctrl-names = "default";
> +
> +		programming_led {
> +			label = "bubba3:green:programming";
> +			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-off";

Perhaps we can use 'default-state = "off";' here to avoid the
linux-specific property?

thx,

Jason.

> +		};
> +
> +		error_led {
> +			label = "bubba3:red:error";
> +			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		active_led {
> +			label = "bubba3:blue:active";
> +			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pmx_button_power>;
> +		pinctrl-names = "default";
> +
> +		power-button {
> +			/* On the back */
> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	beeper: beeper {
> +		/* 4KHz Piezoelectric buzzer */
> +		compatible = "gpio-beeper";
> +		pinctrl-0 = <&pmx_beeper>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 8 {
> +		device_type = "ethernet-phy";
> +		reg = <8>;
> +	};
> +
> +	ethphy1: ethernet-phy at 24 {
> +		device_type = "ethernet-phy";
> +		reg = <24>;
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
> +	ethernet1-port at 0 {
> +		phy-handle = <&ethphy1>;
> +	};
> +};
> +
> -- 
> 1.7.10.4
> 
