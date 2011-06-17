From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2011 18:08:44 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <BANLkTi=XTJuF4np7+rYHzJqWK20OxMrBsw@mail.gmail.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106142030.07549.arnd@arndb.de>
	<BANLkTi=XTJuF4np7+rYHzJqWK20OxMrBsw@mail.gmail.com>
Message-ID: <201106171808.44178.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 June 2011, Daniel Vetter wrote:
> On Tue, Jun 14, 2011 at 20:30, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 14 June 2011 18:58:35 Michal Nazarewicz wrote:
> >> Ah yes, I forgot that separate regions for different purposes could
> >> decrease fragmentation.
> >
> > That is indeed a good point, but having a good allocator algorithm
> > could also solve this. I don't know too much about these allocation
> > algorithms, but there are probably multiple working approaches to this.
> 
> imo no allocator algorithm is gonna help if you have comparably large,
> variable-sized contiguous allocations out of a restricted address range.
> It might work well enough if there are only a few sizes and/or there's
> decent headroom. But for really generic workloads this would require
> sync objects and eviction callbacks (i.e. what Thomas Hellstrom pushed
> with ttm).

The requirements are quite different depending on what system you
look at. In a lot of cases, the constraints are not that tight at all,
and CMA will easily help to turn "works sometimes" into "works almost
always". Let's get there first and then look into the harder problems.

Unfortunately, memory allocation gets nondeterministic in the corner
cases, you can simply get the system into a state where you don't
have enough memory when you try to do too many things at once. This
may sound like a platitude but it's really what is behind all this:

If we had unlimited amounts of RAM, we would never need CMA, we could
simply set aside a lot of memory at boot time. Having one CMA area
with movable page eviction lets you build systems capable of doing
the same thing with less RAM than without CMA. Adding more complexity
lets you reduce that amount further.

The other aspects that have been mentioned about bank affinity and
SRAM are pretty orthogonal to the allocation, so we should also
treat them separately.

> So if this is only a requirement on very few platforms and can be
> cheaply fixed with multiple cma allocation areas (heck, we have
> slabs for the same reasons in the kernel), it might be a sensible
> compromise.

Yes, we can probably add it later when we find out what the limits
of the generic approach are. I don't really mind having the per-device
pointers to CMA areas, we just need to come up with a good way to
initialize them.

	Arnd
