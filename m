From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2016 00:12:32 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87eg57e54l.fsf@belgarion.home>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
Message-ID: <20160829231232.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 09:39:54PM +0200, Robert Jarzmik wrote:
> Hi Russell,
> 
> Russell King <rmk+kernel@armlinux.org.uk> writes:
> 
> > Add a simple, generic, single register fixed-direction GPIO driver.
> > This is able to support a single register where a fixed number of
> > bits are used for input and a fixed number of bits used for output.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/gpio/Kconfig     |   6 ++
> >  drivers/gpio/Makefile    |   1 +
> >  drivers/gpio/gpio-reg.c  | 139 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/gpio-reg.h |  12 ++++
> >  4 files changed, 158 insertions(+)
> >  create mode 100644 drivers/gpio/gpio-reg.c
> >  create mode 100644 include/linux/gpio-reg.h
> >
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 98dd47a30fc7..49bd8b89712e 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -365,6 +365,12 @@ config GPIO_RCAR
> >  	help
> >  	  Say yes here to support GPIO on Renesas R-Car SoCs.
> >  
> > +config GPIO_REG
> > +	bool
> So I suppose it is on purpose you forbid it to be a module. Is there a way to
> write either in the commit message or in the Kconfig this purpose, so that
> nobody on "purpose" changes this bool to tristate ?

The only forbidding is that it's used from code early at boot, so it has
to be available to the kernel for some of these platforms to function.
Even if it's changed to tristate, the select from these platforms would
force it to be built-in.

> > +	help
> > +	  A 32-bit single register GPIO fixed in/out implementation.  This
> > +	  can be used to represent any register as a set of GPIO signals.
> Another question I was asking myself was how it differenciated itself from
> gpio-mmio, ie. what brought the need for this driver that isn't available with
> gpio-mmio ?

gpio-mmio doesn't allow the fixed direction - it assumes that you always
have some form of direction register.  It also doesn't do the double-read
that's necessary for some platforms to get the "current" state of inputs.
It also doesn't do the "use 32-bit accessors even for smaller numbers of
GPIOs".  Lastly, it assumes that the current output state can be read
from the registers - this is not always the case (and is not the case for
Assabet.)

> I seem to understand that this is mainly for platform code, hence the
> "builtin only" necessity, and if I'm right a part of your cover letter
> could very well fit within this patch's commit message.

Apart from the missing MODULE_* tags and symbol exports, there's nothing
whic prohibits it becoming a module.

> > +static void gpio_reg_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> > +	unsigned long *bits)
> > +{
> > +	struct gpio_reg *r = to_gpio_reg(gc);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&r->lock, flags);
> > +	r->out = (r->out & ~*mask) | *bits;
> Shouldn't this be :
> 	r->out = (r->out & ~*mask) | (*bits & *mask);

Possibly, but the latter is redundant when used through gpiolib.

> > diff --git a/include/linux/gpio-reg.h b/include/linux/gpio-reg.h
> > new file mode 100644
> > index 000000000000..0352bec7319a
> > --- /dev/null
> > +++ b/include/linux/gpio-reg.h
> > @@ -0,0 +1,12 @@
> > +#ifndef GPIO_REG_H
> > +#define GPIO_REG_H
> > +
> > +struct device;
> > +
> > +struct gpio_chip *gpio_reg_init(struct device *dev, void __iomem *reg,
> > +	int base, int num, const char *label, u32 direction, u32 def_out,
> > +	const char *const *names);
> Maybe this one would deserve a doxygen comment ?

Maybe, but I've been told not to put such comments in header files.
I've already spent the last two weeks on this stuff (at the expense
of reading mail), I've not got around to thinking about any kind of
documentation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
