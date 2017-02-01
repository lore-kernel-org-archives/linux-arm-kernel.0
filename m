From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 31 Jan 2017 17:40:18 -0800
Subject: [PATCH v3 17/24] media: imx: Add CSI subdev driver
In-Reply-To: <1485881287.2932.73.camel@pengutronix.de>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-18-git-send-email-steve_longerbeam@mentor.com>
 <1485877882.2932.70.camel@pengutronix.de>
 <1485881287.2932.73.camel@pengutronix.de>
Message-ID: <3813b482-49e8-10e0-8197-864ad84eff95@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/31/2017 08:48 AM, Philipp Zabel wrote:
> On Tue, 2017-01-31 at 16:51 +0100, Philipp Zabel wrote:
>> On Fri, 2017-01-06 at 18:11 -0800, Steve Longerbeam wrote:
>> [...]
>>> +static int csi_set_fmt(struct v4l2_subdev *sd,
>>> +		       struct v4l2_subdev_pad_config *cfg,
>>> +		       struct v4l2_subdev_format *sdformat)
>>> +{
>>> +	struct csi_priv *priv = v4l2_get_subdevdata(sd);
>>> +	struct v4l2_mbus_framefmt *infmt, *outfmt;
>>> +	struct v4l2_rect crop;
>>> +	int ret;
>>> +
>>> +	if (sdformat->pad >= CSI_NUM_PADS)
>>> +		return -EINVAL;
>>> +
>>> +	if (priv->stream_on)
>>> +		return -EBUSY;
>>> +
>>> +	infmt = &priv->format_mbus[priv->input_pad];
>>> +	outfmt = &priv->format_mbus[priv->output_pad];
>>> +
>>> +	if (sdformat->pad == priv->output_pad) {
>>> +		sdformat->format.code = infmt->code;
>>> +		sdformat->format.field = infmt->field;
>>> +		crop.left = priv->crop.left;
>>> +		crop.top = priv->crop.top;
>>> +		crop.width = sdformat->format.width;
>>> +		crop.height = sdformat->format.height;
>>> +		ret = csi_try_crop(priv, &crop);
>> This is the wrong way around, see also below.
>>
>> Here the the output sdformat->format.width/height should be set to the
>> priv->crop.width/height (or priv->crop.width/height / 2, to enable
>> downscaling). The crop rectangle should not be changed by an output pad
>> set_fmt.
> [...]
>> The crop rectangle instead should be reset to the full input frame when
>> the input pad format is set.
> How about this:

Thanks for the patch, I'll try it tomorrow.

Steve

>
> ----------8<----------
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 5e80a0871b139..8220e4204a125 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -484,6 +484,8 @@ static int csi_setup(struct csi_priv *priv)
>   	if_fmt.field = outfmt->field;
>   
>   	ipu_csi_set_window(priv->csi, &priv->crop);
> +	ipu_csi_set_downsize(priv->csi, priv->crop.width == 2 * outfmt->width,
> +					priv->crop.height == 2 * outfmt->height);
>   
>   	ipu_csi_init_interface(priv->csi, &sensor_mbus_cfg, &if_fmt);
>   
> @@ -830,15 +832,14 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
>   	switch (sdformat->pad) {
>   	case CSI_SRC_PAD_DIRECT:
>   	case CSI_SRC_PAD_IDMAC:
> -		crop.left = priv->crop.left;
> -		crop.top = priv->crop.top;
> -		crop.width = sdformat->format.width;
> -		crop.height = sdformat->format.height;
> -		ret = csi_try_crop(priv, &crop, sensor);
> -		if (ret)
> -			return ret;
> -		sdformat->format.width = crop.width;
> -		sdformat->format.height = crop.height;
> +		if (sdformat->format.width < priv->crop.width * 3 / 4)
> +			sdformat->format.width = priv->crop.width / 2;
> +		else
> +			sdformat->format.width = priv->crop.width;
> +		if (sdformat->format.height < priv->crop.height * 3 / 4)
> +			sdformat->format.height = priv->crop.height / 2;
> +		else
> +			sdformat->format.height = priv->crop.height;
>   
>   		if (sdformat->pad == CSI_SRC_PAD_IDMAC) {
>   			cc = imx_media_find_format(0, sdformat->format.code,
> @@ -887,6 +888,14 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
>   		}
>   		break;
>   	case CSI_SINK_PAD:
> +		crop.left = 0;
> +		crop.top = 0;
> +		crop.width = sdformat->format.width;
> +		crop.height = sdformat->format.height;
> +		ret = csi_try_crop(priv, &crop, sensor);
> +		if (ret)
> +			return ret;
> +
>   		cc = imx_media_find_format(0, sdformat->format.code,
>   					   true, false);
>   		if (!cc) {
> @@ -904,9 +913,8 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
>   	} else {
>   		priv->format_mbus[sdformat->pad] = sdformat->format;
>   		priv->cc[sdformat->pad] = cc;
> -		/* Update the crop window if this is an output pad  */
> -		if (sdformat->pad == CSI_SRC_PAD_DIRECT ||
> -		    sdformat->pad == CSI_SRC_PAD_IDMAC)
> +		/* Reset the crop window if this is the input pad  */
> +		if (sdformat->pad == CSI_SINK_PAD)
>   			priv->crop = crop;
>   	}
>   
> ---------->8----------
>
> regards
> Philipp
