From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 27 Jul 2018 15:56:45 +0200
Subject: [PATCH 9/9] media: cedrus: Add H264 decoding support
In-Reply-To: <20180613140714.1686-10-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-10-maxime.ripard@bootlin.com>
Message-ID: <8c0b2fbec0302a15292d3629570ab1268fd306b8.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> Introduce some basic H264 decoding support in cedrus. So far, only the
> baseline profile videos have been tested, and some more advanced features
> used in higher profiles are not even implemented.

Here are two specific comments about things I noticed when going through
the h264 code.

[...]

> @@ -88,12 +101,37 @@ struct sunxi_cedrus_ctx {
>  	struct work_struct run_work;
>  	struct list_head src_list;
>  	struct list_head dst_list;
> +
> +	union {
> +		struct {
> +			void		*mv_col_buf;
> +			dma_addr_t	mv_col_buf_dma;
> +			ssize_t		mv_col_buf_size;
> +			void		*neighbor_info_buf;
> +			dma_addr_t	neighbor_info_buf_dma;

Should be "neighbour" instead of "neighbor" and the same applies to most
variables related to this, as well as the register description.

[...]

> +static int sunxi_cedrus_h264_start(struct sunxi_cedrus_ctx *ctx)
> +{
> +	struct sunxi_cedrus_dev *dev = ctx->dev;
> +	int ret;
> +
> +	ctx->codec.h264.pic_info_buf =
> +		dma_alloc_coherent(dev->dev, SUNXI_CEDRUS_PIC_INFO_BUF_SIZE,
> +				   &ctx->codec.h264.pic_info_buf_dma,
> +				   GFP_KERNEL);
> +	if (!ctx->codec.h264.pic_info_buf)
> +		return -ENOMEM;
> +
> +	ctx->codec.h264.neighbor_info_buf =
> +		dma_alloc_coherent(dev->dev, SUNXI_CEDRUS_NEIGHBOR_INFO_BUF_SIZE,
> +				   &ctx->codec.h264.neighbor_info_buf_dma,
> +				   GFP_KERNEL);
> +	if (!ctx->codec.h264.neighbor_info_buf) {
> +		ret = -ENOMEM;
> +		goto err_pic_buf;
> +	}

Although this buffer is allocated here, the resulting address is
apparently never written to the appropriate VPU register (0x54).

Perhaps a write to the aforementioned register was lost along the
development process?

Cheers,

Paul

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/e39f3bdc/attachment.sig>
