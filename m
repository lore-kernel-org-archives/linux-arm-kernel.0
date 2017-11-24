From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Nov 2017 11:19:52 +0100
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new generic
 binding
In-Reply-To: <20171113012523.2328-2-andre.przywara@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
Message-ID: <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 2:25 AM, Andre Przywara <andre.przywara@arm.com> wrote:

> So far all the Allwinner pinctrl drivers provided a table in the
> kernel to describe all the pins and the link between the pinctrl functions
> names (strings) and their respective mux values (register values).
>
> Extend the binding to put those mappings in the DT, so that any SoC can
> describe its pinctrl and GPIO data fully there instead of relying on
> tables.
> This uses a generic compatible name, to be prepended with an SoC
> specific name in the node.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
(...)

I definately want feedback from Maxime before I do anything with
this patch series.

> +** Generic pinctrl binding
> +The above binding requires knowledge of the actual mux setting values for
> +each supported SoC in the code parsing the DT (for instance the kernel).
> +The generic binding puts this information in the DT. It uses the
> +"allwinner,sunxi-pinctrl" compatible, in addition to some SoC specific string.
> +It extends the above described binding as follows:
> +Required properties:
> +- allwinner,gpio-pins: An array of 32-bit numbers to denote the number of
> +  implemented pins per pin controller port. Non-implemented ports can specify
> +  0 here. There will be as many ports as this array has elements.

I don't understand what this adds that gpio-ranges does not already
provide.
Documentation/devicetree/bindings/gpio/gpio.txt
at the end of the file.

These ranges exist exactly to map pin controller pins in a pin controller
to GPIO lines in a gpiochip.

> +- allwinner,irq-pin-map: Contains a number of IRQ port maps, describing the
> +  relationship between interrupt banks and GPIO pins. Each map has six 32-bit
> +  members:
> +  <[IRQ port] [1st IRQ pin] [GPIO port] [1st GPIO pin] [mux value] [length]>
> +  This maps the first [length] IRQ pins starting with [IRQ port]:[1st IRQ pin]
> +  to [GPIO port]:[1st GPIO pin], all using [mux value] to select the IRQ
> +  functionality.

We have recently added GPIO "bank" awareness into gpiolib
via Thierry Reding's patches, so a gpiochip can use the generic
GPIOLIB_IRQCHIP and specify multiple IRQ parents with a map.

Please see if you can use this instead.

If any of this should be expressed in the DT bindings it should
be genericized and not use any "allwinner,*" prefixes, and it
should preferably just be hard-coded in the driver and switched
in from the compatible string IMO.

> +Optional properties:
> +- allwinner,port-base: The number of GPIO ports to skip at the beginning.
> +- allwinner,irq-bank-base: The number of IRQ banks to skip at the beginning.

I don't understand this. It looks hacky. Can you elaborate why this
is needed?

> +- allwinner,irq-read-needs-mux: Specifies that reading the line level of
> +  a pin configured as an IRQ pin is not possible. A driver needs to switch
> +  to the GPIO-in function to be able to read the level.

I guess it is a bool flag?

> +Required properties for subnodes:
> +- pinmux: An array of mux values to write into the respective MMIO register
> +  bits for this pin when selecting the function. If this array has less
> +  elements than pins, the *last* value will be used for all pins beyond that.
> +  This allows to use a single element for the (likely) case all pins use the
> +  same mux value.

This is a standard bindings so I don't have much against it. But I
need Maxime's input here, I think we should keep Allwinner consistent
across SoCs.

Yours,
Linus Walleij
