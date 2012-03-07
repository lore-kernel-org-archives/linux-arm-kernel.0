From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 07 Mar 2012 13:09:04 +0100
Subject: [PATCH v3 13/13] gpio/omap: fix incorrect update to
 context.irqenable1
In-Reply-To: <1331118963-26364-14-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-14-git-send-email-tarun.kanti@ti.com>
Message-ID: <4F574FE0.7080706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
> gpio_mask can be directly set by writing to set_irqenable register
> without overwriting current value. In order to ensure the same is
> stored in context.irqenable1, we must read from regs->irqenable
> instead of overwriting it with gpio_mask.
> The overwriting makes sense only in the second case where irqenable
> is explicitly read and updated with new gpio_mask before writing it
> back. However, for consistency reading regs->irqenable into the
> bank->context.irqenable1 takes care of both the scenarios.
> 
>         if (bank->regs->set_irqenable) {
>                 reg += bank->regs->set_irqenable;
>                 l = gpio_mask;
>         } else {
>                 reg += bank->regs->irqenable;
>                 l = __raw_readl(reg);
>                 if (bank->regs->irqenable_inv)
>                         l &= ~gpio_mask;
>                 else
>                         l |= gpio_mask;
>         }
> 
> Make the same change for _disable_gpio_irqbank().
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
OK.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
