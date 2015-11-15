From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 15 Nov 2015 08:32:27 +0100
Subject: [PATCHv2 1/2] arm64: Get existing page protections in split_pmd
In-Reply-To: <1447207057-11323-2-git-send-email-labbott@fedoraproject.org>
References: <1447207057-11323-1-git-send-email-labbott@fedoraproject.org>
 <1447207057-11323-2-git-send-email-labbott@fedoraproject.org>
Message-ID: <CAKv+Gu9T06y_xenPZZC=oHdKPPVjpw_0QvVhqkiV0nTBWus73w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 November 2015 at 02:57, Laura Abbott <labbott@fedoraproject.org> wrote:
> Rather than always putting the least restrictived permissions
> (PAGE_KERNEL_EXEC) when spliting a pmd into pages, use
> the existing permissions from the pmd for the page.
>
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
> v2: Typo and typechecking fixed
>
> I chose not to add the Reviewed-by from Ard here because of the addition of
> the contiguous bit in split_pmd. Not sure if I should be explicitly carrying
> it over.

Yes, you should. A PMD will be split into more than one contiguous
range, e.g., 32 x 64 KB on 4 KB pages, and the PTE manipulation code
is responsible for clearing the PTE_CONT bit on any PTE that is part
of a range that is no longer mapped contiguously.

> ---
>  arch/arm64/mm/mmu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c2fa6b5..496c3fd 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -76,15 +76,13 @@ static void __init *early_alloc(unsigned long sz)
>  static void split_pmd(pmd_t *pmd, pte_t *pte)
>  {
>         unsigned long pfn = pmd_pfn(*pmd);
> +       unsigned long addr = pfn << PAGE_SHIFT;
> +       pgprot_t prot = __pgprot((pmd_val(*pmd) ^ addr) | PTE_TYPE_PAGE);
> +
>         int i = 0;
>
>         do {
> -               /*
> -                * Need to have the least restrictive permissions available
> -                * permissions will be fixed up later. Default the new page
> -                * range as contiguous ptes.
> -                */
> -               set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC_CONT));
> +               set_pte(pte, pfn_pte(pfn, prot));
>                 pfn++;
>         } while (pte++, i++, i < PTRS_PER_PTE);
>  }
> --
> 2.5.0
>
