From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Nov 2014 17:41:30 +0000
Subject: [PATCH] arm64: efi: Fix stub cache maintenance
In-Reply-To: <54639500.5010309@amd.com>
References: <1415810351-3462-1-git-send-email-mark.rutland@arm.com>
 <54639500.5010309@amd.com>
Message-ID: <20141112174130.GN28015@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 05:12:32PM +0000, Joel Schopp wrote:
> 
> >  
> > +	/*
> > +	 * Ensure that the rest of this function (in the original Image) is
> > +	 * visible when the caches are disabled. The I-cache can't have stale
> > +	 * entries for the VA range of the current image, so no maintenance is
> > +	 * necessary.
> > +	 */
> > +	adr	x0, efi_stub_entry
> > +	adr	x1, efi_stub_entry_end
> > +	sub	x1, x1, x0
> > +	bl	__flush_dcache_area
> It is my understdanding that you also need an isb here.  Tom's testing
> confirms this on my patch with the dsb and without the isb. 

Ok. I still can't see what context we would be synchronising, but it's
entirely possible my reasoning is off. I'm more than happy to add the
ISB if necessary, but I'd like to know why it is necessary.

> Also, since this is not a performance critical path it seems more
> straightforward to just flush everything.

Unfortunately, there's no way of flushing everything to the PoC.

Due to the possible presence of a system cache (e.g. the L3 in CCN), it
is only possible to flush data to the PoC by means of VA operations,
which must respect maintenance by VA per the architecture (see the ARMv8
ARM ARM, issue A.d).

Using Set/Way operations will at best only flush out to the L3 cache,
and even that is racy while the D-cache on; the CPU's D-cache can
speculatively allocate lines out of the system cache (even if dirty),
and theoretically could shuffle lines between levels (and via that race,
between ways in a set).

Set/Way operations can only be used safely with the D-cache off, and
only to ensure that lines have been invalidate or evicted from the CPU's
cache. They cannot be used to ensure that the lines have made it to the
PoC (or PoU).

If other cache-coherent masters (e.g. other CPUs) have caches enabled,
they can similarly acquire cache lines from the current CPU, though that
shouldn't be a concern in this path.

We could flush the entire physical address space by VA, but that will
take an extremely long time, even for a path that isn't performance
critical.

> I'm happy either way. We will test your patch as is and let you know.

Thanks, it's much appreciated.

Mark.
