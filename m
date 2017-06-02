From: eric@anholt.net (Eric Anholt)
Date: Fri, 02 Jun 2017 13:41:34 -0700
Subject: [PATCH v3 1/6] drm/stm: ltdc: Add panel-bridge support
In-Reply-To: <1496414235-20098-2-git-send-email-philippe.cornu@st.com>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
 <1496414235-20098-2-git-send-email-philippe.cornu@st.com>
Message-ID: <87y3ta86m9.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philippe CORNU <philippe.cornu@st.com> writes:

> Add the panel-bridge support for both panels & bridges (used by DSI host &
> HDMI/LVDS bridges).

This looks like a great cleanup.  Just a couple of things I noticed, and
hopefully once the DT is reviewed we can merge it.  I've also
resubmitted the panel-bridge patch so that hopefully we can land it
soon.

> -static struct drm_encoder *ltdc_rgb_encoder_create(struct drm_device *ddev)
> +static int ltdc_encoder_init(struct drm_device *ddev)
>  {
> +	struct ltdc_device *ldev = ddev->dev_private;
>  	struct drm_encoder *encoder;
> +	int ret;
>  
>  	encoder = devm_kzalloc(ddev->dev, sizeof(*encoder), GFP_KERNEL);
>  	if (!encoder)
> -		return NULL;
> +		return -ENOMEM;
>  
>  	encoder->possible_crtcs = CRTC_MASK;
>  	encoder->possible_clones = 0; /* No cloning support */
>  
> -	drm_encoder_init(ddev, encoder, &ltdc_rgb_encoder_funcs,
> +	drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
>  			 DRM_MODE_ENCODER_DPI, NULL);
>  
> -	drm_encoder_helper_add(encoder, &ltdc_rgb_encoder_helper_funcs);
> -
> -	DRM_DEBUG_DRIVER("RGB encoder:%d created\n", encoder->base.id);
> -
> -	return encoder;
> -}
> -
> -/*
> - * DRM_CONNECTOR
> - */
> -
> -static int ltdc_rgb_connector_get_modes(struct drm_connector *connector)
> -{
> -	struct drm_device *ddev = connector->dev;
> -	struct ltdc_device *ldev = ddev->dev_private;
> -	int ret = 0;
> -
> -	DRM_DEBUG_DRIVER("\n");
> -
> -	if (ldev->panel)
> -		ret = drm_panel_get_modes(ldev->panel);
> -
> -	return ret < 0 ? 0 : ret;
> -}
> -
> -static struct drm_connector_helper_funcs ltdc_rgb_connector_helper_funcs = {
> -	.get_modes = ltdc_rgb_connector_get_modes,
> -};
> -
> -static enum drm_connector_status
> -ltdc_rgb_connector_detect(struct drm_connector *connector, bool force)
> -{
> -	struct ltdc_device *ldev = connector_to_ltdc(connector);
> -
> -	return ldev->panel ? connector_status_connected :
> -	       connector_status_disconnected;
> -}
> -
> -static void ltdc_rgb_connector_destroy(struct drm_connector *connector)
> -{
> -	DRM_DEBUG_DRIVER("\n");
> -
> -	drm_connector_unregister(connector);
> -	drm_connector_cleanup(connector);
> -}
> -
> -static const struct drm_connector_funcs ltdc_rgb_connector_funcs = {
> -	.dpms = drm_atomic_helper_connector_dpms,
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.detect = ltdc_rgb_connector_detect,
> -	.destroy = ltdc_rgb_connector_destroy,
> -	.reset = drm_atomic_helper_connector_reset,
> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> -};
> -
> -struct drm_connector *ltdc_rgb_connector_create(struct drm_device *ddev)
> -{
> -	struct drm_connector *connector;
> -	int err;
> -
> -	connector = devm_kzalloc(ddev->dev, sizeof(*connector), GFP_KERNEL);
> -	if (!connector) {
> -		DRM_ERROR("Failed to allocate connector\n");
> -		return NULL;
> -	}
> -
> -	connector->polled = DRM_CONNECTOR_POLL_HPD;
> +	drm_encoder_helper_add(encoder, NULL);

I think the funcs table should be NULL by default, so you can just drop
this line.

>  
> -	err = drm_connector_init(ddev, connector, &ltdc_rgb_connector_funcs,
> -				 DRM_MODE_CONNECTOR_DPI);
> -	if (err) {
> -		DRM_ERROR("Failed to initialize connector\n");
> -		return NULL;
> +	ret = drm_bridge_attach(encoder, ldev->bridge, NULL);
> +	if (ret) {
> +		drm_encoder_cleanup(encoder);
> +		return -EINVAL;
>  	}
>  
> -	drm_connector_helper_add(connector, &ltdc_rgb_connector_helper_funcs);
> -
> -	DRM_DEBUG_DRIVER("RGB connector:%d created\n", connector->base.id);
> +	DRM_DEBUG_DRIVER("Bridge encoder:%d created\n", encoder->base.id);
>  
> -	return connector;
> +	return 0;
>  }



> @@ -1129,9 +988,9 @@ int ltdc_load(struct drm_device *ddev)
>  	ddev->irq_enabled = 1;
>  
>  	return 0;
> +
>  err:
> -	if (ldev->panel)
> -		drm_panel_detach(ldev->panel);
> +	drm_panel_bridge_remove(bridge);
>  
>  	clk_disable_unprepare(ldev->pixel_clk);
>  
> @@ -1146,8 +1005,7 @@ void ltdc_unload(struct drm_device *ddev)
>  
>  	drm_vblank_cleanup(ddev);
>  
> -	if (ldev->panel)
> -		drm_panel_detach(ldev->panel);
> +	drm_panel_bridge_remove(ldev->bridge);

If you had no panel, this would try to kfree some other module's bridge
structure.  I guess you could track ldev->is_panel_bridge (like I did
for vc4) and conditionally drm_panel_bridge_remove().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170602/8f14e37a/attachment.sig>
