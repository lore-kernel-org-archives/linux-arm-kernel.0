From: khilman@ti.com (Kevin Hilman)
Date: Mon, 12 Mar 2012 14:54:17 -0700
Subject: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in
 _set_gpio_dataout_*
In-Reply-To: <1331118963-26364-12-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Wed, 7 Mar 2012 16:46:01 +0530")
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
Message-ID: <87y5r5wkmu.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> In the existing _set_gpio_dataout_*() implementation, the dataout
> register is overwritten every time the function is called. This is
> not intended behavior because that would end up one user of a GPIO
> line overwriting what is written by another. Fix this so that previous
> value is always preserved until explicitly changed by respective
> user/driver of the GPIO line.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 04c2677..2e8e476 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
>  	else
>  		reg += bank->regs->clr_dataout;
>  
> +	l |= __raw_readl(bank->base + bank->regs->set_dataout);

minor: IMO, it's more reader-friendly if this looks like

       l = __raw_read(...)
       l |= GPIO_BIT(...)
       __raw_write(...)

>  	__raw_writel(l, reg);
>  	bank->context.dataout = l;
>  }
> @@ -130,6 +131,8 @@ static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
>  		l |= gpio_bit;
>  	else
>  		l &= ~gpio_bit;
> +
> +	l |= __raw_readl(bank->base + bank->regs->set_dataout);

There's already a __raw_read() in this function just above.

>  	__raw_writel(l, reg);
>  	bank->context.dataout = l;
>  }
