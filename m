From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Feb 2013 10:57:01 +0800
Subject: [PATCH] staging: imx/drm: request irq only after adding the crtc
In-Reply-To: <1361284559-25125-1-git-send-email-p.zabel@pengutronix.de>
References: <1361284559-25125-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130220025659.GC27773@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 03:35:59PM +0100, Philipp Zabel wrote:
> If the bootloader already enabled the display, the interrupt handler
> will be called as soon as it is registered. If the CRTC is not already
> added at this time, the call to imx_drm_handle_vblank will result in
> a NULL pointer dereference.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Greg,

The patch fixes a kernel panic [1], which has been on linux-next since
Jan 8 [2].  Can you please apply it if it looks good to you?

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/218858
[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/208192

> ---
>  drivers/staging/imx-drm/ipuv3-crtc.c |   23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
> index 1892006..d454a16 100644
> --- a/drivers/staging/imx-drm/ipuv3-crtc.c
> +++ b/drivers/staging/imx-drm/ipuv3-crtc.c
> @@ -483,17 +483,6 @@ static int ipu_get_resources(struct ipu_crtc *ipu_crtc,
>  		goto err_out;
>  	}
>  
> -	ipu_crtc->irq = ipu_idmac_channel_irq(ipu, ipu_crtc->ipu_ch,
> -			IPU_IRQ_EOF);
> -	ret = devm_request_irq(ipu_crtc->dev, ipu_crtc->irq, ipu_irq_handler, 0,
> -			"imx_drm", ipu_crtc);
> -	if (ret < 0) {
> -		dev_err(ipu_crtc->dev, "irq request failed with %d.\n", ret);
> -		goto err_out;
> -	}
> -
> -	disable_irq(ipu_crtc->irq);
> -
>  	return 0;
>  err_out:
>  	ipu_put_resources(ipu_crtc);
> @@ -504,6 +493,7 @@ err_out:
>  static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
>  		struct ipu_client_platformdata *pdata)
>  {
> +	struct ipu_soc *ipu = dev_get_drvdata(ipu_crtc->dev->parent);
>  	int ret;
>  
>  	ret = ipu_get_resources(ipu_crtc, pdata);
> @@ -522,6 +512,17 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
>  		goto err_put_resources;
>  	}
>  
> +	ipu_crtc->irq = ipu_idmac_channel_irq(ipu, ipu_crtc->ipu_ch,
> +			IPU_IRQ_EOF);
> +	ret = devm_request_irq(ipu_crtc->dev, ipu_crtc->irq, ipu_irq_handler, 0,
> +			"imx_drm", ipu_crtc);
> +	if (ret < 0) {
> +		dev_err(ipu_crtc->dev, "irq request failed with %d.\n", ret);
> +		goto err_put_resources;
> +	}
> +
> +	disable_irq(ipu_crtc->irq);
> +
>  	return 0;
>  
>  err_put_resources:
> -- 
> 1.7.10.4
> 
