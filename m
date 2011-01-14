From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 14 Jan 2011 16:23:56 +0100
Subject: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
In-Reply-To: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
Message-ID: <AANLkTimc+GY1Pr1T=baF8WO8sTnprra66o52K-4_XxYh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 4:21 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> The new fncpy API is better suited for copying some
> code to SRAM at runtime. This patch changes the ad-hoc
> code to the more generic fncpy API.
>
> Tested OK on OMAP3 in low power modes (RET/OFF)
> with !CONFIG_THUMB2_KERNEL
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

This patch depends on Dave's '[PATCH v3 1/1] ARM: Thumb-2: Symbol
manipulation macros for function' patch, cf.
http://marc.info/?l=linux-arm-kernel&m=129495865831165&w=2

Regards,
Jean

> ---
> ?arch/arm/plat-omap/sram.c | ? ?7 +++----
> ?1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index e26e504..e2982b0 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -23,7 +23,7 @@
>
> ?#include <asm/tlb.h>
> ?#include <asm/cacheflush.h>
> -
> +#include <asm/fncpy.h>
> ?#include <asm/mach/map.h>
>
> ?#include <plat/sram.h>
> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long size)
>
> ? ? ? ?omap_sram_ceil -= size;
> ? ? ? ?omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
> - ? ? ? memcpy((void *)omap_sram_ceil, start, size);
> - ? ? ? flush_icache_range((unsigned long)omap_sram_ceil,
> - ? ? ? ? ? ? ? (unsigned long)(omap_sram_ceil + size));
> +
> + ? ? ? fncpy((void *)omap_sram_ceil, start, size);
>
> ? ? ? ?return (void *)omap_sram_ceil;
> ?}
> --
> 1.7.2.3
>
>
