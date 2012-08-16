From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 07:18:01 +0000
Subject: [PATCH V3 1/5] clk: mmp: add mmp specific clocks
In-Reply-To: <1345086525-12328-2-git-send-email-xiechao.mail@gmail.com>
References: <1345086525-12328-1-git-send-email-xiechao.mail@gmail.com>
 <1345086525-12328-2-git-send-email-xiechao.mail@gmail.com>
Message-ID: <201208160718.01769.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Chao Xie wrote:
> +static int clk_apbc_prepare(struct clk_hw *hw)
> +{
> +       struct clk_apbc *apbc = to_clk_apbc(hw);
> +       unsigned int data;
> +       unsigned long flags = 0;
> +
> +       /*
> +        * It may share same register as MUX clock,
> +        * and it will impact FNCLK enable. Spinlock is needed
> +        */
> +       if (apbc->lock)
> +               spin_lock_irqsave(apbc->lock, flags);
> +
> +       data = __raw_readl(apbc->base);
> +       if (apbc->flags & APBC_POWER_CTRL)
> +               data |= APBC_POWER;
> +       data |= APBC_FNCLK;
> +       __raw_writel(data, apbc->base);

It seems you have missed a few __raw_readl/__raw_writel that still
want to get changed to readl_relaxed/writel_relaxed.

	Arnd
