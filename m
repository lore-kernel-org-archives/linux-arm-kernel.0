From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 5 Nov 2015 08:07:24 +0100
Subject: [PATCH 1/2] arm64: Get existing page protections in split_pmd
In-Reply-To: <1446587315-18145-2-git-send-email-labbott@fedoraproject.org>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <1446587315-18145-2-git-send-email-labbott@fedoraproject.org>
Message-ID: <CAKv+Gu_rDSAtUGoP2uCREJPTpSHaxOi+6aeRJfz+3nEZdFRL6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On 3 November 2015 at 22:48, Laura Abbott <labbott@fedoraproject.org> wrote:
>
> Rather than always putting the least restrictived permissions

restrictive

> (PAGE_KERNEL_EXEC) when spliting a pmd into pages, use
> the existing permissions from the pmd for the page.
>
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
>  arch/arm64/mm/mmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9211b85..ff41efa 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -75,14 +75,13 @@ static void __init *early_alloc(unsigned long sz)
>  static void split_pmd(pmd_t *pmd, pte_t *pte)
>  {
>         unsigned long pfn = pmd_pfn(*pmd);
> +       unsigned long addr = pfn << PAGE_SHIFT;
> +       pgprot_t prot = __pgprot(pmd_val(*pmd) ^ addr) | PTE_TYPE_PAGE;

pgprot_t is a struct type when STRICT_MM_TYPECHECKS is in effect, so
__pgprot() should cover the entire expression.

With the above fixed:
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks,

> +
>         int i = 0;
>
>         do {
> -               /*
> -                * Need to have the least restrictive permissions available
> -                * permissions will be fixed up later
> -                */
> -               set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
> +               set_pte(pte, pfn_pte(pfn, prot));
>                 pfn++;
>         } while (pte++, i++, i < PTRS_PER_PTE);
>  }
> --
> 2.4.3
>
