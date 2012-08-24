From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 24 Aug 2012 07:45:52 +0400
Subject: [PATCH] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <CACRpkdZrcBLz+sg-AwWnBD0SA697uWQzocUYnbC1nPYG14LYyA@mail.gmail.com>
References: <1345635383-12224-1-git-send-email-shc_work@mail.ru>
 <CACRpkdZrcBLz+sg-AwWnBD0SA697uWQzocUYnbC1nPYG14LYyA@mail.gmail.com>
Message-ID: <20120824074552.97d32478.shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Fri, 24 Aug 2012 00:08:45 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

...
> > +static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
> > +{
> > +       int ret;
> > +       struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
> > +
> > +       mutex_lock(&gpio->lock);
> > +       ret = clps_readb(gpio_clps711x_port_dataaddr(chip)) & (1 << offset);
> > +       mutex_unlock(&gpio->lock);
> > +
> > +       return !!ret;
> > +}
> 
> Please get rid of this clps_readb() business. I can see it's just this:
> #define clps_readb(off)         readb(CLPS711X_VIRT_BASE + (off))
> 
> This makes stuff hard to understand, please pass the virtual base as
> a memory resource to the platform device, store it in the state holder
> and just use readb() in the driver from that offset.

This will break the whole concept of this platform. All the CPU registers
are in one particular area, and therefore access to the registers of all
the drivers performed using the macro.
Maybe just add a short comment?

-- 
Alexander Shiyan <shc_work@mail.ru>
