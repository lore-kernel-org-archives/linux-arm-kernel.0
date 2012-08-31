From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 00:44:10 +0200
Subject: [PATCH] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <20120824074552.97d32478.shc_work@mail.ru>
References: <1345635383-12224-1-git-send-email-shc_work@mail.ru>
 <CACRpkdZrcBLz+sg-AwWnBD0SA697uWQzocUYnbC1nPYG14LYyA@mail.gmail.com>
 <20120824074552.97d32478.shc_work@mail.ru>
Message-ID: <CACRpkdZEh1sg5h5-uzpsYwxYM5W47q-1hk4sS3=dQQLaVUC1Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 5:45 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> On Fri, 24 Aug 2012 00:08:45 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> ...
>> > +static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
>> > +{
>> > +       int ret;
>> > +       struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
>> > +
>> > +       mutex_lock(&gpio->lock);
>> > +       ret = clps_readb(gpio_clps711x_port_dataaddr(chip)) & (1 << offset);
>> > +       mutex_unlock(&gpio->lock);
>> > +
>> > +       return !!ret;
>> > +}
>>
>> Please get rid of this clps_readb() business. I can see it's just this:
>> #define clps_readb(off)         readb(CLPS711X_VIRT_BASE + (off))
>>
>> This makes stuff hard to understand, please pass the virtual base as
>> a memory resource to the platform device, store it in the state holder
>> and just use readb() in the driver from that offset.
>
> This will break the whole concept of this platform. All the CPU registers
> are in one particular area, and therefore access to the registers of all
> the drivers performed using the macro.
> Maybe just add a short comment?

It does not break if you pass the offset CLPS711X_VIRT_BASE as
a memory resource and reference from that, e.g.:

Add a base:

struct clps711x_gpio {
       struct gpio_chip       chip[CLPS711X_GPIO_PORTS];
       struct mutex            lock;
+     void __iomem         *base;
};

Fish out the base from the platform device (provided it's added to
the platform device) in .probe:

res = platform_get_resource(dev, IORESOURCE_MEM, 0);
if (!res) {
        ret = -ENOENT;
        goto out;
}
gpio->base = res->start;

The access registers like this:

foo = readb(gpio->base + gpio_clps711x_port_diraddr(chip));

It's no big change, just that the offset is included in every
access instead of using custom accessor functions which
are in an obscure <mach/*> header, and we want to get rid
of all such headers.

If you do this, you should no longer need to include
<mach/hardware.h> (or something more is wrong...)

BTW I cannot see where this patch adds the platform device
named "gpio-clps711x"? Are you intending to do this later?

Yours,
Linus Walleij
