From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Aug 2017 18:03:54 +0100
Subject: [PATCH 1/6] arm64: Fix potential race with hardware DBM in
 ptep_set_access_flags()
In-Reply-To: <20170725135308.18173-2-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-2-catalin.marinas@arm.com>
Message-ID: <20170801170354.GE12027@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 02:53:03PM +0100, Catalin Marinas wrote:
> In a system with DBM (dirty bit management) capable agents there is a
> possible race between a CPU executing ptep_set_access_flags() (maybe
> non-DBM capable) and a hardware update of the dirty state (clearing of
> PTE_RDONLY). The scenario:
> 
> a) the pte is writable (PTE_WRITE set), clean (PTE_RDONLY set) and old
>    (PTE_AF clear)
> b) ptep_set_access_flags() is called as a result of a read access and it
>    needs to set the pte to writable, clean and young (PTE_AF set)
> c) a DBM-capable agent, as a result of a different write access, is
>    marking the entry as young (setting PTE_AF) and dirty (clearing
>    PTE_RDONLY)
> 
> The current ptep_set_access_flags() implementation would set the
> PTE_RDONLY bit in the resulting value overriding the DBM update and
> losing the dirty state.
> 
> This patch fixes such race by setting PTE_RDONLY to the most permissive
> (lowest value) of the current entry and the new one.
> 
> Fixes: 66dbd6e61a52 ("arm64: Implement ptep_set_access_flags() for hardware AF/DBM")
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/mm/fault.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index c7861c9864e6..2509e4fe6992 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -163,26 +163,27 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  	/* only preserve the access flags and write permission */
>  	pte_val(entry) &= PTE_AF | PTE_WRITE | PTE_DIRTY;
>  
> -	/*
> -	 * PTE_RDONLY is cleared by default in the asm below, so set it in
> -	 * back if necessary (read-only or clean PTE).
> -	 */
> +	/* set PTE_RDONLY if actual read-only or clean PTE */
>  	if (!pte_write(entry) || !pte_sw_dirty(entry))
>  		pte_val(entry) |= PTE_RDONLY;
>  
>  	/*
>  	 * Setting the flags must be done atomically to avoid racing with the
> -	 * hardware update of the access/dirty state.
> +	 * hardware update of the access/dirty state. The PTE_RDONLY bit must
> +	 * be set to the most permissive (lowest value) of *ptep and entry
> +	 * (calculated as: a & b == ~(~a | ~b)).
>  	 */
> +	pte_val(entry) ^= PTE_RDONLY;
>  	asm volatile("//	ptep_set_access_flags\n"
>  	"	prfm	pstl1strm, %2\n"
>  	"1:	ldxr	%0, %2\n"
> -	"	and	%0, %0, %3		// clear PTE_RDONLY\n"
> +	"	eor	%0, %0, %3		// negate PTE_RDONLY in *ptep\n"
>  	"	orr	%0, %0, %4		// set flags\n"
> +	"	eor	%0, %0, %3		// negate final PTE_RDONLY\n"
>  	"	stxr	%w1, %0, %2\n"
>  	"	cbnz	%w1, 1b\n"
>  	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
> -	: "L" (~PTE_RDONLY), "r" (pte_val(entry)));
> +	: "L" (PTE_RDONLY), "r" (pte_val(entry)));

Can this be simplified using BIC instead? Ultimately, it would be better
to use cmpxchg, but as a fix for stable I'd prefer something that doesn't
invert the current logic.

Will

--->8

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c7861c9864e6..082366ad04d1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -155,7 +155,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  pte_t entry, int dirty)
 {
 	pteval_t old_pteval;
-	unsigned int tmp;
+	unsigned long tmp;
 
 	if (pte_same(*ptep, entry))
 		return 0;
@@ -177,12 +177,14 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	asm volatile("//	ptep_set_access_flags\n"
 	"	prfm	pstl1strm, %2\n"
 	"1:	ldxr	%0, %2\n"
-	"	and	%0, %0, %3		// clear PTE_RDONLY\n"
-	"	orr	%0, %0, %4		// set flags\n"
+	"	bic	%1, %3, %0		// clear PTE_RDONLY if\n"
+	"	bic	%1, %4, %1		// not already set in pte,\n"
+	"	bic	%0, %0, %3		// then set the other\n"
+	"	orr	%0, %0, %1		// access flags\n"
 	"	stxr	%w1, %0, %2\n"
 	"	cbnz	%w1, 1b\n"
 	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
-	: "L" (~PTE_RDONLY), "r" (pte_val(entry)));
+	: "L" (PTE_RDONLY), "r" (pte_val(entry)));
 
 	flush_tlb_fix_spurious_fault(vma, address);
 	return 1;
