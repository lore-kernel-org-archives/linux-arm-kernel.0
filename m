From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Mar 2017 09:49:39 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
Message-ID: <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Sat, Mar 4, 2017 at 6:48 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Cc += linux-gpio at vger.kernel.org
>
> On Sat, Mar 04, 2017 at 04:35:46PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Mar 3, 2017 at 8:44 PM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > On Fri, Mar 03, 2017 at 08:21:05PM +0100, Geert Uytterhoeven wrote:
>> >> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> >> > index 91e7dddbf72c..2f4cdd4e7b4f 100644
>> >> > --- a/drivers/tty/serial/sh-sci.c
>> >> > +++ b/drivers/tty/serial/sh-sci.c
>> >> > @@ -3022,7 +3022,7 @@ static int sci_probe_single(struct platform_device *dev,
>> >> >                 return ret;
>> >> >
>> >> >         sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
>> >> > -       if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
>> >> > +       if (IS_ERR(sciport->gpios))
>> >> >                 return PTR_ERR(sciport->gpios);
>> >>
>> >> Now the sh-sci driver fails to probe on legacy platforms where GPIOLIB=n.
>> >> The check for -ENOSYS made it succeed before.
>> >
>> > That's right, intended and the only option that's save (for some
>> > definition of save; the obvious downside is that there is no
>> > /dev/tty$whatever for you).
>>
>> That's not just a downside, but a plain regression on legacy platforms that
>> do not use GPIO flow control.
>
> The only sane way out is that the driver somehow finds out that no gpios
> are supposed to be needed. So you can pass in via platform_data that no
> gpios are supposed to be used if you don't want to enable GPIOLIB (or
> implement CONFIG_HALFGPIOLIB). But I'd say this is a quirk that should
> better be fixed globally. So I think we should implement HALFGPIOLIB
> that includes the lookup stuff and so can make gpiod_get_optional and
> friends return NULL if there is really no GPIO.

If CONFIG_GPIOLIB=n, no gpios are supposed to be needed.

>> > Ignoring -ENOSYS is only ok if your device doesn't have a cts-gpio. If
>> > it has, ignoring -ENOSYS hides bugs because the driver sends data while
>> > it shouldn't or cannot signal the other side that it should stop (or
>> > start) a transmission.
>>
>> Mctrl_gpio supports modern platforms with GPIOLIB and DT or ACPI only.
>
> That's wrong. Even for a legacy device you can make use of GPIOs. See
> arch/arm/mach-tegra/board-paz00.c for a simple example.

Sorry, forgot about gpiod_lookup_table. It's not used by any platform using
the sh-sci serial driver.

Still, using gpiod_lookup_table depends on CONFIG_GPIOLIB=y.

>> On legacy platforms, you cannot use GPIO flow control (except when using a
>> custom implementation, which is out-of-scope here), so the issue of silently
>> running without cts-gpio on these platforms is moot.
>
> Given that mctrl-gpio can be useful on legacy platforms, a device could
> silently run without cts-gpio even there.

On platforms were CONFIG_GPIOLIB=n, this is not true, so the issue is moot.

All serial drivers using (optional) mctrl-gpio have this in Kconfig:

    select SERIAL_MCTRL_GPIO if GPIOLIB

So they will use mctrl-gpio when GPIOLIB is enabled.
If GPIOPLIB is disabled, no flow control GPIOs are expected, and the
driver should not break that case.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
