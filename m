From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 23:31:04 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921221229.GF14700@shareable.org>
References: <20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921201043.GA14700@shareable.org> <4AB7F716.2070206@arm.com>
	<20090921221229.GF14700@shareable.org>
Message-ID: <20090921223104.GJ30821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 11:12:29PM +0100, Jamie Lokier wrote:
> Btw, regarding "non-aliasing", it's pretty clear that it does alias
> the I-cache ;-), in much the same way as different addresses alias in
> the D-cache with an "aliasing" cache.  That may well be a clue as to
> clean, systematic and sane way of ensuring all the cache ops are in
> all the right places.

If you want your kernel to flush the I and D caches on every page fault,
process creation and exit, be my guest.  I'd rather have a system with
some reasonable performance left in it rather than being relegated back
to the days of VIVT caches.

The key thing is to work out the _minimum_ amount of cache flushing,
not just throw cache flushing blindly in.

MPCore, btw, is PIPT write allocate harvard.  In other words, it is
fully coherent with virtual mappings - the only things it isn't
coherent with is the instruction cache and DMA.  It'd be absolutely
stupid to have to throw the heavy weights of flushing large amounts
of cache for what is basically a small localized problem.
