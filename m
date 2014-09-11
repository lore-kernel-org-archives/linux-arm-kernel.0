From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 11:50:29 +0200
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <20140911105441.7876966a@free-electrons.com>
References: <2852268.nkG1OoBDfE@wuerfel> <3459745.mC0zoLRDxy@wuerfel>
 <20140911105441.7876966a@free-electrons.com>
Message-ID: <5286718.xUAA8Uddjq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 10:54:41 Thomas Petazzoni wrote:
> 
> On Mon, 08 Sep 2014 22:42:23 +0200, Arnd Bergmann wrote:
> 
> > - The pl310 errata workarounds are not needed on aurora and can be removed
> > - The cache_wait() macro is never needed since this is not an l210/l220
> 
> I am not sure about this change (see below).
> 
> > - aurora_pa_range can keep the spinlock while syncing the cache
> > - We can load the l2x0_base into a local variable across operations
> 
> I am fine with this one, but I'm wondering what is the benefit of doing
> this? The l2x0_base is anyway a global variable that is available for
> all those functions, so not sure what an additional local variable
> brings us.

The compiler does not always know if the l2x0_base pointer has changed
between two accesses. In particular if we do a spin_lock/spin_unlock
as in aurora_pa_range() it has to reload it.

Using a local variable tells the compiler that the pointer should
in fact be read once from memory and then used from a register,
which results in slightly smaller and more efficient object code.

> > -#ifdef CONFIG_CACHE_PL310
> > -static inline void cache_wait(void __iomem *reg, unsigned long mask)
> > -{
> > -     /* cache operations by line are atomic on PL310 */
> > -}
> > -#else
> > -#define cache_wait   l2c_wait_mask
> > -#endif
> 
> How do you conclude from this that cache_wait() does nothing? When
> we're on PL310, it indeed does nothing, but in our case, we're not on a
> PL310, so cache_wait is equivalent to l2c_wait_mask, which does:
>
> /*
>  * Common code for all cache controllers.
>  */
> static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
> {
>         /* wait for cache operation by line or way to complete */
>         while (readl_relaxed(reg) & mask)
>                 cpu_relax();
> }
> 
> And this does not seem to be in any conditional making it specific to
> PL210/PL220 as your commit log suggests.

Interesting. If that is the intention of the code, it is rather broken
because CONFIG_CACHE_PL310 gets set automatically on ARMv7:

if CACHE_L2X0

config CACHE_PL310
        bool
        default y if CPU_V7 && !(CPU_V6 || CPU_V6K)
        help
          This option enables optimisations for the PL310 cache
          controller.
...
endif

This is from the original l2x0 code that is no longer used by anything
other than aurora. The idea was apparently that if we are on a v6+v7
kernel, we might have a l210 and need to wait here, while on a v7-only
kernel, we know that we have a pl310 and never need to do it.

> > -static inline void cache_sync(void)
> > -{
> > -     void __iomem *base = l2x0_base;
> > -
> > -     writel_relaxed(0, base + sync_reg_offset);
> > -     cache_wait(base + L2X0_CACHE_SYNC, 1);
> 
> So to me, this line is actually doing something on an Aurora cache
> controller.
> 
> Am I missing something?

It might be needed, I haven't checked the data sheet. However we don't
run that code today, and my patch does not change that.

	Arnd
