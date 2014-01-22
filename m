From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 11:11:03 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a gpio
 used as an interrupt source.
In-Reply-To: <52D6C545.6080402@atmel.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <52D3C166.5050908@overkiz.com> <52D6C545.6080402@atmel.com>
Message-ID: <CACRpkdaAe7M3RjOiOrs9-bF5p80mshxbcNwKoDSMAXJ+5D27Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 6:28 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 13/01/2014 11:35, boris brezillon :

>> You should only request it as a GPIO and then use gpio_to_irq to get the
>> related IRQ.
>> Because what is done here, is to solve the case where only the irq
>> is request, and in this specific case we need to request the pin as a
>> GPIO.
>
> Yes, this is what we do.
>
> It seems simple and obvious to me, but some may say that "you shall not
> do that, it is horrible!". Well... I always tend to choose a solution
> that works. It is one of my weaknesses, I admit ;-)
>
> Linus W. any advice on this, before we hit again one of those infinite
> threads that leads no progress at all?

So we recently established that it is actually OK for any IRQ
consumer to request an IRQ from any irq_chip no matter if
that is a combined GPIO+IRQ driver. This was concluded after
a long discussion involving several parties.

gpio_to_irq() is just a convenience function and should not be
relied upon to have been called before the IRQ is used.

The basic premise is that gpio_chip and irq_chip are
orthogonal, and offering their services independent of each
other.

Especially in the device tree use case it is very hard to
dictate that a certain semantic need to be followed to use
a certain interrupt-controller to have dependencies to a
certain gpio-controller. So they need to be orthogonal.

First step is: always prepare the hardware and make it
ready for action in respective callbacks from the gpio_chip API
and irq_chip API. Do not rely on gpio_to_irq() having been
called first anymore.

This leads to ambiguities that we need to solve: if there is
competition inside the subsystem which side is using
the resource (a certain GPIO line and register for example)
it needs to deny certain operations and keep track of usage
inside of the gpiolib subsystem.

We have added a new API to help with this situation:

 gpio_lock_as_irq(struct gpio_chip *chip, unsigned int offset)
 gpio_unlock_as_irq(struct gpio_chip *chip,
                                      unsigned int offset)

These should be called from the irq_chip startup() and
.shutdown() callbacks to flag that the line is now in use by
an IRQ. For example the GPIOlib core will deny the line to
be set as output after this.

If we need more infrastructure to help with this, I'm game.

Clear as mud? ;-)

Yours,
Linus Walleij
