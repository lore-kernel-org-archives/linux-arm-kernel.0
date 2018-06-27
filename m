From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Jun 2018 14:59:02 +0100
Subject: [PATCH v3 4/6] KVM: arm/arm64: Consolidate page-table accessors
In-Reply-To: <20180627122058.8210-5-marc.zyngier@arm.com>
References: <20180627122058.8210-1-marc.zyngier@arm.com>
 <20180627122058.8210-5-marc.zyngier@arm.com>
Message-ID: <0afbb729-d801-1563-a319-4d3e3d6ac6a9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 27/06/18 13:20, Marc Zyngier wrote:
> The arm and arm64 KVM page tables accessors are pointlessly different
> between the two architectures, and likely both wrong one way or another:
> arm64 lacks a dsb(), and arm doesn't use WRITE_ONCE.
> 
> Let's unify them.

nit: Feel free to ignore. The changes introducing kvm_p.d_populate
is not mentioned in the commit description and they do look a bit
disconnected from the change described above.

> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>


> +static inline void kvm_pmd_populate(pmd_t *pmdp, pte_t *ptep)
> +{
> +	pmd_populate_kernel(NULL, pmdp, ptep);
> +}
> +
> +static inline void kvm_pud_populate(pud_t *pudp, pmd_t *pmdp)
> +{
> +	pud_populate(NULL, pudp, pmdp);
> +}
> +
> +static inline void kvm_pgd_populate(pgd_t *pgdp, pud_t *pudp)
> +{
> +	pgd_populate(NULL, pgdp, pudp);
> +}
> +

>   /*
>    * Unmapping vs dcache management:
>    *
> @@ -605,7 +632,7 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
>   				kvm_err("Cannot allocate Hyp pte\n");
>   				return -ENOMEM;
>   			}
> -			pmd_populate_kernel(NULL, pmd, pte);
> +			kvm_pmd_populate(pmd, pte);
>   			get_page(virt_to_page(pmd));
>   			kvm_flush_dcache_to_poc(pmd, sizeof(*pmd));
>   		}
> @@ -638,7 +665,7 @@ static int create_hyp_pud_mappings(pgd_t *pgd, unsigned long start,
>   				kvm_err("Cannot allocate Hyp pmd\n");
>   				return -ENOMEM;
>   			}
> -			pud_populate(NULL, pud, pmd);
> +			kvm_pud_populate(pud, pmd);
>   			get_page(virt_to_page(pud));
>   			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
>   		}
> @@ -675,7 +702,7 @@ static int __create_hyp_mappings(pgd_t *pgdp, unsigned long ptrs_per_pgd,
>   				err = -ENOMEM;
>   				goto out;
>   			}
> -			pgd_populate(NULL, pgd, pud);
> +			kvm_pgd_populate(pgd, pud);
>   			get_page(virt_to_page(pgd));
>   			kvm_flush_dcache_to_poc(pgd, sizeof(*pgd));
>   		}
> @@ -1094,7 +1121,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>   		if (!cache)
>   			return 0; /* ignore calls from kvm_set_spte_hva */
>   		pte = mmu_memory_cache_alloc(cache);
> -		pmd_populate_kernel(NULL, pmd, pte);
> +		kvm_pmd_populate(pmd, pte);
>   		get_page(virt_to_page(pmd));
>   	}
>   
> 


Suzuki
