From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 14 Mar 2013 18:45:59 +0100
Subject: [PATCH] genirq: allow an alternative setup for the mask cache
In-Reply-To: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
Message-ID: <20130314174559.GO21620@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 05:10:30PM +0100, Holger Brunck wrote:
> The same interrupt mask cache (stored within struct irq_chip_generic)
> is shared between all the irq_chip_type instances by default. But this
> does not work on Orion SOCs which have separate mask registers for edge
> and level interrupts. Therefore refactor the code that we always use a
> pointer to access the mask register. By default it points to
> gc->mask_cache for Orion SOCs it points to ct->mask_cache which is
> setup in irq_setup_alt_chip().

Thanks for patch. I was really willing to do it but you have been
faster.

> 
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>

You may add here:

Reported-by: Joey Oravec <joravec@drewtech.com>

Joey took some time to report and describe this bug.

> ---
>  include/linux/irq.h       |    3 +++
>  kernel/irq/generic-chip.c |   19 ++++++++++++-------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index bc4e066..6bf2447 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -654,6 +654,7 @@ struct irq_chip_type {
>  	struct irq_chip_regs	regs;
>  	irq_flow_handler_t	handler;
>  	u32			type;
> +	u32			mask_cache;
>  };
>  
>  /**
> @@ -663,6 +664,7 @@ struct irq_chip_type {
>   * @irq_base:		Interrupt base nr for this chip
>   * @irq_cnt:		Number of interrupts handled by this chip
>   * @mask_cache:		Cached mask register
> + * @pmask_cache:	pointer to cached mask register
>   * @type_cache:		Cached type register
>   * @polarity_cache:	Cached polarity register
>   * @wake_enabled:	Interrupt can wakeup from suspend
> @@ -684,6 +686,7 @@ struct irq_chip_generic {
>  	unsigned int		irq_base;
>  	unsigned int		irq_cnt;
>  	u32			mask_cache;
> +	u32			*pmask_cache;
>  	u32			type_cache;
>  	u32			polarity_cache;
>  	u32			wake_enabled;
> diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
> index c89295a..1be14a3 100644
> --- a/kernel/irq/generic-chip.c
> +++ b/kernel/irq/generic-chip.c
> @@ -43,7 +43,7 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
>  
>  	irq_gc_lock(gc);
>  	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->disable);
> -	gc->mask_cache &= ~mask;
> +	*gc->pmask_cache &= ~mask;
>  	irq_gc_unlock(gc);
>  }
>  
> @@ -60,8 +60,8 @@ void irq_gc_mask_set_bit(struct irq_data *d)
>  	u32 mask = 1 << (d->irq - gc->irq_base);
>  
>  	irq_gc_lock(gc);
> -	gc->mask_cache |= mask;
> -	irq_reg_writel(gc->mask_cache, gc->reg_base + cur_regs(d)->mask);
> +	*gc->pmask_cache |= mask;
> +	irq_reg_writel(*gc->pmask_cache, gc->reg_base + cur_regs(d)->mask);
>  	irq_gc_unlock(gc);
>  }
>  
> @@ -78,8 +78,8 @@ void irq_gc_mask_clr_bit(struct irq_data *d)
>  	u32 mask = 1 << (d->irq - gc->irq_base);
>  
>  	irq_gc_lock(gc);
> -	gc->mask_cache &= ~mask;
> -	irq_reg_writel(gc->mask_cache, gc->reg_base + cur_regs(d)->mask);
> +	*gc->pmask_cache &= ~mask;
> +	irq_reg_writel(*gc->pmask_cache, gc->reg_base + cur_regs(d)->mask);
>  	irq_gc_unlock(gc);
>  }
>  > @@ -97,7 +97,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
>  
>  	irq_gc_lock(gc);
>  	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->enable);
> -	gc->mask_cache |= mask;
> +	*gc->pmask_cache |= mask;
>  	irq_gc_unlock(gc);
>  }
>  
> @@ -243,9 +243,12 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
>  	list_add_tail(&gc->list, &gc_list);
>  	raw_spin_unlock(&gc_lock);
>  
> +	/* Setup pointer to mask_cache */
> +	gc->pmask_cache = &gc->mask_cache;

You need a flag here to choose between gc->mask_cache and
ct->mask_cache.

> +
>  	/* Init mask cache ? */
>  	if (flags & IRQ_GC_INIT_MASK_CACHE)
> -		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
> +		*gc->pmask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
>  
>  	for (i = gc->irq_base; msk; msk >>= 1, i++) {
>  		if (!(msk & 0x01))
> @@ -275,6 +278,8 @@ int irq_setup_alt_chip(struct irq_data *d, unsigned int type)
>  	struct irq_chip_type *ct = gc->chip_types;
>  	unsigned int i;
>  
> +	/* Setup pointer to the mask_cache */
> +	gc->pmask_cache = &ct->mask_cache;

You also need to check the flag here, to know if you need to switch
pmask_cache on ct->mask_cache.

>  	for (i = 0; i < gc->num_ct; i++, ct++) {
>  		if (ct->type & type) {
>  			d->chip = &ct->chip;

Additionally, you need to update drivers/gpio/gpio-mvebu.c which use
gc->mask_cache. The gpio-mvebu driver is also impacted by the bug. 

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/c5428cd1/attachment.sig>
