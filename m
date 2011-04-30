From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 30 Apr 2011 10:06:18 +0200
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <BANLkTim5qh_G9t9ucFu8OUzYGceszth1wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/15 Sascha Hauer <s.hauer@pengutronix.de>:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>

> We currently have ~21 definitions of struct clk in the ARM architecture,
> each defined on a per-platform basis. This makes it difficult to define
> platform- (or architecture-) independent clock sources without making
> assumptions about struct clk, and impossible to compile two
> platforms with different struct clks into a single image.

Sorry for this late comment, maybe already adressed:

> +int clk_enable(struct clk *clk)
> +{
> + ? ? ? unsigned long flags;
> + ? ? ? int ret = 0;
> +
> + ? ? ? WARN_ON(clk->prepare_count == 0);
> +
> + ? ? ? spin_lock_irqsave(&clk->enable_lock, flags);
> + ? ? ? if (clk->enable_count == 0 && clk->ops->enable)
> + ? ? ? ? ? ? ? ret = clk->ops->enable(clk);

Here the spinlock is held requiring the clock implementation to
be non-sleeping, something that has been discussed at no end,
without addressing that eternal debate, please just drop the
spinlock during the ->enable() call, what is it protecting during
that time anyway...

> +
> + ? ? ? if (!ret)
> + ? ? ? ? ? ? ? clk->enable_count++;
> + ? ? ? spin_unlock_irqrestore(&clk->enable_lock, flags);
> +
> + ? ? ? return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_enable);
> +
> +void clk_disable(struct clk *clk)
> +{
> + ? ? ? unsigned long flags;
> +
> + ? ? ? spin_lock_irqsave(&clk->enable_lock, flags);
> +
> + ? ? ? WARN_ON(clk->enable_count == 0);
> +
> + ? ? ? if (!--clk->enable_count == 0 && clk->ops->disable)
> + ? ? ? ? ? ? ? clk->ops->disable(clk);

Same here.

> +
> + ? ? ? spin_unlock_irqrestore(&clk->enable_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(clk_disable);

Apart from that I need to add that I really like the spirit this patch.

Yours,
Linus Walleij
