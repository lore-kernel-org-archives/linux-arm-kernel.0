From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Nov 2014 19:28:16 +0000
Subject: [PATCHv2] arm64: add support to dump the kernel page tables
In-Reply-To: <1416262710-7798-1-git-send-email-lauraa@codeaurora.org>
References: <1416262710-7798-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141124192815.GC28207@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Mon, Nov 17, 2014 at 10:18:30PM +0000, Laura Abbott wrote:
> In a similar manner to arm, it's useful to be able to dump the page
> tables to verify permissions and memory types. Add a debugfs file
> to check the page tables.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> v2: Addressed comments from Mark Rutland. Made the logic a bit more
> consistent between functions. Now tested on 4K and 64K pages.
> ---
>  arch/arm64/Kconfig.debug |  12 ++
>  arch/arm64/mm/Makefile   |   1 +
>  arch/arm64/mm/dump.c     | 358 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 arch/arm64/mm/dump.c

[...]

> +static struct pg_level pg_level[] = {
> +	{
> +	}, { /* pgd */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pud */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pmd */
> +		.bits	= section_bits,
> +		.num	= ARRAY_SIZE(section_bits),
> +	}, { /* pte */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	},
> +};

Can't we have section mappings in puds? We have a pud_sect() check in
walk_pud, so I would have expected puds to use section_bits as well
(perhaps pgds too, which I believe the architecture allows for block
mappings in some configurations).

That said, the section and pte bits are the same at the moment, so we
could just use the same bits at all levels for now, and introduce
section_bits if required in future.

[...]

> +static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +{
> +	pud_t *pud = pud_offset(pgd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
> +		addr = start + i * PUD_SIZE;
> +		if (pud_none(*pud) || pud_sect(*pud) || pud_bad(*pud))
> +			note_page(st, addr, 2, pud_val(*pud));
> +		else
> +			walk_pmd(st, pud, addr);
> +	}
> +}
> +
> +static unsigned long normalize_addr(unsigned long u)
> +{
> +	return u | LOWEST_ADDR;
> +}
> +
> +static void walk_pgd(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +{
> +	unsigned i;
> +	unsigned long addr;
> +
> +	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
> +		addr = normalize_addr(start + i * PGDIR_SIZE);

Could we get rid of normalize_addr, and pass in LOWEST_ADDR from
ptdump_show? Then this could be:

		addr = start + i * PGD_SIZE;

Which would make it look like the other walk_* functions, and it would
mean the that start parameter would be the actual start address.

Similarly we could pass in the init_mm rather than and use pgd_offset on
that, as we do in show_pte (in mm/fault.c).

> +		if (pgd_none(*pgd) || pgd_bad(*pgd))
> +			note_page(st, addr, 1, pgd_val(*pgd));
> +		else
> +			walk_pud(st, pgd, addr);
> +	}
> +}
> +
> +static int ptdump_show(struct seq_file *m, void *v)
> +{
> +	struct pg_state st;
> +
> +	memset(&st, 0, sizeof(st));
> +	st.seq = m;
> +	st.marker = address_markers;

If you change this to:

struct pg_state st = {
	.seq = m,
	.marker = address_markers,
};

The other fields will be initialized to zero without the need for an
explicit memset.

Otherwise this looks good to me. Thanks for slogging through this so
far!

With those changes:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
