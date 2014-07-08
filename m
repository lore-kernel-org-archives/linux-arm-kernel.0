From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 11:03:43 +0200
Subject: [PATCH 4/6] pinctrl: exynos: Lock GPIOs as interrupts when used
 as EINTs
In-Reply-To: <1404315664-3174-5-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
 <1404315664-3174-5-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdYD=6iV0qFRQrAf2TJc7tg=m2ZEr6SvhruEwsGQLzskSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 5:41 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> Currently after configuring a GPIO pin as an interrupt related pinmux
> registers are changed, but there is no protection from calling
> gpio_direction_*() in a badly written driver, which would cause the same
> pinmux register to be reconfigured for regular input/output and this
> disabling interrupt capability of the pin.
>
> This patch addresses this issue by moving pinmux reconfiguration to
> .irq_startup() callback of irq_chip and calling gpio_lock_as_irq()
> helper to prevent reconfiguration of pin direction.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
(...)
> +               .irq_startup = exynos_irq_startup,
> +               .irq_shutdown = exynos_irq_shutdown,

I think you should be using the
.irq_request_resources and .irq_release_resources callbacks instead.

The reason is that startup and shutdown cannot really fail (ret code
is unsigned...), so using the other callbacks is safer.

Can you have a quick look at this before I apply any more of the
Samsung patches?

Yours,
Linus Walleij
