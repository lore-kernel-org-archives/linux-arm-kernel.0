From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Dec 2014 13:02:02 -0600
Subject: [PATCHv2] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <20141224223434.GA20669@amd>
References: <20141203214641.GA1390@amd> <20141224223434.GA20669@amd>
Message-ID: <CAL_JsqJsDqYm-xfEM1CqNzJxfZY6vnYxaBYpT+3t4+gV2F3M1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 24, 2014 at 4:34 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> We are moving to device tree support on OMAP3, but that currently
> breaks ADP1653 driver. This adds device tree support, plus required
> documentation.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> ---
>
> Changed -microsec to -us, as requested by devicetree people.
>
> Fixed checkpatch issues.
>
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 2d88816..2c6c7c5 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -14,6 +14,15 @@ Optional properties for child nodes:
>       "ide-disk" - LED indicates disk activity
>       "timer" - LED flashes at a fixed, configurable rate
>
> +- max-microamp : maximum intensity in microamperes of the LED
> +                (torch LED for flash devices)
> +- flash-max-microamp : maximum intensity in microamperes of the
> +                       flash LED; it is mandatory if the LED should
> +                      support the flash mode
> +- flash-timeout-microsec : timeout in microseconds after which the flash
> +                           LED is turned off

Doesn't all this go in your flash led binding patch?

> +
> +
>  Examples:
>
>  system-status {
> @@ -21,3 +30,10 @@ system-status {
>         linux,default-trigger = "heartbeat";
>         ...
>  };
> +
> +camera-flash {
> +       label = "Flash";
> +       max-microamp = <50000>;
> +       flash-max-microamp = <320000>;
> +       flash-timeout-microsec = <500000>;
> +}
> diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> new file mode 100644
> index 0000000..3c7065f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> @@ -0,0 +1,38 @@
> +* Analog Devices ADP1653 flash LED driver
> +
> +Required Properties:
> +
> +  - compatible: Must contain one of the following
> +    - "adi,adp1653"
> +
> +  - reg: I2C slave address
> +
> +  - gpios: References to the GPIO that controls the power for the chip.
> +
> +There are two led outputs available - flash and indicator. One led is
> +represented by one child node, nodes need to be named "flash" and "indicator".
> +
> +Required properties of the LED child node:
> +- max-microamp : see Documentation/devicetree/bindings/leds/common.txt
> +
> +Required properties of the flash LED child node:
> +
> +- flash-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
> +- flash-timeout-us : see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +
> +        adp1653: led-controller at 30 {
> +                compatible = "adi,adp1653";
> +               reg = <0x30>;
> +                gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> +
> +               flash {
> +                        flash-timeout-us = <500000>;
> +                        flash-max-microamp = <320000>;
> +                        max-microamp = <50000>;
> +               };
> +                indicator {

These are different LEDs or different modes?

> +                        max-microamp = <17500>;

This is a bit inconsistent. The binding says this is for flash LEDs
torch mode, but I see no reason why it can't be common. Can you update
the binding doc to be clear here.

Also, aren't you missing label properties?

Rob
