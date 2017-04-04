From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 4 Apr 2017 15:50:56 +0200
Subject: [PATCH v2 07/13] drm/meson: Add support for HDMI encoder and
 DW-HDMI bridge + PHY
In-Reply-To: <3b6333c4-2fe0-8331-e54b-01d956e97797@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
 <1490109950-21421-8-git-send-email-narmstrong@baylibre.com>
 <20170404085752.jg246ilczhgmyyhy@phenom.ffwll.local>
 <3b6333c4-2fe0-8331-e54b-01d956e97797@baylibre.com>
Message-ID: <20170404134957.my2p7hocjolvjqbl@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 11:16:23AM +0200, Neil Armstrong wrote:
> On 04/04/2017 10:57 AM, Daniel Vetter wrote:
> > On Tue, Mar 21, 2017 at 04:25:44PM +0100, Neil Armstrong wrote:
> >> The Amlogic Meson GXBB/GXL/GXM SoCs embeds a Synopsys DesignWare HDMI TX
> >> Controller with a custom Bridge + PHY around the Controller.
> >>
> >> This driver makes uses of all the custom PHY plat data callbacks and enables
> >> the compatible HDMI modes to be configured as a drm_encoder instance.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > 
> > [snip]
> > 
> >> +static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
> >> +					struct drm_crtc_state *crtc_state,
> >> +					struct drm_connector_state *conn_state)
> >> +{
> >> +	return 0;
> >> +}
> > 
> > Given the over-the-top complicated mode encoding you seem to have, this
> > feels like it's a bit too simply.
> 
> Indeed, but the HW is really weird, every supported modes have very specific
> timings/parameters so moving the mode validation code from the dw-hdmi mode_valid
> to here would only make sense if we need to support a different HDMI controller.
> 
> But you are right, but I would have preferred to have a better HW for sure...

Oh, if your constraints on the meson encoder match what dw-hdmi needs,
then the mode_valid checks in there are good enough. A comment might be
good in that case.

But it looked to me (at a very cursory glance) that the meson encoder has
some additional fun restrictions on top.

> >> +
> >> +static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
> >> +{
> >> +	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
> >> +	struct meson_drm *priv = dw_hdmi->priv;
> >> +
> >> +	DRM_DEBUG_DRIVER("\n");
> >> +
> >> +	writel_bits_relaxed(0x3, 0,
> >> +			    priv->io_base + _REG(VPU_HDMI_SETTING));
> >> +
> >> +	writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
> >> +	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
> >> +}
> >> +
> >> +static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
> >> +{
> >> +	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
> >> +	struct meson_drm *priv = dw_hdmi->priv;
> >> +
> >> +	DRM_DEBUG_DRIVER("%s\n", priv->venc.hdmi_use_enci ? "VENCI" : "VENCP");
> >> +
> >> +	if (priv->venc.hdmi_use_enci)
> >> +		writel_relaxed(1, priv->io_base + _REG(ENCI_VIDEO_EN));
> >> +	else
> >> +		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
> >> +}
> >> +
> >> +static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
> >> +				   struct drm_display_mode *mode,
> >> +				   struct drm_display_mode *adjusted_mode)
> >> +{
> >> +	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
> >> +	struct meson_drm *priv = dw_hdmi->priv;
> >> +	int vic = drm_match_cea_mode(mode);
> >> +
> >> +	DRM_DEBUG_DRIVER("%d:\"%s\" vic %d\n",
> >> +			 mode->base.id, mode->name, vic);
> >> +
> >> +	/* Should have been filtered */
> >> +	if (!vic)
> >> +		return;
> >> +
> >> +	/* VENC + VENC-DVI Mode setup */
> >> +	meson_venc_hdmi_mode_set(priv, vic, mode);
> > 
> > So this calls a different module which export_symbol_gpls that thing. I
> > have no idea why arm-soc people love modularized-to-the-function level
> > drivers, but it feels over the top. amd/nouveau/i915 all smash everything
> > into one driver, makes life so much easier.
> 
> I know, we are doomed on that !
> But here, since the wrapping around the dw-hdmi controller is completely custom
> if was necessary to add a separate encoder tied to HDMI and have the physical
> encoding code in the common driver.
> Note that the platform is also able to driver a LCD via LVDS, so this encoder code
> should be reusable here.

I'm not talking about the custom encoder or anything like that, or code
reuse. I'm talking about doing piles of separate .ko when you could have
just one (with a bunch of component drivers contained within). At least
this is how the really big drivers all work.

Of course shared ip (like the dw-hdmi bridge driver) need to be in
separate .ko, that part completely makes sense.

> > Note: bridge drivers as separate .ko makes sense, but separate .ko for
> > every single functional unit in your vendor IP imo totally doesn't.
> 
> Actually I added a global ko for the "DRM" driver with crtc, planes and CVBS,
> and another ko for the HDMI bridge wrapping.

Or maybe I just misunderstood things, but meson_venc_hdmi_mode_set looks
like it could be pulled into this module?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
