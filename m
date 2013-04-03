From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Apr 2013 10:43:34 +0100
Subject: [PATCH 3/7] ARM: KVM: move to a KVM provided HYP idmap
In-Reply-To: <1364909115-3810-4-git-send-email-marc.zyngier@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130403094334.GB11040@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:25:11PM +0100, Marc Zyngier wrote:
> After the HYP page table rework, it is pretty easy to let the KVM
> code provide its own idmap, rather than expecting the kernel to
> provide it. It takes actually less code to do so.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/idmap.h   |  1 -
>  arch/arm/include/asm/kvm_mmu.h |  1 -
>  arch/arm/kvm/mmu.c             | 24 +++++++++++++++++++++++-
>  arch/arm/mm/idmap.c            | 31 +------------------------------
>  4 files changed, 24 insertions(+), 33 deletions(-)

[...]

> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index 5ee505c..9c467d0 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -83,37 +83,10 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> -#if defined(CONFIG_ARM_VIRT_EXT) && defined(CONFIG_ARM_LPAE)
> -pgd_t *hyp_pgd;
> -
> -extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
> -
> -static int __init init_static_idmap_hyp(void)
> -{
> -	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
> -	if (!hyp_pgd)
> -		return -ENOMEM;
> -
> -	pr_info("Setting up static HYP identity map for 0x%p - 0x%p\n",
> -		__hyp_idmap_text_start, __hyp_idmap_text_end);
> -	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
> -			     __hyp_idmap_text_end, PMD_SECT_AP1);
> -
> -	return 0;
> -}
> -#else
> -static int __init init_static_idmap_hyp(void)
> -{
> -	return 0;
> -}
> -#endif
> -
>  extern char  __idmap_text_start[], __idmap_text_end[];
>  
>  static int __init init_static_idmap(void)
>  {
> -	int ret;
> -
>  	idmap_pgd = pgd_alloc(&init_mm);
>  	if (!idmap_pgd)
>  		return -ENOMEM;
> @@ -123,12 +96,10 @@ static int __init init_static_idmap(void)
>  	identity_mapping_add(idmap_pgd, __idmap_text_start,
>  			     __idmap_text_end, 0);
>  
> -	ret = init_static_idmap_hyp();
> -
>  	/* Flush L1 for the hardware to see this page table content */
>  	flush_cache_louis();
>  
> -	return ret;
> +	return 0;
>  }
>  early_initcall(init_static_idmap);

You can probably kill off the #include <asm/virt.h> from this file too,
although I can't immediately see why it's needed anyway.

If that works out,

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
