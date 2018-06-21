From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 21 Jun 2018 17:38:23 +0200
Subject: [PATCH 8/9] media: cedrus: Add start and stop decoder operations
In-Reply-To: <20180613140714.1686-9-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-9-maxime.ripard@bootlin.com>
Message-ID: <f37f23580c92728bbcd5bfe3fff506b5bb2bdfd0.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> Some codec needs to perform some additional task when a decoding is started
> and stopped, and not only at every frame.
> 
> For example, the H264 decoding support needs to allocate buffers that will
> be used in the decoding process, but do not need to change over time, or at
> each frame.
> 
> In order to allow that for codecs, introduce a start and stop hook that
> will be called if present at start_streaming and stop_streaming time.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../platform/sunxi/cedrus/sunxi_cedrus_common.h    |  2 ++
>  .../platform/sunxi/cedrus/sunxi_cedrus_video.c     | 14 +++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> index a2a507eb9fc9..20c78ec1f037 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> @@ -120,6 +120,8 @@ struct sunxi_cedrus_dec_ops {
>  	enum sunxi_cedrus_irq_status (*irq_status)(struct sunxi_cedrus_ctx *ctx);
>  	void (*setup)(struct sunxi_cedrus_ctx *ctx,
>  		      struct sunxi_cedrus_run *run);
> +	int (*start)(struct sunxi_cedrus_ctx *ctx);
> +	void (*stop)(struct sunxi_cedrus_ctx *ctx);
>  	void (*trigger)(struct sunxi_cedrus_ctx *ctx);
>  };
>  
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c
> index fb7b081a5bb7..d93461178857 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_video.c
> @@ -416,6 +416,8 @@ static int sunxi_cedrus_buf_prepare(struct vb2_buffer *vb)
>  static int sunxi_cedrus_start_streaming(struct vb2_queue *q, unsigned int count)
>  {
>  	struct sunxi_cedrus_ctx *ctx = vb2_get_drv_priv(q);
> +	struct sunxi_cedrus_dev *dev = ctx->dev;
> +	int ret = 0;
>  
>  	switch (ctx->vpu_src_fmt->fourcc) {
>  	case V4L2_PIX_FMT_MPEG2_FRAME:
> @@ -425,16 +427,26 @@ static int sunxi_cedrus_start_streaming(struct vb2_queue *q, unsigned int count)
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> +	if (V4L2_TYPE_IS_OUTPUT(q->type) &&

I suppose this check was put in place to ensure that ->start is only
called once, but what if start_streaming is called multiple times on
output? Am I totally unsure about whether the API guarantees that we
only get one start_streaming call per buffer queue, regardless of how
many userspace issues.

If we don't have such a guarantee, we probably need an internal
mechanism to avoid having ->start called more than once.

> +	    dev->dec_ops[ctx->current_codec]->start)
> +		ret = dev->dec_ops[ctx->current_codec]->start(ctx);
> +
> +	return ret;
>  }
>  
>  static void sunxi_cedrus_stop_streaming(struct vb2_queue *q)
>  {
>  	struct sunxi_cedrus_ctx *ctx = vb2_get_drv_priv(q);
> +	struct sunxi_cedrus_dev *dev = ctx->dev;
>  	struct vb2_v4l2_buffer *vbuf;
>  	unsigned long flags;
>  
>  	flush_scheduled_work();
> +
> +	if (V4L2_TYPE_IS_OUTPUT(q->type) &&

Ditto.

Cheers,

Paul

> +	    dev->dec_ops[ctx->current_codec]->stop)
> +		dev->dec_ops[ctx->current_codec]->stop(ctx);
> +
>  	for (;;) {
>  		spin_lock_irqsave(&ctx->dev->irq_lock, flags);
>  
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180621/ce39ae6b/attachment.sig>
