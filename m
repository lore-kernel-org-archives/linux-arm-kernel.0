From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Jun 2012 21:07:56 +0800
Subject: [PATCH] ARM: irq: add a mach/fiq.h inclusion for SPARSE_IRQ build
In-Reply-To: <1339592253-25142-1-git-send-email-shawn.guo@linaro.org>
References: <1339592253-25142-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120613130753.GA31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 08:57:33PM +0800, Shawn Guo wrote:
> The commit a2be01b (ARM: only include mach/irqs.h for !SPARSE_IRQ)
> makes mach/irqs.h only be included for !SPARSE_IRQ build.  There are
> a nubmer of platforms have FIQ_START defined in mach/irqs.h.
> 
>   arch/arm/mach-at91/include/mach/irqs.h:#define FIQ_START AT91_ID_FIQ
>   arch/arm/mach-rpc/include/mach/irqs.h:#define FIQ_START         64
>   arch/arm/mach-s3c24xx/include/mach/irqs.h:#define FIQ_START             IRQ_EINT0
>   arch/arm/plat-mxc/include/mach/irqs.h:#define FIQ_START 0
>   arch/arm/plat-omap/include/plat/irqs.h:#define FIQ_START                1024
> 
> If SPARSE_IRQ is enabled for any of these platforms, the following
> compile error will be seen.
> 
>   arch/arm/kernel/fiq.c: In function ?enable_fiq?:
>   arch/arm/kernel/fiq.c:127:19: error: ?FIQ_START? undeclared (first use in this function)
>   arch/arm/kernel/fiq.c:127:19: note: each undeclared identifier is reported only once for each function it appears in
>   arch/arm/kernel/fiq.c: In function ?disable_fiq?:
>   arch/arm/kernel/fiq.c:132:20: error: ?FIQ_START? undeclared (first use in this function)
> 
> So before we can remove the reference to FIQ_START in fiq.c, we need
> a way out.  The patch adds a mach/fiq.h inclusion for SPARSE_IRQ build
> in asm/irq.h, so that platform can have a chance to provide FIQ_START.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/include/asm/irq.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
> index 35c21c3..3fa390d 100644
> --- a/arch/arm/include/asm/irq.h
> +++ b/arch/arm/include/asm/irq.h
> @@ -7,6 +7,7 @@
>  #include <mach/irqs.h>
>  #else
>  #define NR_IRQS NR_IRQS_LEGACY
> +#include <mach/fiq.h>
>  #endif
>  
Damned.  Just realized that this will break those platforms with
SPARSE_IRQ enabled but no mach/fiq.h provided.

Any sensible solution there?

-- 
Regards,
Shawn
