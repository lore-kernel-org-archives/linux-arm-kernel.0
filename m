From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 17 Oct 2014 18:26:12 +0900
Subject: [PATCH] gpio: pl061: hook request if gpio-ranges avaiable
In-Reply-To: <1412847735-498-1-git-send-email-haojian.zhuang@linaro.org>
References: <1412847735-498-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAAVeFuJf0V6erNuzgipB1O4hSU_E+HiotEWVE5byYkj=0u+HbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 9, 2014 at 6:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> gpio-ranges property could binds gpio to pinctrl. But there may be some
> gpios without pinctrl operation. So check whether gpio-ranges property
> exists in device node first.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/gpio/gpio-pl061.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index 84b49cf..d1813f0 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c
> @@ -52,28 +52,34 @@ struct pl061_gpio {
>
>         void __iomem            *base;
>         struct gpio_chip        gc;
> +       int                     uses_pinctrl;
>
>  #ifdef CONFIG_PM
>         struct pl061_context_save_regs csave_regs;
>  #endif
>  };
>
> -static int pl061_gpio_request(struct gpio_chip *chip, unsigned offset)
> +static int pl061_gpio_request(struct gpio_chip *gc, unsigned offset)
>  {
>         /*
>          * Map back to global GPIO space and request muxing, the direction
>          * parameter does not matter for this controller.
>          */
> -       int gpio = chip->base + offset;
> +       struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
> +       int gpio = gc->base + offset;
>
> -       return pinctrl_request_gpio(gpio);
> +       if (chip->uses_pinctrl)
> +               return pinctrl_request_gpio(gpio);
> +       return 0;
>  }
>
> -static void pl061_gpio_free(struct gpio_chip *chip, unsigned offset)
> +static void pl061_gpio_free(struct gpio_chip *gc, unsigned offset)
>  {
> -       int gpio = chip->base + offset;
> +       struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
> +       int gpio = gc->base + offset;
>
> -       pinctrl_free_gpio(gpio);
> +       if (chip->uses_pinctrl)
> +               pinctrl_free_gpio(gpio);
>  }
>
>  static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
> @@ -264,6 +270,9 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
>
>         spin_lock_init(&chip->lock);
>
> +       /* Hook the request()/free() for pinctrl operation */
> +       if (of_property_read_bool(dev->of_node, "gpio-ranges"))
> +               chip->uses_pinctrl = true;

You probably want to document this property in
Documentation/devicetree/bindings/gpio/pl061-gpio.txt.
