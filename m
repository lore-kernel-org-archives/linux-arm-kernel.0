From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Dec 2016 17:44:44 +0000
Subject: [PATCHv4 08/10] mm/kasan: Switch to using __pa_symbol and lm_alias
In-Reply-To: <1480445729-27130-9-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-9-git-send-email-labbott@redhat.com>
Message-ID: <20161206174443.GG24177@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 10:55:27AM -0800, Laura Abbott wrote:
> __pa_symbol is the correct API to find the physical address of symbols.
> Switch to it to allow for debugging APIs to work correctly. Other
> functions such as p*d_populate may call __pa internally. Ensure that the
> address passed is in the linear region by calling lm_alias.

I've given this a go on Juno with CONFIG_KASAN_INLINE enabled, and
everything seems happy.

We'll need an include of <linux/mm.h> as that appears to be missing. I
guess we're getting lucky with transitive includes. Otherwise this looks
good to me.

With that fixed up:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> Pointed out during review/testing of v3.
> ---
>  mm/kasan/kasan_init.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
> index 3f9a41c..ff04721 100644
> --- a/mm/kasan/kasan_init.c
> +++ b/mm/kasan/kasan_init.c
> @@ -49,7 +49,7 @@ static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
>  	pte_t *pte = pte_offset_kernel(pmd, addr);
>  	pte_t zero_pte;
>  
> -	zero_pte = pfn_pte(PFN_DOWN(__pa(kasan_zero_page)), PAGE_KERNEL);
> +	zero_pte = pfn_pte(PFN_DOWN(__pa_symbol(kasan_zero_page)), PAGE_KERNEL);
>  	zero_pte = pte_wrprotect(zero_pte);
>  
>  	while (addr + PAGE_SIZE <= end) {
> @@ -69,7 +69,7 @@ static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
>  		next = pmd_addr_end(addr, end);
>  
>  		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
> -			pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +			pmd_populate_kernel(&init_mm, pmd, lm_alias(kasan_zero_pte));
>  			continue;
>  		}
>  
> @@ -94,7 +94,7 @@ static void __init zero_pud_populate(pgd_t *pgd, unsigned long addr,
>  
>  			pud_populate(&init_mm, pud, kasan_zero_pmd);
>  			pmd = pmd_offset(pud, addr);
> -			pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +			pmd_populate_kernel(&init_mm, pmd, lm_alias(kasan_zero_pte));
>  			continue;
>  		}
>  
> @@ -135,11 +135,11 @@ void __init kasan_populate_zero_shadow(const void *shadow_start,
>  			 * puds,pmds, so pgd_populate(), pud_populate()
>  			 * is noops.
>  			 */
> -			pgd_populate(&init_mm, pgd, kasan_zero_pud);
> +			pgd_populate(&init_mm, pgd, lm_alias(kasan_zero_pud));
>  			pud = pud_offset(pgd, addr);
> -			pud_populate(&init_mm, pud, kasan_zero_pmd);
> +			pud_populate(&init_mm, pud, lm_alias(kasan_zero_pmd));
>  			pmd = pmd_offset(pud, addr);
> -			pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +			pmd_populate_kernel(&init_mm, pmd, lm_alias(kasan_zero_pte));
>  			continue;
>  		}
>  
> -- 
> 2.7.4
> 
