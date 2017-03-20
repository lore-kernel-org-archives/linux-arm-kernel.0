From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 20:47:06 +0000
Subject: [PATCH v5 38/39] media: imx: csi: fix crop rectangle reset in
 sink set_fmt
In-Reply-To: <1490030604.2917.103.camel@pengutronix.de>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-39-git-send-email-steve_longerbeam@mentor.com>
 <20170319152233.GW21222@n2100.armlinux.org.uk>
 <327d67d9-68c1-7f74-0c0f-f6aee1c4b546@gmail.com>
 <1490010926.2917.59.camel@pengutronix.de>
 <20170320120855.GH21222@n2100.armlinux.org.uk>
 <1490018451.2917.86.camel@pengutronix.de>
 <20170320141705.GL21222@n2100.armlinux.org.uk>
 <1490030604.2917.103.camel@pengutronix.de>
Message-ID: <20170320204705.GT21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 06:23:24PM +0100, Philipp Zabel wrote:
> ----------8<----------
> >From 2830aebc404bdfc9d7fc1ec94e5282d0b668e8f6 Mon Sep 17 00:00:00 2001
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Date: Mon, 20 Mar 2017 17:10:21 +0100
> Subject: [PATCH] media: imx: csi: add sink selection rectangles
> 
> Move the crop rectangle to the sink pad and add a sink compose rectangle
> to configure scaling. Also propagate rectangles from sink pad to crop
> rectangle, to compose rectangle, and to the source pads both in ACTIVE
> and TRY variants of set_fmt/selection, and initialize the default crop
> and compose rectangles.

Looks fine for the most part.

> -	/*
> -	 * Modifying the crop rectangle always changes the format on the source
> -	 * pad. If the KEEP_CONFIG flag is set, just return the current crop
> -	 * rectangle.
> -	 */
> -	if (sel->flags & V4L2_SEL_FLAG_KEEP_CONFIG) {
> -		sel->r = priv->crop;
> -		if (sel->which == V4L2_SUBDEV_FORMAT_TRY)
> -			cfg->try_crop = sel->r;
> +	infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, sel->which);
> +	crop = __csi_get_crop(priv, cfg, sel->which);
> +	compose = __csi_get_compose(priv, cfg, sel->which);
> +
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_CROP:
> +		/*
> +		 * Modifying the crop rectangle always changes the format on
> +		 * the source pads. If the KEEP_CONFIG flag is set, just return
> +		 * the current crop rectangle.
> +		 */
> +		if (sel->flags & V4L2_SEL_FLAG_KEEP_CONFIG) {
> +			sel->r = priv->crop;

My understanding of KEEP_CONFIG is that the only thing we're not
allowed to do is to propagate the change downstream.

Since downstream of the crop is the compose, that means the only
restriction here is that the width and height of the crop window must
be either equal to the compose width/height, or double the compose
width/height.  (Anything else would necessitate the compose window
changing.)

However, the crop window can move position within the crop bounds,
provided it's entirely contained within those crop bounds.

The problem is that this becomes rather more complex it deal with
(as I'm finding out in my imx219 camera driver) and I'm thinking
that some of this complexity should probably be in a helper in
generic v4l2 code.

I don't know whether this applies (I hope it doesn't) but there's a
pile of guidelines in Documentation/media/uapi/v4l/vidioc-g-selection.rst
which describe how a crop/compose rectangle should be adjusted.  As
I say, I hope they don't apply, because if they do, we would _really_
need helpers for this stuff, as I don't think having each driver
implement all these rules would be too successful!

> +			if (sel->which == V4L2_SUBDEV_FORMAT_TRY)
> +				*crop = sel->r;
> +			goto out;
> +		}
> +
> +		csi_try_crop(priv, &sel->r, cfg, infmt, sensor);
> +
> +		*crop = sel->r;
> +
> +		/* Reset scaling to 1:1 */
> +		compose->width = crop->width;
> +		compose->height = crop->height;
> +		break;
> +	case V4L2_SEL_TGT_COMPOSE:
> +		/*
> +		 * Modifying the compose rectangle always changes the format on
> +		 * the source pads. If the KEEP_CONFIG flag is set, just return
> +		 * the current compose rectangle.
> +		 */
> +		if (sel->flags & V4L2_SEL_FLAG_KEEP_CONFIG) {
> +			sel->r = priv->compose;

I think, with my understanding of how the KEEP_CONFIG flag works, this
should be:
			sel->r = *compose;

because if we change the compose rectangle width/height, we would need
to propagate this to the source pad, and the KEEP_CONFIG description
says we're not allowed to do that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
