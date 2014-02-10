From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 16:26:31 +0000
Subject: [RFC PATCH 2/3] staging: imx-drm-core: Use graph to find
 connection between crtc and encoder
In-Reply-To: <1389019922-31992-3-git-send-email-p.zabel@pengutronix.de>
References: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
 <1389019922-31992-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140210162631.GC26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 03:52:01PM +0100, Philipp Zabel wrote:
> @@ -438,24 +453,21 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
>  	struct drm_encoder *encoder, struct device_node *np)
>  {
>  	struct imx_drm_device *imxdrm = drm->dev_private;
> +	struct device_node *ep, *last_ep = NULL;
>  	uint32_t crtc_mask = 0;
>  	int i, ret = 0;
>  
>  	for (i = 0; !ret; i++) {
> -		struct of_phandle_args args;
>  		uint32_t mask;
> -		int id;
>  
> -		ret = of_parse_phandle_with_args(np, "crtcs", "#crtc-cells", i,
> -						 &args);
> -		if (ret == -ENOENT)
> +		ep = v4l2_of_get_next_endpoint(np, last_ep);
> +		if (last_ep)
> +			of_node_put(last_ep);
> +		if (!ep)
>  			break;
> -		if (ret < 0)
> -			return ret;
>  
> -		id = args.args_count > 0 ? args.args[0] : 0;
> -		mask = imx_drm_find_crtc_mask(imxdrm, args.np, id);
> -		of_node_put(args.np);
> +		/* CSI */
> +		mask = imx_drm_find_crtc_mask(imxdrm, ep);
>  
>  		/*
>  		 * If we failed to find the CRTC(s) which this encoder is
> @@ -463,12 +475,20 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
>  		 * not been registered yet.  Defer probing, and hope that
>  		 * the required CRTC is added later.
>  		 */
> -		if (mask == 0)
> +		if (mask == 0) {
> +			of_node_put(ep);
>  			return -EPROBE_DEFER;
> +		}
>  
>  		crtc_mask |= mask;
> +		last_ep = ep;
>  	}
>  
> +	if (ep)
> +		of_node_put(ep);

Why is this loop soo complicated?  Why do you need to mess around with
this "last_ep" stuff - you don't actually end up using it.

The loop reduces down to this without comments:

 	for (i = 0; !ret; i++) {
 		uint32_t mask;

		ep = v4l2_of_get_next_endpoint(np, last_ep);
		if (!ep)
			break;

		/* CSI */
		mask = imx_drm_find_crtc_mask(imxdrm, ep);
		of_node_put(ep);

		if (mask == 0)
			return -EPROBE_DEFER;

		crtc_mask |= mask;
	}

Now, here's the big question: why do we want to use v4l2_* here?  We
may want to use this functionality, but if this functionality is going
to be used outside of v4l2, it needs to become something generic, not
v4l2 specific.

Let's think about this for a moment... if we want to build imx-drm into
the kernel, can we do it with modular videodev, or with videodev
completely unconfigured.  We may wish to do this because we have no
videodev requirement on a platform.  Should the build fail because the
v4l2 function isn't there?

So, before we can change this, I think we first need to get agreement
from Mauro to move this function out of V4L2, so that it can be
available independently of V4L2.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
