From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Aug 2017 13:59:58 +0100
Subject: [PATCH 2/6] arm64: Convert pte handling from inline asm to using
 (cmp)xchg
In-Reply-To: <20170725135308.18173-3-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-3-catalin.marinas@arm.com>
Message-ID: <20170817125957.GA28945@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 02:53:04PM +0100, Catalin Marinas wrote:
> With the support for hardware updates of the access and dirty states,
> the following pte handling functions had to be implemented using
> exclusives: __ptep_test_and_clear_young(), ptep_get_and_clear(),
> ptep_set_wrprotect() and ptep_set_access_flags(). To take advantage of
> the LSE atomic instructions and also make the code cleaner, convert
> these pte functions to use the more generic cmpxchg()/xchg().
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 67 +++++++++++++++++-----------------------
>  arch/arm64/mm/fault.c            | 23 ++++++--------
>  2 files changed, 39 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 6eae342ced6b..4580d5992d0c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -39,6 +39,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/cmpxchg.h>
>  #include <asm/fixmap.h>
>  #include <linux/mmdebug.h>
>  
> @@ -173,6 +174,11 @@ static inline pte_t pte_clear_rdonly(pte_t pte)
>  	return clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>  }
>  
> +static inline pte_t pte_set_rdonly(pte_t pte)
> +{
> +	return set_pte_bit(pte, __pgprot(PTE_RDONLY));
> +}
> +
>  static inline pte_t pte_mkpresent(pte_t pte)
>  {
>  	return set_pte_bit(pte, __pgprot(PTE_VALID));
> @@ -593,20 +599,15 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int __ptep_test_and_clear_young(pte_t *ptep)
>  {
> -	pteval_t pteval;
> -	unsigned int tmp, res;
> +	pte_t old_pte, pte;
>  
> -	asm volatile("//	__ptep_test_and_clear_young\n"
> -	"	prfm	pstl1strm, %2\n"
> -	"1:	ldxr	%0, %2\n"
> -	"	ubfx	%w3, %w0, %5, #1	// extract PTE_AF (young)\n"
> -	"	and	%0, %0, %4		// clear PTE_AF\n"
> -	"	stxr	%w1, %0, %2\n"
> -	"	cbnz	%w1, 1b\n"
> -	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep)), "=&r" (res)
> -	: "L" (~PTE_AF), "I" (ilog2(PTE_AF)));
> +	do {
> +		old_pte = READ_ONCE(*ptep);
> +		pte = pte_mkold(old_pte);
> +	} while (cmpxchg_relaxed(&pte_val(*ptep), pte_val(old_pte),
> +				 pte_val(pte)) != pte_val(old_pte));

Given that cmpxchg returns the value it read, can you avoid the READ_ONCE
on subsequent iterations of the loop? Same with the other cmpxchgs you've
added in this patch.

> -	return res;
> +	return pte_young(old_pte);
>  }
>  
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
> @@ -630,17 +631,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long address, pte_t *ptep)
>  {
> -	pteval_t old_pteval;
> -	unsigned int tmp;
> -
> -	asm volatile("//	ptep_get_and_clear\n"
> -	"	prfm	pstl1strm, %2\n"
> -	"1:	ldxr	%0, %2\n"
> -	"	stxr	%w1, xzr, %2\n"
> -	"	cbnz	%w1, 1b\n"
> -	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep)));
> -
> -	return __pte(old_pteval);
> +	return __pte(xchg_relaxed(&pte_val(*ptep), 0));
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -659,21 +650,21 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>  static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
>  {
> -	pteval_t pteval;
> -	unsigned long tmp;
> -
> -	asm volatile("//	ptep_set_wrprotect\n"
> -	"	prfm	pstl1strm, %2\n"
> -	"1:	ldxr	%0, %2\n"
> -	"	tst	%0, %4			// check for hw dirty (!PTE_RDONLY)\n"
> -	"	csel	%1, %3, xzr, eq		// set PTE_DIRTY|PTE_RDONLY if dirty\n"
> -	"	orr	%0, %0, %1		// if !dirty, PTE_RDONLY is already set\n"
> -	"	and	%0, %0, %5		// clear PTE_WRITE/PTE_DBM\n"
> -	"	stxr	%w1, %0, %2\n"
> -	"	cbnz	%w1, 1b\n"
> -	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
> -	: "r" (PTE_DIRTY|PTE_RDONLY), "L" (PTE_RDONLY), "L" (~PTE_WRITE)
> -	: "cc");
> +	pte_t old_pte, pte;
> +
> +	do {
> +		pte = old_pte = READ_ONCE(*ptep);
> +		/*
> +		 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
> +		 * clear), set the PTE_DIRTY and PTE_RDONLY bits.
> +		 */
> +		if (pte_hw_dirty(pte)) {
> +			pte = pte_mkdirty(pte);
> +			pte = pte_set_rdonly(pte);
> +		}
> +		pte = pte_wrprotect(pte);
> +	} while (cmpxchg_relaxed(&pte_val(*ptep), pte_val(old_pte),
> +				 pte_val(pte)) != pte_val(old_pte));
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 2509e4fe6992..65ed66bb2828 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -34,6 +34,7 @@
>  #include <linux/hugetlb.h>
>  
>  #include <asm/bug.h>
> +#include <asm/cmpxchg.h>
>  #include <asm/cpufeature.h>
>  #include <asm/exception.h>
>  #include <asm/debug-monitors.h>
> @@ -154,8 +155,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  			  unsigned long address, pte_t *ptep,
>  			  pte_t entry, int dirty)
>  {
> -	pteval_t old_pteval;
> -	unsigned int tmp;
> +	pteval_t old_pteval, pteval;
>  
>  	if (pte_same(*ptep, entry))
>  		return 0;
> @@ -165,7 +165,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  
>  	/* set PTE_RDONLY if actual read-only or clean PTE */
>  	if (!pte_write(entry) || !pte_sw_dirty(entry))
> -		pte_val(entry) |= PTE_RDONLY;
> +		entry = pte_set_rdonly(entry);
>  
>  	/*
>  	 * Setting the flags must be done atomically to avoid racing with the
> @@ -174,16 +174,13 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  	 * (calculated as: a & b == ~(~a | ~b)).
>  	 */
>  	pte_val(entry) ^= PTE_RDONLY;
> -	asm volatile("//	ptep_set_access_flags\n"
> -	"	prfm	pstl1strm, %2\n"
> -	"1:	ldxr	%0, %2\n"
> -	"	eor	%0, %0, %3		// negate PTE_RDONLY in *ptep\n"
> -	"	orr	%0, %0, %4		// set flags\n"
> -	"	eor	%0, %0, %3		// negate final PTE_RDONLY\n"
> -	"	stxr	%w1, %0, %2\n"
> -	"	cbnz	%w1, 1b\n"
> -	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
> -	: "L" (PTE_RDONLY), "r" (pte_val(entry)));
> +	do {
> +		old_pteval = READ_ONCE(pte_val(*ptep));
> +		pteval = old_pteval ^ PTE_RDONLY;
> +		pteval |= pte_val(entry);
> +		pteval ^= PTE_RDONLY;
> +	} while (cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval) !=
> +		 old_pteval);
>  
>  	flush_tlb_fix_spurious_fault(vma, address);
>  	return 1;

You haven't changed this in your patch, but how is the return value supposed
to interact with concurrent updates to the pte? Isn't the earlier pte_same
check racy?

Will
