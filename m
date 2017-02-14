From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 14 Feb 2017 21:33:36 +0000
Subject: [PATCH] arm64: fix warning about swapper_pg_dir overflow
In-Reply-To: <20170214212718.2792194-1-arnd@arndb.de>
References: <20170214212718.2792194-1-arnd@arndb.de>
Message-ID: <CAKv+Gu_FMk26Vbrb3mp5cSkSvmELP2iantX4kTyg+U8HO0J9ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2017 at 21:27, Arnd Bergmann <arnd@arndb.de> wrote:
> With 4 levels of 16KB pages, we get this warning about the fact that we are
> copying a whole page into an array that is declared as having only two pointers
> for the top level of the page table:
>
> arch/arm64/mm/mmu.c: In function 'paging_init':
> arch/arm64/mm/mmu.c:528:2: error: 'memcpy' writing 16384 bytes into a region of size 16 overflows the destination [-Werror=stringop-overflow=]
>
> This is harmless since we actually reserve a whole page in the definition of the
> array that comes from, and just the extern declaration is short. The pgdir
> is initialized to zero either way, so copying the actual entries here seems
> like the best solution.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

We should see the same issue with 64k/3 levels, since its PGD_SIZE is
also much smaller than its PAGE_SIZE. This is a much more common
configuration, so I am surprised you found it on 16k/4 levels first.

In any case, the fix is correct IMO, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2131521ddc24..b805c017f789 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -525,7 +525,7 @@ void __init paging_init(void)
>          * To do this we need to go via a temporary pgd.
>          */
>         cpu_replace_ttbr1(__va(pgd_phys));
> -       memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
> +       memcpy(swapper_pg_dir, pgd, PGD_SIZE);
>         cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>
>         pgd_clear_fixmap();
> --
> 2.9.0
>
