From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Sep 2015 11:11:05 +0200
Subject: [PATCH 2/2] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <CAL4ahLeuPX7viZ5=RaC92=n+jT82=Fa3tF7oH8Q=kE=PKVBSwQ@mail.gmail.com>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
 <2311005.jUde56dLfB@wuerfel>
 <CAL4ahLeuPX7viZ5=RaC92=n+jT82=Fa3tF7oH8Q=kE=PKVBSwQ@mail.gmail.com>
Message-ID: <2971356.lYN9OVO6Id@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 September 2015 12:55:55 Y Vo wrote:
> On Fri, Sep 11, 2015 at 11:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 11 September 2015 22:06:58 Y Vo wrote:
> >> On Fri, Sep 11, 2015 at 9:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Friday 11 September 2015 21:23:31 Y Vo wrote:
> >> >> Is that possible if we change to this approach:
> >> >> - Keep all GPIO as GPIO mode by default.
> >> >> - If anyone want to use them as interrupt, they must add the interrupt
> >> >> node to DT specific-board below:
> >> >>
> >> >> Example to configure GPIO_DS11, 12, 13 as external irq:
> >> >>
> >> >> &sbgpio {
> >> >>         interrupts = <0x0 0x2b 0x1>,         /* GPIO_DS11 */
> >> >>                         <0x0 0x2c 0x1>,         /* GPIO_DS12 */
> >> >>                         <0x0 0x2d 0x1>;         /* GPIO_DS13 */
> >> >
> >> > That is exactly the same as you have in your patch. You should
> >> > always list all interrupts that the gpio controller is wired
> >> > to, whether they are used or not.
> >> >
> >> > Ideally, the driver just decides at runtime how to wire that
> >> > mux, based on how the gpio is configured by the client driver.
> >> > If the client asks for an interrupt (with gpio_to_irq) and is
> >> > it is configured as an input, then you connect it to the GIC,
> >> > otherwise you leave it to be handled by the gpio chip itself.
> >> > Any reason you can't do that?
> >> >
> >> As I just explained, the GPIO Standby doesn't support the interrupt.
> >> Both interrupts are came from GIC, so if the client asks for an
> >> interrupt, it will go to the GIC driver (not GPIO Standby driver), so
> >> that's my trouble. We can not implement the code to configured the
> >> GPIO standby at GIC driver.
> >
> > So you are saying we merged a binding that is incapable of describing
> > the hardware? If that is the case, we may have to go back to
> > the drawing board and come up with a working binding.
> >
> > One part that I don't understand yet is how the driver handles
> > irqs to start with, as it does not register a nested irq domain
> > or irqchip, so I'm guessing that client drivers cannot actually
> > use the IRQ functionality. Is that right?
> For our case the irq_domain is in irq-gic driver, the GPIO driver only
> is responsible to wire 2 the external irq of GIC to GPIO pin.
> 
> Example for configure GPIO_DS13 as interrupt and use as button with
> the current gpio driver:
>         gpio-keys {
>                 compatible = "gpio-keys";
>                 button at 1 {
>                         label = "POWER";
>                         linux,code = <116>;
>                         linux,input-type = <0x1>;
>                         interrupts = <0x0 0x2d 0x1>;
>                 };
>         };

Wait, this looks wrong: the gpio driver doesn't actually see
the connection here and won't be able to configure the interrupt
correctly. The interrupt is already owned by the gpio driver, so
you cannot use it in the button node.

> >
> > It also seems to me that the binding cannot distinguish between a
> > line configured as an input and one that is configured as an
> > interrupt, which are for other gpio chips the same thing, but
> > not on this one.  Could this be rectified by using another bit
> > of the second gpio cell? The low bit is used for active-high/active-low,
> > so you could use the second bit for irq/input.
> >
> Do you mean #gpio-cells property and using the high bit of the second
> bit for irq/input  ?

Yes, that would be an option.

	Arnd
