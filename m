From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 24 Nov 2017 11:58:54 +0000
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new generic
 binding
In-Reply-To: <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
 <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
Message-ID: <d3bbbcb4-eb91-7f6a-bc0e-a99bb69351c4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

thanks for having a look!

On 24/11/17 10:19, Linus Walleij wrote:
> On Mon, Nov 13, 2017 at 2:25 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> So far all the Allwinner pinctrl drivers provided a table in the
>> kernel to describe all the pins and the link between the pinctrl functions
>> names (strings) and their respective mux values (register values).
>>
>> Extend the binding to put those mappings in the DT, so that any SoC can
>> describe its pinctrl and GPIO data fully there instead of relying on
>> tables.
>> This uses a generic compatible name, to be prepended with an SoC
>> specific name in the node.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> (...)
> 
> I definately want feedback from Maxime before I do anything with
> this patch series.
> 
>> +** Generic pinctrl binding
>> +The above binding requires knowledge of the actual mux setting values for
>> +each supported SoC in the code parsing the DT (for instance the kernel).
>> +The generic binding puts this information in the DT. It uses the
>> +"allwinner,sunxi-pinctrl" compatible, in addition to some SoC specific string.
>> +It extends the above described binding as follows:
>> +Required properties:
>> +- allwinner,gpio-pins: An array of 32-bit numbers to denote the number of
>> +  implemented pins per pin controller port. Non-implemented ports can specify
>> +  0 here. There will be as many ports as this array has elements.
> 
> I don't understand what this adds that gpio-ranges does not already
> provide.
> Documentation/devicetree/bindings/gpio/gpio.txt
> at the end of the file.

Ah, thanks for the pointer, will try to see if that fits in here.
Although here (despite my clumsy naming) I think this is more about the
"pinmux" pins than the GPIOs. I am not sure if it's just my
understanding or if on Allwinner we just happen to have every pinmux pin
being a GPIO pin as well, so the distinction between the two isn't so clear.

> These ranges exist exactly to map pin controller pins in a pin controller
> to GPIO lines in a gpiochip.

Which makes it a bit more confusing because we have the pinctrl and GPIO
controller drivers combined in one file.

>> +- allwinner,irq-pin-map: Contains a number of IRQ port maps, describing the
>> +  relationship between interrupt banks and GPIO pins. Each map has six 32-bit
>> +  members:
>> +  <[IRQ port] [1st IRQ pin] [GPIO port] [1st GPIO pin] [mux value] [length]>
>> +  This maps the first [length] IRQ pins starting with [IRQ port]:[1st IRQ pin]
>> +  to [GPIO port]:[1st GPIO pin], all using [mux value] to select the IRQ
>> +  functionality.
> 
> We have recently added GPIO "bank" awareness into gpiolib
> via Thierry Reding's patches, so a gpiochip can use the generic
> GPIOLIB_IRQCHIP and specify multiple IRQ parents with a map.
> 
> Please see if you can use this instead.

Thanks for the hint, will have a look.

> If any of this should be expressed in the DT bindings it should
> be genericized and not use any "allwinner,*" prefixes, and it
> should preferably just be hard-coded in the driver and switched
> in from the compatible string IMO.

I agree, this allwinner prefix was just a first shot for the RFC.

The reason for this map is that older Allwinner SoCs have *one* IRQ pin
bank, which contains pins from *multiple* GPIO banks. The A10/A20 for
instance maps the first 22 IRQ pins to Port H0-H21, the remaining 10 IRQ
pins are on port I10-I19. This irq-pin-map is an admittedly
over-engineered attempt to express this is a generic way, trying to
embrace the DT way of mapping things, like we do with the "ranges"
property, for instance.

Recent SoCs just have some GPIO banks which map directly to IRQ pin
banks (on the A64 ports B, G and H map to IRQ bank 0, 1 and 2), so this
is not really needed here. My first version indeed just had a simpler
list to express this.

This series aims to build on top of the existing driver as much as
possible, so some things are not as elegant as they could be.

>> +Optional properties:
>> +- allwinner,port-base: The number of GPIO ports to skip at the beginning.
>> +- allwinner,irq-bank-base: The number of IRQ banks to skip at the beginning.
> 
> I don't understand this. It looks hacky. Can you elaborate why this
> is needed?

It is indeed hacky, and just maps the irq_bank_base member of struct
sunxi_pinctrl_desc into the DT. My understanding is that the A33 skips
the first interrupt bank in the register map, for whatever reason. Might
just be an implementation oddity.
I am just wondering if this could be expressed with the irq-pin-map
above. Or if it's more or less an A33 bug, we could derive this from the
compatible string.

>> +- allwinner,irq-read-needs-mux: Specifies that reading the line level of
>> +  a pin configured as an IRQ pin is not possible. A driver needs to switch
>> +  to the GPIO-in function to be able to read the level.
> 
> I guess it is a bool flag?

Right, should mention that.

>> +Required properties for subnodes:
>> +- pinmux: An array of mux values to write into the respective MMIO register
>> +  bits for this pin when selecting the function. If this array has less
>> +  elements than pins, the *last* value will be used for all pins beyond that.
>> +  This allows to use a single element for the (likely) case all pins use the
>> +  same mux value.
> 
> This is a standard bindings so I don't have much against it. But I
> need Maxime's input here, I think we should keep Allwinner consistent
> across SoCs.

I can understand that, and that's why I choose the new binding to just
be an extension of what we have already.

I am happy to have a discussion on that in general - actually this was
one aim of this series. See the other thread.

I might even write some summary on how it works today and why I believe
it should be improved, I just wasn't sure that was actually needed.

Cheers,
Andre.
