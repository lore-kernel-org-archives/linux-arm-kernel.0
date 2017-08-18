From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 17:15:12 +0100
Subject: [PATCH 2/6] arm64: Convert pte handling from inline asm to using
 (cmp)xchg
In-Reply-To: <20170817125957.GA28945@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-3-catalin.marinas@arm.com>
 <20170817125957.GA28945@arm.com>
Message-ID: <20170818161512.ylsngecefjlksldm@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 01:59:58PM +0100, Will Deacon wrote:
> On Tue, Jul 25, 2017 at 02:53:04PM +0100, Catalin Marinas wrote:
> > @@ -593,20 +599,15 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
> >  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> >  static inline int __ptep_test_and_clear_young(pte_t *ptep)
> >  {
> > -	pteval_t pteval;
> > -	unsigned int tmp, res;
> > +	pte_t old_pte, pte;
> >  
> > -	asm volatile("//	__ptep_test_and_clear_young\n"
> > -	"	prfm	pstl1strm, %2\n"
> > -	"1:	ldxr	%0, %2\n"
> > -	"	ubfx	%w3, %w0, %5, #1	// extract PTE_AF (young)\n"
> > -	"	and	%0, %0, %4		// clear PTE_AF\n"
> > -	"	stxr	%w1, %0, %2\n"
> > -	"	cbnz	%w1, 1b\n"
> > -	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep)), "=&r" (res)
> > -	: "L" (~PTE_AF), "I" (ilog2(PTE_AF)));
> > +	do {
> > +		old_pte = READ_ONCE(*ptep);
> > +		pte = pte_mkold(old_pte);
> > +	} while (cmpxchg_relaxed(&pte_val(*ptep), pte_val(old_pte),
> > +				 pte_val(pte)) != pte_val(old_pte));
> 
> Given that cmpxchg returns the value it read, can you avoid the READ_ONCE
> on subsequent iterations of the loop? Same with the other cmpxchgs you've
> added in this patch.

I'll have a look.

> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 2509e4fe6992..65ed66bb2828 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/hugetlb.h>
> >  
> >  #include <asm/bug.h>
> > +#include <asm/cmpxchg.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/exception.h>
> >  #include <asm/debug-monitors.h>
> > @@ -154,8 +155,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
> >  			  unsigned long address, pte_t *ptep,
> >  			  pte_t entry, int dirty)
> >  {
> > -	pteval_t old_pteval;
> > -	unsigned int tmp;
> > +	pteval_t old_pteval, pteval;
> >  
> >  	if (pte_same(*ptep, entry))
> >  		return 0;
> > @@ -165,7 +165,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
> >  
> >  	/* set PTE_RDONLY if actual read-only or clean PTE */
> >  	if (!pte_write(entry) || !pte_sw_dirty(entry))
> > -		pte_val(entry) |= PTE_RDONLY;
> > +		entry = pte_set_rdonly(entry);
> >  
> >  	/*
> >  	 * Setting the flags must be done atomically to avoid racing with the
> > @@ -174,16 +174,13 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
> >  	 * (calculated as: a & b == ~(~a | ~b)).
> >  	 */
> >  	pte_val(entry) ^= PTE_RDONLY;
> > -	asm volatile("//	ptep_set_access_flags\n"
> > -	"	prfm	pstl1strm, %2\n"
> > -	"1:	ldxr	%0, %2\n"
> > -	"	eor	%0, %0, %3		// negate PTE_RDONLY in *ptep\n"
> > -	"	orr	%0, %0, %4		// set flags\n"
> > -	"	eor	%0, %0, %3		// negate final PTE_RDONLY\n"
> > -	"	stxr	%w1, %0, %2\n"
> > -	"	cbnz	%w1, 1b\n"
> > -	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
> > -	: "L" (PTE_RDONLY), "r" (pte_val(entry)));
> > +	do {
> > +		old_pteval = READ_ONCE(pte_val(*ptep));
> > +		pteval = old_pteval ^ PTE_RDONLY;
> > +		pteval |= pte_val(entry);
> > +		pteval ^= PTE_RDONLY;
> > +	} while (cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval) !=
> > +		 old_pteval);
> >  
> >  	flush_tlb_fix_spurious_fault(vma, address);
> >  	return 1;
> 
> You haven't changed this in your patch, but how is the return value supposed
> to interact with concurrent updates to the pte? Isn't the earlier pte_same
> check racy?

The pte_same() check is a best effort and it's meant to return early if
we are not changing any permissions. The only scenario where this can
happen is if the caller of ptep_set_access_flags() wants to set the AF
bit while the hardware also set it, so they look the same and we exit
early. There is no information loss.

The return value is irrelevant to arm64 since all the core code does is
call update_mmu_cache() if 1.

-- 
Catalin
