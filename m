From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 1 Mar 2010 03:44:28 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <1267199030.14703.28.camel@e102109-lin.cambridge.arm.com>
References: <20100223152402.GF10501@n2100.arm.linux.org.uk>
	<1266940955.3123.133.camel@e102109-lin.cambridge.arm.com>
	<20100223180342.GA26434@n2100.arm.linux.org.uk>
	<1267199030.14703.28.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100301034428.GF8391@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> A better implementation would be this:
> 
> #ifndef CONFIG_SMP
> #define smp_mb()	barrier()
> #define smp_rmb()	barrier()
> #define smp_wmb()	barrier()
> #else
> #define smp_mb()	dsb()
> #define smp_rmb()	mb()
> #define smp_wmb()	dsb()
> #endif
> 
> Since the mb() may have other effects like draining the L2 write buffer
> which is definitely not needed for the SMP barriers.
> 
> Anyway, the above change to smp_*mb() would probably have a performance
> impact especially with spinlocks.
> 
> I can see that the driver situation you described appears in other
> drivers as well. Whether this is a correct usage model I can't tell. It
> may be worth going with this on linux-arch. PowerPC for example uses a
> light barrier for the smp_wmb() case which doesn't ensure ordering
> between accesses to normal vs I/O memory.

I agree, it looks like some confusion about the meaning of smp_wmb()
for ordering w.r.t. I/O, DMA and interrupts has crept in.
It would be good to clarify it.

-- Jamie
