From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 31 Jan 2017 16:51:22 +0100
Subject: [PATCH v3 17/24] media: imx: Add CSI subdev driver
In-Reply-To: <1483755102-24785-18-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-18-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1485877882.2932.70.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-01-06 at 18:11 -0800, Steve Longerbeam wrote:
[...]
> +static int csi_set_fmt(struct v4l2_subdev *sd,
> +		       struct v4l2_subdev_pad_config *cfg,
> +		       struct v4l2_subdev_format *sdformat)
> +{
> +	struct csi_priv *priv = v4l2_get_subdevdata(sd);
> +	struct v4l2_mbus_framefmt *infmt, *outfmt;
> +	struct v4l2_rect crop;
> +	int ret;
> +
> +	if (sdformat->pad >= CSI_NUM_PADS)
> +		return -EINVAL;
> +
> +	if (priv->stream_on)
> +		return -EBUSY;
> +
> +	infmt = &priv->format_mbus[priv->input_pad];
> +	outfmt = &priv->format_mbus[priv->output_pad];
> +
> +	if (sdformat->pad == priv->output_pad) {
> +		sdformat->format.code = infmt->code;
> +		sdformat->format.field = infmt->field;
> +		crop.left = priv->crop.left;
> +		crop.top = priv->crop.top;
> +		crop.width = sdformat->format.width;
> +		crop.height = sdformat->format.height;
> +		ret = csi_try_crop(priv, &crop);

This is the wrong way around, see also below.

Here the the output sdformat->format.width/height should be set to the
priv->crop.width/height (or priv->crop.width/height / 2, to enable
downscaling). The crop rectangle should not be changed by an output pad
set_fmt.

> +		if (ret)
> +			return ret;
> +		sdformat->format.width = crop.width;
> +		sdformat->format.height = crop.height;
> +	}
> +
> +	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
> +		cfg->try_fmt = sdformat->format;
> +	} else {
> +		priv->format_mbus[sdformat->pad] = sdformat->format;
> +		/* Update the crop window if this is output pad  */
> +		if (sdformat->pad == priv->output_pad)
> +			priv->crop = crop;

The crop rectangle instead should be reset to the full input frame when
the input pad format is set.

regards
Philipp
