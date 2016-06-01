From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Jun 2016 10:58:18 +0100
Subject: [PATCH 1/2] arm64: mm: dump: make page table dumping reusable
In-Reply-To: <20160601030133.GB14411@sha-win-210.asiapac.arm.com>
References: <1464702542-24394-1-git-send-email-mark.rutland@arm.com>
 <1464702542-24394-2-git-send-email-mark.rutland@arm.com>
 <20160601030133.GB14411@sha-win-210.asiapac.arm.com>
Message-ID: <20160601095818.GA9280@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 11:01:35AM +0800, Huang Shijie wrote:
> On Tue, May 31, 2016 at 02:49:01PM +0100, Mark Rutland wrote:
> > +struct ptdump_info {
> > +	struct mm_struct		*mm;
> > +	const struct addr_marker	*markers;
> > +	unsigned long			base_addr;
> > +	unsigned long			max_addr;
> > +};
> > +
> > +int ptdump_register(struct ptdump_info *info, const char *name);
> Since we export this to other page tables,  I guess the @base_addr in
> the ptdump_info{} may not equal to the VA_START.

Yes, that is the intent.

The only requirement is that this is only VA_START or 0, as these are the only
addresses aligned to VA_BITS which actually correspond to regions page tables
can cover.

> But the current dump.c does _NOT_ use the @start address been
> passed in, it use the 0 as the start address for the walk_pgd/walk_pud/walk_pmd/walk_pte.

Yes, this is deliberate. The trick is that start must be aligned to
VA_BITS, and the page table accessors do the right thing, masking out
bits which do not matter for their respective indices, e.g.

#define pgd_index(addr)			(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
#define pgd_offset_raw(pgd, addr)	((pgd) + pgd_index(addr))
#define pgd_offset(mm, addr)		(pgd_offset_raw((mm)->pgd, (addr)))

This allows us to either provide a virtual address to the accessors
(which can be in the low or high half), or an offset relative to the
start of each pgd, pud, pmd, or pte.

So for walk_pgd:

static void walk_pgd(struct pg_state *st, struct mm_struct *mm, unsigned long start)
{
	pgd_t *pgd = pgd_offset(mm, 0UL);
	unsigned i;
	unsigned long addr;

	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
		addr = start + i * PGDIR_SIZE;
		if (pgd_none(*pgd)) {
			note_page(st, addr, 1, pgd_val(*pgd));
		} else {
			BUG_ON(pgd_bad(*pgd));
			walk_pud(st, pgd, addr);
		}
	}
}

Here, the 0UL we pass to pgd_offset is the offset from the start of the
pgd, not the absolute virtual address. 

In the loop, we generate the virtual address each pgd_t corresponds to,
and we pass this down to note_page or walk_pud as appropriate. We do
likewise in walk_pud, walk_pmd, and walk_pte.

So when we reach note_page, we should always have the right virtual
address in the addr parameter.

> It is wrong in logic, since the start address is VA_START, the code gets
> the right result coincidentally.

As above, I think that the logic is correct.

Hopefully the explanation above allays your fears?

Thanks,
Mark.
