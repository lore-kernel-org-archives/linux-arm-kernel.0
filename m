From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 10:54:41 +0200
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <3459745.mC0zoLRDxy@wuerfel>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk>
 <2958731.nsOomQFma0@wuerfel> <3459745.mC0zoLRDxy@wuerfel>
Message-ID: <20140911105441.7876966a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Thanks for working on this.

On Mon, 08 Sep 2014 22:42:23 +0200, Arnd Bergmann wrote:

> - The pl310 errata workarounds are not needed on aurora and can be removed
> - The cache_wait() macro is never needed since this is not an l210/l220

I am not sure about this change (see below).

> - aurora_pa_range can keep the spinlock while syncing the cache
> - We can load the l2x0_base into a local variable across operations

I am fine with this one, but I'm wondering what is the benefit of doing
this? The l2x0_base is anyway a global variable that is available for
all those functions, so not sure what an additional local variable
brings us.


> -#ifdef CONFIG_CACHE_PL310
> -static inline void cache_wait(void __iomem *reg, unsigned long mask)
> -{
> -	/* cache operations by line are atomic on PL310 */
> -}
> -#else
> -#define cache_wait	l2c_wait_mask
> -#endif

How do you conclude from this that cache_wait() does nothing? When
we're on PL310, it indeed does nothing, but in our case, we're not on a
PL310, so cache_wait is equivalent to l2c_wait_mask, which does:

/*
 * Common code for all cache controllers.
 */
static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
{
        /* wait for cache operation by line or way to complete */
        while (readl_relaxed(reg) & mask)
                cpu_relax();
}

And this does not seem to be in any conditional making it specific to
PL210/PL220 as your commit log suggests.

> -static inline void cache_sync(void)
> -{
> -	void __iomem *base = l2x0_base;
> -
> -	writel_relaxed(0, base + sync_reg_offset);
> -	cache_wait(base + L2X0_CACHE_SYNC, 1);

So to me, this line is actually doing something on an Aurora cache
controller.

Am I missing something?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
