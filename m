From: peda@axentia.se (Peter Rosin)
Date: Tue, 31 Jul 2018 07:46:01 +0200
Subject: [PATCH v2 2/7] drm/i2c: tda998x: split tda998x_encoder_dpms into
 enable/disable
In-Reply-To: <E1fkBFL-00048X-1P@rmk-PC.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <E1fkBFL-00048X-1P@rmk-PC.armlinux.org.uk>
Message-ID: <1f5fdfa8-4ed2-d0b5-0b45-3c0273bef1f0@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-30 18:42, Russell King wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> This fits better with the drm_bridge callbacks for when this
> driver becomes a drm_bridge.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> [edited by rmk to just split the tda998x_encoder_dpms() function
>  and restore the double-disable protection we originally had,
>  preserving original behaviour.]
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index b05f54c8585b..1c2f5dac1886 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1299,18 +1299,9 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
>  
>  /* DRM encoder functions */
>  
> -static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
> +static void tda998x_enable(struct tda998x_priv *priv)
>  {
> -	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> -	bool on;
> -
> -	/* we only care about on or off: */
> -	on = mode == DRM_MODE_DPMS_ON;
> -
> -	if (on == priv->is_on)
> -		return;
> -
> -	if (on) {
> +	if (!priv->is_on) {
>  		/* enable video ports, audio will be enabled later */
>  		reg_write(priv, REG_ENA_VP_0, 0xff);
>  		reg_write(priv, REG_ENA_VP_1, 0xff);
> @@ -1321,7 +1312,12 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
>  		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
>  
>  		priv->is_on = true;
> -	} else {
> +	}
> +}
> +
> +static void tda998x_disable(struct tda998x_priv *priv)
> +{
> +	if (!priv->is_on) {

	if (priv->is_on) {

I'm pretty sure that one's on you... :-)

Cheers,
Peter

>  		/* disable video ports */
>  		reg_write(priv, REG_ENA_VP_0, 0x00);
>  		reg_write(priv, REG_ENA_VP_1, 0x00);
> @@ -1331,6 +1327,23 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
>  	}
>  }
>  
> +static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
> +{
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +	bool on;
> +
> +	/* we only care about on or off: */
> +	on = mode == DRM_MODE_DPMS_ON;
> +
> +	if (on == priv->is_on)
> +		return;
> +
> +	if (on)
> +		tda998x_enable(priv);
> +	else
> +		tda998x_disable(priv);
> +}
> +
>  static void
>  tda998x_encoder_mode_set(struct drm_encoder *encoder,
>  			 struct drm_display_mode *mode,
> 
