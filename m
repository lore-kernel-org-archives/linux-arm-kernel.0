From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 20:09:45 +0100
Subject: [PATCH v3 08/12] gpio: pxa: move gpio properties into child node
In-Reply-To: <1361164358-5845-9-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkda7P5GsOB=s0YbeV2rXbpQaHQNkr0Po73Lwo-vyFcN1Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Move gpio properties into child node. So pinctrl driver could binds to
> each gpio chip with gpio range.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
(...)
> +       np = pdev->dev.of_node;
> +#ifdef CONFIG_OF
> +       if (np)
> +               next = of_get_next_child(np, NULL);
> +#endif
(...)
> +#ifdef CONFIG_OF
> +               if (np) {
> +                       gc->of_node = next;
> +                       next = of_get_next_child(np, next);
> +
> +                       gc->of_xlate = pxa_gpio_of_xlate;
> +                       gc->of_gpio_n_cells = 2;
> +               }
>  #endif
(...)
> +       of_node_put(next);

So if you're #ifdef:in all the other of_* stuff, why are you not
#ifdef:in this?

Is the #ifdef really necessary by the way, or will there be stubs
handling it?

Have you considered using IS_ENABLED() from <linux/kconfig.h>?

Yours,
Linus Walleij
