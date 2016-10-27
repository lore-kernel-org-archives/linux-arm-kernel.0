From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 27 Oct 2016 23:32:54 +0800
Subject: [PATCH v3 2/3] drm: zte: add initial vou drm driver
In-Reply-To: <20161020122958.GC10198@joana>
Message-ID: <20161027153128.GS30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gustavo,

Thanks for looking at the patch.

> 2016-10-20 Shawn Guo <shawn.guo@linaro.org>:
> 
> > It adds the initial ZTE VOU display controller DRM driver.  There are
> > still some features to be added, like overlay plane, scaling, and more
> > output devices support.  But it's already useful with dual CRTCs and
> > HDMI monitor working.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

<snip>

> > +static void zx_hdmi_connector_destroy(struct drm_connector *connector)
> > +{
> > +     drm_connector_unregister(connector);
> 
> drm_connector_unregister() is not needed anymore. DRM core will call it
> for you.
> 
> > +     drm_connector_cleanup(connector);
> > +}
> > +
> > +static const struct drm_connector_funcs zx_hdmi_connector_funcs = {
> > +     .dpms = drm_atomic_helper_connector_dpms,
> > +     .fill_modes = drm_helper_probe_single_connector_modes,
> > +     .detect = zx_hdmi_connector_detect,
> > +     .destroy = zx_hdmi_connector_destroy,
> 
> Then here you can use drm_connector_cleanup() directly.

Okay, will do.

> > +     .reset = drm_atomic_helper_connector_reset,
> > +     .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > +     .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > +};

<snip>

> > +static void zx_crtc_atomic_begin(struct drm_crtc *crtc,
> > +                              struct drm_crtc_state *state)
> > +{
> > +     struct drm_pending_vblank_event *event = crtc->state->event;
> > +
> > +     if (!event)
> > +             return;
> > +
> > +     crtc->state->event = NULL;
> > +
> > +     spin_lock_irq(&crtc->dev->event_lock);
> > +     if (drm_crtc_vblank_get(crtc) == 0)
> > +             drm_crtc_arm_vblank_event(crtc, event);
> > +     else
> > +             drm_crtc_send_vblank_event(crtc, event);
> > +     spin_unlock_irq(&crtc->dev->event_lock);
> 
> I think you may want to send the vblank event to userspace after you
> commit your planes, and not before.

I guess you are suggesting that the code should be implemented in
.atomic_flush hook instead, right?

> > +}
> > +
> > +static const struct drm_crtc_helper_funcs zx_crtc_helper_funcs = {
> > +     .enable = zx_crtc_enable,
> > +     .disable = zx_crtc_disable,
> > +     .atomic_begin = zx_crtc_atomic_begin,
> > +};
> > +
> > +static const struct drm_crtc_funcs zx_crtc_funcs = {
> > +     .destroy = drm_crtc_cleanup,
> > +     .set_config = drm_atomic_helper_set_config,
> > +     .page_flip = drm_atomic_helper_page_flip,
> > +     .reset = drm_atomic_helper_crtc_reset,
> > +     .atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> > +     .atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> > +};
> > +
> > +static int zx_crtc_init(struct drm_device *drm, struct zx_vou_hw *vou,
> > +                     enum vou_chn_type chn_type)
> > +{
> > +     struct device *dev = vou->dev;
> > +     struct zx_layer_data data;
> > +     struct zx_crtc *zcrtc;
> > +     int ret;
> > +
> > +     zcrtc = devm_kzalloc(dev, sizeof(*zcrtc), GFP_KERNEL);
> > +     if (!zcrtc)
> > +             return -ENOMEM;
> > +
> > +     zcrtc->vou = vou;
> > +     zcrtc->chn_type = chn_type;
> > +
> > +     if (chn_type == VOU_CHN_MAIN) {
> > +             data.layer = vou->osd + MAIN_GL_OFFSET;
> > +             data.csc = vou->osd + MAIN_CSC_OFFSET;
> > +             data.hbsc = vou->osd + MAIN_HBSC_OFFSET;
> > +             data.rsz = vou->otfppu + MAIN_RSZ_OFFSET;
> > +             zcrtc->chnreg = vou->osd + OSD_MAIN_CHN;
> > +             zcrtc->regs = &main_crtc_regs;
> > +             zcrtc->bits = &main_crtc_bits;
> > +     } else {
> > +             data.layer = vou->osd + AUX_GL_OFFSET;
> > +             data.csc = vou->osd + AUX_CSC_OFFSET;
> > +             data.hbsc = vou->osd + AUX_HBSC_OFFSET;
> > +             data.rsz = vou->otfppu + AUX_RSZ_OFFSET;
> > +             zcrtc->chnreg = vou->osd + OSD_AUX_CHN;
> > +             zcrtc->regs = &aux_crtc_regs;
> > +             zcrtc->bits = &aux_crtc_bits;
> > +     }
> > +
> > +     zcrtc->pixclk = devm_clk_get(dev, (chn_type == VOU_CHN_MAIN) ?
> > +                                       "main_wclk" : "aux_wclk");
> > +     if (IS_ERR(zcrtc->pixclk)) {
> > +             ret = PTR_ERR(zcrtc->pixclk);
> > +             dev_err(dev, "failed to get pix clk: %d\n", ret);
> 
> DRM_ERROR() - here and in other places in your patch

I will follow Sean's suggestion to use DRM_DEV_* for these messages.

Shawn
