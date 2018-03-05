From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Mar 2018 08:25:58 +0100
Subject: [PATCH] drm/sun4i: move rgb mode_valid from connector to encoder
In-Reply-To: <1520159870-41286-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1520159870-41286-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180305072558.ujxojkrm5r5rican@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sun, Mar 04, 2018 at 11:37:50AM +0100, Giulio Benetti wrote:
> mode_valid function must be connected to encoder, not connector.
> Otherwise it doesn't get called by drm.

That's not true, or rather, that's a big oversimplification. It
doesn't get called by DRM if you have a bridge instead of a panel
attached to the encoder.

> Move mode_valid function pointer to encoder helper functions,
> changing its prototype according to encoder helper function pointer.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_rgb.c | 102 +++++++++++++++++++-------------------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index b8da5a5..6539dcc 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -52,11 +52,59 @@ static int sun4i_rgb_get_modes(struct drm_connector *connector)
>  	return drm_panel_get_modes(tcon->panel);
>  }
>  
> -static int sun4i_rgb_mode_valid(struct drm_connector *connector,
> -				struct drm_display_mode *mode)
> +static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
> +	.get_modes	= sun4i_rgb_get_modes,
> +};
> +
> +static void
> +sun4i_rgb_connector_destroy(struct drm_connector *connector)
>  {
>  	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
>  	struct sun4i_tcon *tcon = rgb->tcon;
> +
> +	drm_panel_detach(tcon->panel);
> +	drm_connector_cleanup(connector);
> +}
> +
> +static const struct drm_connector_funcs sun4i_rgb_con_funcs = {
> +	.fill_modes		= drm_helper_probe_single_connector_modes,
> +	.destroy		= sun4i_rgb_connector_destroy,
> +	.reset			= drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
> +	struct sun4i_tcon *tcon = rgb->tcon;
> +
> +	DRM_DEBUG_DRIVER("Enabling RGB output\n");
> +
> +	if (!IS_ERR(tcon->panel)) {
> +		drm_panel_prepare(tcon->panel);
> +		drm_panel_enable(tcon->panel);
> +	}
> +}
> +
> +static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
> +{
> +	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
> +	struct sun4i_tcon *tcon = rgb->tcon;
> +
> +	DRM_DEBUG_DRIVER("Disabling RGB output\n");
> +
> +	if (!IS_ERR(tcon->panel)) {
> +		drm_panel_disable(tcon->panel);
> +		drm_panel_unprepare(tcon->panel);
> +	}
> +}
> +
> +static enum drm_mode_status sun4i_rgb_encoder_mode_valid(struct drm_encoder *crtc,
> +							 const struct drm_display_mode *mode)
> +{
> +	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(crtc);
> +	struct sun4i_tcon *tcon = rgb->tcon;
>  	u32 hsync = mode->hsync_end - mode->hsync_start;
>  	u32 vsync = mode->vsync_end - mode->vsync_start;
>  	unsigned long rate = mode->clock * 1000;
> @@ -106,58 +154,10 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
>  	return MODE_OK;
>  }
>  
> -static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
> -	.get_modes	= sun4i_rgb_get_modes,
> -	.mode_valid	= sun4i_rgb_mode_valid,
> -};
> -
> -static void
> -sun4i_rgb_connector_destroy(struct drm_connector *connector)
> -{
> -	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
> -	struct sun4i_tcon *tcon = rgb->tcon;
> -
> -	drm_panel_detach(tcon->panel);
> -	drm_connector_cleanup(connector);
> -}
> -
> -static const struct drm_connector_funcs sun4i_rgb_con_funcs = {
> -	.fill_modes		= drm_helper_probe_single_connector_modes,
> -	.destroy		= sun4i_rgb_connector_destroy,
> -	.reset			= drm_atomic_helper_connector_reset,
> -	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
> -};
> -
> -static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
> -{
> -	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
> -	struct sun4i_tcon *tcon = rgb->tcon;
> -
> -	DRM_DEBUG_DRIVER("Enabling RGB output\n");
> -
> -	if (!IS_ERR(tcon->panel)) {
> -		drm_panel_prepare(tcon->panel);
> -		drm_panel_enable(tcon->panel);
> -	}
> -}
> -
> -static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
> -{
> -	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
> -	struct sun4i_tcon *tcon = rgb->tcon;
> -
> -	DRM_DEBUG_DRIVER("Disabling RGB output\n");
> -
> -	if (!IS_ERR(tcon->panel)) {
> -		drm_panel_disable(tcon->panel);
> -		drm_panel_unprepare(tcon->panel);
> -	}
> -}
> -
>  static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
>  	.disable	= sun4i_rgb_encoder_disable,
>  	.enable		= sun4i_rgb_encoder_enable,
> +	.mode_valid	= sun4i_rgb_encoder_mode_valid,

The only thing you should be changing is that structure, the matching
connector structure, and the function prototype. This patch is way
bigger than it needs to be.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/b2de9465/attachment.sig>
