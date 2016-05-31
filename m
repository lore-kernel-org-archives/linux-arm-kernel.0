From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 10:48:53 +0200
Subject: interrupts properties and API usage with GPIO controllers/Device
 Tree
In-Reply-To: <57461CDC.603@gmail.com>
References: <57461CDC.603@gmail.com>
Message-ID: <CACRpkdbys9JDCdwxpFuYFd_c=i2KaoTTf0WWX+J4qbiubSJNWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 11:45 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:

> - is this a valid API and Device Tree use case: call
> of_irq_parse_and_map on an "interrupts" property which has not been
> acquired using the GPIO API and then gpio_to_irq?

Yes. See Documentation/gpio/driver.txt:

-------

It is legal for any IRQ consumer to request an IRQ from any irqchip no matter
if that is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
irq_chip are orthogonal, and offering their services independent of each
other.

gpiod_to_irq() is just a convenience function to figure out the IRQ for a
certain GPIO line and should not be relied upon to have been called before
the IRQ is used.

So always prepare the hardware and make it ready for action in respective
callbacks from the GPIO and irqchip APIs. Do not rely on gpiod_to_irq() having
been called first.

This orthogonality leads to ambiguities that we need to solve: if there is
competition inside the subsystem which side is using the resource (a certain
GPIO line and register for example) it needs to deny certain operations and
keep track of usage inside of the gpiolib subsystem. This is why the API
below exists.

-----

> While gpio_to_irq()
> works, are not we losing the second specifier in the interrupt cells
> about what kind of interrupt type this is?

Yeah and .set_type() needs to work. See other drivers for inspiration...

> - would it be acceptable to export gpiochip_irq_map and
> gpiochip_irq_export to make them accessible as helpers so we could just
> wrap things a bit around or should I just open code the same things and
> allow gpiochip_irqchip_add to be passed custom irq_domain_ops for instance?

Rather than poke around in gpiolib internals, make a separate
implementation for corner cases unless you can make it really
clean and nice for all consumers.

Yours,
Linus Walleij
