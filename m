From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 5 Mar 2010 10:17:46 +0900
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267738660.22204.77.camel@pasglop>
References: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
	<20100304154103.GA9384@linux-sh.org>
	<1267726049.6526.543.camel@e102109-lin.cambridge.arm.com>
	<1267738660.22204.77.camel@pasglop>
Message-ID: <20100305011745.GC26618@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 08:37:40AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2010-03-04 at 18:07 +0000, Catalin Marinas wrote:
> > Are you more in favour if a PIO kmap API than inverting the meaning of
> > PG_arch_1? 
> 
> My main worry with this approach is the sheer amount of drivers that
> need fixing. I believe inverting PG_arch_1 is a better solution and I
> somewhat fail to see how we end up doing too much flushing if we have
> per-page execute permission (but maybe SH doesn't ?)
> 
Basically we have two different MMUs on VIPT parts, the older one on all
SH-4 parts were all read-implies-exec with no ability to differentiate
between read or exec access. For these parts the PG_dcache_dirty approach
saves us from a lot of flushing, and the corner cases were isolated
enough that we could tolerate fixups at the driver level, even on a
write-allocate D-cache.

For second generation SH-4A (SH-X2) and up parts, read and exec are split
out and we could reasonably adopt the PG_dcache_clean approach there
while adopting the same sort of flushing semantics as PPC to avoid
flushing constantly. The current generation of parts far outnumber their
legacy counterparts, so it's certainly something I plan to experiment
with.

We have an additional level of complexity on some of the SMP parts with a
non-coherent I-cache, some of the early CPUs have broken broadcasting of
the cacheops in hardware and so need to rely on IPIs, while the later
parts broadcast properly. We also need to deal with D-cache IPIs when
using mixed coherency protocols on different CPUs.

For older PIPT parts we've never used the deferred flush, since the only
time we ever had to bother with cache maintenance was in the DMA ops, as
anything closer to the CPU than the PCI DMAC had no opportunity to be
snooped.

> > I'm not familiar with SH but for PIO devices the flushing shouldn't be
> > more aggressive. For the DMA devices, Russell suggested that we mark
> > the page as clean (set PG_dcache_clean) in the DMA API to avoid the
> > default flushing.
> 
> I really like that idea, as I said earlier, but I'm worried about the I$
> side of things. IE. What I'm trying to say is that I can't see how to do
> that optimisation without ending up with missing I$ invalidations or
> doing way too many of them, unless we have a separate bit to track I$
> state.
> 
Using PG_dcache_clean from the DMA API sounds like a pretty good idea,
and certainly worth experimenting with. I don't know how we would do the
I-cache optimization without a PG_arch_2, though.

In any event, if there's going to be a mass exodus to PG_dcache_clean,
Documentation/cachetlb.txt could use a considerable amount of expanding.
The read/exec and I-cache optimizations are something that would be
valuable to document, as opposed to simply being pointed at the sparc64
approach with the regular PG_dcache_dirty caveats.
