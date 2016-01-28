From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jan 2016 10:40:12 +0100
Subject: [PATCH 2/2 V3] drivers/gpio: Switch gpio-mpc8xxx to use
 gpio-generic
In-Reply-To: <1452600610-17400-2-git-send-email-Gang.Liu@nxp.com>
References: <1452600610-17400-1-git-send-email-Gang.Liu@nxp.com>
 <1452600610-17400-2-git-send-email-Gang.Liu@nxp.com>
Message-ID: <CACRpkdZMPho0=1-S9=E+2Q8moccegfupXJEbnpfxRe-+W=3uGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 1:10 PM, Liu Gang <Gang.Liu@nxp.com> wrote:

> The new Layerscape platforms has the same ip block/controller
> as GPIO on PowerPC platforms(MPC8XXX), but the GPIO registers
> may be big or little endian. So the code needs to get the
> endian property from DTB, then make additional functions to
> fit all the PowerPC/Layerscape GPIO register read/write
> operations.
>
> gpio-generic.c provides an universal infrastructure for both
> big and little endian register operations. So switch the
> gpio-mpc8xxx to use gpio-generic can simplify the driver and
> reduce a lot of code.
>
> The IRQ and some workaround parts in gpio-mpc8xxx.c will be
> updated with the new API interfaces but following the
> original functionalities.
>
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
> ---
> -V3: Switch gpio-mpc8xxx to use gpio-generic for both
>      little, big endian kinds of GPIO register following
>      Linus Walleij comments.

This is starting to look good :)

Just a few minor tweaks left.

First rebase onto linux v4.5-rc1 unless you've already done
this. Unfortunately you're hitting the window when I've been
refactoring generic GPIO...

>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/irq.h>
> +#include <linux/basic_mmio_gpio.h>

You should remove #include <linux/gpioh.h> and
#include <linux/basic_mmio_gpio.h> as I have moved
all of that into #include <linux/gpio/driver.h> so include
that instead.

>  struct mpc8xxx_gpio_chip {
> -       struct of_mm_gpio_chip mm_gc;
> +       struct bgpio_chip       bgc;

Just use struct gpio_chip *gc

as I merged strict bgpio_chip into struct gpio_chip,
see commit 0f4630f3720e7e6e921bf525c8357fea7ef3dbab
"gpio: generic: factor into gpio_chip struct"

If you look at this commit, you will see what changes
are needed for your driver.

>  static inline struct mpc8xxx_gpio_chip *
> -to_mpc8xxx_gpio_chip(struct of_mm_gpio_chip *mm)
> +to_mpc8xxx_gpio_chip(struct bgpio_chip *bg_c)
>  {
> -       return container_of(mm, struct mpc8xxx_gpio_chip, mm_gc);
> -}

You should be able to use gpio_add_chip_data() and then
get the pointer to your struct mpc8xxx_gpio_chip *
from gpiochip_get_data() instead, like that:

struct mpc8xxx_gpio_chip *mpc = gpiochip_get_data(gc);

Just search and replace everywhere.

Yours,
Linus Walleij
