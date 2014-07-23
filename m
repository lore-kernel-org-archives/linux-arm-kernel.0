From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jul 2014 18:14:02 +0200
Subject: [[RFC PATCH]] gpio: gpio-mxc: make sure gpio is input when
 request IRQ
In-Reply-To: <20140722074257.GC21229@dragon>
References: <1405518664-31313-1-git-send-email-list-09_linux_arm@tqsc.de>
 <20140722062803.GA21229@dragon> <53CE107A.1000000@tqsc.de>
 <20140722074257.GC21229@dragon>
Message-ID: <CACRpkdYxOv+k2Sazm83sA=LwKUv5yMzag44A=Ez8pNQHRO3V6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 9:42 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Jul 22, 2014 at 09:19:22AM +0200, Markus Niebel wrote:

>> Currently client drivers have simply interrupts and interrupt-parent
>> in their bindings, but no interrupt-gpios. Therefore in this case a
>> client does not know about a dedicated gpio which is to be requested
>> and configured.
>
> Okay.  I understand your problem now.  This is an issue in case we
> specify a GPIO to be used as interrupt from device tree.  In non-DT
> world, client driver knows this is an interrupt on GPIO, and therefore
> takes the responsibility to request and configure the GPIO to work as
> interrupt.  But in DT case, client driver does not know whether it's an
> IRQ line or GPIO based interrupt.  The consequence is that GPIO
> subsystem, OF subsystem, client driver, none of the three is requesting
> and configuring the GPIO to be used as interrupt.
>
> This is a common issue instead of i.MX specific, and should be addressed
> globally, I think.

This is very well documented in Documentation/gpio/driver.txt these
days. Quoting:

"
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


Locking IRQ usage
-----------------
Input GPIOs can be used as IRQ signals. When this happens, a driver is requested
to mark the GPIO as being used as an IRQ:

        int gpiod_lock_as_irq(struct gpio_desc *desc)

This will prevent the use of non-irq related GPIO APIs until the GPIO IRQ lock
is released:

        void gpiod_unlock_as_irq(struct gpio_desc *desc)

When implementing an irqchip inside a GPIO driver, these two functions should
typically be called in the .startup() and .shutdown() callbacks from the
irqchip.
"

So: make sure each API can be used orthogonally by just poking
into the hardware registers. Do not call gpio_request_one().

Yours,
Linus Walleij
