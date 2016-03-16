From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Mar 2016 18:20:26 +0000
Subject: [PATCH v3 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <20160226172825.GK29125@arm.com>
References: <1455903983-23910-1-git-send-email-jeremy.linton@arm.com>
 <1455903983-23910-3-git-send-email-jeremy.linton@arm.com>
 <20160225161630.GB16546@arm.com> <56CF683D.30003@arm.com>
 <20160226172825.GK29125@arm.com>
Message-ID: <20160316182025.GD13423@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 05:28:26PM +0000, Will Deacon wrote:
> On Thu, Feb 25, 2016 at 02:46:54PM -0600, Jeremy Linton wrote:
> > On 02/25/2016 10:16 AM, Will Deacon wrote:
> > >On Fri, Feb 19, 2016 at 11:46:23AM -0600, Jeremy Linton wrote:
> > >>+static void clear_cont_pte_range(pte_t *pte, unsigned long addr)
> > >>+{
> > >>+	int i;
> > >>+
> > >>+	pte -= CONT_RANGE_OFFSET(addr);
> > >>+	for (i = 0; i < CONT_PTES; i++) {
> > >>+		if (pte_cont(*pte))
> > >>+			set_pte(pte, pte_mknoncont(*pte));
> > >>+		pte++;
> > >>+	}
> > >>+	flush_tlb_all();
> > >
> > >Do you still need this invalidation? I thought the table weren't even
> > >live at this point?
> > 
> > Well it continues to match the calls in alloc_init_p*.
> 
> Ok, but if it's not needed (and I don't think it is), then we should
> remove the invalidation from there too rather than add more of it.

I agree. Talking to Mark R, I think all the create_pgd_mapping code
should be trimmed of p*d splitting entirely (with some warnings left in
place).

The efi_create_mapping() case is done on efi_mm anyway with a low
address and non-active TTBR0_EL1. As Mark suggested, dropping p*d
splitting should work for this case as well by ignoring the next
consecutive mapping if it overlaps since it's a linear mapping (possibly
some permissions may need to be upgraded). In this case, the TLBI would
be done by efi_create_mapping() or even skipped altogether assuming that
no page tables are changed (only going from invalid to valid).

My preference, however, would be for efi_create_mapping() should use a
different mechanism from create_pgd_mapping (aimed at very early memmap)
like remap_pfn_range() but I haven't looked in detail on whether this is
feasible.

Once we have this clean-up in place, we can rebase the contiguous PTE
patches on top and remove unnecessary TLBI.

-- 
Catalin
