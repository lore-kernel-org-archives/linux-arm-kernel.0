From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 21 Mar 2017 16:56:52 -0700
Subject: [PATCH v5 38/39] media: imx: csi: fix crop rectangle reset in
 sink set_fmt
In-Reply-To: <20170321112741.GV21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-39-git-send-email-steve_longerbeam@mentor.com>
 <20170319152233.GW21222@n2100.armlinux.org.uk>
 <327d67d9-68c1-7f74-0c0f-f6aee1c4b546@gmail.com>
 <1490010926.2917.59.camel@pengutronix.de>
 <20170320120855.GH21222@n2100.armlinux.org.uk>
 <1490018451.2917.86.camel@pengutronix.de>
 <20170320141705.GL21222@n2100.armlinux.org.uk>
 <1490030604.2917.103.camel@pengutronix.de>
 <20170321112741.GV21222@n2100.armlinux.org.uk>
Message-ID: <1d382b89-fac3-a413-55a3-06cd2b751322@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/21/2017 04:27 AM, Russell King - ARM Linux wrote:
> On Mon, Mar 20, 2017 at 06:23:24PM +0100, Philipp Zabel wrote:
>> @@ -1173,15 +1196,8 @@ static void csi_try_fmt(struct csi_priv *priv,
>>  		incc = imx_media_find_mbus_format(infmt->code,
>>  						  CS_SEL_ANY, true);
>>
>> -		if (sdformat->format.width < priv->crop.width * 3 / 4)
>> -			sdformat->format.width = priv->crop.width / 2;
>> -		else
>> -			sdformat->format.width = priv->crop.width;
>> -
>> -		if (sdformat->format.height < priv->crop.height * 3 / 4)
>> -			sdformat->format.height = priv->crop.height / 2;
>> -		else
>> -			sdformat->format.height = priv->crop.height;
>> +		sdformat->format.width = compose->width;
>> +		sdformat->format.height = compose->height;
>>
>>  		if (incc->bayer) {
>>  			sdformat->format.code = infmt->code;
>
> We need to do more in here, because right now setting the source pads
> overwrites the colorimetry etc information.  Maybe something like the
> below?

I'm thinking, to support propagating the colorimetry params, there
should be a util function

void imx_media_copy_colorimetry(struct v4l2_mbus_framefmt *out,
				struct v4l2_mbus_framefmt *in);

that can be used throughout the pipeline, that does exactly what
you add below.

>  I'm wondering if it would be a saner approach to copy the
> sink format and update the parameters that can be changed, rather than
> trying to list all the parameters that shouldn't be changed.

For CSI that is a bit difficult, because the source formats are
hardly related to the sink formats, so so much would have to be
modified after copying the sink format that it would be rather
pointless, except to forward the colorimetry params.

Steve

>  What if the format structure gains a new member?
>
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 1492b92e1970..756204ced53c 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1221,6 +1221,12 @@ static void csi_try_fmt(struct csi_priv *priv,
>  			sdformat->format.field =  (infmt->height == 480) ?
>  				V4L2_FIELD_SEQ_TB : V4L2_FIELD_SEQ_BT;
>  		}
> +
> +		/* copy settings we can't change */
> +		sdformat->format.colorspace = infmt->colorspace;
> +		sdformat->format.ycbcr_enc = infmt->ycbcr_enc;
> +		sdformat->format.quantization = infmt->quantization;
> +		sdformat->format.xfer_func = infmt->xfer_func;
>  		break;
>  	case CSI_SINK_PAD:
>  		v4l_bound_align_image(&sdformat->format.width, MIN_W, MAX_W,
>
>
>
