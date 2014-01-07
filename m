From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Jan 2014 14:49:50 +0800
Subject: [PATCH RFC 30/46] imx-drm: remove separate imx-fbdev
In-Reply-To: <E1VypoR-0007FW-4q@rmk-PC.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoR-0007FW-4q@rmk-PC.arm.linux.org.uk>
Message-ID: <20140107064949.GC12346@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 09:28:19PM +0000, Russell King wrote:
> @@ -449,6 +458,24 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
>  		}
>  	}
>  
> +	/*
> +	 * All components are now initialised, so setup the fb helper.
> +	 * The fb helper takes copies of key hardware information, so the
> +	 * crtcs/connectors/encoders must not change after this point.
> +	 */
> +#if IS_ENABLED(CONFIG_DRM_IMX_FB_HELPER)
> +	if (legacyfb_depth != 16 && legacyfb_depth != 32) {
> +		dev_warn(drm->dev, "Invalid legacyfb_depth.  Defaulting to 16bpp\n");
> +		legacyfb_depth = 16;
> +	}
> +	imxdrm->fbhelper = drm_fbdev_cma_init(drm, legacyfb_depth,
> +				drm->mode_config.num_crtc, 4);

s/4/MAX_CRTC

imx-drm-core.c has the macro.

Shawn

> +	if (IS_ERR(imxdrm->fbhelper)) {
> +		ret = PTR_ERR(imxdrm->fbhelper);
> +		imxdrm->fbhelper = NULL;
> +		goto err_unbind;
> +	}
> +#endif
>  	return 0;
>  
>  err_unbind:
