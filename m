From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 07 Dec 2016 16:47:34 +0200
Subject: [PATCH v5 3/5] [media] davinci: vpif_capture: fix start/stop
 streaming locking
In-Reply-To: <20161207050826.23174-4-khilman@baylibre.com>
References: <20161207050826.23174-1-khilman@baylibre.com>
 <20161207050826.23174-4-khilman@baylibre.com>
Message-ID: <5753609.tAY8Gxp3ld@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Thank you for the patch.

On Tuesday 06 Dec 2016 21:08:24 Kevin Hilman wrote:
> Video capture subdevs may be over I2C and may sleep during xfer, so we
> cannot do IRQ-disabled locking when calling the subdev.
> 
> The IRQ-disabled locking is meant to protect the DMA queue list
> throughout the rest of the driver, so update the locking in
> [start|stop]_streaming to protect just this list.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

I would also add a comment to document the irqlock field as protecting the 
dma_queue list only. Something like

-	/* Used in video-buf */
+	/* Protects the dma_queue field */
	spinlock_t irqlock;

With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/davinci/vpif_capture.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/davinci/vpif_capture.c
> b/drivers/media/platform/davinci/vpif_capture.c index
> c24049acd40a..f72a719efb3d 100644
> --- a/drivers/media/platform/davinci/vpif_capture.c
> +++ b/drivers/media/platform/davinci/vpif_capture.c
> @@ -179,8 +179,6 @@ static int vpif_start_streaming(struct vb2_queue *vq,
> unsigned int count) unsigned long addr, flags;
>  	int ret;
> 
> -	spin_lock_irqsave(&common->irqlock, flags);
> -
>  	/* Initialize field_id */
>  	ch->field_id = 0;
> 
> @@ -211,6 +209,7 @@ static int vpif_start_streaming(struct vb2_queue *vq,
> unsigned int count) vpif_config_addr(ch, ret);
> 
>  	/* Get the next frame from the buffer queue */
> +	spin_lock_irqsave(&common->irqlock, flags);
>  	common->cur_frm = common->next_frm = list_entry(common-
>dma_queue.next,
>  				    struct vpif_cap_buffer, list);
>  	/* Remove buffer from the buffer queue */
> @@ -244,6 +243,7 @@ static int vpif_start_streaming(struct vb2_queue *vq,
> unsigned int count) return 0;
> 
>  err:
> +	spin_lock_irqsave(&common->irqlock, flags);
>  	list_for_each_entry_safe(buf, tmp, &common->dma_queue, list) {
>  		list_del(&buf->list);
>  		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
> @@ -287,7 +287,6 @@ static void vpif_stop_streaming(struct vb2_queue *vq)
>  		vpif_dbg(1, debug, "stream off failed in subdev\n");
> 
>  	/* release all active buffers */
> -	spin_lock_irqsave(&common->irqlock, flags);
>  	if (common->cur_frm == common->next_frm) {
>  		vb2_buffer_done(&common->cur_frm->vb.vb2_buf,
>  				VB2_BUF_STATE_ERROR);
> @@ -300,6 +299,7 @@ static void vpif_stop_streaming(struct vb2_queue *vq)
>  					VB2_BUF_STATE_ERROR);
>  	}
> 
> +	spin_lock_irqsave(&common->irqlock, flags);
>  	while (!list_empty(&common->dma_queue)) {
>  		common->next_frm = list_entry(common->dma_queue.next,
>  						struct vpif_cap_buffer, list);

-- 
Regards,

Laurent Pinchart
