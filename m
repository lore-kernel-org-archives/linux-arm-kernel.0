From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 Oct 2014 14:40:27 +0100
Subject: [PATCH v2 1/3] arm64: KVM: Implement 48 VA support for KVM EL2
 and Stage-2
In-Reply-To: <1412627427-28629-2-git-send-email-christoffer.dall@linaro.org>
References: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
 <1412627427-28629-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <5433ED4B.10000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/10/14 21:30, Christoffer Dall wrote:
> This patch adds the necessary support for all host kernel PGSIZE and
> VA_SPACE configuration options for both EL2 and the Stage-2 page tables.
> 
> However, for 40bit and 42bit PARange systems, the architecture mandates
> that VTCR_EL2.SL0 is maximum 1, resulting in fewer levels of stage-2
> pagge tables than levels of host kernel page tables.  At the same time,
> systems with a PARange > 42bit, we limit the IPA range by always setting
> VTCR_EL2.T0SZ to 24.
> 
> To solve the situation with different levels of page tables for Stage-2
> translation than the host kernel page tables, we allocate a dummy PGD
> with pointers to our actual inital level Stage-2 page table, in order
> for us to reuse the kernel pgtable manipulation primitives.  Reproducing
> all these in KVM does not look pretty and unnecessarily complicates the
> 32-bit side.
> 
> Systems with a PARange < 40bits are not yet supported.
> 
>  [ I have reworked this patch from its original form submitted by
>    Jungseok to take the architecture constraints into consideration.
>    There were too many changes from the original patch for me to
>    preserve the authorship.  Thanks to Catalin Marinas for his help in
>    figuring out a good solution to this challenge.  I have also fixed
>    various bugs and missing error code handling from the original
>    patch. - Christoffer ]
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

On top of Catalin's review, I have the following comments:

[...]

> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index bb06f76..3b3e18f 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -42,7 +42,7 @@ static unsigned long hyp_idmap_start;
>  static unsigned long hyp_idmap_end;
>  static phys_addr_t hyp_idmap_vector;
> 
> -#define pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
> +#define hyp_pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
> 
>  #define kvm_pmd_huge(_x)       (pmd_huge(_x) || pmd_trans_huge(_x))
> 
> @@ -158,7 +158,7 @@ static void unmap_pmds(struct kvm *kvm, pud_t *pud,
>                 }
>         } while (pmd++, addr = next, addr != end);
> 
> -       if (kvm_pmd_table_empty(start_pmd))
> +       if (kvm_pmd_table_empty(start_pmd) && (!kvm || KVM_PREALLOC_LEVEL < 2))

This really feels clunky. Can we fold the additional tests inside
kvm_pmd_table_empty(), taking kvm as an additional parameter?

>                 clear_pud_entry(kvm, pud, start_addr);
>  }
> 
> @@ -182,7 +182,7 @@ static void unmap_puds(struct kvm *kvm, pgd_t *pgd,
>                 }
>         } while (pud++, addr = next, addr != end);
> 
> -       if (kvm_pud_table_empty(start_pud))
> +       if (kvm_pud_table_empty(start_pud) && (!kvm || KVM_PREALLOC_LEVEL < 1))

Same here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
