From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 21 Sep 2012 09:24:19 -0700
Subject: [PATCH 4/6] staging: drm/imx: Add i.MX IPUv3 crtc support
In-Reply-To: <1348214872-28594-5-git-send-email-s.hauer@pengutronix.de>
References: <1348214872-28594-1-git-send-email-s.hauer@pengutronix.de>
 <1348214872-28594-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <505C94B3.3020308@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

While testing against a video-enabled U-Boot on i.MX6, I found the issue
below.

On 09/21/2012 01:07 AM, Sascha Hauer wrote:
> This adds a i.MX51/53/6 IPU (Image Processing Unit) KMS driver. The
> driver has been tested on the i.MX51 babbage board, the i.MX53 LOCO
> board and the i.MX6q sabrelite board in different clone mode and dual
> head setups.
>
> Signed-off-by: Sascha Hauer<s.hauer@pengutronix.de>
> ---
> +++ b/drivers/staging/imx-drm/ipuv3-crtc.c
> @@ -0,0 +1,579 @@
> +/*
> + * i.MX IPUv3 Graphics driver
> + *
 >
 > <snip>
 >
> +static int ipu_get_resources(struct ipu_crtc *ipu_crtc,
> +		struct ipu_client_platformdata *pdata)
> +{
> +
> +	ipu_crtc->irq = ipu_idmac_channel_irq(ipu, ipu_crtc->ipu_ch,
> +			IPU_IRQ_EOF);

Interrupts get enabled here

> +	ret = devm_request_irq(ipu_crtc->dev, ipu_crtc->irq, ipu_irq_handler, 0,
> +			"imx_drm", ipu_crtc);
> +	if (ret<  0) {
> +		dev_err(ipu_crtc->dev, "irq request failed with %d.\n", ret);
> +		goto err_out;
> +	}
> +
>
> <snip>
>
> +
> +static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
> +		struct ipu_client_platformdata *pdata)
> +{
> +	int ret;
> +
> +	ret = ipu_get_resources(ipu_crtc, pdata);
> +	if (ret) {
> +		dev_err(ipu_crtc->dev, "getting resources failed with %d.\n",
> +				ret);
> +		return ret;
> +	}
> +

But ipu_crtc->imx_crtc gets initialized in this call, and
ipu_irq_handler() makes use of it.

The U-Boot code doesn't enable interrupts, so it's not acking
along the way, and leaves bits set in IPU1_INT_STAT_15.

I found that I can get around this in U-Boot by disabling the
LCD controller and acking all of the interrupts after disabling
the controller, but I haven't yet figured out where to tap into 
cleanup_before_linux().

Regards,


Eric
