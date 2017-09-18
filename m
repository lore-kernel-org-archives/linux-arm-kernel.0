From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Sep 2017 11:58:40 +0200
Subject: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
In-Reply-To: <20170917093906.16325-8-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-8-linus.walleij@linaro.org>
Message-ID: <CAMuHMdX+bx9pNEAFoBzfM7JhhH800u-HumpQYRsG3d5BNuduvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This adds support for using the "sda" and "scl" GPIOs in
> device tree instead of anonymously using index 0 and 1 of
> the "gpios" property.
>
> We add a helper function to retrieve the GPIO descriptors
> and some explicit error handling since the probe may have
> to be deferred. At least this happened to me when moving
> to using named "sda" and "scl" lines (all of a sudden this
> started to probe before the GPIO driver) so we need to
> gracefully defer probe when we ge -ENOENT in the error
> pointer.
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This is pretty much a rewrite of Geerts patch on top of
> my own changes to support descriptors.
> ---
>  drivers/i2c/busses/i2c-gpio.c | 59 +++++++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index beb5ce523684..2738b851f470 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -82,6 +82,42 @@ static void of_i2c_gpio_get_props(struct device_node *np,
>                 of_property_read_bool(np, "i2c-gpio,scl-output-only");
>  }
>
> +static struct gpio_desc *i2c_gpio_get_desc(struct device *dev,
> +                                          const char *con_id,
> +                                          unsigned int index,
> +                                          enum gpiod_flags gflags)
> +{
> +       struct gpio_desc *retdesc;
> +       int ret;

[...]

> +       if (ret != -EPROBE_DEFER)
> +               dev_err(dev, "error trying to get descriptor: %ld\n", ret);

warning: format '%ld' expects argument of type 'long int', but
argument 3 has type 'int' [-Wformat=]

%d (0day busy?)

> +
> +       return retdesc;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
