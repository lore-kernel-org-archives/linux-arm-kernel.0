From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 4 Apr 2017 10:57:52 +0200
Subject: [PATCH v2 07/13] drm/meson: Add support for HDMI encoder and
 DW-HDMI bridge + PHY
In-Reply-To: <1490109950-21421-8-git-send-email-narmstrong@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
 <1490109950-21421-8-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170404085752.jg246ilczhgmyyhy@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:25:44PM +0100, Neil Armstrong wrote:
> The Amlogic Meson GXBB/GXL/GXM SoCs embeds a Synopsys DesignWare HDMI TX
> Controller with a custom Bridge + PHY around the Controller.
> 
> This driver makes uses of all the custom PHY plat data callbacks and enables
> the compatible HDMI modes to be configured as a drm_encoder instance.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[snip]

> +static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state)
> +{
> +	return 0;
> +}

Given the over-the-top complicated mode encoding you seem to have, this
feels like it's a bit too simply.

> +
> +static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
> +{
> +	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
> +	struct meson_drm *priv = dw_hdmi->priv;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	writel_bits_relaxed(0x3, 0,
> +			    priv->io_base + _REG(VPU_HDMI_SETTING));
> +
> +	writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
> +	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
> +}
> +
> +static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
> +	struct meson_drm *priv = dw_hdmi->priv;
> +
> +	DRM_DEBUG_DRIVER("%s\n", priv->venc.hdmi_use_enci ? "VENCI" : "VENCP");
> +
> +	if (priv->venc.hdmi_use_enci)
> +		writel_relaxed(1, priv->io_base + _REG(ENCI_VIDEO_EN));
> +	else
> +		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
> +}
> +
> +static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
> +				   struct drm_display_mode *mode,
> +				   struct drm_display_mode *adjusted_mode)
> +{
> +	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
> +	struct meson_drm *priv = dw_hdmi->priv;
> +	int vic = drm_match_cea_mode(mode);
> +
> +	DRM_DEBUG_DRIVER("%d:\"%s\" vic %d\n",
> +			 mode->base.id, mode->name, vic);
> +
> +	/* Should have been filtered */
> +	if (!vic)
> +		return;
> +
> +	/* VENC + VENC-DVI Mode setup */
> +	meson_venc_hdmi_mode_set(priv, vic, mode);

So this calls a different module which export_symbol_gpls that thing. I
have no idea why arm-soc people love modularized-to-the-function level
drivers, but it feels over the top. amd/nouveau/i915 all smash everything
into one driver, makes life so much easier.

Note: bridge drivers as separate .ko makes sense, but separate .ko for
every single functional unit in your vendor IP imo totally doesn't.

Not going to stop you either :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
