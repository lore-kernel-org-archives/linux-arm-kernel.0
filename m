From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2012 11:50:52 +0000
Subject: [PATCH 2/6] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <1344250002-6011-3-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
 <1344250002-6011-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201208061150.53076.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012, Lee Jones wrote:

>  
> +struct irq_domain *db8500_irq_domain;
> +
 
Should this be static?

> @@ -2583,7 +2585,7 @@ static void prcmu_irq_mask(struct irq_data *d)
>  
>         spin_lock_irqsave(&mb0_transfer.dbb_irqs_lock, flags);
>  
> -       mb0_transfer.req.dbb_irqs &= ~prcmu_irq_bit[d->irq - IRQ_PRCMU_BASE];
> +       mb0_transfer.req.dbb_irqs &= ~prcmu_irq_bit[d->hwirq];
>  
>         spin_unlock_irqrestore(&mb0_transfer.dbb_irqs_lock, flags);

Ah, so the hwirq number *is* used directly here, unlike what I thought
when we first discussed it. I suppose that means we don't need the
xlate function after all (and you did not add one).

	Arnd
