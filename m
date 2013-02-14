From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Feb 2013 16:29:00 +0100
Subject: [PATCH v8 05/12] gpio: pl061: bind pinctrl by gpio request
In-Reply-To: <1360602659-4774-6-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdb+S7s42dq1q872p6sMw8rPaPRS8NxGMDFBeht0BbYtMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
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
> +       return pinctrl_request_gpio(gpio);
> +}

So this will work find if the platform supports pinctrl, and either the
pin controller can do something with this, or (after the other patch)
if the GPIO is in some range, but not handled by some
pin controller.

But what about the case where there is a pin controller on the
system, but no range matching this pin?

What will happen then? Eternal deferral?

Yours,
Linus Walleij
