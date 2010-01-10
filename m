From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 23:06:58 +0000
Subject: [PATCH 3/3] arm: export arm_add_memory
In-Reply-To: <201001110832.44274.jeremy.kerr@canonical.com>
References: <1262835561.887063.943450380979.0.gpush@pororo>
	<1262835561.888252.461260980683.3.gpush@pororo>
	<20100108163905.GF32558@n2100.arm.linux.org.uk>
	<201001110832.44274.jeremy.kerr@canonical.com>
Message-ID: <20100110230658.GC15812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 08:32:44AM +1100, Jeremy Kerr wrote:
> Russell,
>  
> > I've been thinking about this a bit, and rather than indirecting the
> > DT stuff through an inline function, I think we should rename the
> > function instead to something that's compatible with DT.  Yes, that
> > means changing the arguments, but in the longer term, we're likely
> > to need to pass more than 32-bits of memory start/size to the kernel.
> 
> Any thoughts on using the generic LMB infrastructure to manage this instead?
> 
> The DT code is written for arches that have LMB support, so the main reason 
> for this patch is to provide a hook into non-LMB arches.

Maybe when we go to 64-bit memory; until that time it looks like it
doesn't meet our needs and would be additional bloat.

It certainly would need some modification - the auto-coalescing which
it currently does would be a problem - we explicitly split our memory
information if it overlaps a lowmem/highmem boundary, and where it
splits sparsemem/discontig zones.  We also sort our memory information
into ascending address, which LMB also doesn't do.

We certainly don't need the lmb allocation stuff, and I don't understand
why LMB is trying to implement this functionality.  Bootmem was supposed
to get around the problem of early kernel allocations (before the main
page allocator and therefore kmalloc) were up and running - and it does
this fairly well.  The only down-side to it is you need to find some way
of placing its bitmap for registering the allocated/free areas.  That's
fairly easy to do (and we've done it on ARM with no problems.)

So why do we need an early-early allocator?  (Should we expect to see in
a few years an early-early-early allocator and an early-early-early-early
allocator as well? :P)
