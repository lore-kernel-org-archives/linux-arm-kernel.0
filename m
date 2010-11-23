From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 23 Nov 2010 23:54:48 +0100 (CET)
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101011152516.GF27153@n2100.arm.linux.org.uk>
	<1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1011232354180.25676@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Nov 2010, Uwe Kleine-K?nig wrote:

> There is no need to memzero the buffer because dma_alloc_coherent zeros
> the memory for us.
> 
> This fixes:
> 
> 	BUG: Your driver calls ioremap() on system memory.  This leads
> 	<4>to architecturally unpredictable behaviour on ARMv6+, and ioremap()
> 	<4>will fail in the next kernel release.  Please fix your driver.
> 
> Tested-by: Michael Grzeschik <mgr@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> it seems to work this way, still I'd like to have some feedback if this
> is done right.  Russell?
> 
> I assume sending a patch to remove the <4> is just a waste of time,
> isn't it?
> 
> Best regards
> Uwe
> 
>  arch/arm/mach-mx3/mach-pcm037.c |   36 ++++++++++++++++++++----------------
>  1 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
> index 2ff3f66..265757f 100644
> --- a/arch/arm/mach-mx3/mach-pcm037.c
> +++ b/arch/arm/mach-mx3/mach-pcm037.c
> @@ -32,6 +32,7 @@
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
>  #include <linux/gfp.h>
> +#include <linux/memblock.h>
>  
>  #include <media/soc_camera.h>
>  
> @@ -413,29 +414,22 @@ struct mx3_camera_pdata camera_pdata = {
>  	.mclk_10khz	= 2000,
>  };
>  
> +static phys_addr_t mx3_camera_base __initdata;
> +#define MX3_CAMERA_BUF_SIZE SZ_4M
> +
>  static int __init pcm037_camera_alloc_dma(const size_t buf_size)
>  {
> -	dma_addr_t dma_handle;
> -	void *buf;
>  	int dma;
>  
> -	if (buf_size < 2 * 1024 * 1024)
> -		return -EINVAL;
> -
> -	buf = dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);
> -	if (!buf) {
> -		pr_err("%s: cannot allocate camera buffer-memory\n", __func__);
> -		return -ENOMEM;
> -	}
> -
> -	memset(buf, 0, buf_size);
> -
>  	dma = dma_declare_coherent_memory(&mx3_camera.dev,
> -					dma_handle, dma_handle, buf_size,
> +					mx3_camera_base, mx3_camera_base,
> +					MX3_CAMERA_BUF_SIZE,
>  					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
>  
> -	/* The way we call dma_declare_coherent_memory only a malloc can fail */
> -	return dma & DMA_MEMORY_MAP ? 0 : -ENOMEM;

What was wrong with the original return statement?

Thanks
Guennadi

> +	if (!(dma & DMA_MEMORY_MAP))
> +		return -ENOMEM;
> +
> +	return 0;
>  }
>  
>  static struct platform_device *devices[] __initdata = {
> @@ -676,6 +670,15 @@ struct sys_timer pcm037_timer = {
>  	.init	= pcm037_timer_init,
>  };
>  
> +static void __init pcm037_reserve(void)
> +{
> +	/* reserve 4 MiB for mx3-camera */
> +	mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
> +			/* ??? */ MX3_CAMERA_BUF_SIZE);
> +	memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> +	memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> +}
> +
>  MACHINE_START(PCM037, "Phytec Phycore pcm037")
>  	/* Maintainer: Pengutronix */
>  	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
> @@ -683,4 +686,5 @@ MACHINE_START(PCM037, "Phytec Phycore pcm037")
>  	.init_irq       = mx31_init_irq,
>  	.init_machine   = mxc_board_init,
>  	.timer          = &pcm037_timer,
> +	.reserve	= pcm037_reserve,
>  MACHINE_END
> -- 
> 1.7.2.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
