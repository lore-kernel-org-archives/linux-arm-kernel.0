From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 21 Jun 2018 11:13:19 +0200
Subject: [PATCH 3/9] media: cedrus: Add a macro to check for the
 validity of a control
In-Reply-To: <20180613140714.1686-4-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-4-maxime.ripard@bootlin.com>
Message-ID: <18ffd09bf91908886aebbad127e612775b7f0bf8.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> During our frame decoding setup, we need to check a number of controls to
> make sure that they are properly filled before trying to access them.
> 
> It's not too bad with MPEG2 since there's just a single one, but with the
> upcoming increase of codecs, and the integration of more complex codecs,
> this logic will be duplicated a significant number of times. H264 for
> example uses 4 different controls.
> 
> Add a macro that expands to the proper check in order to reduce the
> duplication.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../platform/sunxi/cedrus/sunxi_cedrus_dec.c     | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
> index 8c92af34ebeb..c19acf9626c4 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
> @@ -110,15 +110,16 @@ void sunxi_cedrus_device_run(void *priv)
>  
>  	spin_lock_irqsave(&ctx->dev->irq_lock, flags);
>  
> +#define CHECK_CONTROL(ctx, ctrl)					\
> +	if (!ctx->ctrls[(ctrl)]) {					\

Although this was not introduced in this patch, I believe this approach
won't work since ctx->ctrls[i] is a pointer returned from
v4l2_ctrl_new_custom(hdl, &cfg, NULL), which will always be non-null
after calling cedrus_init_ctrls.

Perhaps checking ctx->ctrls[i].p_cur.p would be the right thing to
check, but I'm unsure about that.

> +		v4l2_err(&(ctx)->dev->v4l2_dev, "Invalid " #ctrl " control\n"); \
> +		(ctx)->job_abort = 1;					\
> +		goto unlock_complete;					\
> +	}
> +
>  	switch (ctx->vpu_src_fmt->fourcc) {
>  	case V4L2_PIX_FMT_MPEG2_FRAME:
> -		if (!ctx->ctrls[SUNXI_CEDRUS_CTRL_DEC_MPEG2_FRAME_HDR]) {
> -			v4l2_err(&ctx->dev->v4l2_dev,
> -				 "Invalid MPEG2 frame header control\n");
> -			ctx->job_abort = 1;
> -			goto unlock_complete;
> -		}
> -
> +		CHECK_CONTROL(ctx, SUNXI_CEDRUS_CTRL_DEC_MPEG2_FRAME_HDR);
>  		run.mpeg2.hdr = get_ctrl_ptr(ctx, SUNXI_CEDRUS_CTRL_DEC_MPEG2_FRAME_HDR);
>  		sunxi_cedrus_mpeg2_setup(ctx, &run);
>  
> @@ -128,6 +129,7 @@ void sunxi_cedrus_device_run(void *priv)
>  	default:
>  		ctx->job_abort = 1;
>  	}

Maybe add a newline here?

Cheers,

Paul

> +#undef CHECK_CONTROL
>  
>  unlock_complete:
>  	spin_unlock_irqrestore(&ctx->dev->irq_lock, flags);
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180621/b3b35974/attachment.sig>
