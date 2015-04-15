From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Apr 2015 13:07:38 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <552C14F0.7020006@oracle.com>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408173656.GF5977@leverpostej>
 <20150408175533.GN12732@n2100.arm.linux.org.uk>
 <552C14F0.7020006@oracle.com>
Message-ID: <20150415120738.GD2866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >> To the best of my knowledge, the page table walkers aren't affected by
> >> SCTLR.C, and use the attributes in TTBR{0,1} or TTBCR when translation
> >> is active (i.e. when SCTLR.M is set). So at this point they can make
> >> cacheable accesses to the page tables (and allocate into the caches) in
> >> the background...
> >
> > We had better clear those bits too then.
> >
> >> I think that the cache flush needs to be performed after both
> >> SCTLR.{C,M} are cleared in lpae_pgtables_remap_asm, just before the page
> >> table updates. So long as the relevant pieces of kernel text are
> >> initially clean to the PoC, we shouldn't need to flush anything
> >> beforehand.
> >
> > To that I say... no bloody way in hell, even once hell has frozen
> > over.  It took almost a _day_ to get this much working, much of it
> > was attempting to use cache flushing functions after the MMU had
> > been turned off.
> >
> > If it was possible to make it work, I'd have done so.  It isn't, so
> > please forget the idea.
> >
> I fully agree. I gone through the same pane while incorporating Will's
> comment on similar lines last time.

I'm surprised that it's so painful to get that working. I don't have a
system I could test this on, so unfortunately I can't offer much help
there.

> >>> +ENTRY(lpae_pgtables_remap_asm)
> >>> +       stmfd   sp!, {r4-r8, lr}
> >>> +
> >>> +       mrc     p15, 0, r8, c1, c0, 0           @ read control reg
> >>> +       bic     ip, r8, #CR_M                   @ disable caches and MMU
> >>> +       mcr     p15, 0, ip, c1, c0, 0
> >>> +       dsb
> >>> +       isb
> >>
> >> Shouldn't the DSB be between the STMFD and the MCR (given the SP doesn't
> >> point to an idmap/physical address)?
> >>
> >> I don't see why we need a DSB after the write to the SCTLR.
> >>
> dsb can be moved up after stmfd but leaving as above should be fine
> as well.

I don't think that it's safe to leave it where it is. Currently the
STMFD could be reordered w.r.t. the cp15 accesses, and hence the write
may occur with translation disabled (and would go to the wrong physical
address).

We need to ensure that the STMFD is executed before the MCR potentially
changes the execution context. The DSB will ensure that in addition to
ensuring completion of the write (i.e. it isn't left sat in a write
buffer).

> >> [...]
> >>
> >>> +       dsb
> >>> +       isb
> >>> +
> >>> +       mcr     p15, 0, r8, c1, c0, 0           @ re-enable MMU
> >>> +       dsb
> >>> +       isb
> >>
> >> Similarly, isn't the last DSB redundant?
> >
> This dsb probably can be dropped but I leave that to Russell
> to decide. That one extra instruction doesn't hurt much.

I don't see that it adds anything to the ISB given the DSB; ISB prior to
the write to the SCTLR -- there's nothing it would ensure completion of
that the first DSB won't already have.

Mark.
