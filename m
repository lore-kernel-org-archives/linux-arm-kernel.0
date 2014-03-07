From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Mar 2014 16:50:31 +0000
Subject: [PATCH v9][ 5/8] staging: imx-drm: Use de-active and
 pixelclk-active display-timings.
In-Reply-To: <1394121869-13387-2-git-send-email-denis@eukrea.com>
References: <1394121702-13257-3-git-send-email-denis@eukrea.com>
 <1394121869-13387-1-git-send-email-denis@eukrea.com>
 <1394121869-13387-2-git-send-email-denis@eukrea.com>
Message-ID: <20140307165031.GO21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 05:04:26PM +0100, Denis Carikli wrote:
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> index 849b3e1..5d273c1 100644
> --- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> +++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> @@ -595,8 +595,12 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
>  		}
>  	}
>  
> -	if (sig->clk_pol)
> -		di_gen |= DI_GEN_POLARITY_DISP_CLK;
> +	if (sig->set_mask & SET_CLK_POL) {
> +		if (sig->clk_pol)
> +			di_gen |= DI_GEN_POLARITY_DISP_CLK;
> +		else
> +			di_gen &= ~DI_GEN_POLARITY_DISP_CLK;
> +	}
>  
>  	ipu_di_write(di, di_gen, DI_GENERAL);
>  
> @@ -606,8 +610,13 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
>  	reg = ipu_di_read(di, DI_POL);
>  	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
>  
> -	if (sig->enable_pol)
> -		reg |= DI_POL_DRDY_POLARITY_15;
> +	if (sig->set_mask & SET_DE_POL) {
> +		if (sig->enable_pol)
> +			reg |= DI_POL_DRDY_POLARITY_15;
> +		else
> +			reg &= ~DI_POL_DRDY_POLARITY_15;
> +	}
> +
>  	if (sig->data_pol)
>  		reg |= DI_POL_DRDY_DATA_POLARITY;
>  
> diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
> index f506075..71f757f 100644
> --- a/drivers/staging/imx-drm/ipuv3-crtc.c
> +++ b/drivers/staging/imx-drm/ipuv3-crtc.c
> @@ -157,8 +157,22 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
>  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>  		sig_cfg.Vsync_pol = 1;
>  
> -	sig_cfg.enable_pol = 1;
> -	sig_cfg.clk_pol = 0;
> +	if (mode->private_flags & IMXDRM_MODE_FLAG_DE_HIGH) {
> +		sig_cfg.enable_pol = 1;
> +		sig_cfg.set_mask |= SET_DE_POL;
> +	} else if (mode->private_flags & IMXDRM_MODE_FLAG_DE_LOW) {
> +		sig_cfg.enable_pol = 0;
> +		sig_cfg.set_mask |= SET_DE_POL;
> +	}
> +
> +	if (mode->private_flags & IMXDRM_MODE_FLAG_PIXDATA_POSEDGE) {
> +		sig_cfg.clk_pol = 1;
> +		sig_cfg.set_mask |= SET_CLK_POL;
> +	} else if (mode->private_flags & IMXDRM_MODE_FLAG_PIXDATA_NEGEDGE) {
> +		sig_cfg.clk_pol = 0;
> +		sig_cfg.set_mask |= SET_CLK_POL;
> +	}

So how does this work for other displays, for example, HDMI, where we need
enable_pol=1 and clk_pol=0 ?

>From what I can see, we end up with sig_cfg.enable_pol=0, sig_cfg.clk_pol=0,
sig_cfg.set_mask=0.

What we end up with for enable_pol is this:

	reg = ipu_di_read(di, DI_POL);
	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);

-	if (sig->enable_pol)
-		reg |= DI_POL_DRDY_POLARITY_15;
+	if (sig->set_mask & SET_DE_POL) {
+		if (sig->enable_pol)
+			reg |= DI_POL_DRDY_POLARITY_15;
+		else
+			reg &= ~DI_POL_DRDY_POLARITY_15;
+	}

which is no different from:

	reg = ipu_di_read(di, DI_POL);
	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);

	if (sig->set_mask & SET_DE_POL && sig->enable_pol)
		reg |= DI_POL_DRDY_POLARITY_15;

because even with SET_DE_POL unset, we still end up clearing the bit.

Similar seems to happen with the clock polarity as well - in order for
that bit to be set, buth the set_mask and the clk_pol but must be set.

Dovetailing in to my previous reply, if we want to do this, maybe we
should convert clk_pol and enable_pol to be a tristate (can be an
u8 or enum).  Essentially, it has three values: preserve, active high,
active low.

However, one of the things that really worries me here is the "preserve"
action - what if it's not correctly set initially, and we don't have
anything specifying either polarity, which will happen if the only
encoder/connector you have is imx-hdmi.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
