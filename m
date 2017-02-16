From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 16 Feb 2017 10:19:25 -0800
Subject: [PATCH v4 36/36] media: imx: propagate sink pad formats to source
 pads
In-Reply-To: <1487244568.2377.36.camel@pengutronix.de>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-37-git-send-email-steve_longerbeam@mentor.com>
 <1487244568.2377.36.camel@pengutronix.de>
Message-ID: <5512bed2-375b-ae31-f210-3fff4c0417c7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/16/2017 03:29 AM, Philipp Zabel wrote:
> On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
> [...]
>> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
>> index dd9d499..c43f85f 100644
>> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
>> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
>> @@ -806,16 +806,22 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
>>  	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
>>  		cfg->try_fmt = sdformat->format;
>>  	} else {
>> -		priv->format_mbus[sdformat->pad] = sdformat->format;
>> +		struct v4l2_mbus_framefmt *f =
>> +			&priv->format_mbus[sdformat->pad];
>> +		struct v4l2_mbus_framefmt *outf =
>> +			&priv->format_mbus[PRPENCVF_SRC_PAD];
>> +
>> +		*f = sdformat->format;
>>  		priv->cc[sdformat->pad] = cc;
>> -		if (sdformat->pad == PRPENCVF_SRC_PAD) {
>> -			/*
>> -			 * update the capture device format if this is
>> -			 * the IDMAC output pad
>> -			 */
>> -			imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix,
>> -						      &sdformat->format, cc);
>> +
>> +		/* propagate format to source pad */
>> +		if (sdformat->pad == PRPENCVF_SINK_PAD) {
>> +			outf->width = f->width;
>> +			outf->height = f->height;
>
> What about media bus format, field, and colorimetry?

Right, I need to propagate a default media bus format and field
that works.

As for colorimtery, I did see the work you are doing in your
branch, but was not sure if you were finished with that support.
Can you send me a patch?

>
>>  		}
>> +
>> +		/* update the capture device format from output pad */
>> +		imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix, outf, cc);
>>  	}
>>
>>  	return 0;
>> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
>> index 3e6b607..9d9ec03 100644
>> --- a/drivers/staging/media/imx/imx-media-csi.c
>> +++ b/drivers/staging/media/imx/imx-media-csi.c
>> @@ -1161,19 +1161,27 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
>>  	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
>>  		cfg->try_fmt = sdformat->format;
>>  	} else {
>> +		struct v4l2_mbus_framefmt *f_direct, *f_idmac;
>> +
>>  		priv->format_mbus[sdformat->pad] = sdformat->format;
>>  		priv->cc[sdformat->pad] = cc;
>> -		/* Reset the crop window if this is the input pad */
>> -		if (sdformat->pad == CSI_SINK_PAD)
>> +
>> +		f_direct = &priv->format_mbus[CSI_SRC_PAD_DIRECT];
>> +		f_idmac = &priv->format_mbus[CSI_SRC_PAD_IDMAC];
>> +
>> +		if (sdformat->pad == CSI_SINK_PAD) {
>> +			/* reset the crop window */
>>  			priv->crop = crop;
>> -		else if (sdformat->pad == CSI_SRC_PAD_IDMAC) {
>> -			/*
>> -			 * update the capture device format if this is
>> -			 * the IDMAC output pad
>> -			 */
>> -			imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix,
>> -						      &sdformat->format, cc);
>> +
>> +			/* propagate format to source pads */
>> +			f_direct->width = crop.width;
>> +			f_direct->height = crop.height;
>> +			f_idmac->width = crop.width;
>> +			f_idmac->height = crop.height;
>
> This is missing also media bus format, field and colorimetry
> propagation.

Yep, will add that.

Steve

>
>>  		}
>> +
>> +		/* update the capture device format from IDMAC output pad */
>> +		imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix, f_idmac, cc);
>>  	}
>>
>>  	return 0;
>> diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
>> index 61e6017..55fb522 100644
>> --- a/drivers/staging/media/imx/imx-media-vdic.c
>> +++ b/drivers/staging/media/imx/imx-media-vdic.c
>> @@ -649,8 +649,21 @@ static int vdic_set_fmt(struct v4l2_subdev *sd,
>>  	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
>>  		cfg->try_fmt = sdformat->format;
>>  	} else {
>> -		priv->format_mbus[sdformat->pad] = sdformat->format;
>> +		struct v4l2_mbus_framefmt *f =
>> +			&priv->format_mbus[sdformat->pad];
>> +		struct v4l2_mbus_framefmt *outf =
>> +			&priv->format_mbus[VDIC_SRC_PAD_DIRECT];
>> +
>> +		*f = sdformat->format;
>>  		priv->cc[sdformat->pad] = cc;
>> +
>> +		/* propagate format to source pad */
>> +		if (sdformat->pad == VDIC_SINK_PAD_DIRECT ||
>> +		    sdformat->pad == VDIC_SINK_PAD_IDMAC) {
>> +			outf->width = f->width;
>> +			outf->height = f->height;
>> +			outf->field = V4L2_FIELD_NONE;
>
> This is missing colorimetry, too.
>
> regards
> Philipp
>
