From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Nov 2017 11:54:13 +0100
Subject: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
In-Reply-To: <20171107201857.5752-1-linus.walleij@linaro.org>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a0_kB8NBifbutqyvY_FYHnZTpwK-m0KZV3swpMa4fxjrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 9:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index 9db483a42826..7d4feb8a49ac 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -328,9 +328,9 @@ static struct platform_device simpad_gpio_leds = {
>  static struct gpiod_lookup_table simpad_i2c_gpiod_table = {
>         .dev_id = "i2c-gpio",
>         .table = {
> -               GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0,
> +               GPIO_LOOKUP_IDX("gpio", 21, NULL, 0,
>                                 GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
> -               GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1,
> +               GPIO_LOOKUP_IDX("gpio", 25, NULL, 1,
>                                 GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>         },
>  };

This looks like it's probably correct, but now I'm puzzled by another line in
the same file:

static struct gpio_keys_button simpad_button_table[] = {
        { KEY_POWER, IRQ_GPIO_POWER_BUTTON, 1, "power button" },
};

Here we pass a gpio number as well, but we use the macro for the IRQ
number that is apparently 32 higher than the gpio number. This came from the
same commit that introduced the GPIO_GPIO21 reference, so it may well
be broken, too.

I'm fine with your version getting merged as it certainly can't make things
worse, it fixes the build warning, and it probably fixes one thing that is
wrong today, but I'd also like to see someone figure these numbers out
properly, or maybe we should think about just removing the file if nobody
has noticed that it didn't work in the past six years.

       Arnd
