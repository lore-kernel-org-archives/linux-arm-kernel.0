From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Feb 2011 00:09:34 +0530
Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi() for
	CONFIG_THUMB2_KERNEL
In-Reply-To: <1296756161-26092-2-git-send-email-dave.martin@linaro.org>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-2-git-send-email-dave.martin@linaro.org>
Message-ID: <b0242fa556f17e47222fa7f30a36d75b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin at linaro.org]
> Sent: Thursday, February 03, 2011 11:33 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
> linux-omap at vger.kernel.org; Nicolas Pitre
> Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi()
> for CONFIG_THUMB2_KERNEL
>
> For the Thumb-2 case, the "wfi" mnemonic is used, since in this
> case the tools will necessarily be new enough to support it.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

I guess, we discussed this patch in your previous post.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h
> b/arch/arm/mach-omap2/include/mach/omap4-common.h
> index 5b0270b..68ce058 100644
> --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
> +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
> @@ -17,8 +17,13 @@
>   * wfi used in low power code. Directly opcode is used instead
>   * of instruction to avoid mulit-omap build break
>   */
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define do_wfi()			\
> +		__asm__ __volatile__ ("wfi" : : : "memory")
> +#else
>  #define do_wfi()			\
>  		__asm__ __volatile__ (".word	0xe320f003" : : :
> "memory")
> +#endif
>
>  #ifdef CONFIG_CACHE_L2X0
>  extern void __iomem *l2cache_base;
> --
> 1.7.1
