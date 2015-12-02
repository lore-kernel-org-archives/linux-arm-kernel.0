From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Dec 2015 09:07:35 -0600
Subject: [PATCH 1/3] pinctrl: Broadcom NSP GPIO-a device tree bindings
In-Reply-To: <1449031598-18849-1-git-send-email-yrdreddy@broadcom.com>
References: <1449031598-18849-1-git-send-email-yrdreddy@broadcom.com>
Message-ID: <20151202150735.GA6165@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:46:38PM -0500, Yendapally Reddy Dhananjaya Reddy wrote:
> Device tree binding documentation for Broadcom NSP GPIO-a driver

Bindings are for h/w, not drivers...

> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
> ---
>  .../devicetree/bindings/pinctrl/brcm,nsp-gpio.txt  | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt
> new file mode 100644
> index 0000000..bea4211
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt
> @@ -0,0 +1,80 @@
> +Broadcom Northstar plus (NSP) GPIO/PINCONF Controller
> +
> +Required properties:
> +- compatible:
> +    Must be "brcm,nsp-gpio-a"
> +
> +- reg:
> +    Should contain the register physical address and length for each of
> +    GPIO base, IO control registers
> +
> +- #gpio-cells:
> +    Must be two. The first cell is the GPIO pin number (within the
> +    controller's pin space) and the second cell is used for the following:
> +    bit[0]: polarity (0 for active high and 1 for active low)
> +
> +- gpio-controller:
> +    Specifies that the node is a GPIO controller
> +
> +- ngpios:
> +    Number of gpios supported (58x25 supports 32 and 58x23 supports 24)

2 chips? You should have 2 compatible strings. I think this is incorrect 
use of ngpios which AIUI is not for how many lines there are, but how 
many can be used (e.g. not reserved).

> +
> +Optional properties:
> +- interrupts:
> +    Interrupt ID
> +
> +- interrupt-controller:
> +    Specifies that the node is an interrupt controller
> +
> +- gpio-ranges:
> +    Specifies the mapping between gpio controller and pin-controllers pins.
> +    This requires 4 fields in cells defined as -
> +    1. Phandle of pin-controller.
> +    2. GPIO base pin offset.
> +    3  Pin-control base pin offset.
> +    4. number of gpio pins which are linearly mapped from pin base.
> +
> +Supported generic PINCONF properties in child nodes:
> +- pins:
> +    The list of pins (within the controller's own pin space) that properties
> +    in the node apply to. Pin names are "gpio-<pin>"
> +
> +- bias-disable:
> +    Disable pin bias
> +
> +- bias-pull-up:
> +    Enable internal pull up resistor
> +
> +- bias-pull-down:
> +    Enable internal pull down resistor
> +
> +- drive-strength:
> +    Valid drive strength values include 2, 4, 6, 8, 10, 12, 14, 16 (mA)
> +
> +Example:
> +
> +	gpioa: gpio-a at 18000020 {

node names are preferred to be generic, so just "gpio at ..."

> +		compatible = "brcm,nsp-gpio-a";
> +		reg = <0x18000020 0x100>,
> +		      <0x1803f1c4 0x1c>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <32>;
> +		gpio-ranges = <&pinctrl 0 0 31>;
> +		interrupt-controller;
> +		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		/* Hog a few default settings */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led>;
> +		led: led {
> +			pins = "gpio-1";
> +			bias-pull-up;
> +		};
> +
> +		pwr: pwr {
> +			gpio-hog;
> +			gpios = <3 1>;
> +			output-high;
> +		};
> +	};
> -- 
> 2.1.0
> 
