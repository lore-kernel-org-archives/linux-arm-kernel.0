From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 14:14:17 +0000
Subject: [PATCH v4 01/14] ARM: Add page table and page defines needed by
 KVM
In-Reply-To: <20121110154217.2836.41905.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154217.2836.41905.stgit@chazy-air>
Message-ID: <20121119141417.GT3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:42:17PM +0000, Christoffer Dall wrote:
> KVM uses the stage-2 page tables and the Hyp page table format,
> so we define the fields and page protection flags needed by KVM.
> 
> The nomenclature is this:
>  - page_hyp:        PL2 code/data mappings
>  - page_hyp_device: PL2 device mappings (vgic access)
>  - page_s2:         Stage-2 code/data page mappings
>  - page_s2_device:  Stage-2 device mappings (vgic access)
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Christoffer Dall <c.dall@virtualopensystems.com>

[...]

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 941dfb9..087d949 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -57,43 +57,61 @@ static unsigned int cachepolicy __initdata = CPOLICY_WRITEBACK;
>  static unsigned int ecc_mask __initdata = 0;
>  pgprot_t pgprot_user;
>  pgprot_t pgprot_kernel;
> +pgprot_t pgprot_hyp_device;
> +pgprot_t pgprot_s2;
> +pgprot_t pgprot_s2_device;
>  
>  EXPORT_SYMBOL(pgprot_user);
>  EXPORT_SYMBOL(pgprot_kernel);
> +EXPORT_SYMBOL(pgprot_hyp_device);
> +EXPORT_SYMBOL(pgprot_s2);
> +EXPORT_SYMBOL(pgprot_s2_device);

Do we still need these?

>  struct cachepolicy {
>  	const char	policy[16];
>  	unsigned int	cr_mask;
>  	pmdval_t	pmd;
>  	pteval_t	pte;
> +	pteval_t	pte_s2;
>  };
>  
> +#ifdef CONFIG_ARM_LPAE
> +#define s2_policy(policy)	policy
> +#else
> +#define s2_policy(policy)	0
> +#endif

Put the macro in pgtable-{2,3}level.h?

Will
