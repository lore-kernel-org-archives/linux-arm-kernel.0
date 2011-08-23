From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:42:46 +0530
Subject: [PATCH v5 11/22] gpio/omap: remove hardcoded offsets in ctxt
	save/restore
In-Reply-To: <1312455893-14922-12-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-12-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53A74E.4030002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> It is not required to use hard-coded offsets any more in context save and
> restore functions and instead use the generic offsets which have been correctly
> initialized during device registration.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
$SUB
/s /ctx  /context please

>   arch/arm/mach-omap2/gpio.c             |    2 +
>   arch/arm/plat-omap/include/plat/gpio.h |    1 +
>   drivers/gpio/gpio-omap.c               |   41 ++++++++++++++-----------------
>   3 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 8745c3a..0ee9a55 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -103,6 +103,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>   		pdata->regs->irqstatus = OMAP24XX_GPIO_IRQSTATUS1;
>   		pdata->regs->irqstatus2 = OMAP24XX_GPIO_IRQSTATUS2;
>   		pdata->regs->irqenable = OMAP24XX_GPIO_IRQENABLE1;
> +		pdata->regs->irqenable2 = OMAP24XX_GPIO_IRQENABLE2;
>   		pdata->regs->set_irqenable = OMAP24XX_GPIO_SETIRQENABLE1;
>   		pdata->regs->clr_irqenable = OMAP24XX_GPIO_CLEARIRQENABLE1;
>   		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
> @@ -125,6 +126,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>   		pdata->regs->irqstatus = OMAP4_GPIO_IRQSTATUS0;
>   		pdata->regs->irqstatus2 = OMAP4_GPIO_IRQSTATUS1;
>   		pdata->regs->irqenable = OMAP4_GPIO_IRQSTATUSSET0;
> +		pdata->regs->irqenable2 = OMAP4_GPIO_IRQSTATUSSET1;
>   		pdata->regs->set_irqenable = OMAP4_GPIO_IRQSTATUSSET0;
>   		pdata->regs->clr_irqenable = OMAP4_GPIO_IRQSTATUSCLR0;
>   		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index 7d12fe8..0ad4f49 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -184,6 +184,7 @@ struct omap_gpio_reg_offs {
>   	u16 irqstatus;
>   	u16 irqstatus2;
>   	u16 irqenable;
> +	u16 irqenable2;
>   	u16 set_irqenable;
>   	u16 clr_irqenable;
>   	u16 debounce;
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index be561be..e7c9fe5 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1348,45 +1348,42 @@ void omap2_gpio_resume_after_idle(void)
>   static void omap_gpio_save_context(struct gpio_bank *bank)
>   {
>   	bank->context.irqenable1 =
> -		__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
> +			__raw_readl(bank->base + bank->regs->irqenable);
>   	bank->context.irqenable2 =
> -		__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
> +			__raw_readl(bank->base + bank->regs->irqenable2);
>   	bank->context.wake_en =
> -		__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
> -	bank->context.ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> -	bank->context.oe = __raw_readl(bank->base + OMAP24XX_GPIO_OE);
> +			__raw_readl(bank->base + bank->regs->wkup_status);
Not related to this patch but saving the status register just useless.
You should rather save/restore 'wkup_set' register.

Can you please fix this in relevant patch. O.w this patch looks ok to
me.

Regards
Santosh
