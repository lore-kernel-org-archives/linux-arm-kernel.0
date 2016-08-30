From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2016 22:42:53 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <CACRpkdZJy9gZwH9__qXAf6nURN7xV6CbOaGC-JL6X5rDHN55VQ@mail.gmail.com>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <CACRpkdZJy9gZwH9__qXAf6nURN7xV6CbOaGC-JL6X5rDHN55VQ@mail.gmail.com>
Message-ID: <20160830214253.GP1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 11:25:19PM +0200, Linus Walleij wrote:
> On Mon, Aug 29, 2016 at 12:24 PM, Russell King
> <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Add a simple, generic, single register fixed-direction GPIO driver.
> > This is able to support a single register where a fixed number of
> > bits are used for input and a fixed number of bits used for output.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Clever, I like it!
> 
> >  include/linux/gpio-reg.h |  12 ++++
> 
> Can we put this in include/linux/gpio/gpio-reg.h?
> 
> I try to do some scopeing to <linux/gpio/*> there.

Sure, I'll just have to hunt through all the patches to find an occurance
of the include to fix them all up...

> > +#define to_gpio_reg(x) container_of(x, struct gpio_reg, gc)
> 
> You don't need that trickery anymore, just:
> 
> > +static int gpio_reg_get_direction(struct gpio_chip *gc, unsigned offset)
> > +{
> > +       struct gpio_reg *r = to_gpio_reg(gc);
> 
> struct gpio_reg *r = gpiochip_get_data(gc);
> 
> (applied everywhere)

I prefer my method by a long shot - it's always going to work because
the gpiochip is embedded within the gpio_reg structure, and the compiler
is inteligent enough to keep a single pointer around.  With your
suggestion, the compiler has no idea that 'r' and 'gc' are actually
the same pointer, but a different type, and we end up having to carry
around identical pointers in two registers rather than just one.

It makes more sense to use gpiochip_get_data() if gpio_chip were a const
data structure that was never embedded, but the way *gpiochip_add*()
writes to the structure and the presence of members like "base" prevents
that.

> 
> > +       if (dev)
> > +               ret = devm_gpiochip_add_data(dev, &r->gc, r);
> > +       else
> > +               ret = gpiochip_add_data(&r->gc, r);
> 
> Aha both device and device-less, I see.

Yes, to avoid problems with the transition to it - the legacy APIs
(such as ASSABET_BCR_frob(), etc) can be called really early, so we
need the gpiochip available early as well so we can keep the legacy
APIs working until they can be killed off.  There's some corner
cases in the assabet code which make that difficult at the moment.

This whole patch set is still very much a work-in-progress - there's
more that needs doing, but I wanted to get _this_ out there so that
people can reviewing it, and hopefully get it queued for the next
merge window.

> Apart from that it looks nice, any other questionmarks were
> fixed in the other replies.
> 
> Yours,
> Linus Walleij

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
