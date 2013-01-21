From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Jan 2013 15:37:52 +0100
Subject: [PATCH v7 08/15] gpio: pl061: bind pinctrl by gpio request
In-Reply-To: <1358494279-16503-9-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZo6mVSaHBr6PJt8QCkiKp-Vs7mWup8n=4zyacRwf8V3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Add the pl061_gpio_request() to request pinctrl. Create the logic
> between pl061 gpio driver and pinctrl (pinctrl-single) driver.
>
> While a gpio pin is requested, it will request pinctrl driver to
> set that pin with gpio function mode. So pinctrl driver should
> append .gpio_request_enable() in pinmux_ops.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
(...)
> +static int pl061_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       /*
> +        * Map back to global GPIO space and request muxing, the direction
> +        * parameter does not matter for this controller.
> +        */
> +       int gpio = chip->base + offset;
> +
> +       /*
> +        * Do NOT check the return value at here. Since sometimes the gpio
> +        * pin needn't to be configured in pinmux controller. So it's
> +        * impossible to find the matched gpio range.
> +        */
> +       pinctrl_request_gpio(gpio);

Handling of error code?

(Maybe I should add a __must_check on this function.)

> +       return 0;
> +}
> +
>  static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
>  {
>         struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
> @@ -251,6 +269,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
>
>         spin_lock_init(&chip->lock);
>
> +       chip->gc.request = pl061_gpio_request;
>         chip->gc.direction_input = pl061_direction_input;
>         chip->gc.direction_output = pl061_direction_output;
>         chip->gc.get = pl061_get_value;

What happens on a platform that has a PL061
GPIO block but no pinctrl related to it?

But still has some other pinctrl driver in the platform ....

Right, it'll return -EPROBE_DEFER from pinctrl_request_gpio().

This may happen on for example a combined SPEAr
kernel where some platforms have PL061 and others us
a pin controller, so both will be enabled.

I think, add a field like this to struct pl061_gpio:

bool has_pinctrl_backend;

The only call that from pl061_gpio_request() if this is
set:

if (pl061->has_pinctrl_backend)
   ret = pinctrl_request_gpio(gpio);

Then assign it in some clever way. For DT I think the
proper way would be so add a cross-binding to the
pin controller, like:

gpio2: gpio at d8100000 {
    #gpio-cells = <2>;
    compatible = "arm,pl061", "arm,primecell";
(...)
    pinctrl = <&mr_pincontrol>;
};

Then just check if you have this pinctrl binding set
to figure out if has_pinctrl_backend should be true.

Yours,
Linus Walleij
