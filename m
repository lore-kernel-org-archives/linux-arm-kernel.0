From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 13:34:28 +0000
Subject: [PATCH 1/2] mach-ux500: cache operations are atomic on PL310
In-Reply-To: <20120117112741.GA14426@bnru02>
References: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <20120113181422.GB24373@mudshark.cambridge.arm.com>
 <20120116110528.GA24824@bnru02>
 <20120116145008.GH9068@mudshark.cambridge.arm.com>
 <20120117062224.GA26832@bnru02>
 <20120117103023.GB9230@mudshark.cambridge.arm.com>
 <20120117112741.GA14426@bnru02>
Message-ID: <20120117133428.GB11581@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 11:27:43AM +0000, Srinidhi KASAGAR wrote:
> On Tue, Jan 17, 2012 at 11:30:23 +0100, Will Deacon wrote:
> > On Tue, Jan 17, 2012 at 06:22:26AM +0000, Srinidhi KASAGAR wrote:
> > > 
> > > Yes, we boot with L2 enabled.
> > 
> > Interesting. I'm surprised you don't have problems with stale data on the
> > D-side after the decompressor. Maybe you're lucky with the mappings being no
> > write allocate.
> 
> Actually the pre bootloader makes sure that L2 is clean before relinquishing
> the control to kernel decompressor.

I was thinking more of the decompressor populating the L2 and not flushing
it.

> From a8cf7e2f7b58c3ef860be58fa72cd0c51e2be487 Mon Sep 17 00:00:00 2001
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Date: Tue, 17 Jan 2012 11:29:39 +0530
> Subject: [PATCH] mach-ux500: Do not override outer.inv_all
> 
> Invalidating outer cache without disabling it is a big
> nono, and so, remove the machine specific outer.inv_all
> 
> And at the same time it does not prevent us overriding
> outer.disable as we do not have any such secure SMI to
> handle the same while kexec disables the outer cache.
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
>  arch/arm/mach-ux500/cache-l2x0.c |   48 +++++--------------------------------
>  1 files changed, 7 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
> index 122ddde..45111c8 100644
> --- a/arch/arm/mach-ux500/cache-l2x0.c
> +++ b/arch/arm/mach-ux500/cache-l2x0.c
> @@ -12,44 +12,6 @@
>  
>  static void __iomem *l2x0_base;
>  
> -static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
> -{
> -	/* wait for the operation to complete */
> -	while (readl_relaxed(reg) & mask)
> -		cpu_relax();
> -}
> -
> -static inline void ux500_cache_sync(void)
> -{
> -	writel_relaxed(0, l2x0_base + L2X0_CACHE_SYNC);
> -	ux500_cache_wait(l2x0_base + L2X0_CACHE_SYNC, 1);
> -}
> -
> -/*
> - * The L2 cache cannot be turned off in the non-secure world.
> - * Dummy until a secure service is in place.
> - */
> -static void ux500_l2x0_disable(void)
> -{
> -}
> -
> -/*
> - * This is only called when doing a kexec, just after turning off the L2
> - * and L1 cache, and it is surrounded by a spinlock in the generic version.
> - * However, we're not really turning off the L2 cache right now and the
> - * PL310 does not support exclusive accesses (used to implement the spinlock).
> - * So, the invalidation needs to be done without the spinlock.
> - */
> -static void ux500_l2x0_inv_all(void)
> -{
> -	uint32_t l2x0_way_mask = (1<<16) - 1;	/* Bitmask of active ways */
> -
> -	/* invalidate all ways */
> -	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
> -	ux500_cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
> -	ux500_cache_sync();
> -}
> -
>  static int __init ux500_l2x0_unlock(void)
>  {
>  	int i;
> @@ -85,9 +47,13 @@ static int __init ux500_l2x0_init(void)
>  	/* 64KB way size, 8 way associativity, force WA */
>  	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
>  
> -	/* Override invalidate function */
> -	outer_cache.disable = ux500_l2x0_disable;
> -	outer_cache.inv_all = ux500_l2x0_inv_all;
> +	/*
> +	 * We can't disable l2 as we are in non secure mode, currently
> +	 * this seems being called only during kexec path. So let's

s/being/to be/

> +	 * override outer.disable with nasty assignment until we have
> +	 * some SMI service available.
> +	 */
> +	outer_cache.disable = NULL;

This looks alright to me.

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
