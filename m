From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 18 Feb 2014 11:29:25 -0800
Subject: [PATCH v4 04/12] ARM: KVM: introduce kvm_p*d_addr_end
In-Reply-To: <1392737253-10480-5-git-send-email-marc.zyngier@arm.com>
References: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
 <1392737253-10480-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140218192925.GA2084@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:27:25PM +0000, Marc Zyngier wrote:
> The use of p*d_addr_end with stage-2 translation is slightly dodgy,
> as the IPA is 40bits, while all the p*d_addr_end helpers are
> taking an unsigned long (arm64 is fine with that as unligned long
> is 64bit).
> 
> The fix is to introduce 64bit clean versions of the same helpers,
> and use them in the stage-2 page table code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  arch/arm/include/asm/kvm_mmu.h   | 13 +++++++++++++
>  arch/arm/kvm/mmu.c               | 10 +++++-----
>  arch/arm64/include/asm/kvm_mmu.h |  4 ++++
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index f997b9e..88bba33 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -114,6 +114,19 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
>  	pmd_val(*pmd) |= L_PMD_S2_RDWR;
>  }
>  
> +/* Open coded p*d_addr_end that can deal with 64bit addresses */
> +#define kvm_pgd_addr_end(addr, end)					\
> +({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
> +	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> +})
> +
> +#define kvm_pud_addr_end(addr,end)		(end)
> +
> +#define kvm_pmd_addr_end(addr, end)					\
> +({	u64 __boundary = ((addr) + PMD_SIZE) & PMD_MASK;		\
> +	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> +})
> +
>  struct kvm;
>  
>  static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 415fd63..7f84116 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -145,7 +145,7 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>  		pgd = pgdp + pgd_index(addr);
>  		pud = pud_offset(pgd, addr);
>  		if (pud_none(*pud)) {
> -			addr = pud_addr_end(addr, end);
> +			addr = kvm_pud_addr_end(addr, end);
>  			continue;
>  		}
>  
> @@ -155,13 +155,13 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>  			 * move on.
>  			 */
>  			clear_pud_entry(kvm, pud, addr);
> -			addr = pud_addr_end(addr, end);
> +			addr = kvm_pud_addr_end(addr, end);
>  			continue;
>  		}
>  
>  		pmd = pmd_offset(pud, addr);
>  		if (pmd_none(*pmd)) {
> -			addr = pmd_addr_end(addr, end);
> +			addr = kvm_pmd_addr_end(addr, end);
>  			continue;
>  		}
>  
> @@ -176,10 +176,10 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>  		 */
>  		if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
>  			clear_pmd_entry(kvm, pmd, addr);
> -			next = pmd_addr_end(addr, end);
> +			next = kvm_pmd_addr_end(addr, end);
>  			if (page_empty(pmd) && !page_empty(pud)) {
>  				clear_pud_entry(kvm, pud, addr);
> -				next = pud_addr_end(addr, end);
> +				next = kvm_pud_addr_end(addr, end);
>  			}
>  		}
>  
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index c04b419..19cb328 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -121,6 +121,10 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
>  	pmd_val(*pmd) |= PMD_S2_RDWR;
>  }
>  
> +#define kvm_pgd_addr_end(addr, end)	pgd_addr_end(addr, end)
> +#define kvm_pud_addr_end(addr, end)	pud_addr_end(addr, end)
> +#define kvm_pmd_addr_end(addr, end)	pmd_addr_end(addr, end)
> +
>  struct kvm;
>  
>  #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
> -- 
> 1.8.3.4
> 
