From: steve.capper@arm.com (Steve Capper)
Date: Fri, 5 Apr 2013 12:11:59 +0100
Subject: [PATCH] arm: mm: lockless get_user_pages_fast
In-Reply-To: <1360890012-4684-1-git-send-email-chanho61.park@samsung.com>
References: <1360890012-4684-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <20130405111158.GA13428@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

Apologies for the tardy response, this patch slipped past me.

On Fri, Feb 15, 2013 at 01:00:12AM +0000, Chanho Park wrote:
> This patch adds get_user_pages_fast(old name is "fast_gup") for ARM.
> The fast_gup can walk pagetable without taking mmap_sem or any locks. If there
> is not a pte with the correct permissions for the access, we fall back to slow
> path(get_user_pages) to get remaining pages. This patch is written on reference
> the x86's gup implementation. Traversing of hugepages is excluded because ARM
> haven't supported hugepages yet[1], just only RFC.
> 

I've tested this patch out, unfortunately it treats huge pmds as regular
pmds and attempts to traverse them rather than fall back to a slow path.
The fix for this is very minor, please see my suggestion below.

As an aside, I would like to extend this fast_gup to include full huge
page support and include a __get_user_pages_fast implementation. This
will hopefully fix a problem that was brought to my attention by
Grazvydas Ignotas whereby a FUTEX_WAIT on a THP tail page will cause
an infinite loop due to the stock implementation of __get_user_pages_fast
always returning 0.

> diff --git a/arch/arm/mm/gup.c b/arch/arm/mm/gup.c
> new file mode 100644
> index 0000000..ed54fd8

...

> +static int gup_pmd_range(pud_t *pudp, unsigned long addr, unsigned long end,
> +		int write, struct page **pages, int *nr)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (pmd_none(*pmdp))
> +			return 0;

I would suggest:
		if (pmd_none(*pmdp) || pmd_bad(*pmdp))
			return 0;
as this will pick up pmds that can't be traversed, and fall back to the slow path.

> +		else if (!gup_pte_range(pmdp, addr, next, write, pages, nr))
> +			return 0;
> +	} while (pmdp++, addr = next, addr != end);
> +
> +	return 1;
> +}
> +

Cheers,
-- 
Steve
