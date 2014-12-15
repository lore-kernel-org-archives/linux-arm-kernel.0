From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 15 Dec 2014 14:30:03 +0000
Subject: Do I need to invalidate caches before enabling (on ARMv7)?
In-Reply-To: <20141208115908.GE16185@e104818-lin.cambridge.arm.com>
References: <20141204100357.GO2129@pengutronix.de>
 <20141208115908.GE16185@e104818-lin.cambridge.arm.com>
Message-ID: <20141215143003.GA15879@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 11:59:09AM +0000, Catalin Marinas wrote:
> On Thu, Dec 04, 2014 at 10:03:57AM +0000, Uwe Kleine-K?nig wrote:
> > Reading through ARMARM for v7-A and v7-R (ARM DDI 0406C.c, p1269) I
> > found:
> > 
> >  ==== Behavior of the caches at reset ====
> >  [...]
> >  * An implementation can require the use of a specific cache
> >    initialization routine to invalidate its storage array before it is
> >    enabled.
> 
> Yes.
> 
> > The breakage I'm currently seeing in barebox might well be explained by
> > stale I-cache entries and barebox (as of now) doesn't invalidate the
> > i-cache before enabling it.
> 
> It should.
> 
> > In the paragraph that the above quote is taken from, furthermore the
> > following is written:
> > 
> >  It is IMPLEMENTATION DEFINED whether an access can generate a cache hit
> >  when the cache is disabled.
> > 
> > So stale entries in the cache might even hurt before the cache is
> > enabled?!
> 
> The above is continued with:
> 
>   In particular, if an implementation permits cache hits when the cache
>   is disabled and the cache contents are not invalidated at reset, the
>   initialization routine must avoid any possibility of running from an
>   uninitialized cache. It is acceptable for an initialization routine to
>   require a fixed instruction sequence to be placed in a restricted
>   range of memory.
> 
> So if some implementation does this, the SoC firmware must take care of
> this before invoking other code like boot-loaders.
> 
> In addition, B3.2.1 VMSA behaviour when Stage 1 MMU is disabled states
> that when SCTLR.I is 0, the memory accesses are non-cacheable, so such
> accesses should hit in the cache (until the MMU is enabled).

You mean "should not" right ? I think that given the IMPLEMENTATION
DEFINED behaviour, caches must always be invalidated on reset by
the code that enables them. On new generation cores (eg A15 and A7) this
is done in HW.

> Anyway, cc'ing Lorenzo for when he's back from holiday, he spent a lot
> of time digging into this.

For the specific issue Uwe is hitting invalidation on both I and D caches
is what is needed, but on v7 processors the cache enabling/disabling has
implementation specific behaviour that should be handled on a per
implementation basis (D-cache behaviour when SCTLR.C is 0 is another prime
example).

Lorenzo
