From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Jun 2017 10:46:18 +0000
Subject: [PATCH] ARM: small correction to early_ioremap support
In-Reply-To: <20170627005731.7869-1-opendmb@gmail.com>
References: <20170627005731.7869-1-opendmb@gmail.com>
Message-ID: <CAKv+Gu-GzbbmnWDLFJh6u5jeAfeMtBBFC7X9y+ePVGXhz+JZYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2017 at 00:57, Doug Berger <opendmb@gmail.com> wrote:
> The fixmap pages need to be on the same pmd page for the current
> implementation of arm early_fixmap.  A build time bug check is
> used to ensure that.  However, the worst case fixmap range is
> better represented by __end_of_fixed_addresses than by the value
> __end_of_early_ioremap_region.
>
> Fixes: 2937367b8a4b ("ARM: add support for generic early_ioremap/early_memremap")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  arch/arm/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 31af3cb59a60..74c0ed5c3b08 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -392,7 +392,7 @@ void __init early_fixmap_init(void)
>          * The early fixmap range spans multiple pmds, for which
>          * we are not prepared:
>          */
> -       BUILD_BUG_ON((__fix_to_virt(__end_of_early_ioremap_region) >> PMD_SHIFT)
> +       BUILD_BUG_ON((__fix_to_virt(__end_of_fixed_addresses) >> PMD_SHIFT)
>                      != FIXADDR_TOP >> PMD_SHIFT);
>
>         pmd = fixmap_pmd(FIXADDR_TOP);

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
