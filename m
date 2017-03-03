From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Mar 2017 20:21:05 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
Message-ID: <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Fri, Mar 3, 2017 at 8:12 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Mar 03, 2017 at 07:58:36PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Mar 3, 2017 at 3:22 PM, Richard Genoud <richard.genoud@gmail.com> wrote:
>> > Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
>> > the mctrl_gpio_to_gpiod() function can't return an error anymore.
>> > So, just testing for a NULL pointer is ok.
>>
>> If CONFIG_GPIOLIB=n, mctrl_gpio_to_gpiod() always returns ERR_PTR(-ENOSYS).
>> That case should be handled correctly, too.
>
> The correct change to handle this is:
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 91e7dddbf72c..2f4cdd4e7b4f 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3022,7 +3022,7 @@ static int sci_probe_single(struct platform_device *dev,
>                 return ret;
>
>         sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
> -       if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
> +       if (IS_ERR(sciport->gpios))
>                 return PTR_ERR(sciport->gpios);

Now the sh-sci driver fails to probe on legacy platforms where GPIOLIB=n.
The check for -ENOSYS made it succeed before.

> Then mctrl_gpio_to_gpiod isn't called. I don't have a machine to test
> this, but I think currently this makes the machine barf to continue
> here because with sciport->gpios = ERR_PTR(-ENOSYS) calling
>
>         mctrl_gpio_to_gpiod(sciport->gpios, ...)
>
> is a bad idea.

If sciport->gpios == ERR_PTR(-ENOSYS), CONFIG_GPIOLIB is not enabled, the
feature is not available, and mctrl_gpio_to_gpiod() will not
dereference the error
pointer.

>> Perhaps mctrl_gpio_to_gpiod() should always return NULL if !CONFIG_GPIOLIB?
>
> No, mctrl_gpio_to_gpiod is right. You are only supposed to call it if
> mctrl_gpio_init succeeded.

Then I have to add checks for sciport->gpios == ERR_PTR(-ENOSYS)...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
