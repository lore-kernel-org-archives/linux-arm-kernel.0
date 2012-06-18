From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 18 Jun 2012 16:39:53 +0800
Subject: [PATCH 15/16] ARM: fiq: save FIQ_START by passing absolute fiq
 number
In-Reply-To: <1339653587-4832-16-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-16-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120618083952.GF25447@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:46PM +0800, Shawn Guo wrote:
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
> Though FIQ_START is defined in above 5 platforms, a grep on the whole
> tree only reports the following users of enable_fiq/disable_fiq.
> 
>   arch/arm/mach-rpc/dma.c
>   drivers/media/video/mx1_camera.c
>   sound/soc/fsl/imx-pcm-fiq.c
> 
> That said, only rpc and imx are actually using enable_fiq/disable_fiq.
> 
> The patch changes enable_fiq/disable_fiq a little bit to have the
> absolute fiq number than offset passed into by parameter "fiq".  While
> fiq on imx starts from 0, only rpc needs a fix-up to adapt the change.
> 
> With this change, all those FIQ_START definitions in platform irqs.h
> can be removed now, but we chose to leave the decision to platform
> maintainers, it should be removed or just left there as a document
> on where fiq starts on the platform.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/kernel/fiq.c                 |    4 ++--
>  arch/arm/mach-rpc/include/mach/irqs.h |   12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
> index c32f845..5953bea 100644
> --- a/arch/arm/kernel/fiq.c
> +++ b/arch/arm/kernel/fiq.c
> @@ -124,12 +124,12 @@ void release_fiq(struct fiq_handler *f)
>  
>  void enable_fiq(int fiq)
>  {
> -	enable_irq(fiq + FIQ_START);
> +	enable_irq(fiq);
>  }
>  
>  void disable_fiq(int fiq)
>  {
> -	disable_irq(fiq + FIQ_START);
> +	disable_irq(fiq);
>  }
>  

I don't know why we put FIQ_START in fiq.c, but this looks like a reasonable
solution, so:
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Also waiting for other people's comments.

Regards
Dong Aisheng
