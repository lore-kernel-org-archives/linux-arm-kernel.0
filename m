From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Jan 2013 10:36:06 +0000
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <alpine.LFD.2.02.1301101713380.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
 <CAHkRjk4A+EMFRTVdfCUBNpAEUMWrOqbT2ki19Vska6dY_WrVXQ@mail.gmail.com>
 <alpine.LFD.2.02.1301101232270.6300@xanadu.home>
 <CAHkRjk5f5Rg6Sc8vLOashcesOdf8aQAtvHJ_PN_UJ3S2xEL30w@mail.gmail.com>
 <alpine.LFD.2.02.1301101713380.6300@xanadu.home>
Message-ID: <20130111103606.GA1966@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 05:31:08PM -0500, Nicolas Pitre wrote:
> On Thu, 10 Jan 2013, Catalin Marinas wrote:
> 
> > On 10 January 2013 17:59, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > On Thu, 10 Jan 2013, Catalin Marinas wrote:
> > >
> > >> On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > >> > --- a/arch/arm/common/bL_entry.c
> > >> > +++ b/arch/arm/common/bL_entry.c
> > >> > @@ -116,3 +116,163 @@ int bL_cpu_powered_up(void)
> > >> >                 platform_ops->powered_up();
> > >> >         return 0;
> > >> >  }
> > >> > +
> > >> > +struct bL_sync_struct bL_sync;
> > >> > +
> > >> > +static void __sync_range(volatile void *p, size_t size)
> > >> > +{
> > >> > +       char *_p = (char *)p;
> > >> > +
> > >> > +       __cpuc_flush_dcache_area(_p, size);
> > >> > +       outer_flush_range(__pa(_p), __pa(_p + size));
> > >> > +       outer_sync();
> > ...
> > >> However, on the same CPU you can get a speculative load into L1 after
> > >> the L1 flush but before the L2 flush, so the reader case can fail.
> > >>
> > >> The sequence for readers is (note *L2* inval first):
> > >>
> > >> L2 inval
> > >> L1 inval
> > >
> > > As you noted below and as I explained above, this can't be an inval
> > > operation as that could discard a concurrent writer's update.
> > >
> > >> The sequence for writers is:
> > >>
> > >> L1 clean
> > >> L2 clean
> > >>
> > >> The bi-directional sequence (that's what you need) is:
> > >>
> > >> L1 clean
> > >> L2 clean+inval
> > >> L1 clean+inval

Agreed.  My bad, sorry... I was focusing on other aspects; plus we have
no actual outer cache, so the mis-ordering is hidden in our testing.

This code has been through a few iterations, some of which had separate
sequences for reads and writes, though possibly the ordering is still
wrong.

If our cache is enabled, we may end up with the responsibility of writing
out another CPU's dirty lines due to speculative migration, so for most
or all of the flushes here, we do need the third sequence (inner clean;
outer clean+invalidate; inner clean+invalidate)

> > >>
> > >> The last L1 op must be clean+inval in case another CPU writes to this
> > >> location to avoid discarding the write.
> > >>
> > >> If you don't have an L2, you just end up with two L1 clean ops, so you
> > >> can probably put some checks.
> > >
> > > In fact, since this is only used on A7/A15 right now, there is no outer
> > > cache and the outer calls are effectively no-ops.  I'm wondering if
> > > those should simply be removed until/unless there is some system showing
> > > up with a need for them.
> > 
> > You could. I expect multi-cluster systems to have integrated L2 cache
> > and avoid explicit outer cache maintenance. But is there a chance that
> > your patches could be generalised to existing systems with A9 (not b.L
> > configuration but just hotplug or cpuidle support)? I haven't finished
> > reading all the patches, so maybe that's not the case at all.
> 
> I suppose it could, although the special requirements put on the first 
> man / last man exist only for multi-cluster systems.  OTOH, existing A9 
> systems are already served by far less complex code already, so it is 
> really a matter of figuring out if the backend for those A9 systems 
> needed by this cluster code would be simpler than the existing code, in 
> which case that would certainly be beneficial.

The outer operations just expand to nothing if there is no outer cache; the
optimisation would be that instead of L1 clean; L1 clean+inval, we just
need L1 clean+inval.

> > Anyway, my point is that if L1 is inner and L2 outer, the correct
> > bi-derectional flushing sequence is slightly different.
> 
> Agreed, I'll make sure to capture that in the code somehow.

I'll have a go at this today (but I won't over-elaborate in case you've
already done it...)

Cheers
---Dave
