From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 12:59:54 -0500 (EST)
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <CAHkRjk4A+EMFRTVdfCUBNpAEUMWrOqbT2ki19Vska6dY_WrVXQ@mail.gmail.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
 <CAHkRjk4A+EMFRTVdfCUBNpAEUMWrOqbT2ki19Vska6dY_WrVXQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1301101232270.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Catalin Marinas wrote:

> On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > --- /dev/null
> > +++ b/Documentation/arm/big.LITTLE/cluster-pm-race-avoidance.txt
> > @@ -0,0 +1,498 @@
> > +Big.LITTLE cluster Power-up/power-down race avoidance algorithm
> > +===============================================================
> 
> Nice description and ascii art :).
> 
> > --- a/arch/arm/common/bL_entry.c
> > +++ b/arch/arm/common/bL_entry.c
> > @@ -116,3 +116,163 @@ int bL_cpu_powered_up(void)
> >                 platform_ops->powered_up();
> >         return 0;
> >  }
> > +
> > +struct bL_sync_struct bL_sync;
> > +
> > +static void __sync_range(volatile void *p, size_t size)
> > +{
> > +       char *_p = (char *)p;
> > +
> > +       __cpuc_flush_dcache_area(_p, size);
> > +       outer_flush_range(__pa(_p), __pa(_p + size));
> > +       outer_sync();
> 
> The outer flush-range operations already contain a cache_sync, so an
> additional outer_sync() operation is not necessary.
> 
> You (well, Dave) said that you use the flush instead of
> clean/invalidate to avoid races with other CPUs writing the location.

Yes.  To clarify for everyone, the issue here is that those state values 
are being written and/or read by different CPUs which may or may not 
have their cache enabled.  And in some cases the L1 cache is disabled 
but L2 is still enabled.

So a cached reader must invalidate the cache to ensure it reads an 
up-to-date value from RAM since the last update might have come from a 
CPU with its cache disabled.  But invalidating the cache might discard 
the newly updated state from a writer with an active cache before that 
writer had the chance to clean its cache to RAM.  Therefore, using a 
cache flush rather than a cache invalidate before every reads solves 
this race.

> However, on the same CPU you can get a speculative load into L1 after
> the L1 flush but before the L2 flush, so the reader case can fail.
> 
> The sequence for readers is (note *L2* inval first):
> 
> L2 inval
> L1 inval

As you noted below and as I explained above, this can't be an inval 
operation as that could discard a concurrent writer's update.

> The sequence for writers is:
> 
> L1 clean
> L2 clean
> 
> The bi-directional sequence (that's what you need) is:
> 
> L1 clean
> L2 clean+inval
> L1 clean+inval
> 
> The last L1 op must be clean+inval in case another CPU writes to this
> location to avoid discarding the write.
> 
> If you don't have an L2, you just end up with two L1 clean ops, so you
> can probably put some checks.

In fact, since this is only used on A7/A15 right now, there is no outer 
cache and the outer calls are effectively no-ops.  I'm wondering if 
those should simply be removed until/unless there is some system showing 
up with a need for them.

> > +#define sync_mem(ptr) __sync_range(ptr, sizeof *(ptr))
> > +
> > +/*
> > + * __bL_cpu_going_down: Indicates that the cpu is being torn down.
> > + *    This must be called at the point of committing to teardown of a CPU.
> > + *    The CPU cache (SCTRL.C bit) is expected to still be active.
> > + */
> > +void __bL_cpu_going_down(unsigned int cpu, unsigned int cluster)
> > +{
> > +       bL_sync.clusters[cluster].cpus[cpu].cpu = CPU_GOING_DOWN;
> > +       sync_mem(&bL_sync.clusters[cluster].cpus[cpu].cpu);
> > +}
> > +
> > +/*
> > + * __bL_cpu_down: Indicates that cpu teardown is complete and that the
> > + *    cluster can be torn down without disrupting this CPU.
> > + *    To avoid deadlocks, this must be called before a CPU is powered down.
> > + *    The CPU cache (SCTRL.C bit) is expected to be off.
> > + */
> > +void __bL_cpu_down(unsigned int cpu, unsigned int cluster)
> > +{
> > +       dsb();
> > +       bL_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
> > +       sync_mem(&bL_sync.clusters[cluster].cpus[cpu].cpu);
> > +       sev();
> 
> For the sev() here (and other functions in this patch) you need a
> dsb() before. I'm not sure outer_sync() has one.

__cpuc_flush_dcache_area() does though, via v7_flush_kern_dcache_area.


Nicolas
