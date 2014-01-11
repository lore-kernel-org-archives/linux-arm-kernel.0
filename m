From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:38:17 +0000
Subject: [PATCH v2 9/28] drm/i2c: tda998x: don't read write-only registers
In-Reply-To: <20140109115941.30e67a37@armhf>
References: <20140109115941.30e67a37@armhf>
Message-ID: <20140111183817.GI15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:59:41AM +0100, Jean-Francois Moine wrote:
> @@ -936,10 +926,22 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
>  	/* must be last register set: */
>  	reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
>  
> +	/*
> +	 * Always generate sync polarity relative to input sync and
> +	 * revert input stage toggled sync at output stage
> +	 */
> +	reg = TBG_CNTRL_1_DWIN_DIS | TBG_CNTRL_1_TGL_EN;
> +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +		reg |= TBG_CNTRL_1_H_TGL;
> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +		reg |= TBG_CNTRL_1_V_TGL;
> +	reg_write(priv, REG_TBG_CNTRL_1, reg);
> +

I now NAK this patch, as it messes up the register writing order.  See
the comment in the context line above.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
