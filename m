From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 15 Nov 2015 08:38:25 +0100
Subject: [PATCHv2] arm64: Fix R/O permissions in mark_rodata_ro
In-Reply-To: <1447359670-23652-1-git-send-email-labbott@fedoraproject.org>
References: <CAKv+Gu8Z7bkogGUGcNbuSoEbUBAwVmtFNhX9VcbypucaUGd+HQ@mail.gmail.com>
 <1447359670-23652-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <CAKv+Gu_xkiH8w2gor8SEp4y2UV9KSKTp9Kjtr6C9aU7XduZ06g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 21:21, Laura Abbott <labbott@fedoraproject.org> wrote:
> The permissions in mark_rodata_ro trigger a build error
> with STRICT_MM_TYPECHECKS. Fix this by introducing
> PAGE_KERNEL_ROX for the same reasons as PAGE_KERNEL_RO.

Forgive the bikeshedding but perhaps PAGE_KERNEL_EXEC_RO is more consistent?

> From Ard:
>
> "PAGE_KERNEL_EXEC has PTE_WRITE set as well, making the range
> writeable under the ARMv8.1 DBM feature, that manages the
> dirty bit in hardware (writing to a page with the PTE_RDONLY
> and PTE_WRITE bits both set will clear the PTE_RDONLY bit in that case)"
>
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/pgtable.h | 1 +
>  arch/arm64/mm/mmu.c              | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9819a94..7e074f9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -81,6 +81,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>
>  #define PAGE_KERNEL            __pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
>  #define PAGE_KERNEL_RO         __pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
> +#define PAGE_KERNEL_ROX        __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
>  #define PAGE_KERNEL_EXEC       __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
>  #define PAGE_KERNEL_EXEC_CONT  __pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9ca5996..6598c48 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -475,7 +475,7 @@ void mark_rodata_ro(void)
>  {
>         create_mapping_late(__pa(_stext), (unsigned long)_stext,
>                                 (unsigned long)_etext - (unsigned long)_stext,
> -                               PAGE_KERNEL_EXEC | PTE_RDONLY);
> +                               PAGE_KERNEL_ROX);
>
>  }
>  #endif
> --
> 2.5.0
>
