From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 4 Mar 2010 18:13:38 +0100 (CET)
Subject: [PATCH] V4L/DVB: mx1-camera: compile fix
In-Reply-To: <1267721687-19697-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1267721687-19697-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1003041811160.4825@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe

On Thu, 4 Mar 2010, Uwe Kleine-K?nig wrote:

> This is a regression of
> 
> 	7d58289 (mx1: prefix SOC specific defines with MX1_ and deprecate old names)
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this went unnoticed up to now as mx1_defconfig doesn't include support
> for mx1-camera.
> I have a patch pending to change that though.
> 
> Best regards
> Uwe
> 
>  drivers/media/video/mx1_camera.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/media/video/mx1_camera.c b/drivers/media/video/mx1_camera.c
> index 2ba14fb..38e5315 100644
> --- a/drivers/media/video/mx1_camera.c
> +++ b/drivers/media/video/mx1_camera.c
> @@ -45,6 +45,9 @@
>  #include <mach/hardware.h>
>  #include <mach/mx1_camera.h>
>  
> +#undef DMA_BASE 
> +#define DMA_BASE MX1_IO_ADDRESS(MX1_DMA_BASE_ADDR)

I don't like this. Why the "undef"? Is DMA_BASE already defined? where and 
what is it? If it is - we better use a different name, if not - just 
remove the undef, please.

> +
>  /*
>   * CSI registers
>   */
> @@ -783,7 +786,7 @@ static int __init mx1_camera_probe(struct platform_device *pdev)
>  			       pcdev);
>  
>  	imx_dma_config_channel(pcdev->dma_chan, IMX_DMA_TYPE_FIFO,
> -			       IMX_DMA_MEMSIZE_32, DMA_REQ_CSI_R, 0);
> +			       IMX_DMA_MEMSIZE_32, MX1_DMA_REQ_CSI_R, 0);
>  	/* burst length : 16 words = 64 bytes */
>  	imx_dma_config_burstlen(pcdev->dma_chan, 0);
>  
> -- 
> 1.7.0
> 

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
