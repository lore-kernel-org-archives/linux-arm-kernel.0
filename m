From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Apr 2013 10:00:35 +0200
Subject: [PATCH v3 5/7] ARM: KVM: rework HYP page table freeing
In-Reply-To: <CAEDV+gJAUOsi3yjwp3hmBPbLkaL_0PaUNGFLLZN0nOzya7BA-A@mail.gmail.com>
References: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
 <1365779932-20322-6-git-send-email-marc.zyngier@arm.com>
 <CAEDV+gJAUOsi3yjwp3hmBPbLkaL_0PaUNGFLLZN0nOzya7BA-A@mail.gmail.com>
Message-ID: <89815b00ef8a11e6fc7bc03497b9668a@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 14 Apr 2013 23:51:55 -0700, Christoffer Dall
<cdall@cs.columbia.edu> wrote:
> On Fri, Apr 12, 2013 at 8:18 AM, Marc Zyngier <marc.zyngier@arm.com>
wrote:
>> There is no point in freeing HYP page tables differently from Stage-2.
>> They now have the same requirements, and should be dealt with the same
>> way.
>>
>> Promote unmap_stage2_range to be The One True Way, and get rid of a
>> number
>> of nasty bugs in the process (goo thing we never actually called
>> free_hyp_pmds
> 
> could you remind me, did you already point out these nasty bugs
> somewhere or did we discuss them in an older thread?

No, I decided it wasn't worth the hassle when I spotted them (specially as
we're moving away from section mapped idmap)... But for the record:

<quote>
static void free_hyp_pgd_entry(pgd_t *pgdp, unsigned long addr)
{
	pgd_t *pgd;
	pud_t *pud;
	pmd_t *pmd;

	pgd = pgdp + pgd_index(addr);
	pud = pud_offset(pgd, addr);

	if (pud_none(*pud))
		return;
	BUG_ON(pud_bad(*pud));

	pmd = pmd_offset(pud, addr);
	free_ptes(pmd, addr);
	pmd_free(NULL, pmd);
        ^^^^^^^^^^^^^^^^^^^^<-- BUG_ON(pmd not page aligned)
	pud_clear(pud);
}
</quote>

Now, if you decide to fix the above by forcing the page alignment:

<quote>
static void free_ptes(pmd_t *pmd, unsigned long addr)
{
	pte_t *pte;
	unsigned int i;

	for (i = 0; i < PTRS_PER_PMD; i++, addr += PMD_SIZE) {
             ^^^^^^^^^^^^^<-- start freeing memory outside of the
(unaligned) pmd...
		if (!pmd_none(*pmd) && pmd_table(*pmd)) {
			pte = pte_offset_kernel(pmd, addr);
			pte_free_kernel(NULL, pte);
		}
		pmd++;
	}
}
</quote>

Once you've fixed that as well, you end up noticing that if you have PTEs
pointed to by the same PMD, you need to introduce some refcounting if you
need to free one PTE and not the others.

At this point, I had enough, and decided to reuse what we already had
instead of reinventing the wheel.

> nit: s/goo/good/
> 
>> before...).

Will fix.

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.
