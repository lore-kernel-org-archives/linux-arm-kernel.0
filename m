From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 11 Mar 2011 17:33:21 +0100 (CET)
Subject: [PATCH 1/7] ARM: irq: introduce entry and exit functions for
	chained handlers
In-Reply-To: <1299604405-12960-2-git-send-email-will.deacon@arm.com>
References: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
	<1299604405-12960-2-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1103111731440.2787@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Mar 2011, Will Deacon wrote:

> Some chained IRQ handlers are written to cope with primary chips of
> potentially different flow types. Whether this a sensible thing to do
> is a point of contention.

That wants a comment that these functions are only dealing with
fasteoi and level type flow control.

Otherwise fine with me. Feel free to add my Acked-by.

> This patch introduces entry/exit functions for chained handlers which
> infer the flow type of the primary chip by checking whether or not
> the ->irq_eoi function pointer is present and calling back to the
> primary chip as necessary.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/mach/irq.h |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
> index 22ac140..34d1de8 100644
> --- a/arch/arm/include/asm/mach/irq.h
> +++ b/arch/arm/include/asm/mach/irq.h
> @@ -34,4 +34,31 @@ do {							\
>  	raw_spin_unlock(&desc->lock);			\
>  } while(0)
>  
> +#ifndef __ASSEMBLY__
> +static inline void chained_irq_enter(struct irq_chip *chip,
> +				     struct irq_desc *desc)
> +{
> +	/* FastEOI controllers require no action on entry. */
> +	if (chip->irq_eoi)
> +		return;
> +
> +	if (chip->irq_mask_ack) {
> +		chip->irq_mask_ack(&desc->irq_data);
> +	} else {
> +		chip->irq_mask(&desc->irq_data);
> +		if (chip->irq_ack)
> +			chip->irq_ack(&desc->irq_data);
> +	}
> +}
> +
> +static inline void chained_irq_exit(struct irq_chip *chip,
> +				    struct irq_desc *desc)
> +{
> +	if (chip->irq_eoi)
> +		chip->irq_eoi(&desc->irq_data);
> +	else
> +		chip->irq_unmask(&desc->irq_data);
> +}
> +#endif
> +
>  #endif
> -- 
> 1.7.0.4
> 
