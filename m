From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Nov 2012 08:25:52 -0600
Subject: [PATCH v4 02/14] ARM: Section based HYP idmap
In-Reply-To: <20121110154224.2836.21775.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154224.2836.21775.stgit@chazy-air>
Message-ID: <50AA4170.7010905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2012 09:42 AM, Christoffer Dall wrote:
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

Minor nit. You don't need ifdefs around declarations.

Rob
