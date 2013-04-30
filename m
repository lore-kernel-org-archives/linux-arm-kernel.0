From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 10:17:17 -0700
Subject: [PATCH 1/4] ARM: KVM: be more thorough when invalidating TLBs
In-Reply-To: <1367331446-28030-2-git-send-email-marc.zyngier@arm.com>
References: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
 <1367331446-28030-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAEDV+g+LKEj_XdeLvMwxJhVQ9FG9=U6eqO7dPU340xX2oMkS0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 7:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The KVM/ARM MMU code doesn't take care of invalidating TLBs before
> freeing a {pte,pmd} table. This could cause problems if the page
> is reallocated and then speculated into by another CPU.
>
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/interrupts.S |  2 ++
>  arch/arm/kvm/mmu.c        | 36 +++++++++++++++++++++---------------
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index f7793df..9e2d906c 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -37,6 +37,8 @@ __kvm_hyp_code_start:
>   *
>   * void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>   *
> + * Invalidate TLB for the given IPA, or invalidate all if ipa is zero.
> + *
>   * We rely on the hardware to broadcast the TLB invalidation to all CPUs
>   * inside the inner-shareable domain (which is the case for all v7
>   * implementations).  If we come across a non-IS SMP implementation, we'll
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 9657065..71f2a57 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -43,7 +43,8 @@ static phys_addr_t hyp_idmap_vector;
>
>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  {
> -       kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
> +       if (kvm)
> +               kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);

this feels slightly abusive? could we add a comment that hyp page
table freeing don't need tlb flushing from these functions and don't
have a struct kvm?

alternatively it may be more clear to have something like:

if (kvm) /* Check if Hyp or Stage-2 page table */
    kvm_tlb_flush_vmid_ipa(kvm, addr);

in the callers, but, eh, maybe I'm over thinking this.

>  }
>
>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
> @@ -78,18 +79,20 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
>         return p;
>  }
>
> -static void clear_pud_entry(pud_t *pud)
> +static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
>  {
>         pmd_t *pmd_table = pmd_offset(pud, 0);
>         pud_clear(pud);
> +       kvm_tlb_flush_vmid_ipa(kvm, addr);
>         pmd_free(NULL, pmd_table);
>         put_page(virt_to_page(pud));
>  }
>
> -static void clear_pmd_entry(pmd_t *pmd)
> +static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
>  {
>         pte_t *pte_table = pte_offset_kernel(pmd, 0);
>         pmd_clear(pmd);
> +       kvm_tlb_flush_vmid_ipa(kvm, addr);
>         pte_free_kernel(NULL, pte_table);
>         put_page(virt_to_page(pmd));
>  }
> @@ -100,11 +103,12 @@ static bool pmd_empty(pmd_t *pmd)
>         return page_count(pmd_page) == 1;
>  }
>
> -static void clear_pte_entry(pte_t *pte)
> +static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>  {
>         if (pte_present(*pte)) {
>                 kvm_set_pte(pte, __pte(0));
>                 put_page(virt_to_page(pte));
> +               kvm_tlb_flush_vmid_ipa(kvm, addr);

I enjoyed the fact that it's perfectly correct to have this flush
after the put_page.

>         }
>  }
>
> @@ -114,7 +118,8 @@ static bool pte_empty(pte_t *pte)
>         return page_count(pte_page) == 1;
>  }
>
> -static void unmap_range(pgd_t *pgdp, unsigned long long start, u64 size)
> +static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
> +                       unsigned long long start, u64 size)
>  {
>         pgd_t *pgd;
>         pud_t *pud;
> @@ -138,15 +143,15 @@ static void unmap_range(pgd_t *pgdp, unsigned long long start, u64 size)
>                 }
>
>                 pte = pte_offset_kernel(pmd, addr);
> -               clear_pte_entry(pte);
> +               clear_pte_entry(kvm, pte, addr);
>                 range = PAGE_SIZE;
>
>                 /* If we emptied the pte, walk back up the ladder */
>                 if (pte_empty(pte)) {
> -                       clear_pmd_entry(pmd);
> +                       clear_pmd_entry(kvm, pmd, addr);
>                         range = PMD_SIZE;
>                         if (pmd_empty(pmd)) {
> -                               clear_pud_entry(pud);
> +                               clear_pud_entry(kvm, pud, addr);
>                                 range = PUD_SIZE;
>                         }
>                 }
> @@ -165,14 +170,14 @@ void free_boot_hyp_pgd(void)
>         mutex_lock(&kvm_hyp_pgd_mutex);
>
>         if (boot_hyp_pgd) {
> -               unmap_range(boot_hyp_pgd, hyp_idmap_start, PAGE_SIZE);
> -               unmap_range(boot_hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
> +               unmap_range(NULL, boot_hyp_pgd, hyp_idmap_start, PAGE_SIZE);
> +               unmap_range(NULL, boot_hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
>                 kfree(boot_hyp_pgd);
>                 boot_hyp_pgd = NULL;
>         }
>
>         if (hyp_pgd)
> -               unmap_range(hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
> +               unmap_range(NULL, hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
>
>         kfree(init_bounce_page);
>         init_bounce_page = NULL;
> @@ -200,9 +205,10 @@ void free_hyp_pgds(void)
>
>         if (hyp_pgd) {
>                 for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
> -                       unmap_range(hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
> +                       unmap_range(NULL, hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
>                 for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
> -                       unmap_range(hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
> +                       unmap_range(NULL, hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
> +
>                 kfree(hyp_pgd);
>                 hyp_pgd = NULL;
>         }
> @@ -393,7 +399,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>   */
>  static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>  {
> -       unmap_range(kvm->arch.pgd, start, size);
> +       unmap_range(kvm, kvm->arch.pgd, start, size);
>  }
>
>  /**
> @@ -413,6 +419,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
>                 return;
>
>         unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
> +       kvm_tlb_flush_vmid_ipa(kvm, 0); /* Invalidate TLB ALL */
>         free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
>         kvm->arch.pgd = NULL;
>  }
> @@ -675,7 +682,6 @@ static void handle_hva_to_gpa(struct kvm *kvm,
>  static void kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, void *data)
>  {
>         unmap_stage2_range(kvm, gpa, PAGE_SIZE);
> -       kvm_tlb_flush_vmid_ipa(kvm, gpa);
>  }
>
>  int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
> --
> 1.8.2.1
>
>
looks good to me,

-Christoffer
