From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 00:09:10 +0200
Subject: triggering an gpio-irq on both edges
In-Reply-To: <20120913081920.GF19497@pengutronix.de>
References: <20120913081920.GF19497@pengutronix.de>
Message-ID: <CACRpkdbcMVhm+pXKHkOs7xVxzyi+gtMdpYD6FHWLG-xGUG9Hgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 10:19 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> I guess there are more machines than mxc and mxs that have the same
> problem.

The COH901 GPIO driver has the same issue, see
drivers/pinctrl/pinctrl-coh901.c, functions named
u300_toggle_trigger() etc.

It will toggle the trigger from rising to falling on every
arriving IRQ by calling u300_toggle_trigger() from
fastpath in the IRQ handler.

Theoretically it is racy, but since it's used for GPIO
and these signals tend to not be super-fast we're safe.
It's used for card detection on SD cards and such.

> In my opinion this calls for a wrapper, something like:
>
>         int gpio_irq_emulate_both_edges_set_irq_type(struct irq_data *d,
>                 unsigned int type, int (*set_irq_type)(...),
>                 int (*get_value)(...), struct something *privdata)
>         {
>                 ...
>         }
>
>         int gpio_irq_emulate_both_edges_handler(...)
>         {
>
>         }
>
> Does this sound good and possible? I didn't find something like that
> already implemented, but maybe I missed it?

I've thought about this too but never thought there was something
generic enough to do about it...

Yours,
Linus Walleij
