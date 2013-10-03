From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Oct 2013 18:27:55 +0100
Subject: [RFC] ARM: lockless get_user_pages_fast()
In-Reply-To: <1380820515-21100-1-git-send-email-zishen.lim@linaro.org>
References: <1380820515-21100-1-git-send-email-zishen.lim@linaro.org>
Message-ID: <20131003172755.GG7408@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 06:15:15PM +0100, Zi Shen Lim wrote:
> Futex uses GUP. Currently on ARM, the default __get_user_pages_fast
> being used always returns 0, leading to a forever loop in get_futex_key :(
> 
> Implementing GUP solves this problem.
> 
> Tested on vexpress-A15 on QEMU.
> 8<---------------------------------------------------->8
> 
> Implement get_user_pages_fast without locking in the fastpath on ARM.
> This work is derived from the x86 version and adapted to ARM.

This looks pretty much like an exact copy of the x86 version, which will
likely also result in another exact copy for arm64. Can none of this code be
made common? Furthermore, the fact that you've lifted the code and not
provided much of an explanation in the cover letter hints that you might not
be aware of all the subtleties involved here...

> +static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
> +		int write, struct page **pages, int *nr)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp;
> +
> +	pmdp = pmd_offset(&pud, addr);
> +	do {
> +		pmd_t pmd = *pmdp;
> +
> +		next = pmd_addr_end(addr, end);
> +		/*
> +		 * The pmd_trans_splitting() check below explains why
> +		 * pmdp_splitting_flush has to flush the tlb, to stop
> +		 * this gup-fast code from running while we set the
> +		 * splitting bit in the pmd. Returning zero will take
> +		 * the slow path that will call wait_split_huge_page()
> +		 * if the pmd is still in splitting state. gup-fast
> +		 * can't because it has irq disabled and
> +		 * wait_split_huge_page() would never return as the
> +		 * tlb flush IPI wouldn't run.
> +		 */
> +		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
> +			return 0;
> +		if (unlikely(pmd_huge(pmd))) {
> +			if (!gup_huge_pmd(pmd, addr, next, write, pages, nr))
> +				return 0;
> +		} else {
> +			if (!gup_pte_range(pmd, addr, next, write, pages, nr))
> +				return 0;
> +		}
> +	} while (pmdp++, addr = next, addr != end);

...case in point: we don't (usually) require IPIs to shoot down TLB entries
in SMP systems, so this is racy under thp splitting.

Will
