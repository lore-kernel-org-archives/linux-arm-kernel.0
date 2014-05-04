From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 04 May 2014 23:21:37 +0200
Subject: [PATCH v2 2/5] ARM: Kirkwood: Add DT descriptions for net2big
 and net5big.
In-Reply-To: <1399142114-24257-3-git-send-email-andrew@lunn.ch>
References: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
 <1399142114-24257-3-git-send-email-andrew@lunn.ch>
Message-ID: <5366AF61.2090806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2014 08:35 PM, Andrew Lunn wrote:
> Describe LaCie 2Big and 5Big Network v2 using device tree.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2
> Fix size of memory
> Clean up ethernet nodes
> s/at/atmel/
> ---
[...]
> diff --git a/arch/arm/boot/dts/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
> new file mode 100644
> index 000000000000..604d7f4949af
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
> @@ -0,0 +1,171 @@
> +/*
> + * Device Tree common file for LaCie 2Big and 5Big Network v2
> + *
> + * Copyright (C) 2014
> + *
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * Based on netxbig_v2-setup.c,
> + * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> +*/
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";

nit: add stdout-path = &uart0;

> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			status = "ok";

nit: s/ok/okay/

> +		};
> +
> +		spi at 10600 {
> +			pinctrl-0 = <&pmx_spi>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +
> +			flash at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "mxicy,mx25l4005a";
> +				reg = <0>;
> +				spi-max-frequency = <20000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x80000>;
> +					label = "u-boot";
> +				};
> +			};
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +
> +	};
> +
> +	gpio_keys {

nit: s/gpio_keys/gpio-keys/

> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/*
> +		 * button at 1 and button at 2 represent a three position rocker
> +		 * switch. Thus the conventional KEY_POWER does not fit
> +		 */
> +		button at 1 {
> +			label = "Back power switch (on|auto)";
> +			linux,code = <KEY_ESC>;
> +			linux,input-type = <5>;
> +			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +		};
> +		button at 2 {
> +			label = "Back power switch (auto|off)";
> +			linux,code = <KEY_1>;
> +			linux,input-type = <5>;
> +			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> +		};
> +		button at 3 {
> +			label = "Function button";
> +			linux,code = <KEY_OPTION>;
> +			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +	};
> +
> +	gpio_poweroff {

nit: s/gpio_poweroff/gpio-poweroff/

If there is nothing more severe with this, I am sure Jason can
just squash in the nits.

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +		compatible = "gpio-poweroff";
> +		gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +       	regulators: regulators {
> +                status = "okay";
> +                compatible = "simple-bus";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                pinctrl-names = "default";
> +
> +                regulator at 1 {
> +                        compatible = "regulator-fixed";
> +                        reg = <1>;
> +                        regulator-name = "hdd0power";
> +                        regulator-min-microvolt = <5000000>;
> +                        regulator-max-microvolt = <5000000>;
> +                        enable-active-high;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                        gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +                };
> +
> +                regulator at 2 {
> +                        compatible = "regulator-fixed";
> +                        reg = <2>;
> +                        regulator-name = "hdd1power";
> +                        regulator-min-microvolt = <5000000>;
> +                        regulator-max-microvolt = <5000000>;
> +                        enable-active-high;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                        gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> +                };
> +
> +        };
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		reg = <8>;
> +	};
> +
> +	ethphy1: ethernet-phy at 1 {
> +		reg = <0>;
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
> +&pinctrl {
> +	pinctrl-names = "default";
> +
> +	pmx_button_function: pmx-button-function {
> +		marvell,pins = "mpp34";
> +		marvell,function = "gpio";
> +	};
> +	pmx_button_power_off: pmx-button-power-off {
> +		marvell,pins = "mpp15";
> +		marvell,function = "gpio";
> +	};
> +	pmx_button_power_on: pmx-button-power-on {
> +		marvell,pins = "mpp13";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-0 = <&pmx_twsi0>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	eeprom at 50 {
> +		compatible = "atmel,24c04";
> +		pagesize = <16>;
> +		reg = <0x50>;
> +	};
> +};
> +
> 
