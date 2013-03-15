From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 Mar 2013 21:47:23 +0100 (CET)
Subject: [PATCH 2/2] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <1363376175-22312-3-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
 <1363376175-22312-3-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <alpine.LFD.2.02.1303152101080.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerlando,

On Fri, 15 Mar 2013, Gerlando Falauto wrote:

> This fixes a regression introduced by e59347a
> "arm: orion: Use generic irq chip".
> 
> The same interrupt mask cache (stored within struct irq_chip_generic)
> is shared between all the irq_chip_type instances. As each irq_chip_type
> can use a distinct mask register, sharing a single mask cache may not be
> correct. For instance in the case of Orion SoCs, which have separate
> mask registers for edge and level interrupts.
> 
> This patch moves mask_cache from struct irq_chip_generic into struct
> irq_chip_type. Note that the interrupt support for Samsung SoCs is also
> slightly affected.

The patch is correct, but we want a more incremental approach.

Step 1: 
     Add the pointer and the mask_cache to ct
     init all ct->pointers in the setup code to gc->mask_cache
     switch core code over to use the ct->pointer

     Functional equivilent!

Step 2:
     Convert each user out of core to the ct->pointer (separate patches)

     Functional equivilent!

Step 3:
     Rename gc->mask_cache to gc->shared_mask_cache

     And we keep that instead of using ct[0].mask_cache simply because
     it makes the code simpler to understand.

Step 4:
     Add the extra flag and the initializer for the separate mask_caches

Step5:
     Convert the affected SOCs (separate patches)

Otherwise I only have a coding style related request:

> @@ -246,9 +246,21 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
>  	list_add_tail(&gc->list, &gc_list);
>  	raw_spin_unlock(&gc_lock);
>  
> -	/* Init mask cache ? */
> -	if (flags & IRQ_GC_INIT_MASK_CACHE)
> -		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
> +	for (i = 0; i < gc->num_ct; i++) {
> +		if (flags & IRQ_GC_SEPARATE_MASK_REGISTERS)
> +			/* Define mask cache pointer */
> +			ct[i].pmask_cache = &ct[i].mask_cache;
> +		else
> +			/* They all point to the same mask cache */
> +			ct[i].pmask_cache = &ct[0].mask_cache;
> +
> +		/* Init mask cache ? */
> +		if ((flags & IRQ_GC_INIT_MASK_CACHE)
> +		 && ((flags & IRQ_GC_SEPARATE_MASK_REGISTER)
> +		  || (i == 0)))
> +			*ct[i].pmask_cache =
> +				irq_reg_readl(gc->reg_base + ct[i].regs.mask);
> +	}

My eyes are burning, my head is spinning and I have a hard time not to
use swearwords.

	bool mskperct = flags & IRQ_GC_SEPARATE_MASK_REGISTERS;
	bool mskinit = flags & IRQ_GC_INIT_MASK_CACHE;
	u32 *shmsk = &gc->shared_mask_cache;

	if (!mskperct && mskinit)
	     	*shmsk = irq_reg_readl(gc->reg_base + ct->regs.mask);

	for (i = 0; i < gc->num_ct: i++, ct++) {
	       ct->pmask_cache = mskperct ? &ct->mask_cache : shmsk;
	       
	       if (mskperct && mskinit)
	       	  	ct->mask_cache = irq_reg_readl(gc->reg_base +
				       	 	       ct->regs.mask);
	}

Or something like that, perhaps ?

Thanks,

	tglx
