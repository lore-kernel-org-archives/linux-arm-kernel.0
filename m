From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 19 Sep 2014 15:48:57 +0200
Subject: [PATCH 4/4] dt-bindings: Add pinctrl bindings for mt65xx/mt81xx.
In-Reply-To: <1411127306-13677-5-git-send-email-srv_hongzhou.yang@mediatek.com>
References: <1411127306-13677-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411127306-13677-5-git-send-email-srv_hongzhou.yang@mediatek.com>
Message-ID: <8504020.ELHUosuJMo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 19. September 2014, 19:48:26 schrieb 
srv_hongzhou.yang at mediatek.com:
> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
> 
> Add devicetree bindings for Mediatek SoC pinctrl driver.
> 
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt | 92
> ++++++++++++++++++++++ 1 file changed, 92 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt new file
> mode 100644
> index 0000000..e2deff6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
> @@ -0,0 +1,92 @@
> +* Mediatek MT65XX Pin Controller
> +
> +The Mediatek's Pin controller is used to control GPIO pins.
> +
> +Required properties:
> +- compatible: value should be either of the following.
> +    (a) "mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
> +- reg: Should contain the register physical address and length for the
> +  pin controller.
> +- gpio-controller : Marks the device node as a gpio controller.
> +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> +  binding is used, the amount of cells must be specified as 2. See the
> below +  mentioned gpio binding representation for description of
> particular cells. +
> +	Eg: <&pio 6 0>
> +	<[phandle of the gpio controller node]
> +	[pin number within the gpio controller]
> +	[flags]>
> +
> +	Values for gpio specifier:
> +	- Pin number: is a value between 0 to 202.
> +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> +            Only the following flags are supported:
> +            0 - GPIO_ACTIVE_HIGH
> +            1 - GPIO_ACTIVE_LOW
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices.
> +
> +A pinctrl node should contain at least one subnodes representing the
> +pinctrl groups available on the machine. Each subnode will list the
> +pins it needs, and how they should be configured, with regard to muxer
> +configuration and pullups. If one of these options is
> +not set, its actual value will be unspecified.
> +
> +Required subnode-properties:
> +
> +- mediatek,pinfunc: List of gpio number and function to mux.
> +
> +The mediatek,pinfunc can use defines directly,
> +which are already defind in boot/dts/mt8135-pinfunc.h.
> +
> +Optional subnode-properties:
> +- mediatek,pull: Integer, defines in dt-bindings/pinctrl/mt65xx.h.
> +    MT_PIN_PULL_DISABLE: No resistor
> +    MT_PIN_CONF_PULL_UP: Pull-up resistor
> +    MT_PIN_CONF_PULL_DOWN: Pull-down resistor

Please use the generic pinconfig for such options instead of defining your own.

For examples on how to do this in a devicetree-context using 
pinconf_generic_parse_dt_config() you could look at

drivers/pinctrl/nomadik/pinctrl-abx500.c
drivers/pinctrl/pinctrl-tz1090.c
drivers/pinctrl/sh-pfc/pinctrl.c


Heiko

> +
> +The mediatek,pull can be either a single value or an array.
> +If it is a single value, that means all pins use use this value for same.
> +If it is an array, the means one value per pin.
> +
> +Examples:
> +
> +pinctrl at 01c20800 {
> +	compatible = "mediatek,mt8135-pinctrl";
> +	reg = <0x01c20800 0x400>;
> +	gpio-controller;
> +	#gpio-cells = <2>;
> +
> +	i2c0_pins_a: i2c0 at 0 {
> +		mediatek,pinfunc = <MT8135_PIN_100_SDA0__FUNC_SDA0
> MT8135_PIN_101_SCL0__FUNC_SCL0>; +		mediatek,pull = 
<MT_PIN_PULL_DISABLE>;
> +	};
> +
> +	i2c1_pins_a: i2c1 at 0 {
> +		mediatek,pinfunc = <MT8135_PIN_195_SDA1__FUNC_SDA1
> MT8135_PIN_196_SCL1__FUNC_SCL1>; +		mediatek,pull = 
<MT_PIN_PULL_DISABLE>;
> +	};
> +
> +	i2c2_pins_a: i2c2 at 0 {
> +		mediatek,pinfunc = <MT8135_PIN_193_SDA2__FUNC_SDA2
> MT8135_PIN_194_SCL2__FUNC_SCL2>; +		mediatek,pull = 
<MT_PIN_PULL_DISABLE>;
> +	};
> +
> +	i2c3_pins_a: i2c3 at 0 {
> +		mediatek,pinfunc = <MT8135_PIN_35_SCL3__FUNC_SCL3
> MT8135_PIN_36_SDA3__FUNC_SDA3>; +		mediatek,pull = 
<MT_PIN_PULL_DISABLE>;
> +	};
> +
> +	uart2_pins_a: uart2 at 0 {
> +		mediatek,pinfunc = <MT8135_PIN_53_URXD2__FUNC_URXD2
> MT8135_PIN_54_UTXD2__FUNC_UTXD2>; +		mediatek,pull = 
<MT_PIN_PULL_DISABLE>;
> +	};
> +
> +	uart3_pins_a: uart3 at 0 {
> +		mediatek,pinfunc = <MT8135_PIN_191_URXD3__FUNC_URXD3
> MT8135_PIN_192_UTXD3__FUNC_UTXD3>; +		mediatek,pull =
> <MT_PIN_PULL_DISABLE>;
> +	};
> +	...
> +
> +};
