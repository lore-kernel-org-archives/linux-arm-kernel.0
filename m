From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Mar 2016 09:48:34 -0500
Subject: [PATCH v3 12/18] dt-bindings: Add PLX Technology OXNAS pinctrl
 and gpio bindings
In-Reply-To: <1458838215-23314-13-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-13-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160325144834.GA27177@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 05:50:09PM +0100, Neil Armstrong wrote:
> Add pinctrl and gpio DT bindings for PLX Technology OXNAS SoC Family.
> This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/gpio/gpio_oxnas.txt        | 47 ++++++++++++++++++
>  .../bindings/pinctrl/plxtech,pinctrl.txt           | 57 ++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
> new file mode 100644
> index 0000000..4530fa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
> @@ -0,0 +1,47 @@
> +* PLX Technology OXNAS SoC GPIO Controller
> +
> +Required properties:
> + - compatible: "oxsemi,ox810se-gpio"
> + - reg: Base address and length for the device.
> + - interrupts: The port interrupt shared by all pins.
> + - gpio-controller: Marks the port as GPIO controller.
> + - #gpio-cells: Two. The first cell is the pin number and
> +   the second cell is used to specify the gpio polarity as defined in
> +   defined in <dt-bindings/gpio/gpio.h>:
> +      0 = GPIO_ACTIVE_HIGH
> +      1 = GPIO_ACTIVE_LOW
> + - interrupt-controller: Marks the device node as an interrupt controller.
> + - #interrupt-cells: Two. The first cell is the GPIO number and second cell
> +   is used to specify the trigger type as defined in
> +   <dt-bindings/interrupt-controller/irq.h>:
> +      IRQ_TYPE_EDGE_RISING
> +      IRQ_TYPE_EDGE_FALLING
> +      IRQ_TYPE_EDGE_BOTH
> + - plxtech,gpio-bank: Specifies which bank a controller owns.

How is this used?

> + - gpio-ranges: Interaction with the PINCTRL subsystem.
> + - ngpios: Specifies the gpio lines count in this specific bank.
> +
> +Example:
> +
> +gpio0: gpio at 0 {
> +	compatible = "oxsemi,ox810se-gpio";
> +	reg = <0x000000 0x100000>;
> +	interrupts = <21>;
> +	#gpio-cells = <2>;
> +	gpio-controller;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	plxtech,gpio-bank = <0>;
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +	ngpios = <32>;

Is 32 the max? It should not be needed then.

> +};
> +
> +keys {
> +	...
> +
> +	button at sw1 {

sw1 is not a unit-address. Just do "sw1-button".

> +		label = "ESC";
> +		linux,code = <1>;
> +		gpios = <&gpio0 12 0>;
> +	};
> +};
