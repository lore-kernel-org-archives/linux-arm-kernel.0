From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Jan 2015 17:25:34 +0000
Subject: [PATCH] arm64: allow late use of early_ioremap
In-Reply-To: <1421081711-1128-1-git-send-email-msalter@redhat.com>
References: <1421081711-1128-1-git-send-email-msalter@redhat.com>
Message-ID: <20150112172534.GJ13360@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 04:55:11PM +0000, Mark Salter wrote:
> Commit 0e63ea48b4d8 (arm64/efi: add missing call to early_ioremap_reset())
> added a missing call to early_ioremap_reset(). This triggers a BUG if code
> tries using early_ioremap() after the early_ioremap_reset(). This is a
> problem for some ACPI code which needs short-lived temporary mappings
> after paging_init() but before mm_init(). This patch adds definitions for
> the __late_set_fixmap() and __late_clear_fixmap() which avoids the BUG
> by allowing later use of early_ioremap().
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Leif Lindholm <leif.lindholm@linaro.org>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/fixmap.h | 3 +++
>  1 file changed, 3 insertions(+)

Given that we don't support ACPI on arm64 in mainline, I assume this can
wait until at least 3.20?

Will

> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 9ef6eca..e629c70 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -61,6 +61,9 @@ void __init early_fixmap_init(void);
>  
>  #define __early_set_fixmap __set_fixmap
>  
> +#define __late_set_fixmap __set_fixmap
> +#define __late_clear_fixmap(idx) __set_fixmap((idx), 0, FIXMAP_PAGE_CLEAR)
> +
>  extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
>  
>  #include <asm-generic/fixmap.h>
> -- 
> 1.8.3.1
> 
> 
