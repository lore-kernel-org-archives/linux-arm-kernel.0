From: k.debski@samsung.com (Kamil Debski)
Date: Thu, 04 Feb 2016 15:23:02 +0100
Subject: [PATCH 3/4] [media] s5p-mfc: don't close instance after free
 OUTPUT buffers
In-Reply-To: <1454180017-29071-4-git-send-email-ayaka@soulik.info>
References: <1454180017-29071-1-git-send-email-ayaka@soulik.info>
 <1454180017-29071-4-git-send-email-ayaka@soulik.info>
Message-ID: <003501d15f57$8f1904b0$ad4b0e10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: ayaka [mailto:ayaka at soulik.info]
> Sent: Saturday, January 30, 2016 7:54 PM
>
> Free buffers in OUTPUT is quite normal to detect the driver's buffer
capacity,
> it doesn't mean the application want to close that mfc instance.
> 
> Signed-off-by: ayaka <ayaka@soulik.info>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> index aebe4fd..609b17b 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> @@ -474,7 +474,6 @@ static int reqbufs_output(struct s5p_mfc_dev *dev,
> struct s5p_mfc_ctx *ctx,
>  		ret = vb2_reqbufs(&ctx->vq_src, reqbufs);
>  		if (ret)
>  			goto out;
> -		s5p_mfc_close_mfc_inst(dev, ctx);
>  		ctx->src_bufs_cnt = 0;
>  		ctx->output_state = QUEUE_FREE;
>  	} else if (ctx->output_state == QUEUE_FREE) {

What exactly do you mean by "detecting buffer capacity"  ? Is it the max
number of buffer
that can be allocated?

Anyway, if the instance is not closed, then in a consecutive call to reqbufs
(with cound != 0)
the instance will be opened for a second time. So either the instance has to
be closed, or
it should be opened in another place.

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland
