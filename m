From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 Dec 2010 16:06:33 +0530
Subject: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
In-Reply-To: <1292580506-4421-3-git-send-email-j-pihet@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<1292580506-4421-3-git-send-email-j-pihet@ti.com>
Message-ID: <c088f96a59d7745a4341f142ffb64d62@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of jean.pihet at newoldbits.com
> Sent: Friday, December 17, 2010 3:38 PM
> To: linux-omap at vger.kernel.org
> Cc: khilman at deeprootsystems.com; linux-arm-kernel at lists.infradead.org;
> Jean Pihet
> Subject: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
>
> From: Jean Pihet <j-pihet@ti.com>
>
> The SRAM PA addresses are locally defined and used at
> different places, i.e. SRAM management code and idle sleep code.
>
> The macros are now defined at a centralized place, for
> easier maintenance.
>
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/sdrc.h             |    1 -
>  arch/arm/mach-omap2/sleep34xx.S        |    1 +
>  arch/arm/plat-omap/include/plat/sram.h |   11 +++++++++++
>  arch/arm/plat-omap/sram.c              |    7 ++-----
>  4 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
> index 68f57bb..b3f8379 100644
> --- a/arch/arm/mach-omap2/sdrc.h
> +++ b/arch/arm/mach-omap2/sdrc.h
> @@ -74,5 +74,4 @@ static inline u32 sms_read_reg(u16 reg)
>   */
>  #define SDRC_MPURATE_LOOPS		96
>
> -
>  #endif
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 2191576..406cd2a 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -26,6 +26,7 @@
>   */
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> +#include <plat/sram.h>
>  #include <mach/io.h>
>
>  #include "cm.h"
> diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-
> omap/include/plat/sram.h
> index 5905100..9967d5e 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -11,6 +11,7 @@
>  #ifndef __ARCH_ARM_OMAP_SRAM_H
>  #define __ARCH_ARM_OMAP_SRAM_H
>
> +#ifndef __ASSEMBLY__
>  extern void * omap_sram_push(void * start, unsigned long size);
>  extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
>
> @@ -74,4 +75,14 @@ extern void omap_push_sram_idle(void);
>  static inline void omap_push_sram_idle(void) {}
>  #endif /* CONFIG_PM */
>
> +#endif /* __ASSEMBLY__ */
> +
> +/*
> + * OMAP2+: define the SRAM PA addresses.
> + * Used by the SRAM management code and the idle sleep code.
> + */
> +#define OMAP2_SRAM_PA		0x40200000
> +#define OMAP3_SRAM_PA           0x40200000
> +#define OMAP4_SRAM_PA		0x40300000
> +
>  #endif
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 819ea0c..1a686c8 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -41,15 +41,12 @@
>
>  #define OMAP1_SRAM_PA		0x20000000
>  #define OMAP1_SRAM_VA		VMALLOC_END
> -#define OMAP2_SRAM_PA		0x40200000
> -#define OMAP2_SRAM_PUB_PA	0x4020f800
> +#define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
>  #define OMAP2_SRAM_VA		0xfe400000
>  #define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
> -#define OMAP3_SRAM_PA           0x40200000
>  #define OMAP3_SRAM_VA           0xfe400000
> -#define OMAP3_SRAM_PUB_PA       0x40208000
> +#define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
>  #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
> -#define OMAP4_SRAM_PA		0x40300000
>  #define OMAP4_SRAM_VA		0xfe400000
>  #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
>  #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
