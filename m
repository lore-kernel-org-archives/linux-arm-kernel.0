From: pza@pengutronix.de (Philipp Zabel)
Date: Mon, 10 Feb 2014 21:45:45 +0100
Subject: [RFC PATCH 2/3] staging: imx-drm-core: Use graph to find
 connection between crtc and encoder
In-Reply-To: <20140210162631.GC26684@n2100.arm.linux.org.uk>
References: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
 <1389019922-31992-3-git-send-email-p.zabel@pengutronix.de>
 <20140210162631.GC26684@n2100.arm.linux.org.uk>
Message-ID: <20140210204545.GA2793@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 04:26:31PM +0000, Russell King - ARM Linux wrote:
[...]
> Why is this loop soo complicated?  Why do you need to mess around with
> this "last_ep" stuff - you don't actually end up using it.

The last_ep dance is necessary because v4l2_of_get_next_endpoint(node,prev)
does not decrement the reference count of its prev argument.
To make the loop as simple as you propose, I'd either have to change
the get_next_endpoint library function or wrap it to release the prev
node:

static struct device_node *imx_drm_of_get_next_endpoint(
		struct device_node *node, struct device_node *prev)
{
	node = v4l2_of_get_next_endpoint(node, prev);
	of_node_put(prev);
	return node;
}
 
> The loop reduces down to this without comments:
> 
>  	for (i = 0; !ret; i++) {
>  		uint32_t mask;
> 
> 		ep = v4l2_of_get_next_endpoint(np, last_ep);
> 		if (!ep)
> 			break;
> 
> 		/* CSI */
> 		mask = imx_drm_find_crtc_mask(imxdrm, ep);
> 		of_node_put(ep);
> 
> 		if (mask == 0)
> 			return -EPROBE_DEFER;
> 
> 		crtc_mask |= mask;
> 	}

Yes, that is easier to read.

> Now, here's the big question: why do we want to use v4l2_* here?  We
> may want to use this functionality, but if this functionality is going
> to be used outside of v4l2, it needs to become something generic, not
> v4l2 specific.
> 
> Let's think about this for a moment... if we want to build imx-drm into
> the kernel, can we do it with modular videodev, or with videodev
> completely unconfigured.  We may wish to do this because we have no
> videodev requirement on a platform.  Should the build fail because the
> v4l2 function isn't there?
> 
> So, before we can change this, I think we first need to get agreement
> from Mauro to move this function out of V4L2, so that it can be
> available independently of V4L2.

Either that, or we add a temporary copy of the v4l2_of_get_next_endpoint
and v4l2_of_get_remote_port functions while doing the same.

regards
Philipp
