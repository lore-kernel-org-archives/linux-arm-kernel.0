From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 19:36:22 +0000
Subject: [PATCH v3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <1382992009-19407-1-git-send-email-festevam@gmail.com>
References: <1382992009-19407-1-git-send-email-festevam@gmail.com>
Message-ID: <20131030193622.GN16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 06:26:49PM -0200, Fabio Estevam wrote:
> +	/*Wait for PHY PLL lock */
> +	msec = 4;
> +	val = hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_TX_PHY_LOCK;
> +	while (!val) {
> +		udelay(1000);
> +		if (msec-- == 0) {
> +			dev_dbg(hdmi->dev, "PHY PLL not locked\n");
> +			return -EINVAL;
> +		}
> +		val = hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_TX_PHY_LOCK;
> +	}

This loop is not always sufficient for the PLL to always lock.  It's also
buggy because it behaves like this:

	msec = 4
	read register
	check bit - still one?
		yes - wait 1ms
		msec == 0?
			no - msec = 3
			read register
... msec eventually msec = 0
	read register
	check bit - still one
		yes - wait 1ms
		msec == 0?
			yes - print debug and exit

So the last wait for 1ms performs no real function other than to delay
the inevitable exit.  If we really want to wait 5ms for the condition
we're testing to become true, then do it like this:

	msec = 5;
	do {
		val = hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_TX_PHY_LOCK;
		if (!val)
			break;
 
		if (msec == 0) {
			dev_err(hdmi->dev, "PHY PLL not locked\n");
			return -EINVAL;
		}
 
		udelay(1000);
		msec--;
	} while (1);

This way, we check for the success condition immediately before checking
for the failure condition, and only waiting after that.

I'd also suggest making it a dev_err() so that it's obvious when it
doesn't lock - the current dev_dbg() remains hidden and causes
failures which don't seem to be visible to the user via the logs.
Hence why this issue has been overlooked...

> +static void hdmi_av_composer(struct imx_hdmi *hdmi,
> +			     const struct drm_display_mode *mode)
> +{
> +	u8 inv_val;
> +	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
> +	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
> +
> +	vmode->mhsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
> +	vmode->mvsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
> +	vmode->minterlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
> +	vmode->mpixelclock = mode->htotal * mode->vtotal *
> +			     drm_mode_vrefresh(mode);

We can do better here:

	vmode->mpixelclock = mode->clock * 1000;

as the above is not quite correct when considering all the
possibilities.  Since we're given the pixel clock in the mode structure,
we might as well make use it.

> +	/* Set up VSYNC active edge delay (in pixel clks) */
> +	vsync_len = mode->vsync_end - mode->vsync_start;
> +	hdmi_writeb(hdmi, vsync_len, HDMI_FC_VSYNCINWIDTH);

Commentry - vsync len is in lines not pixel clocks.

Other than that, it seems to work here on the Carrier-1.  Thanks.
