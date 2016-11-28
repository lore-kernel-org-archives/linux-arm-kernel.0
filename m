From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 28 Nov 2016 16:47:28 +0100
Subject: [PATCH] drm/atmel-hlcdc: Rework the fbdev creation logic
In-Reply-To: <1480345267-18461-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480345267-18461-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20161128154728.kinvnyukkwuax3sv@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 04:01:07PM +0100, Boris Brezillon wrote:
> Now that we wait for DRM panels to be available before registering the
> DRM device (returning -EPROBE_DEFER if the panel has not been probed
> yet), we no longer need to put the fbdev creation code in
> ->output_poll_changed().
> 
> This removes the 10 secs delay between DRM dev registration and fbdev
> creation (polling period = 10 seconds).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Alex Vazquez <avazquez.dev@gmail.com>

+1 Would still be good to eventually resurrect Thierry's deferred fbdev
setup code for other use-cases. But for panels the driver should indeed
not need this.
-Daniel
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 5f484310bee9..2325de7c5c6f 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -431,15 +431,8 @@ static void atmel_hlcdc_fb_output_poll_changed(struct drm_device *dev)
>  {
>  	struct atmel_hlcdc_dc *dc = dev->dev_private;
>  
> -	if (dc->fbdev) {
> +	if (dc->fbdev)
>  		drm_fbdev_cma_hotplug_event(dc->fbdev);
> -	} else {
> -		dc->fbdev = drm_fbdev_cma_init(dev, 24,
> -				dev->mode_config.num_crtc,
> -				dev->mode_config.num_connector);
> -		if (IS_ERR(dc->fbdev))
> -			dc->fbdev = NULL;
> -	}
>  }
>  
>  struct atmel_hlcdc_dc_commit {
> @@ -652,10 +645,13 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  
>  	platform_set_drvdata(pdev, dev);
>  
> -	drm_kms_helper_poll_init(dev);
> +	dc->fbdev = drm_fbdev_cma_init(dev, 24,
> +			dev->mode_config.num_crtc,
> +			dev->mode_config.num_connector);
> +	if (IS_ERR(dc->fbdev))
> +		dc->fbdev = NULL;
>  
> -	/* force connectors detection */
> -	drm_helper_hpd_irq_event(dev);
> +	drm_kms_helper_poll_init(dev);
>  
>  	return 0;
>  
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
