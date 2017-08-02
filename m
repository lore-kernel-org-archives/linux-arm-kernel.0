From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Aug 2017 10:01:31 +0100
Subject: [PATCH 1/6] arm64: Fix potential race with hardware DBM in
 ptep_set_access_flags()
In-Reply-To: <20170801170354.GE12027@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-2-catalin.marinas@arm.com>
 <20170801170354.GE12027@arm.com>
Message-ID: <20170802090130.4cqwrlraem7f2rb3@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Aug 01, 2017 at 06:03:54PM +0100, Will Deacon wrote:
> On Tue, Jul 25, 2017 at 02:53:03PM +0100, Catalin Marinas wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index c7861c9864e6..2509e4fe6992 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -163,26 +163,27 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
> >  	/* only preserve the access flags and write permission */
> >  	pte_val(entry) &= PTE_AF | PTE_WRITE | PTE_DIRTY;
> >  
> > -	/*
> > -	 * PTE_RDONLY is cleared by default in the asm below, so set it in
> > -	 * back if necessary (read-only or clean PTE).
> > -	 */
> > +	/* set PTE_RDONLY if actual read-only or clean PTE */
> >  	if (!pte_write(entry) || !pte_sw_dirty(entry))
> >  		pte_val(entry) |= PTE_RDONLY;
> >  
> >  	/*
> >  	 * Setting the flags must be done atomically to avoid racing with the
> > -	 * hardware update of the access/dirty state.
> > +	 * hardware update of the access/dirty state. The PTE_RDONLY bit must
> > +	 * be set to the most permissive (lowest value) of *ptep and entry
> > +	 * (calculated as: a & b == ~(~a | ~b)).
> >  	 */
> > +	pte_val(entry) ^= PTE_RDONLY;
> >  	asm volatile("//	ptep_set_access_flags\n"
> >  	"	prfm	pstl1strm, %2\n"
> >  	"1:	ldxr	%0, %2\n"
> > -	"	and	%0, %0, %3		// clear PTE_RDONLY\n"
> > +	"	eor	%0, %0, %3		// negate PTE_RDONLY in *ptep\n"
> >  	"	orr	%0, %0, %4		// set flags\n"
> > +	"	eor	%0, %0, %3		// negate final PTE_RDONLY\n"
> >  	"	stxr	%w1, %0, %2\n"
> >  	"	cbnz	%w1, 1b\n"
> >  	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
> > -	: "L" (~PTE_RDONLY), "r" (pte_val(entry)));
> > +	: "L" (PTE_RDONLY), "r" (pte_val(entry)));
> 
> Can this be simplified using BIC instead? Ultimately, it would be better
> to use cmpxchg, but as a fix for stable I'd prefer something that doesn't
> invert the current logic.

The login is inverted only for PTE_RDONLY since this bit is the inverse
of PTE_WRITE. If 'o' is the old entry PTE_RDONLY value and 'n' is the
new one, what we want is (o & n) as the resulting PTE_RDONLY bit. See
below.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index c7861c9864e6..082366ad04d1 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -155,7 +155,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  			  pte_t entry, int dirty)
>  {
>  	pteval_t old_pteval;
> -	unsigned int tmp;
> +	unsigned long tmp;
>  
>  	if (pte_same(*ptep, entry))
>  		return 0;
> @@ -177,12 +177,14 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  	asm volatile("//	ptep_set_access_flags\n"
>  	"	prfm	pstl1strm, %2\n"
>  	"1:	ldxr	%0, %2\n"
> -	"	and	%0, %0, %3		// clear PTE_RDONLY\n"
> -	"	orr	%0, %0, %4		// set flags\n"
> +	"	bic	%1, %3, %0		// clear PTE_RDONLY if\n"

Here you calculate ~o.

> +	"	bic	%1, %4, %1		// not already set in pte,\n"

This changes PTE_RDONLY in the new value to n & ~(~o) = n & o (all the
other bits are unchanged).

IOW, it clears PTE_RDONLY in the new value if also cleared in the old
value. BTW, to make the diff simpler, you could do "bic %4, %4, $1" to
keep the same "orr %0, %0, %4" is in the existing code.

> +	"	bic	%0, %0, %3		// then set the other\n"

Always clears PTE_RDONLY in the old value (as per the original code).

> +	"	orr	%0, %0, %1		// access flags\n"

This adds the other bits and PTE_RDONLY as (o & n). So it is equivalent
to my original approach.

>  	"	stxr	%w1, %0, %2\n"
>  	"	cbnz	%w1, 1b\n"
>  	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
> -	: "L" (~PTE_RDONLY), "r" (pte_val(entry)));
> +	: "L" (PTE_RDONLY), "r" (pte_val(entry)));

Is "L" still ok here? Does this constraint allow the generation of an
immediate?

>From my patch I would also keep the comment changes, especially the
second hunk (slightly adapted):

 	/*
 	 * Setting the flags must be done atomically to avoid racing with the
-	 * hardware update of the access/dirty state.
+	 * hardware update of the access/dirty state. The PTE_RDONLY bit must
+	 * be set to the most permissive (lowest value) of *ptep and entry.
 	 */

Anyway, it's up to you which version you merged. I personally find my
version clearer but maybe because I looked at it for a longer time ;).

-- 
Catalin
