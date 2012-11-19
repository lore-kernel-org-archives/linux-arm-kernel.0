From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 14:16:31 +0000
Subject: [PATCH v4 02/14] ARM: Section based HYP idmap
In-Reply-To: <20121110154224.2836.21775.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154224.2836.21775.stgit@chazy-air>
Message-ID: <20121119141631.GU3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:42:24PM +0000, Christoffer Dall wrote:
> Add a method (hyp_idmap_setup) to populate a hyp pgd with an
> identity mapping of the code contained in the .hyp.idmap.text
> section.
> 
> Offer a method to drop this identity mapping through
> hyp_idmap_teardown.
> 
> Make all the above depend on CONFIG_ARM_VIRT_EXT and CONFIG_ARM_LPAE.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/idmap.h                |    5 ++
>  arch/arm/include/asm/pgtable-3level-hwdef.h |    1 
>  arch/arm/kernel/vmlinux.lds.S               |    6 ++
>  arch/arm/mm/idmap.c                         |   74 +++++++++++++++++++++++----
>  4 files changed, 73 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
> index bf863ed..36708ba 100644
> --- a/arch/arm/include/asm/idmap.h
> +++ b/arch/arm/include/asm/idmap.h
> @@ -11,4 +11,9 @@ extern pgd_t *idmap_pgd;
>  
>  void setup_mm_for_reboot(void);
>  
> +#ifdef CONFIG_ARM_VIRT_EXT
> +void hyp_idmap_teardown(pgd_t *hyp_pgd);
> +void hyp_idmap_setup(pgd_t *hyp_pgd);
> +#endif

I wonder whether the dependency is quite right here. Functionally, we're
only dependent on LPAE but it doesn't make sense if !ARM_VIRT_EXT. In
fact, I start to question whether CONFIG_ARM_VIRT_EXT is worthwhile at
all as it stands. Maybe it would be better to add the LPAE dependency
there and make the hyp_stub stuff that's currently in mainline
unconditional?

> +/*
> + * This version actually frees the underlying pmds for all pgds in range and
> + * clear the pgds themselves afterwards.
> + */
> +void hyp_idmap_teardown(pgd_t *hyp_pgd)
> +{
> +	unsigned long addr, end;
> +	unsigned long next;
> +	pgd_t *pgd = hyp_pgd;
> +
> +	addr = virt_to_phys(__hyp_idmap_text_start);
> +	end = virt_to_phys(__hyp_idmap_text_end);
> +
> +	pgd += pgd_index(addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (!pgd_none_or_clear_bad(pgd))
> +			hyp_idmap_del_pmd(pgd, addr);
> +	} while (pgd++, addr = next, addr < end);
> +}
> +EXPORT_SYMBOL_GPL(hyp_idmap_teardown);
> +
> +void hyp_idmap_setup(pgd_t *hyp_pgd)
> +{
> +	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
> +			     __hyp_idmap_text_end, PMD_SECT_AP1);
> +}
> +EXPORT_SYMBOL_GPL(hyp_idmap_setup);
> +#endif

Again, do we need these exports?

I also think it might be cleaner to declare the hyp_pgd next to the
idmap_pgd then add the hyp_idmap_setup code to init_static_idmap, so
that we don't add new entry points to this file. The teardown can all be
moved into the kvm/ code as it doesn't need any of the existing idmap
functions.

Will
