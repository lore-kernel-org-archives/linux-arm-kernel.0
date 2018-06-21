From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 21 Jun 2018 11:33:44 +0200
Subject: [PATCH 4/9] media: cedrus: make engine type more generic
In-Reply-To: <20180613140714.1686-5-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-5-maxime.ripard@bootlin.com>
Message-ID: <4fcfed23bfae158699c23329f92d6f2e968dc062.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> The sunxi_cedrus_engine enum actually enumerates pretty much the codecs to
> use (or we can easily infer the codec engine from the codec).
> 
> Since we will need the codec type as well in some later refactoring, make
> that structure more useful by just enumerating the codec, and converting
> the existing users.

With the comment below taken in account, this is:

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h | 6 ++++++
>  drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c     | 6 +++---
>  drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h     | 6 +-----
>  drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c  | 2 +-
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> index b1ed1c8cb130..a5f83c452006 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> @@ -61,6 +61,12 @@ struct sunxi_cedrus_run {
>  	};
>  };
>  
> +enum sunxi_cedrus_codec {

Feel free to rename to cedrus_codec when rebasing on top of the latest
patchset introducing the driver.

Cheers,

Paul

> +	SUNXI_CEDRUS_CODEC_MPEG2,
> +
> +	SUNXI_CEDRUS_CODEC_LAST,
> +};
> +
>  struct sunxi_cedrus_ctx {
>  	struct v4l2_fh fh;
>  	struct sunxi_cedrus_dev	*dev;
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> index fc688a5c1ea3..bb46a01214e0 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.c
> @@ -41,7 +41,7 @@
>  #define SYSCON_SRAM_C1_MAP_VE	0x7fffffff
>  
>  int sunxi_cedrus_engine_enable(struct sunxi_cedrus_dev *dev,
> -			       enum sunxi_cedrus_engine engine)
> +			       enum sunxi_cedrus_codec codec)
>  {
>  	u32 reg = 0;
>  
> @@ -53,8 +53,8 @@ int sunxi_cedrus_engine_enable(struct sunxi_cedrus_dev *dev,
>  
>  	reg |= VE_CTRL_CACHE_BUS_BW_128;
>  
> -	switch (engine) {
> -	case SUNXI_CEDRUS_ENGINE_MPEG:
> +	switch (codec) {
> +	case SUNXI_CEDRUS_CODEC_MPEG2:
>  		reg |= VE_CTRL_DEC_MODE_MPEG;
>  		break;
>  
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h
> index 34f3fae462a8..3236c80bfcf4 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_hw.h
> @@ -23,12 +23,8 @@
>  #ifndef _SUNXI_CEDRUS_HW_H_
>  #define _SUNXI_CEDRUS_HW_H_
>  
> -enum sunxi_cedrus_engine {
> -	SUNXI_CEDRUS_ENGINE_MPEG,
> -};
> -
>  int sunxi_cedrus_engine_enable(struct sunxi_cedrus_dev *dev,
> -			       enum sunxi_cedrus_engine engine);
> +			       enum sunxi_cedrus_codec codec);
>  void sunxi_cedrus_engine_disable(struct sunxi_cedrus_dev *dev);
>  
>  int sunxi_cedrus_hw_probe(struct sunxi_cedrus_dev *dev);
> diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
> index 5be3e3b9ceef..85e6fc2fbdb2 100644
> --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
> +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
> @@ -83,7 +83,7 @@ void sunxi_cedrus_mpeg2_setup(struct sunxi_cedrus_ctx *ctx,
>  	}
>  
>  	/* Activate MPEG engine. */
> -	sunxi_cedrus_engine_enable(dev, SUNXI_CEDRUS_ENGINE_MPEG);
> +	sunxi_cedrus_engine_enable(dev, SUNXI_CEDRUS_CODEC_MPEG2);
>  
>  	/* Set quantization matrices. */
>  	for (i = 0; i < 64; i++) {
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180621/8ee3cf01/attachment-0001.sig>
