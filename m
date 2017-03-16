From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 16 Mar 2017 17:38:45 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
References: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
Message-ID: <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Mar 16, 2017 at 4:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Mar 6, 2017 at 11:02 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
>> On Mon, Mar 06, 2017 at 10:53:27AM +0100, Geert Uytterhoeven wrote:
>>> On Mon, Mar 6, 2017 at 10:30 AM, Uwe Kleine-K?nig
>>> > I wouldn't want to code this in each driver (something like:
>>> >
>>> >         if (IS_ENABLED(GPIOLIB) || device_is_instantiated_by_dt(dev) || device_is_instantiated_by_acpi(dev))
>>> >                 gpios = mctrl_gpio_init(...);
>>> >         else
>>> >                 gpios = NULL;
>>> >
>>> > ). Putting this into GPIOLIB is the right approach, and so this is
>>> > another argument for HALFGPIOLIB. This would fix mctrl_gpio_init en
>>> > passant.
>>>
>>> Do we have platforms where DT=y || ACPI=y, but GPIOLIB=n?
>>> Ah, x86 ;-)
>>
>> Yeah, and I think rm -r arch/x86 won't be acceptable :-) I assume you
>> can also configure some arm or powerpc systems without GPIOLIB.
>>
>>> Anyway, for sh-sci.c, platforms either have DT and GPIOLIB, or they do not
>>> need mctrl-gpio.
>>
>> So we're in agreement now that HALFGPIOLIB is the way to go?
>> Linus, what do you think?
>
> OK modem lines over GPIO.
>
> So the problem is that GPIOLIB is needed (obviously) for mctrl_gpio_init() to
> work properly, and then there are some stubs in
> drivers/tty/serial/serial_mctrl_gpio.h
> for !GPIOLIB.
>
> And this whole discussion is all about that !GPIOLIB case really,
> whether DT, ACPI, SFI or board files machine data is used doesn't
> really matter.
>
> We're talking about:
>
>> git grep mctrl_gpio_init
> drivers/tty/serial/atmel_serial.c:      atmel_port->gpios =
> mctrl_gpio_init(&atmel_port->uart, 0);
> drivers/tty/serial/clps711x.c:  s->gpios =
> mctrl_gpio_init_noauto(&pdev->dev, 0);
> drivers/tty/serial/etraxfs-uart.c:      up->gpios =
> mctrl_gpio_init_noauto(&pdev->dev, 0);
> drivers/tty/serial/imx.c:       sport->gpios = mctrl_gpio_init(&sport->port, 0);
> drivers/tty/serial/mxs-auart.c: s->gpios = mctrl_gpio_init_noauto(dev, 0);
> drivers/tty/serial/sh-sci.c:    sciport->gpios =
> mctrl_gpio_init(&sciport->port, 0);
>
> Atmel, ARM, ETRAX, ARM, ARM, Super-H, all have GPIOLIB.
> Right now no x86, correct?

It's not that black-and-white. Some of SuperH have GPIOLIB, other parts don't.

> They actually all even do things like this in Kconfig:
>
> config SERIAL_ATMEL
> (...)
>         select SERIAL_MCTRL_GPIO if GPIOLIB
>
> What stops us from removing all the stubs in
> drivers/tty/serial/serial_mctrl_gpio.h
> and just make SERIAL_MCTRL_GPIO depends on GPIOLIB?

Removing the stubs implies adding #ifdefs to the drivers that need
to handle the !SERIAL_MCTRL_GPIO case.

E.g. I don't want to break the sh-sci serial driver on SuperH platforms that
(a) don't select GPIOLIB, and
(b) don't use mtrl_gpio.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
