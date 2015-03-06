From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Mar 2015 10:12:53 +0100
Subject: [PATCH v2 10/18] dt-bindings: Document the STM32 pin controller
In-Reply-To: <1424455277-29983-11-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-11-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdaRuFE4Ja8pJEGKuf7yorkyjAHwB+KZn7yz60P+ZnyvOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> This adds documentation of device tree bindings for the
> STM32 pin controller.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
(...)
> +Pin controller node:
> +Required properies:
> +- compatible   : "st,stm32-pinctrl"
> +- #address-cells: The value of this property must be 1
> +- #size-cells  : The value of this property must be 1
> +- ranges       : defines mapping between pin controller node (parent) to
> +  gpio-bank node (children).
> +
> +GPIO controller/bank node:
> +Required properties:
> +- gpio-controller : Indicates this device is a GPIO controller
> +- #gpio-cells    : Should be two.
> +                       The first cell is the pin number
> +                       The second one is the polarity:
> +                               - 0 for active high
> +                               - 1 for active low
> +- reg            : The gpio address range, relative to the pinctrl range
> +- st,bank-name   : Should be a name string for this bank as specified in
> +  the datasheet

OK...

(...)
> +               ...
> +               pin-functions nodes follow...
> +       };
> +
> +Contents of function subnode node:
> +----------------------------------
> +
> +Required properties for pin configuration node:
> +- st,pins      : Child node with list of pins with configuration.

Don't use vendor prefix. Use the new standard notation, just "pins".
See Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

> +Below is the format of how each pin conf should look like.
> +
> +<bank offset altmode pull type speed>
> +
> +Every PIO is represented with 4 to 6 parameters.
> +Each parameter is explained as below.
> +
> +- bank   : Should be bank phandle to which this PIO belongs.
> +- offset  : Offset in the PIO bank.

No. Don't hardcode register offsets into the DTS files. This is
something the driver should know from the compatible string or
instance number, not by explicit reference.

> +- altmode : Should be mode or alternate function number associated this pin, as
> +described in the datasheet (IN, OUT, ALT0...ALT15, ANALOG)
> +- pull   : Should be either NO_PULL, PULL_UP or PULL_DOWN
> +- type   : Should be either PUSH_PULL or OPEN_DRAIN.
> +           Setting it is not needed for IN and ANALOG modes, or alternate
> +           functions acting as inputs.
> +- speed          : Value taken from the datasheet, depending on the function
> +(LOW_SPEED, MEDIUM_SPEED, FAST_SPEED, HIGH_SPEED)
> +           Setting it is not needed for IN and ANALOG modes, or alternate
> +           functions acting as inputs.

NACK. Make your Kconfig select GENERIC_PINCONF and use the
already existing generic pin configuration specifiers from the standard
bindings. Like bias-pull-up; etc.

This kind of custom pin config is a thing of the past.

> +usart1 {
> +       pinctrl_usart1: usart1-0 {
> +               st,pins {
> +                       tx = <&gpioa 9 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
> +                       rx = <&gpioa 10 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
> +               };
> +       };
> +};

You might have to use separate parameters for muxing and config
in your description.

Yours,
Linus Walleij
