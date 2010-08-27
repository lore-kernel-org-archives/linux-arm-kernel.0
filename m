From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 27 Aug 2010 11:07:31 +0200 (CEST)
Subject: [PATCH 4/4] mx2_camera: implement forced termination of active
	buffer for mx25
In-Reply-To: <967af81dac1c4c7627b18b5eec23a258ac7d9cd2.1280229966.git.baruch@tkos.co.il>
References: <cover.1280229966.git.baruch@tkos.co.il>
	<967af81dac1c4c7627b18b5eec23a258ac7d9cd2.1280229966.git.baruch@tkos.co.il>
Message-ID: <Pine.LNX.4.64.1008271054060.28043@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch

On Tue, 27 Jul 2010, Baruch Siach wrote:

> This allows userspace to terminate a capture without waiting for the current
> frame to complete.

This is an improvement, not a fix, right? Without this patch the 
termination just have to wait a couple of ms longer? so, it is ok to 
schedule it for 2.6.37?

Thanks
Guennadi

> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/media/video/mx2_camera.c |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/video/mx2_camera.c b/drivers/media/video/mx2_camera.c
> index d327d11..396542b 100644
> --- a/drivers/media/video/mx2_camera.c
> +++ b/drivers/media/video/mx2_camera.c
> @@ -648,15 +648,27 @@ static void mx2_videobuf_release(struct videobuf_queue *vq,
>  	 * Terminate only queued but inactive buffers. Active buffers are
>  	 * released when they become inactive after videobuf_waiton().
>  	 *
> -	 * FIXME: implement forced termination of active buffers, so that the
> -	 * user won't get stuck in an uninterruptible state. This requires a
> -	 * specific handling for each of the three DMA types that this driver
> -	 * supports.
> +	 * FIXME: implement forced termination of active buffers for mx27 and 
> +	 * mx27 eMMA, so that the user won't get stuck in an uninterruptible
> +	 * state. This requires a specific handling for each of the these DMA
> +	 * types.
>  	 */
>  	spin_lock_irqsave(&pcdev->lock, flags);
>  	if (vb->state == VIDEOBUF_QUEUED) {
>  		list_del(&vb->queue);
>  		vb->state = VIDEOBUF_ERROR;
> +	} else if (cpu_is_mx25() && vb->state == VIDEOBUF_ACTIVE) {
> +		if (pcdev->fb1_active == buf) {
> +			pcdev->csicr1 &= ~CSICR1_FB1_DMA_INTEN;
> +			writel(0, pcdev->base_csi + CSIDMASA_FB1);
> +			pcdev->fb1_active = NULL;
> +		} else if (pcdev->fb2_active == buf) {
> +			pcdev->csicr1 &= ~CSICR1_FB2_DMA_INTEN;
> +			writel(0, pcdev->base_csi + CSIDMASA_FB2);
> +			pcdev->fb2_active = NULL;
> +		}
> +		writel(pcdev->csicr1, pcdev->base_csi + CSICR1);
> +		vb->state = VIDEOBUF_ERROR;
>  	}
>  	spin_unlock_irqrestore(&pcdev->lock, flags);
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
