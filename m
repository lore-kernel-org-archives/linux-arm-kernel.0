From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 02 Feb 2012 21:35:59 -0500 (EST)
Subject: [PATCH] ARM: cache-v7: Disable preemption when reading CCSIDR
In-Reply-To: <1328234629-32735-1-git-send-email-sboyd@codeaurora.org>
References: <1328234629-32735-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1202022110080.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Feb 2012, Stephen Boyd wrote:
> On 02/02/12 17:18, Nicolas Pitre wrote:
> > If you simply disable/restore IRQs around the critical region then you 
> > don't have to worry about __v7_setup.  Plus this will allow for 
> > v7_flush_dcache_all to still be callable from atomic context.
> 
> Ok. Here's a patch. I still need to test it. I'll send another patch
> series to cleanup the get_thread_info stuff (there's two of them?).
> 
>  arch/arm/mm/cache-v7.S |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 07c4bc8..654a5fc 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -54,9 +54,15 @@ loop1:
>  	and	r1, r1, #7			@ mask of the bits for current cache only
>  	cmp	r1, #2				@ see what cache we have at this level
>  	blt	skip				@ skip if no cache, or just i-cache
> +#ifdef CONFIG_PREEMPT
> +	save_and_disable_irqs r9		@ make cssr&csidr read atomic
> +#endif
>  	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
>  	isb					@ isb to sych the new cssr&csidr
>  	mrc	p15, 1, r1, c0, c0, 0		@ read the new csidr
> +#ifdef CONFIG_PREEMPT
> +	restore_irqs r9
> +#endif

I'd suggest using restore_irqs_notrace instead.  The IRQ-off period is 
so small that there is no point tracing it.

Withthat change:

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas
