From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Sep 2017 13:15:55 +0200
Subject: [PATCH 0/7] I2C GPIO to use gpiolibs open drain
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Message-ID: <CAMuHMdWOt3e7eT4_wF8QJVM=aZNNcou+tGmjZOyvOziutedv_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Sep 17, 2017 at 11:38 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This augments the I2C GPIO driver to use open drain emulation
> or hardware support for open drain from the GPIO driver.
>
> This version layers Geert Uytterhoeven's idea to use explicit
> sda-gpios and scl-gpios for the GPIO lines, and strongly
> encourage the (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN) flags to be
> used in all device trees.
>
> We have collected ACKs from the ARM SoC maintainers and the
> MFD maintainer and are looking for testers to try this out.
>
> Geert Uytterhoeven (1):
>   dt-bindings: i2c: i2c-gpio: Add support for named gpios
>
> Linus Walleij (6):
>   i2c: gpio: Convert to use descriptors
>   gpio: Make it possible for consumers to enforce open drain
>   i2c: gpio: Enforce open drain through gpiolib
>   i2c: gpio: Augment all boardfiles to use open drain
>   i2c: gpio: Local vars in probe
>   i2c: gpio: Add support for named gpios in DT

Thanks for doing this, and picking up my patch.

I gave this a try on r8a7740/armadillo800eva.
Without DT changes, the GPIO i2c bus still works fine, but a warning is
printed, as expected:

    gpio-208 (sda): enforced open drain please flag it properly in
DT/ACPI DSDT/board file
    gpio-91 (scl): enforced open drain please flag it properly in
DT/ACPI DSDT/board file

After

    -  sda-gpios = <&pfc 208 GPIO_ACTIVE_HIGH>;
    -  scl-gpios = <&pfc 91 GPIO_ACTIVE_HIGH>;
    + sda-gpios = <&pfc 208 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
    + scl-gpios = <&pfc 91 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;

the warning is gone, and the GPIO i2c bus still works.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
