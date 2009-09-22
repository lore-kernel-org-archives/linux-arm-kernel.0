From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Sep 2009 11:19:13 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921213802.GH30821@n2100.arm.linux.org.uk>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
Message-ID: <1253614753.14049.47.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-21 at 22:38 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 11:07:51AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> > > I would still call this I-D cache coherency issue since the two caches
> > > have a different view of the RAM but I agree that the D-cache is the one
> > > holding the data (with a slight chance for the I-cache not to be in sync
> > > with main RAM, though we could treat it separately).
> > > 
> > > We can sort out the D-cache issue with your approach for cleaning it in
> > > the copy_user_highpage() function, but, as I said, we affect the
> > > standard CoW mechanism for data pages quite a lot.
> > 
> > Let me restate my approach more clearly:
> > 
> > 1. Remember that a VMA has been executable.
> > 2. Only do the additional handing if the VMA has been executable.

> Well, there's a problem with this approach.  Any binary which executes
> with read-implies-exec (in other words, the majority of those around)
> results in any region with read permission also getting exec permission.

Some idea (not tested) - we keep XN always set even if the mapping has
PROT_EXEC. We then handle the prefetch abort and with the IFSR patches
from Kirill we can detect the permission fault and clear the XN bit
while also cleaning the D-cache, maybe via update_mmu_cache() or
directly in __do_page_fault().

Most text pages are handled via a prefetch abort anyway, so we don't
have any performance penalty here. For the read-implies-exec pages or
the dynamic linker case, we have an additional prefetch abort but that's
much faster than either flush_cache_range() or copy_to_user_highpage()
patches.

We may need an additional pte bit or just reuse L_PTE_EXEC.

Yet another idea - add a generic flush_cache_range_for_mprotect()
function with a specific implementation for ARM (called via
change_protection).

-- 
Catalin
