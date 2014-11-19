From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 19 Nov 2014 20:17:34 +0100
Subject: [PATCH 2/2] pinctrl: rockchip: Fix enable/disable/mask/unmask
In-Reply-To: <1416354596-15013-3-git-send-email-dianders@chromium.org>
References: <1416354596-15013-1-git-send-email-dianders@chromium.org>
 <1416354596-15013-3-git-send-email-dianders@chromium.org>
Message-ID: <1768585.5TrMbB8pvA@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. November 2014, 15:49:56 schrieb Doug Anderson:
> The Rockchip pinctrl driver was only implementing the "mask" and
> "unmask" operations though the hardware actually has two distinct
> things: enable/disable and mask/unmask.  It was implementing the
> "mask" operations as a hardware enable/disable and always leaving all
> interrupts unmasked.
> 
> I believe that the old system had some downsides, specifically:
> - (Untested) if an interrupt went off while interrupts were "masked"
>   it would be lost.  Now it will be kept track of.
> - If someone wanted to change an interrupt back into a GPIO (is such a
>   thing sensible?) by calling irq_disable() it wouldn't actually take
>   effect.  That's because Linux does some extra optimizations when
>   there's no true "disable" function: it does a lazy mask.
> 
> Let's actually implement enable/disable/mask/unmask properly.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

There is one small issue concerning a personal style-preference below. 
Otherwise

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


@LinusW: any preference on how to handle these follow up changes - like 
another pull on top of the last, or do you simply want to apply these two 
yourself?

> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index e91e845..60d1a49 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -1562,6 +1562,28 @@ static void rockchip_irq_resume(struct irq_data *d)
>  	irq_reg_writel(gc, bank->saved_enables, GPIO_INTEN);
>  }
> 
> +static void rockchip_irq_disable(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	irq_gc_lock(gc);
> +	val = irq_reg_readl(gc, GPIO_INTEN);
> +	irq_reg_writel(gc, val & ~d->mask, GPIO_INTEN);

personally I'd prefer this to be a bit more spread out, i.e.

val = irq_reg_readl(gc, GPIO_INTEN);
val &= ~d->mask;
irq_reg_writel(gc, val, GPIO_INTEN);

makes reading a bit easier


> +	irq_gc_unlock(gc);
> +}
> +
> +static void rockchip_irq_enable(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	irq_gc_lock(gc);
> +	val = irq_reg_readl(gc, GPIO_INTEN);
> +	irq_reg_writel(gc, val | d->mask, GPIO_INTEN);

same here


> +	irq_gc_unlock(gc);
> +}
> +
>  static int rockchip_interrupts_register(struct platform_device *pdev,
>  						struct rockchip_pinctrl *info)
>  {
> @@ -1600,11 +1622,13 @@ static int rockchip_interrupts_register(struct
> platform_device *pdev, gc = irq_get_domain_generic_chip(bank->domain, 0);
>  		gc->reg_base = bank->reg_base;
>  		gc->private = bank;
> -		gc->chip_types[0].regs.mask = GPIO_INTEN;
> +		gc->chip_types[0].regs.mask = GPIO_INTMASK;
>  		gc->chip_types[0].regs.ack = GPIO_PORTS_EOI;
>  		gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
> -		gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
> -		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
> +		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
> +		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
> +		gc->chip_types[0].chip.irq_enable = rockchip_irq_enable;
> +		gc->chip_types[0].chip.irq_disable = rockchip_irq_disable;
>  		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
>  		gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
>  		gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
