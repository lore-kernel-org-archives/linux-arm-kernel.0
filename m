From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Feb 2012 15:50:24 -0800
Subject: [PATCH 2/6] gpio/omap: remove saved_wakeup field from struct
 gpio_bank
In-Reply-To: <1329999031-6914-3-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Thu, 23 Feb 2012 17:40:27 +0530")
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <87aa43vnsv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> There is no more need to have saved_wakeup. Instead we can use
> context.wake_en which holds the current wakeup enable register
> context. This also means that the read from wakeup enable register
> is not needed.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Looks right, but one question below...

> ---
>  drivers/gpio/gpio-omap.c |   13 ++++---------
>  1 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 40a1fb2..64f15d5 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -54,7 +54,6 @@ struct gpio_bank {
>  	u16 irq;
>  	u16 virtual_irq_start;
>  	u32 suspend_wakeup;
> -	u32 saved_wakeup;
>  	u32 non_wakeup_gpios;
>  	u32 enabled_non_wakeup_gpios;
>  	struct gpio_regs context;
> @@ -772,7 +771,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
>  	unsigned long		flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -	bank->saved_wakeup = __raw_readl(mask_reg);
> +	bank->context.wake_en = __raw_readl(mask_reg);

Why is this read needed?

Kevin

>  	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
