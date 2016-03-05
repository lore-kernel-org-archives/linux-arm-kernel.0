From: john@keeping.me.uk (John Keeping)
Date: Sat, 5 Mar 2016 12:11:16 +0000
Subject: [PATCH 1/2] drm/rockchip: dw_hdmi: Call drm_encoder_cleanup() in
 error path
In-Reply-To: <1457133723-24869-1-git-send-email-dianders@chromium.org>
References: <1457133723-24869-1-git-send-email-dianders@chromium.org>
Message-ID: <20160305121005.GA11966@serenity.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 03:22:01PM -0800, Douglas Anderson wrote:
> The drm_encoder_cleanup() was missing both from the error path of
> dw_hdmi_rockchip_bind().  This caused a crash when slub_debug was
> enabled and we ended up deferring probe of HDMI at boot.
> 
> This call isn't needed from unbind() because if dw_hdmi_bind() returns
> no error then it takes over the job of freeing the encoder (in
> dw_hdmi_unbind).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Does dw_hdmi-imx need a similar change?  I wonder if it would be cleaner
to push this into dw_hdmi_bind() if it affects all of the platforms..

>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 3d3cf2f8891e..88776aba984e 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -293,7 +293,16 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
>  			 DRM_MODE_ENCODER_TMDS, NULL);
>  
> -	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
> +	ret = dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
> +
> +	/*
> +	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
> +	 * which would have called the encoder cleanup.  Do it manually.
> +	 */
> +	if (ret)
> +		drm_encoder_cleanup(encoder);
> +
> +	return ret;
>  }
>  
>  static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
> -- 
> 2.7.0.rc3.207.g0ac5344
