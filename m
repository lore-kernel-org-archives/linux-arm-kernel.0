From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 24 Sep 2012 21:49:57 +0400
Subject: [PATCH] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <CACRpkdZEh1sg5h5-uzpsYwxYM5W47q-1hk4sS3=dQQLaVUC1Vw@mail.gmail.com>
References: <1345635383-12224-1-git-send-email-shc_work@mail.ru>
 <CACRpkdZrcBLz+sg-AwWnBD0SA697uWQzocUYnbC1nPYG14LYyA@mail.gmail.com>
 <20120824074552.97d32478.shc_work@mail.ru>
 <CACRpkdZEh1sg5h5-uzpsYwxYM5W47q-1hk4sS3=dQQLaVUC1Vw@mail.gmail.com>
Message-ID: <20120924214957.6999df72.shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 1 Sep 2012 00:44:10 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> > ...
> >> > +static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
> >> > +{
> >> > +       int ret;
> >> > +       struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
> >> > +
> >> > +       mutex_lock(&gpio->lock);
> >> > +       ret = clps_readb(gpio_clps711x_port_dataaddr(chip)) & (1 << offset);
> >> > +       mutex_unlock(&gpio->lock);
> >> > +
> >> > +       return !!ret;
> >> > +}
...
> > This will break the whole concept of this platform. All the CPU registers
> > are in one particular area, and therefore access to the registers of all
> > the drivers performed using the macro.
> > Maybe just add a short comment?
> It does not break if you pass the offset CLPS711X_VIRT_BASE as
> a memory resource and reference from that, e.g.:
...
> If you do this, you should no longer need to include
> <mach/hardware.h> (or something more is wrong...)
I plan in the future to remove the macros clps_read/write, and while the time
to do an override for ports in the header mach/gpio.h.
Passing of resources to the driver still seems superfluous, in any case
I changed the code, so please comment on the new version, which will post today.

> BTW I cannot see where this patch adds the platform device
> named "gpio-clps711x"? Are you intending to do this later?
Yes, I forgot about it in the previous version. The new version of the code
is different and it is no longer necessary.

-- 
Alexander Shiyan <shc_work@mail.ru>
