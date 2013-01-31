From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 31 Jan 2013 12:16:35 -0500 (EST)
Subject: [PATCH v3 03/15] ARM: mcpm: introduce helpers for platform
 coherency exit/setup
In-Reply-To: <510A96F7.8090106@ti.com>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-4-git-send-email-nicolas.pitre@linaro.org>
 <510A96F7.8090106@ti.com>
Message-ID: <alpine.LFD.2.02.1301311210040.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013, Santosh Shilimkar wrote:

> On Tuesday 29 January 2013 01:20 PM, Nicolas Pitre wrote:
> > From: Dave Martin <dave.martin@linaro.org>
> > 
> > This provides helper methods to coordinate between CPUs coming down
> > and CPUs going up, as well as documentation on the used algorithms,
> > so that cluster teardown and setup
> > operations are not done for a cluster simultaneously.
> > 
> > For use in the power_down() implementation:
> >    * __mcpm_cpu_going_down(unsigned int cluster, unsigned int cpu)
> >    * __mcpm_outbound_enter_critical(unsigned int cluster)
> >    * __mcpm_outbound_leave_critical(unsigned int cluster)
> >    * __mcpm_cpu_down(unsigned int cluster, unsigned int cpu)
> > 
> > The power_up_setup() helper should do platform-specific setup in
> > preparation for turning the CPU on, such as invalidating local caches
> > or entering coherency.  It must be assembler for now, since it must
> > run before the MMU can be switched on.  It is passed the affinity level
> > which should be initialized.
> > 
> > Because the mcpm_sync_struct content is looked-up and modified
> > with the cache enabled or disabled depending on the code path, it is
> > crucial to always ensure proper cache maintenance to update main memory
> > right away.  Therefore, any cached write must be followed by a cache
> > clean operation and any cached read must be preceded by a cache
> > invalidate operation (actually a cache flush i.e. clean+invalidate to
> > avoid discarding possible concurrent writes) on the accessed memory.
> > 
> > Also, in order to prevent a cached writer from interfering with an
> > adjacent non-cached writer, we ensure each state variable is located to
> > a separate cache line.
> > 
> > Thanks to Nicolas Pitre and Achin Gupta for the help with this
> > patch.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > ---
> [..]
> 
> > diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> > index c8c0e2113e..2b83121966 100644
> > --- a/arch/arm/common/mcpm_entry.c
> > +++ b/arch/arm/common/mcpm_entry.c
> > @@ -18,6 +18,7 @@
> >   #include <asm/proc-fns.h>
> >   #include <asm/cacheflush.h>
> >   #include <asm/idmap.h>
> > +#include <asm/cputype.h>
> > 
> >   extern volatile unsigned long
> > mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
> > 
> [...]
> 
> > +/*
> > + * Ensure preceding writes to *p by other CPUs are visible to
> > + * subsequent reads by this CPU.  We must be careful not to
> > + * discard data simultaneously written by another CPU, hence the
> > + * usage of flush rather than invalidate operations.
> > + */
> > +static void __sync_range_r(volatile void *p, size_t size)
> > +{
> > +	char *_p = (char *)p;
> > +
> > +#ifdef CONFIG_OUTER_CACHE
> > +	if (outer_cache.flush_range) {
> > +
> You don't need above #ifdef. In case of non-outer
> cache the function pointer is null anyways.

We do need the #ifdef, because if CONFIG_OUTER_CACHE is not selected 
then the outer_cache structure simply doesn't exist.

> 		/*
> > +		 * Ensure dirty data migrated from other CPUs into our cache
> > +		 * are cleaned out safely before the outer cache is cleaned:
> > +		 */
> > +		__cpuc_clean_dcache_area(_p, size);
> > +
> > +		/* Clean and invalidate stale data for *p from outer ... */
> > +		outer_flush_range(__pa(_p), __pa(_p + size));
> > +	}
> > +#endif
> > +
> > +	/* ... and inner cache: */
> > +	__cpuc_flush_dcache_area(_p, size);
> This will be un-necessary when inner cache is available, no ?
> May be you can re-arrange the code like below, unless and until
> you would like to invalidate any speculative fetches during the
> outer_flush_range()
> 
> 	__cpuc_clean_dcache_area(_p, size);
> 	if (outer_cache.flush_range)
> 		outer_flush_range(__pa(_p), __pa(_p + size));

As you said, the code is sequenced that way to get rid of potential 
speculative fetch that could happen right before L2 is flushed.

See discussion here:
http://article.gmane.org/gmane.linux.ports.arm.kernel/208887


Nicolas
