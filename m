From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 1 Aug 2017 13:16:18 +0200
Subject: [PATCH 3/6] kvm: arm64: Convert kvm_set_s2pte_readonly() from
 inline asm to cmpxchg()
In-Reply-To: <20170725135308.18173-4-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-4-catalin.marinas@arm.com>
Message-ID: <20170801111618.GC5176@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Jul 25, 2017 at 02:53:05PM +0100, Catalin Marinas wrote:
> To take advantage of the LSE atomic instructions and also make the code
> cleaner, convert the kvm_set_s2pte_readonly() function to use the more
> generic cmpxchg().
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index a89cc22abadc..40b3ea690826 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -175,18 +175,14 @@ static inline pmd_t kvm_s2pmd_mkwrite(pmd_t pmd)
>  
>  static inline void kvm_set_s2pte_readonly(pte_t *pte)
>  {
> -	pteval_t pteval;
> -	unsigned long tmp;
> -
> -	asm volatile("//	kvm_set_s2pte_readonly\n"
> -	"	prfm	pstl1strm, %2\n"
> -	"1:	ldxr	%0, %2\n"
> -	"	and	%0, %0, %3		// clear PTE_S2_RDWR\n"
> -	"	orr	%0, %0, %4		// set PTE_S2_RDONLY\n"
> -	"	stxr	%w1, %0, %2\n"
> -	"	cbnz	%w1, 1b\n"
> -	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*pte))
> -	: "L" (~PTE_S2_RDWR), "L" (PTE_S2_RDONLY));
> +	pteval_t old_pteval, pteval;
> +
> +	do {
> +		pteval = old_pteval = READ_ONCE(pte_val(*pte));
> +		pteval &= ~PTE_S2_RDWR;
> +		pteval |= PTE_S2_RDONLY;
> +	} while (cmpxchg_relaxed(&pte_val(*pte), old_pteval, pteval) !=
> +		 old_pteval);

I'm wondering if the READ_ONCE for old_pteval is strictly necessary, or
if that's really for the pteval.  Actually, I'm a little unsure whether
this is equivalent to

	old_pteval = READ_ONCE(pte_val(*pte));
	pteval = old_pteval;

or

	old_pteval = READ_ONCE(pte_val(*pte));
	pteval = READ_ONCE(pte_val(*pte));

I think it's the former, which I also think is correct, but the reason
I'm going down this road is that we have a use of cmpxchg() in the VGIC
code, which doesn't use READ_ONCE for the old value (~
vgic-mmio-v3.c:404), and I also found other occurences of this in the
kernel, so I'm wondering if the VGIC code is broken or we're being
overly careful here, or if this is necessary because hardware can update
the value behind our backs in this case?

In any case, for this patch:

Reviewed-by: Christoffer Dall <cdall@linaro.org>



>  }
>  
>  static inline bool kvm_s2pte_readonly(pte_t *pte)
