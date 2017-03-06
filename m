From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Mar 2017 10:53:27 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
Message-ID: <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Mar 6, 2017 at 10:30 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Mar 06, 2017 at 10:09:50AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Mar 6, 2017 at 9:58 AM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > On Mon, Mar 06, 2017 at 09:49:39AM +0100, Geert Uytterhoeven wrote:
>> >> > Given that mctrl-gpio can be useful on legacy platforms, a device could
>> >> > silently run without cts-gpio even there.
>> >>
>> >> On platforms were CONFIG_GPIOLIB=n, this is not true, so the issue is moot.
>> >>
>> >> All serial drivers using (optional) mctrl-gpio have this in Kconfig:
>> >>
>> >>     select SERIAL_MCTRL_GPIO if GPIOLIB
>> >>
>> >> So they will use mctrl-gpio when GPIOLIB is enabled.
>> >> If GPIOPLIB is disabled, no flow control GPIOs are expected, and the
>> >> driver should not break that case.
>> >
>> > So it all boils down to the question: Is GPIOLIB=n enough to assume no
>> > gpio is needed?
>> >
>> > I'd say it is not.
>>
>> How does the platform register these GPIOs when GPIOPLIB is not enabled by
>> the platform, and gpiod_add_lookup_table() is thus not available?
>
> Obviously the platformcode cannot. In this case you could argue that
> platformcode shouldn't register the device if a gpio is necessary. But
> this reasoning doesn't work for (DT=y || ACPI=y) && GPIOLIB=n.
>
> I wouldn't want to code this in each driver (something like:
>
>         if (IS_ENABLED(GPIOLIB) || device_is_instantiated_by_dt(dev) || device_is_instantiated_by_acpi(dev))
>                 gpios = mctrl_gpio_init(...);
>         else
>                 gpios = NULL;
>
> ). Putting this into GPIOLIB is the right approach, and so this is
> another argument for HALFGPIOLIB. This would fix mctrl_gpio_init en
> passant.

Do we have platforms where DT=y || ACPI=y, but GPIOLIB=n?
Ah, x86 ;-)

Anyway, for sh-sci.c, platforms either have DT and GPIOLIB, or they do not
need mctrl-gpio.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
