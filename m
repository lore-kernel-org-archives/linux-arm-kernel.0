From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 5 Nov 2010 11:37:10 +0100 (CET)
Subject: [PATCH 1/3] ARM mx3_camera: check for DMA engine type
In-Reply-To: <1288949165-13286-2-git-send-email-s.hauer@pengutronix.de>
References: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
	<1288949165-13286-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1011051136000.28289@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Nov 2010, Sascha Hauer wrote:

> We have two dma engines in MX3 systems: The IPU and the SDMA
> engine. We have to check if we got a channel from the correct
> engine before proceeding with a channel.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, since this is a fix and the SDMA is already in the mainline, I can 
pull this via v4l for 37-rc2.

Thanks
Guennadi

> ---
>  drivers/media/video/mx3_camera.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/mx3_camera.c b/drivers/media/video/mx3_camera.c
> index 29c5fc3..aa871c2 100644
> --- a/drivers/media/video/mx3_camera.c
> +++ b/drivers/media/video/mx3_camera.c
> @@ -27,6 +27,7 @@
>  
>  #include <mach/ipu.h>
>  #include <mach/mx3_camera.h>
> +#include <mach/dma.h>
>  
>  #define MX3_CAM_DRV_NAME "mx3-camera"
>  
> @@ -638,6 +639,9 @@ static bool chan_filter(struct dma_chan *chan, void *arg)
>  	struct dma_chan_request *rq = arg;
>  	struct mx3_camera_pdata *pdata;
>  
> +	if (!imx_dma_is_ipu(chan))
> +		return false;
> +
>  	if (!rq)
>  		return false;
>  
> -- 
> 1.7.2.3
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
