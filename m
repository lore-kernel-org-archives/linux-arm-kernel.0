From: k.debski@samsung.com (Kamil Debski)
Date: Mon, 14 Jul 2014 11:29:16 +0200
Subject: [PATCH] s5p-mfc: limit the size of the CPB
In-Reply-To: <1405322547-3216-1-git-send-email-panpan1.liu@samsung.com>
References: <1405322547-3216-1-git-send-email-panpan1.liu@samsung.com>
Message-ID: <122f01cf9f46$15d03f10$4170bd30$%debski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi panpan,

Thank you for your patch, please find my comments inline.

> From: panpan liu [mailto:panpan1.liu at samsung.com]
> Sent: Monday, July 14, 2014 9:22 AM
> 
> The register of the CPB limits the size. The max size is 4M, so it is
> more reasonable.
> 
> Signed-off-by: panpan liu <panpan1.liu@samsung.com>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)  mode change 100644 =>
> 100755 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> old mode 100644
> new mode 100755
> index 0bae907..889cb06
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> @@ -466,7 +466,8 @@ static int vidioc_s_fmt(struct file *file, void
> *priv, struct v4l2_format *f)
>  	mfc_debug(2, "The codec number is: %d\n", ctx->codec_mode);
>  	pix_mp->height = 0;
>  	pix_mp->width = 0;
> -	if (pix_mp->plane_fmt[0].sizeimage)
> +	if (pix_mp->plane_fmt[0].sizeimage &&
> +			pix_mp->plane_fmt[0].sizeimage <= MAX_CPB_SIZE)

The MAX_CPB_SIZE applies only to the v5 version of the MFC. To have this
dependent on the actual variant used please use:
...
struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
...
if (pix_mp->plane_fmt[0].sizeimage &&
	pix_mp->plane_fmt[0].sizeimage <= buf_size->cpb)
...

>  		ctx->dec_src_buf_size = pix_mp->plane_fmt[0].sizeimage;
>  	else
>  		pix_mp->plane_fmt[0].sizeimage = ctx->dec_src_buf_size =

Also, in case the desired buffer size is too large the driver should set
the maximum size allowed and not the default size which is fairly small.

So you should cover three cases:
- no size set -> set default size
- size set < max - set the desired size
- size set > max - set the maximum size allowed

Best wishes, 
-- 
Kamil Debski
Samsung R&D Institute Poland
