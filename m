From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 22 Jul 2014 18:39:51 +0200
Subject: [PATCH 1/2] arm: use generic fixmap.h
In-Reply-To: <1404898792-4201-2-git-send-email-leif.lindholm@linaro.org>
References: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
 <1404898792-4201-2-git-send-email-leif.lindholm@linaro.org>
Message-ID: <53CE93D7.5010608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leif,

On 09.07.2014 11:39, Leif Lindholm wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> ARM is different from other architectures in that fixmap pages are
> indexed with a positive offset from FIXADDR_START. Other architectures
> index with a negative offset from FIXADDR_TOP. In order to use the
> generic fixmap.h definitions, this patch redefines FIXADDR_TOP to be
> inclusive of the useable range. That is, FIXADDR_TOP is the virtual
> address of the topmost fixed page. The newly defined FIXADDR_END is
> the first virtual address past the fixed mappings.
> 
> The patch also introduces local helper macros in highmem.c to reverse
> the iteration order of fixmap pages.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> [Rebased to 3.16-rc4, reverse kmap fixmap traversal]
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/arm/include/asm/fixmap.h |   45 ++++++++++++++++++++++++++---------------
>  arch/arm/mm/highmem.c         |   13 +++++++-----
>  arch/arm/mm/init.c            |    2 +-
>  3 files changed, 38 insertions(+), 22 deletions(-)
> 

I've tried to use this series to enable earlycon without hardcoded
static mappings, but apparently something is not right yet. Please see
below.

[snip]

> -extern void __this_fixmap_does_not_exist(void);
> +#define FIXMAP_PAGE_NORMAL (L_PTE_MT_WRITEBACK | L_PTE_YOUNG | L_PTE_PRESENT)
> +#define FIXMAP_PAGE_IO (L_PTE_MT_DEV_NONSHARED | L_PTE_YOUNG | L_PTE_PRESENT)

This set of flags gives a read-only mapping on the machine I'm testing
on (Exynos4412, Cortex A9MPcore). If I use the same set of flags as used
in arch/arm/mm/mmu.c for MT_DEVICE_NONSHARED then the mapping works fine.

Best regards,
Tomasz
