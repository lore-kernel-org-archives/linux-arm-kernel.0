From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Feb 2016 17:58:58 +0000
Subject: [PATCH 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <56BE17C9.6090608@arm.com>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
 <1455293208-6763-3-git-send-email-jeremy.linton@arm.com>
 <20160212165707.GB20262@leverpostej> <56BE17C9.6090608@arm.com>
Message-ID: <20160212175857.GE20262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 11:35:05AM -0600, Jeremy Linton wrote:
> On 02/12/2016 10:57 AM, Mark Rutland wrote:
> (trimming)
> > On Fri, Feb 12, 2016 at 10:06:48AM -0600, Jeremy Linton wrote:
> >>+static void clear_cont_pte_range(pte_t *pte, unsigned long addr)
> >>+{
> >>+	int i;
> >>+
> >>+	pte -= CONT_RANGE_OFFSET(addr);
> >>+	for (i = 0; i < CONT_PTES; i++) {
> >>+		if (pte_cont(*pte))
> >>+			set_pte(pte, pte_mknoncont(*pte));
> >>+		pte++;
> >>+	}
> >>+	flush_tlb_all();
> >>+}
> >
> >As far as I can tell, "splitting" contiguous entries comes with the same
> >caveats as splitting sections. In the absence of a BBM sequence we might
> >end up with conflicting TLB entries.
> 
> As I mentioned a couple weeks ago, I'm not sure that inverting a BBM
> to a full "make partial copy of the whole table->break TTBR to copy
> sequence" is so bad if the copy process maintains references to the
> original table entries when they aren't in the modification path. It
> might even work with all the CPU's spun up because the break
> sequence would just be IPI's to the remaining cpu's to replace their
> TTBR/flush with a new value. I think you mentioned the ugly part is
> arbitrating access to the update functionality (and all the implied
> rules of when it could be done). But doing it that way doesn't
> require stalling the CPU's during the "make partial copy" portion.

That may be true, and worthy of investigation.

One problem I envisaged with that is concurrent kernel pagetable
modification (e.g. vmalloc, DEBUG_PAGEALLOC). To handle that correctly
you require global serialization (or your copy may be stale), though as
you point out that doesn't mean stop-the-world entirely.

For the above, I was simply pointing out that in general,
splitting/fusing contiguous ranges comes with the same issues as
splitting/fusing sections, as that may not be immediately obvious.

> >However, I think we're OK for now.
> >
> >The way we consistently map/unmap/modify image/linear "chunks" should
> >prevent us from trying to split those, and if/when we do this for the
> >EFI runtime page tables thy aren't live.
> >
> >It would be good to figure out how to get rid of the splitting entirely.
> 
> Well we could hoist some of it earlier by taking the
> create_mapping_late() calls and doing them earlier with RWX
> permissions, and then applying the RO,ROX,RW later as necessarily.
> 
> Which is ugly, but it might solve particular late splitting cases.

I'm not sure I follow.

The aim was that after my changes we should only split/fuse for EFI page
tables, and only for !4K page kernels. See [1] for why. Avoiding that in
the EFI case is very painful, so for now we kept split_pud and
split_pmd.

All create_mapping_late() calls should be performed with the same
physical/virtual start/end as earlier "chunk" mappings, and thus should
never result in a fuse/split or translation change -- only permission
changes (which we believe do not result in TLB conflicts, or we'd need
to do far more work to fix those up).

If we split/fuse in any case other than EFI runtime table creation, that
is a bug that we need to fix. If you're seeing a case we do that, then
please let me know!

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398178.html
