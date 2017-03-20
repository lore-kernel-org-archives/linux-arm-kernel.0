From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 20 Mar 2017 10:56:14 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
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
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
Message-ID: <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Mar 16, 2017 at 5:38 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> They actually all even do things like this in Kconfig:
>>
>> config SERIAL_ATMEL
>> (...)
>>         select SERIAL_MCTRL_GPIO if GPIOLIB
>>
>> What stops us from removing all the stubs in
>> drivers/tty/serial/serial_mctrl_gpio.h
>> and just make SERIAL_MCTRL_GPIO depends on GPIOLIB?
>
> Removing the stubs implies adding #ifdefs to the drivers that need
> to handle the !SERIAL_MCTRL_GPIO case.
>
> E.g. I don't want to break the sh-sci serial driver on SuperH platforms that
> (a) don't select GPIOLIB, and
> (b) don't use mtrl_gpio.

Alternatively, after commit 22c403676dbbb7c6 ("gpio: return NULL from
gpiod_get_optional when GPIOLIB is disabled") we might just drop the
dependency of SERIAL_MCTRL_GPIO on GPIOLIB? Then no special handling
is needed in drivers, as all GPIOs will just be considered not present.

Documentation/gpio/consumer.txt rightfully sates:
| Note that gpio_get*_optional() functions (and their managed variants), unlike
| the rest of gpiolib API, also return NULL when gpiolib support is disabled.
| This is helpful to driver authors, since they do not need to special case
| -ENOSYS return codes.  System integrators should however be careful to enable
| gpiolib on systems that need it.

drivers/tty/serial/serial_mctrl_gpio.o already compiles fine if
CONFIG_GPIOLIB=n, which reduces its size by ca. 25%.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
