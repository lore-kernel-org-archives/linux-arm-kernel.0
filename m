From: k.debski@samsung.com (Kamil Debski)
Date: Mon, 14 Jul 2014 16:07:56 +0200
Subject: [PATCH] s5p-mfc: limit the size of the CPB
In-Reply-To: <1405336698-3873-1-git-send-email-panpan1.liu@samsung.com>
References: <1405336698-3873-1-git-send-email-panpan1.liu@samsung.com>
Message-ID: <126d01cf9f6d$038b82c0$0aa28840$%debski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: panpan liu [mailto:panpan1.liu at samsung.com]
> Sent: Monday, July 14, 2014 1:18 PM
> Subject: [PATCH] s5p-mfc: limit the size of the CPB
> 
> The register of the CPB limits the size. The max size is 4M, so it
> is more reasonable.

The commit message should be rephrased as well. It is no longer fixed
to 4MB.

"The CPB size is limited by the hardware. Add this limit to the s_fmt."

> 
> 
> Signed-off-by: panpan liu <panpan1.liu@samsung.com>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>  mode change 100644 => 100755 drivers/media/platform/s5p-
> mfc/s5p_mfc_dec.c
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> old mode 100644
> new mode 100755
> index 0bae907..70b9458
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> @@ -413,7 +413,8 @@ static int vidioc_s_fmt(struct file *file, void
> *priv, struct v4l2_format *f)
>  	int ret = 0;
>  	struct s5p_mfc_fmt *fmt;
>  	struct v4l2_pix_format_mplane *pix_mp;
> -
> +	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
> +
>  	mfc_debug_enter();
>  	ret = vidioc_try_fmt(file, priv, f);
>  	pix_mp = &f->fmt.pix_mp;
> @@ -466,11 +467,13 @@ static int vidioc_s_fmt(struct file *file, void
> *priv, struct v4l2_format *f)
>  	mfc_debug(2, "The codec number is: %d\n", ctx->codec_mode);
>  	pix_mp->height = 0;
>  	pix_mp->width = 0;
> -	if (pix_mp->plane_fmt[0].sizeimage)
> -		ctx->dec_src_buf_size = pix_mp->plane_fmt[0].sizeimage;
> -	else
> +	if (pix_mp->plane_fmt[0].sizeimage == 0)
>  		pix_mp->plane_fmt[0].sizeimage = ctx->dec_src_buf_size =
>
DEF_CPB_SIZE;
> +	else if(pix_mp->plane_fmt[0].sizeimage > buf_size->cpb)
> +		ctx->dec_src_buf_size = buf_size->cpb;
> +	else
> +		ctx->dec_src_buf_size = pix_mp->plane_fmt[0].sizeimage;
>  	pix_mp->plane_fmt[0].bytesperline = 0;
>  	ctx->state = MFCINST_INIT;
>  out:
> --
> 1.7.9.5

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland
