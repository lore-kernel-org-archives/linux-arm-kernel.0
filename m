From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jul 2018 11:57:17 +0100
Subject: [PATCH v5 5/7] drm/i2c: tda998x: split tda998x_encoder_dpms into
 enable/disable
In-Reply-To: <20180523093122.27859-6-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
 <20180523093122.27859-6-peda@axentia.se>
Message-ID: <20180706105717.GW17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 11:31:20AM +0200, Peter Rosin wrote:
> This fits better with the drm_bridge callbacks for when this
> driver becomes a drm_bridge.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 64 ++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index 933d309d2e0f..3dda07a2fd2f 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1163,36 +1163,42 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
>  
>  /* DRM encoder functions */
>  
> -static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
> +static void tda998x_enable(struct tda998x_priv *priv)
>  {
> -	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> -	bool on;
> +	if (priv->is_on)
> +		return;
>  
> -	/* we only care about on or off: */
> -	on = mode == DRM_MODE_DPMS_ON;
> +	/* enable video ports, audio will be enabled later */
> +	reg_write(priv, REG_ENA_VP_0, 0xff);
> +	reg_write(priv, REG_ENA_VP_1, 0xff);
> +	reg_write(priv, REG_ENA_VP_2, 0xff);
> +	/* set muxing after enabling ports: */
> +	reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
> +	reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
> +	reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
>  
> -	if (on == priv->is_on)
> -		return;
> +	priv->is_on = true;
> +}
>  
> -	if (on) {
> -		/* enable video ports, audio will be enabled later */
> -		reg_write(priv, REG_ENA_VP_0, 0xff);
> -		reg_write(priv, REG_ENA_VP_1, 0xff);
> -		reg_write(priv, REG_ENA_VP_2, 0xff);
> -		/* set muxing after enabling ports: */
> -		reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
> -		reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
> -		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
> -
> -		priv->is_on = true;
> -	} else {
> -		/* disable video ports */
> -		reg_write(priv, REG_ENA_VP_0, 0x00);
> -		reg_write(priv, REG_ENA_VP_1, 0x00);
> -		reg_write(priv, REG_ENA_VP_2, 0x00);
> +static void tda998x_disable(struct tda998x_priv *priv)
> +{
> +	/* disable video ports */
> +	reg_write(priv, REG_ENA_VP_0, 0x00);
> +	reg_write(priv, REG_ENA_VP_1, 0x00);
> +	reg_write(priv, REG_ENA_VP_2, 0x00);
>  
> -		priv->is_on = false;
> -	}
> +	priv->is_on = false;
> +}
> +
> +static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
> +{
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	/* we only care about on or off: */
> +	if (mode == DRM_MODE_DPMS_ON)
> +		tda998x_enable(priv);
> +	else
> +		tda998x_disable(priv);
>  }
>  
>  static void
> @@ -1606,12 +1612,16 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
>  
>  static void tda998x_encoder_prepare(struct drm_encoder *encoder)
>  {
> -	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	tda998x_disable(priv);
>  }
>  
>  static void tda998x_encoder_commit(struct drm_encoder *encoder)
>  {
> -	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	tda998x_enable(priv);
>  }
>  
>  static const struct drm_encoder_helper_funcs tda998x_encoder_helper_funcs = {

Please group the tda998x_encoder_* functions together, and in order of
their use in the function vtables, and just above the function vtables.
That'll mean that all the encoder veneers are together, all the bridge
veneers are together, etc, and probably means later on it's easier to
remove the encoder stuff (as all the encoder code will be in one hunk
rather than scattered throughout the file.)

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
