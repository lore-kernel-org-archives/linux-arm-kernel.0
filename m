From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 3 Apr 2013 16:15:23 -0700
Subject: [PATCH 5/7] ARM: KVM: parametrize HYP page table freeing
In-Reply-To: <1364909115-3810-6-git-send-email-marc.zyngier@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130403231523.GE29227@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:25:13PM +0100, Marc Zyngier wrote:
> In order to prepare for having to deal with multiple HYP page tables,
> pass the PGD parameter to the function performing the freeing of the
> page tables.
> 
> Also move the freeing of the PGD itself there, and rename the
> free_hyp_pmds to free_hyp_pgds.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h |  2 +-
>  arch/arm/kvm/arm.c             |  2 +-
>  arch/arm/kvm/mmu.c             | 30 +++++++++++++++++-------------
>  3 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 3c71a1d..92eb20d 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -32,7 +32,7 @@
>  
>  int create_hyp_mappings(void *from, void *to);
>  int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
> -void free_hyp_pmds(void);
> +void free_hyp_pgds(void);
>  
>  int kvm_alloc_stage2_pgd(struct kvm *kvm);
>  void kvm_free_stage2_pgd(struct kvm *kvm);
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 2ce90bb..6eba879 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -936,7 +936,7 @@ static int init_hyp_mode(void)
>  out_free_context:
>  	free_percpu(kvm_host_cpu_state);
>  out_free_mappings:
> -	free_hyp_pmds();
> +	free_hyp_pgds();
>  out_free_stack_pages:
>  	for_each_possible_cpu(cpu)
>  		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 7d23480..85b3553 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -86,42 +86,46 @@ static void free_ptes(pmd_t *pmd, unsigned long addr)
>  	}
>  }
>  
> -static void free_hyp_pgd_entry(unsigned long addr)
> +static void free_hyp_pgd_entry(pgd_t *pgdp, unsigned long addr)
>  {
>  	pgd_t *pgd;
>  	pud_t *pud;
>  	pmd_t *pmd;
> -	unsigned long hyp_addr = KERN_TO_HYP(addr);
>  
> -	pgd = hyp_pgd + pgd_index(hyp_addr);
> -	pud = pud_offset(pgd, hyp_addr);
> +	pgd = pgdp + pgd_index(addr);
> +	pud = pud_offset(pgd, addr);
>  
>  	if (pud_none(*pud))
>  		return;
>  	BUG_ON(pud_bad(*pud));
>  
> -	pmd = pmd_offset(pud, hyp_addr);
> +	pmd = pmd_offset(pud, addr);
>  	free_ptes(pmd, addr);
>  	pmd_free(NULL, pmd);
>  	pud_clear(pud);
>  }
>  
>  /**
> - * free_hyp_pmds - free a Hyp-mode level-2 tables and child level-3 tables
> + * free_hyp_pgds - free Hyp-mode page tables
>   *
> - * Assumes this is a page table used strictly in Hyp-mode and therefore contains
> + * Assumes hyp_pgd is a page table used strictly in Hyp-mode and therefore contains
>   * either mappings in the kernel memory area (above PAGE_OFFSET), or
>   * device mappings in the vmalloc range (from VMALLOC_START to VMALLOC_END).
>   */
> -void free_hyp_pmds(void)
> +void free_hyp_pgds(void)
>  {
>  	unsigned long addr;
>  
>  	mutex_lock(&kvm_hyp_pgd_mutex);
> -	for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
> -		free_hyp_pgd_entry(addr);
> -	for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
> -		free_hyp_pgd_entry(addr);
> +
> +	if (hyp_pgd) {
> +		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
> +			free_hyp_pgd_entry(hyp_pgd, KERN_TO_HYP(addr));
> +		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
> +			free_hyp_pgd_entry(hyp_pgd, KERN_TO_HYP(addr));
> +		kfree(hyp_pgd);
> +	}
> +
>  	mutex_unlock(&kvm_hyp_pgd_mutex);
>  }
>  
> @@ -741,7 +745,7 @@ int kvm_mmu_init(void)
>  
>  	return 0;
>  out:
> -	kfree(hyp_pgd);
> +	free_hyp_pgds();
>  	return err;
>  }
>  
> -- 
> 1.8.1.4
> 
> 

Acked-by: Christoffer Dall <cdall@cs.columbia.edu>
