From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 28 Nov 2016 10:34:58 +0100
Subject: [RFC PATCH 1/3] drm: Add support for Amlogic Meson Graphic
 Controller
In-Reply-To: <20161128081601.wapare3pyzmzghvp@phenom.ffwll.local>
References: <1480089791-12517-1-git-send-email-narmstrong@baylibre.com>
 <1480089791-12517-2-git-send-email-narmstrong@baylibre.com>
 <20161128081601.wapare3pyzmzghvp@phenom.ffwll.local>
Message-ID: <99e71b1b-b0cc-ec54-6ca9-417d20195aca@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 11/28/2016 09:16 AM, Daniel Vetter wrote:
> On Fri, Nov 25, 2016 at 05:03:09PM +0100, Neil Armstrong wrote:
>> The Amlogic Meson Display controller is composed of several components :
>>
>> DMC|---------------VPU (Video Processing Unit)----------------|------HHI------|
>>    | vd1   _______     _____________    _________________     |               |
>> D  |-------|      |----|            |   |                |    |   HDMI PLL    |
>> D  | vd2   | VIU  |    | Video Post |   | Video Encoders |<---|-----VCLK      |
>> R  |-------|      |----| Processing |   |                |    |               |
>>    | osd2  |      |    |            |---| Enci ----------|----|-----VDAC------|
>> R  |-------| CSC  |----| Scalers    |   | Encp ----------|----|----HDMI-TX----|
>> A  | osd1  |      |    | Blenders   |   | Encl ----------|----|---------------|
>> M  |-------|______|----|____________|   |________________|    |               |
>> ___|__________________________________________________________|_______________|
>>
>>
>> VIU: Video Input Unit
>> ---------------------
>>
>> The Video Input Unit is in charge of the pixel scanout from the DDR memory.
>> It fetches the frames addresses, stride and parameters from the "Canvas" memory.
>> This part is also in charge of the CSC (Colorspace Conversion).
>> It can handle 2 OSD Planes and 2 Video Planes.
>>
>> VPP: Video Processing Unit
>> --------------------------
>>
>> The Video Processing Unit is in charge if the scaling and blending of the
>> various planes into a single pixel stream.
>> There is a special "pre-blending" used by the video planes with a dedicated
>> scaler and a "post-blending" to merge with the OSD Planes.
>> The OSD planes also have a dedicated scaler for one of the OSD.
>>
>> VENC: Video Encoders
>> --------------------
>>
>> The VENC is composed of the multiple pixel encoders :
>>  - ENCI : Interlace Video encoder for CVBS and Interlace HDMI
>>  - ENCP : Progressive Video Encoder for HDMI
>>  - ENCL : LCD LVDS Encoder
>> The VENC Unit gets a Pixel Clocks (VCLK) from a dedicated HDMI PLL and clock
>> tree and provides the scanout clock to the VPP and VIU.
>> The ENCI is connected to a single VDAC for Composite Output.
>> The ENCI and ENCP are connected to an on-chip HDMI Transceiver.
>>
>> This driver is a DRM/KMS driver using the following DRM components :
>>  - GEM-CMA
>>  - PRIME-CMA
>>  - Atomic Modesetting
>>  - FBDev-CMA
>>
>> For the following SoCs :
>>  - GXBB Family (S905)
>>  - GXL Family (S905X, S905D)
>>  - GXM Family (S912)
>>
>> The current driver only supports the CVBS PAL/NTSC output modes, but the
>> CRTC/Planes management should support bigger modes.
>> But Advanced Colorspace Conversion, Scaling and HDMI Modes will be added in
>> a second time.
>>
>> The Device Tree bindings makes use of the endpoints video interface definitions
>> to connect to the optional CVBS and in the future the HDMI Connector nodes.
>>
>> HDMI Support is planned for a next release.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Few small comments below, but looks reasonable overall. Once you have acks
> for the DT part pls submit the entire series as a pull request to Dave
> Airlie (with an additional patch to add a MAINTAINERS entry).

Thanks for the review.
Ok, will add the MAINTAINERS entry.

> 
> Cheers, Daniel
> 
>> ---
>>  drivers/gpu/drm/Kconfig                 |    2 +
>>  drivers/gpu/drm/Makefile                |    1 +
>>  drivers/gpu/drm/meson/Kconfig           |    8 +
>>  drivers/gpu/drm/meson/Makefile          |    5 +
>>  drivers/gpu/drm/meson/meson_canvas.c    |   96 +++
>>  drivers/gpu/drm/meson/meson_canvas.h    |   31 +
>>  drivers/gpu/drm/meson/meson_crtc.c      |  176 ++++
>>  drivers/gpu/drm/meson/meson_crtc.h      |   34 +
>>  drivers/gpu/drm/meson/meson_cvbs.c      |  293 +++++++
>>  drivers/gpu/drm/meson/meson_cvbs.h      |   32 +
>>  drivers/gpu/drm/meson/meson_drv.c       |  383 +++++++++
>>  drivers/gpu/drm/meson/meson_drv.h       |   68 ++
>>  drivers/gpu/drm/meson/meson_plane.c     |  150 ++++
>>  drivers/gpu/drm/meson/meson_plane.h     |   32 +
>>  drivers/gpu/drm/meson/meson_registers.h | 1395 +++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/meson/meson_vclk.c      |  169 ++++
>>  drivers/gpu/drm/meson/meson_vclk.h      |   36 +
>>  drivers/gpu/drm/meson/meson_venc.c      |  286 +++++++
>>  drivers/gpu/drm/meson/meson_venc.h      |   77 ++
>>  drivers/gpu/drm/meson/meson_viu.c       |  497 +++++++++++
>>  drivers/gpu/drm/meson/meson_viu.h       |   37 +
>>  drivers/gpu/drm/meson/meson_vpp.c       |  189 +++++
>>  drivers/gpu/drm/meson/meson_vpp.h       |   43 +
>>  23 files changed, 4040 insertions(+)
>>  create mode 100644 drivers/gpu/drm/meson/Kconfig
>>  create mode 100644 drivers/gpu/drm/meson/Makefile
>>  create mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_canvas.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_crtc.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_crtc.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_cvbs.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_cvbs.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_drv.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_drv.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_plane.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_plane.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_registers.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_vclk.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_vclk.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_venc.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_venc.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_viu.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_viu.h
>>  create mode 100644 drivers/gpu/drm/meson/meson_vpp.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_vpp.h
>>

[...]

>> +
>> +static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
>> +				    struct drm_crtc_state *state)
>> +{
>> +	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>> +	unsigned long flags;
>> +
>> +	if (crtc->state->event) {
>> +		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
>> +
>> +		spin_lock_irqsave(&crtc->dev->event_lock, flags);
>> +		meson_crtc->event = crtc->state->event;
>> +		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
>> +		crtc->state->event = NULL;
> 
> If you set this to NULL here
>> +	}
>> +}
>> +
>> +static void meson_crtc_atomic_flush(struct drm_crtc *crtc,
>> +				    struct drm_crtc_state *old_crtc_state)
>> +{
>> +	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>> +	struct drm_pending_vblank_event *event = crtc->state->event;
>> +
>> +	if (meson_crtc->priv->viu.osd1_enabled)
>> +		meson_crtc->priv->viu.osd1_commit = true;
>> +
>> +	if (event) {
>> +		crtc->state->event = NULL;
>> +
>> +		spin_lock_irq(&crtc->dev->event_lock);
>> +		if (drm_crtc_vblank_get(crtc) == 0)
>> +			drm_crtc_arm_vblank_event(crtc, event);
>> +		else
>> +			drm_crtc_send_vblank_event(crtc, event);
>> +		spin_unlock_irq(&crtc->dev->event_lock);
>> +	}
> 
> This here becomes dead code. And indeed it is, since you have your own
> special crtc/vblank irq handling code right below. Please remove to avoid
> confusion.

Ok, will clarify.

> 
>> +}
>> +
>> +static const struct drm_crtc_helper_funcs meson_crtc_helper_funcs = {
>> +	.enable		= meson_crtc_enable,
>> +	.disable	= meson_crtc_disable,
>> +	.atomic_begin	= meson_crtc_atomic_begin,
>> +	.atomic_flush	= meson_crtc_atomic_flush,
>> +};
>> +
>> +void meson_crtc_irq(struct meson_drm *priv)
>> +{
>> +	struct meson_crtc *meson_crtc = to_meson_crtc(priv->crtc);
>> +	unsigned long flags;
>> +
>> +	meson_viu_sync_osd1(priv);
>> +
>> +	drm_crtc_handle_vblank(priv->crtc);
>> +
>> +	spin_lock_irqsave(&priv->drm->event_lock, flags);
>> +	if (meson_crtc->event) {
>> +		drm_crtc_send_vblank_event(priv->crtc, meson_crtc->event);
>> +		drm_crtc_vblank_put(priv->crtc);
>> +		meson_crtc->event = NULL;
>> +	}
>> +	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
>> +}
>> +

[...]

>> +
>> +static int meson_cvbs_encoder_atomic_check(struct drm_encoder *encoder,
>> +					struct drm_crtc_state *crtc_state,
>> +					struct drm_connector_state *conn_state)
>> +{
>> +	return 0;
>> +}
> 
> Dummy atomic_check isn't needed, pls remove.

OK, with your following comments, will replace with a proper mode check here.

>> +
>> +static void meson_cvbs_encoder_disable(struct drm_encoder *encoder)
>> +{
>> +	struct meson_cvbs *meson_cvbs = encoder_to_meson_cvbs(encoder);
>> +
>> +	meson_venci_cvbs_disable(meson_cvbs->priv);
>> +}
>> +
>> +static void meson_cvbs_encoder_enable(struct drm_encoder *encoder)
>> +{
>> +	struct meson_cvbs *meson_cvbs = encoder_to_meson_cvbs(encoder);
>> +
>> +	meson_venci_cvbs_enable(meson_cvbs->priv);
>> +}
> 
> Personally I'd remove the indirection above, more direct code is easier to
> read.

I understand, I'll maybe change the meson_venci_cvbs_XXable to be directly added to the ops.

I want to keep the registers setup in separate files and keep a clean DRM/HW separation.

>> +
>> +static void meson_cvbs_encoder_mode_set(struct drm_encoder *encoder,
>> +				   struct drm_display_mode *mode,
>> +				   struct drm_display_mode *adjusted_mode)
>> +{
>> +	struct meson_cvbs *meson_cvbs = encoder_to_meson_cvbs(encoder);
>> +	int i;
>> +
>> +	drm_mode_debug_printmodeline(mode);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(meson_cvbs_modes); ++i) {
>> +		struct meson_cvbs_mode *meson_mode = &meson_cvbs_modes[i];
>> +
>> +		if (drm_mode_equal(mode, &meson_mode->mode)) {
>> +			meson_cvbs->mode = meson_mode;
>> +
>> +			meson_venci_cvbs_mode_set(meson_cvbs->priv,
>> +						  meson_mode->enci);
>> +			break;
>> +		}
>> +	}
>> +}
> 
> What happens if userspace sets a mode you don't have? I guess you do need
> a real atomic_check, so you can return -EINVAL if that's the case ;-)

Will add a proper atomic_check !

> 
>> +
>> +static const struct drm_encoder_helper_funcs meson_cvbs_encoder_helper_funcs = {
>> +	.atomic_check	= meson_cvbs_encoder_atomic_check,
>> +	.disable	= meson_cvbs_encoder_disable,
>> +	.enable		= meson_cvbs_encoder_enable,
>> +	.mode_set	= meson_cvbs_encoder_mode_set,
>> +};
>> +
>> +/* Connector */
>> +
>> +static void meson_cvbs_connector_destroy(struct drm_connector *connector)
>> +{
>> +	drm_connector_cleanup(connector);
>> +}
>> +
>> +static enum drm_connector_status
>> +meson_cvbs_connector_detect(struct drm_connector *connector, bool force)
>> +{
> 
> FIXME: Implement load-detect?

Actually it's not implemented anywhere on Amlogic SoCs, will add a FIXME comment here !

> 
>> +	return connector_status_connected;
>> +}
>> +
>> +static int meson_cvbs_connector_get_modes(struct drm_connector *connector)
>> +{
>> +	struct drm_device *dev = connector->dev;
>> +	struct drm_display_mode *mode;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(meson_cvbs_modes); ++i) {
>> +		struct meson_cvbs_mode *meson_mode = &meson_cvbs_modes[i];
>> +
>> +		mode = drm_mode_duplicate(dev, &meson_mode->mode);
>> +		if (!mode) {
>> +			DRM_ERROR("Failed to create a new display mode\n");
>> +			return 0;
>> +		}
>> +
>> +		drm_mode_probed_add(connector, mode);
>> +	}
>> +
>> +	return i;
>> +}
>> +
>> +static int meson_cvbs_connector_mode_valid(struct drm_connector *connector,
>> +					   struct drm_display_mode *mode)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(meson_cvbs_modes); ++i) {
>> +		struct meson_cvbs_mode *meson_mode = &meson_cvbs_modes[i];
>> +
>> +		if (drm_mode_equal(mode, &meson_mode->mode))
>> +			return MODE_OK;
>> +	}
>> +
>> +	return MODE_BAD;
>> +}
> 
> Ok, this is confusion, but I thought the docs explain this. mode_valid is
> only to validate the modes added in get_modes. This is useful for outputs
> which add modes from an EDID, but not in this case. Having a mode_valid
> unfortunately doesn't ensure that these modes will be rejected in a
> modeset, for that you need a separate mode_fixup or atomic_check on the
> encoder.
> 
> It's a bit a long-standing issue, but not entirely non-trivial to fix up:
> In the general case the atomic_check is for a specific configuration,
> whereaas mode_valid must only filter modes that won't work in any
> configuration. For display blocks with lots of shared resources there's a
> big difference between the two.
> 
> Please double-check the kerneldoc for all these hooks, and if this is not
> clearly enough explained for you then pls raise this (or even better,
> submit at patch).

OK, for now it seems quite clear, but I clearly missed the atomic_check case.

> 
>> +
>> +static const struct drm_connector_funcs meson_cvbs_connector_funcs = {
>> +	.dpms			= drm_atomic_helper_connector_dpms,
>> +	.detect			= meson_cvbs_connector_detect,
>> +	.fill_modes		= drm_helper_probe_single_connector_modes,
>> +	.destroy		= meson_cvbs_connector_destroy,
>> +	.reset			= drm_atomic_helper_connector_reset,
>> +	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
>> +	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
>> +};
>> +

[...]

>> +
>> +static int meson_drv_bind(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct meson_drm *priv;
>> +	struct drm_device *drm;
>> +	struct resource *res;
>> +	void __iomem *regs;
>> +	int ret;
>> +
>> +	drm = drm_dev_alloc(&meson_driver, dev);
>> +	if (IS_ERR(drm))
>> +		return PTR_ERR(drm);
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv) {
>> +		ret = -ENOMEM;
>> +		goto free_drm;
>> +	}
>> +	drm->dev_private = priv;
>> +	priv->drm = drm;
>> +	priv->dev = dev;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "base");
>> +	regs = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +
>> +	priv->io_base = regs;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
>> +	/* Simply ioremap since it may be a shared register zone */
>> +	regs = devm_ioremap(dev, res->start, resource_size(res));
>> +	if (!regs)
>> +		return -EADDRNOTAVAIL;
>> +
>> +	priv->hhi = devm_regmap_init_mmio(dev, regs,
>> +					  &meson_regmap_config);
>> +	if (IS_ERR(priv->hhi)) {
>> +		dev_err(&pdev->dev, "Couldn't create the HHI regmap\n");
>> +		return PTR_ERR(priv->hhi);
>> +	}
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
>> +	/* Simply ioremap since it may be a shared register zone */
>> +	regs = devm_ioremap(dev, res->start, resource_size(res));
>> +	if (!regs)
>> +		return -EADDRNOTAVAIL;
>> +
>> +	priv->dmc = devm_regmap_init_mmio(dev, regs,
>> +					  &meson_regmap_config);
>> +	if (IS_ERR(priv->dmc)) {
>> +		dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
>> +		return PTR_ERR(priv->dmc);
>> +	}
>> +
>> +	priv->vsync_irq = platform_get_irq(pdev, 0);
>> +
>> +	/* Hardware Initialization */
>> +
>> +	meson_vpp_init(priv);
>> +	meson_viu_init(priv);
>> +	meson_venc_init(priv);
>> +
>> +	drm_vblank_init(drm, 1);
>> +	drm_mode_config_init(drm);
>> +
>> +	/* Components Initialization */
>> +
>> +	ret = component_bind_all(drm->dev, drm);
>> +	if (ret) {
>> +		dev_err(drm->dev, "Couldn't bind all components\n");
>> +		goto free_drm;
>> +	}
>> +
>> +	ret = meson_plane_create(priv);
>> +	if (ret)
>> +		goto free_drm;
>> +
>> +	ret = meson_crtc_create(priv);
>> +	if (ret)
>> +		goto free_drm;
>> +
>> +	ret = drm_irq_install(drm, priv->vsync_irq);
>> +	if (ret)
>> +		goto free_drm;
>> +
>> +	drm_mode_config_reset(drm);
>> +	drm->mode_config.max_width = 8192;
>> +	drm->mode_config.max_height = 8192;
>> +	drm->mode_config.funcs = &meson_mode_config_funcs;
>> +
>> +	priv->fbdev = drm_fbdev_cma_init(drm, 32,
>> +					 drm->mode_config.num_crtc,
>> +					 drm->mode_config.num_connector);
>> +	if (IS_ERR(priv->fbdev)) {
>> +		ret = PTR_ERR(priv->fbdev);
>> +		goto free_drm;
>> +	}
>> +
>> +	drm_kms_helper_poll_init(drm);
>> +
>> +	ret = drm_dev_register(drm, 0);
>> +	if (ret)
>> +		goto free_drm;
>> +
>> +	platform_set_drvdata(pdev, priv);
> 
> You need this before the drm_dev_register call I think.

Would be cleaner indeed.

>> +
>> +	return 0;
>> +
>> +free_drm:
>> +	drm_dev_unref(drm);
>> +
>> +	return ret;
>> +}
>> +

[...]

>> +
>> +static int meson_plane_atomic_check(struct drm_plane *plane,
>> +				    struct drm_plane_state *state)
>> +{
>> +	struct drm_rect src = {
>> +		.x1 = state->src_x,
>> +		.y1 = state->src_y,
>> +		.x2 = state->src_x + state->src_w,
>> +		.y2 = state->src_y + state->src_h,
>> +	};
>> +	struct drm_rect dest = {
>> +		.x1 = state->crtc_x,
>> +		.y1 = state->crtc_y,
>> +		.x2 = state->crtc_x + state->crtc_w,
>> +		.y2 = state->crtc_y + state->crtc_h,
>> +	};
>> +
>> +	if (state->fb) {
>> +		int ret;
>> +
>> +		ret = drm_rect_calc_hscale(&src, &dest,
>> +					   DRM_PLANE_HELPER_NO_SCALING,
>> +					   DRM_PLANE_HELPER_NO_SCALING);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret = drm_rect_calc_vscale(&src, &dest,
>> +					   DRM_PLANE_HELPER_NO_SCALING,
>> +					   DRM_PLANE_HELPER_NO_SCALING);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
> 
> drm_plane_helper_check_state gives you the above in less code.

Ok

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void meson_plane_atomic_update(struct drm_plane *plane,
>> +				      struct drm_plane_state *old_state)
>> +{
>> +	struct meson_plane *meson_plane = to_meson_plane(plane);
>> +
>> +	/*
>> +	 * Update Coordinates
>> +	 * Update Formats
>> +	 * Update Buffer
>> +	 * Enable Plane
>> +	 */
>> +	meson_viu_update_osd1(meson_plane->priv, plane);
>> +	meson_canvas_update_osd1_buffer(meson_plane->priv, plane);
>> +}
>> +

[...]

>> +
>> +void meson_viu_update_osd1(struct meson_drm *priv, struct drm_plane *plane)
>> +{
>> +	struct drm_plane_state *state = plane->state;
>> +	struct drm_framebuffer *fb = state->fb;
>> +	struct drm_rect src = {
>> +		.x1 = (state->src_x),
>> +		.y1 = (state->src_y),
>> +		.x2 = (state->src_x + state->src_w),
>> +		.y2 = (state->src_y + state->src_h),
>> +	};
>> +	struct drm_rect dest = {
>> +		.x1 = state->crtc_x,
>> +		.y1 = state->crtc_y,
>> +		.x2 = state->crtc_x + state->crtc_w,
>> +		.y2 = state->crtc_y + state->crtc_h,
>> +	};
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&priv->drm->event_lock, flags);
>> +
>> +	/* Enable OSD and BLK0, set max global alpha */
>> +	priv->viu.osd1_ctrl_stat = OSD_ENABLE |
>> +				   (0xFF << OSD_GLOBAL_ALPHA_SHIFT) |
>> +				   OSD_BLK0_ENABLE;
>> +
>> +	/* Set up BLK0 to point to the right canvas */
>> +	priv->viu.osd1_blk0_cfg[0] = ((MESON_CANVAS_ID_OSD1 << OSD_CANVAS_SEL) |
>> +				      OSD_ENDIANNESS_LE);
>> +
>> +	/* On GXBB, Use the old non-HDR RGB2YUV converter */
>> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>> +		priv->viu.osd1_blk0_cfg[0] |= OSD_OUTPUT_COLOR_RGB;
>> +
>> +	switch (fb->pixel_format) {
>> +	case DRM_FORMAT_XRGB8888:
>> +		/* For XRGB, replace the pixel's alpha by 0xFF */
>> +		writel_bits_relaxed(OSD_REPLACE_EN, OSD_REPLACE_EN,
>> +				    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
>> +		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
>> +					      OSD_COLOR_MATRIX_32_ARGB;
>> +		break;
>> +	case DRM_FORMAT_ARGB8888:
>> +		/* For ARGB, use the pixel's alpha */
>> +		writel_bits_relaxed(OSD_REPLACE_EN, 0,
>> +				    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
>> +		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
>> +					      OSD_COLOR_MATRIX_32_ARGB;
>> +		break;
>> +	case DRM_FORMAT_RGB888:
>> +		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_24 |
>> +					      OSD_COLOR_MATRIX_24_RGB;
>> +		break;
>> +	case DRM_FORMAT_RGB565:
>> +		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_16 |
>> +					      OSD_COLOR_MATRIX_16_RGB565;
>> +		break;
>> +	};
>> +
>> +	if (state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE) {
>> +		priv->viu.osd1_interlace = true;
>> +
>> +		dest.y1 /= 2;
>> +		dest.y2 /= 2;
>> +	} else {
>> +		priv->viu.osd1_interlace = true;
>> +		meson_vpp_disable_interlace_vscaler_osd1(priv);
>> +	}
>> +
>> +	/*
>> +	 * The format of these registers is (x2 << 16 | x1),
>> +	 * where x2 is exclusive.
>> +	 * e.g. +30x1920 would be (1919 << 16) | 30
>> +	 */
>> +	priv->viu.osd1_blk0_cfg[1] = ((fixed16_to_int(src.x2) - 1) << 16) |
>> +					fixed16_to_int(src.x1);
>> +	priv->viu.osd1_blk0_cfg[2] = ((fixed16_to_int(src.y2) - 1) << 16) |
>> +					fixed16_to_int(src.y1);
>> +	priv->viu.osd1_blk0_cfg[3] = ((dest.x2 - 1) << 16) | dest.x1;
>> +	priv->viu.osd1_blk0_cfg[4] = ((dest.y2 - 1) << 16) | dest.y1;
>> +
>> +	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
>> +}
>> +
>> +void meson_viu_sync_osd1(struct meson_drm *priv)
>> +{
>> +	/* Update the OSD registers */
>> +	if (priv->viu.osd1_enabled && priv->viu.osd1_commit) {
>> +		writel_relaxed(priv->viu.osd1_ctrl_stat,
>> +				priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
>> +		writel_relaxed(priv->viu.osd1_blk0_cfg[0],
>> +				priv->io_base + _REG(VIU_OSD1_BLK0_CFG_W0));
>> +		writel_relaxed(priv->viu.osd1_blk0_cfg[1],
>> +				priv->io_base + _REG(VIU_OSD1_BLK0_CFG_W1));
>> +		writel_relaxed(priv->viu.osd1_blk0_cfg[2],
>> +				priv->io_base + _REG(VIU_OSD1_BLK0_CFG_W2));
>> +		writel_relaxed(priv->viu.osd1_blk0_cfg[3],
>> +				priv->io_base + _REG(VIU_OSD1_BLK0_CFG_W3));
>> +		writel_relaxed(priv->viu.osd1_blk0_cfg[4],
>> +				priv->io_base + _REG(VIU_OSD1_BLK0_CFG_W4));
>> +
>> +		if (priv->viu.osd1_interlace) {
>> +			struct drm_plane *plane = priv->primary_plane;
>> +			struct drm_plane_state *state = plane->state;
>> +			struct drm_rect dest = {
>> +				.x1 = state->crtc_x,
>> +				.y1 = state->crtc_y,
>> +				.x2 = state->crtc_x + state->crtc_w,
>> +				.y2 = state->crtc_y + state->crtc_h,
>> +			};
>> +
>> +			meson_vpp_setup_interlace_vscaler_osd1(priv, &dest);
>> +		}
>> +
>> +		meson_vpp_enable_osd1(priv);
>> +
>> +		priv->viu.osd1_commit = false;
>> +	}
>> +}
> 
> Again I'd remove the indirection and for these put them into your plane
> implementation directly.

OK, I'll make them callable from the DRM ops directly.

> 
>> +
>> +
>> +/* OSD csc defines */
>> +
>> +enum viu_matrix_sel_e {
>> +	VIU_MATRIX_OSD_EOTF = 0,
>> +	VIU_MATRIX_OSD,
>> +};
>> +
>> +enum viu_lut_sel_e {
>> +	VIU_LUT_OSD_EOTF = 0,
>> +	VIU_LUT_OSD_OETF,
>> +};
>> +
>> +#define COEFF_NORM(a) ((int)((((a) * 2048.0) + 1) / 2))
>> +#define MATRIX_5X3_COEF_SIZE 24
>> +
>> +#define EOTF_COEFF_NORM(a) ((int)((((a) * 4096.0) + 1) / 2))
>> +#define EOTF_COEFF_SIZE 10
>> +#define EOTF_COEFF_RIGHTSHIFT 1
>> +
>> +static int RGB709_to_YUV709l_coeff[MATRIX_5X3_COEF_SIZE] = {
>> +	0, 0, 0, /* pre offset */
>> +	COEFF_NORM(0.181873),	COEFF_NORM(0.611831),	COEFF_NORM(0.061765),
>> +	COEFF_NORM(-0.100251),	COEFF_NORM(-0.337249),	COEFF_NORM(0.437500),
>> +	COEFF_NORM(0.437500),	COEFF_NORM(-0.397384),	COEFF_NORM(-0.040116),
>> +	0, 0, 0, /* 10'/11'/12' */
>> +	0, 0, 0, /* 20'/21'/22' */
>> +	64, 512, 512, /* offset */
>> +	0, 0, 0 /* mode, right_shift, clip_en */
>> +};
>> +
>> +/*  eotf matrix: bypass */
>> +static int eotf_bypass_coeff[EOTF_COEFF_SIZE] = {
>> +	EOTF_COEFF_NORM(1.0),	EOTF_COEFF_NORM(0.0),	EOTF_COEFF_NORM(0.0),
>> +	EOTF_COEFF_NORM(0.0),	EOTF_COEFF_NORM(1.0),	EOTF_COEFF_NORM(0.0),
>> +	EOTF_COEFF_NORM(0.0),	EOTF_COEFF_NORM(0.0),	EOTF_COEFF_NORM(1.0),
>> +	EOTF_COEFF_RIGHTSHIFT /* right shift */
>> +};
>> +
>> +void meson_viu_set_osd_matrix(struct meson_drm *priv,
>> +			      enum viu_matrix_sel_e m_select,
>> +			      int *m, bool csc_on)
>> +{
>> +	if (m_select == VIU_MATRIX_OSD) {
>> +		/* osd matrix, VIU_MATRIX_0 */
>> +		writel(((m[0] & 0xfff) << 16) | (m[1] & 0xfff),
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_PRE_OFFSET0_1));
>> +		writel(m[2] & 0xfff,
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_PRE_OFFSET2));
>> +		writel(((m[3] & 0x1fff) << 16) | (m[4] & 0x1fff),
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_COEF00_01));
>> +		writel(((m[5] & 0x1fff) << 16) | (m[6] & 0x1fff),
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_COEF02_10));
>> +		writel(((m[7] & 0x1fff) << 16) | (m[8] & 0x1fff),
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_COEF11_12));
>> +		writel(((m[9] & 0x1fff) << 16) | (m[10] & 0x1fff),
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_COEF20_21));
>> +
>> +		if (m[21]) {
>> +			writel(((m[11] & 0x1fff) << 16) | (m[12] & 0x1fff),
>> +				priv->io_base +
>> +					_REG(VIU_OSD1_MATRIX_COEF22_30));
>> +			writel(((m[13] & 0x1fff) << 16) | (m[14] & 0x1fff),
>> +				priv->io_base +
>> +					_REG(VIU_OSD1_MATRIX_COEF31_32));
>> +			writel(((m[15] & 0x1fff) << 16) | (m[16] & 0x1fff),
>> +				priv->io_base +
>> +					_REG(VIU_OSD1_MATRIX_COEF40_41));
>> +			writel(m[17] & 0x1fff, priv->io_base +
>> +				_REG(VIU_OSD1_MATRIX_COLMOD_COEF42));
>> +		} else
>> +			writel((m[11] & 0x1fff) << 16, priv->io_base +
>> +				_REG(VIU_OSD1_MATRIX_COEF22_30));
>> +
>> +		writel(((m[18] & 0xfff) << 16) | (m[19] & 0xfff),
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_OFFSET0_1));
>> +		writel(m[20] & 0xfff,
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_OFFSET2));
>> +
>> +		writel_bits_relaxed(3 << 30, m[21] << 30,
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_COLMOD_COEF42));
>> +		writel_bits_relaxed(7 << 16, m[22] << 16,
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_COLMOD_COEF42));
>> +
>> +		/* 23 reserved for clipping control */
>> +		writel_bits_relaxed(BIT(0), csc_on ? BIT(0) : 0,
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_CTRL));
>> +		writel_bits_relaxed(BIT(1), 0,
>> +			priv->io_base + _REG(VIU_OSD1_MATRIX_CTRL));
>> +	} else if (m_select == VIU_MATRIX_OSD_EOTF) {
>> +		int i;
>> +
>> +		/* osd eotf matrix, VIU_MATRIX_OSD_EOTF */
>> +		for (i = 0; i < 5; i++)
>> +			writel(((m[i * 2] & 0x1fff) << 16) |
>> +				(m[i * 2 + 1] & 0x1fff), priv->io_base +
>> +				_REG(VIU_OSD1_EOTF_CTL + i + 1));
>> +
>> +		writel_bits_relaxed(BIT(30), csc_on ? BIT(30) : 0,
>> +			priv->io_base + _REG(VIU_OSD1_EOTF_CTL));
>> +		writel_bits_relaxed(BIT(31), csc_on ? BIT(31) : 0,
>> +			priv->io_base + _REG(VIU_OSD1_EOTF_CTL));
>> +	}
>> +}
>> +
>> +#define OSD_EOTF_LUT_SIZE 33
>> +#define OSD_OETF_LUT_SIZE 41
>> +
>> +void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
>> +			   unsigned int *r_map, unsigned int *g_map,
>> +			   unsigned int *b_map,
>> +			   bool csc_on)
>> +{
>> +	unsigned int addr_port;
>> +	unsigned int data_port;
>> +	unsigned int ctrl_port;
>> +	int i;
>> +
>> +	if (lut_sel == VIU_LUT_OSD_EOTF) {
>> +		addr_port = VIU_OSD1_EOTF_LUT_ADDR_PORT;
>> +		data_port = VIU_OSD1_EOTF_LUT_DATA_PORT;
>> +		ctrl_port = VIU_OSD1_EOTF_CTL;
>> +	} else if (lut_sel == VIU_LUT_OSD_OETF) {
>> +		addr_port = VIU_OSD1_OETF_LUT_ADDR_PORT;
>> +		data_port = VIU_OSD1_OETF_LUT_DATA_PORT;
>> +		ctrl_port = VIU_OSD1_OETF_CTL;
>> +	} else
>> +		return;
>> +
>> +	if (lut_sel == VIU_LUT_OSD_OETF) {
>> +		writel(0, priv->io_base + _REG(addr_port));
>> +
>> +		for (i = 0; i < 20; i++)
>> +			writel(r_map[i * 2] | (r_map[i * 2 + 1] << 16),
>> +				priv->io_base + _REG(data_port));
>> +
>> +		writel(r_map[OSD_OETF_LUT_SIZE - 1] | (g_map[0] << 16),
>> +			priv->io_base + _REG(data_port));
>> +
>> +		for (i = 0; i < 20; i++)
>> +			writel(g_map[i * 2 + 1] | (g_map[i * 2 + 2] << 16),
>> +				priv->io_base + _REG(data_port));
>> +
>> +		for (i = 0; i < 20; i++)
>> +			writel(b_map[i * 2] | (b_map[i * 2 + 1] << 16),
>> +				priv->io_base + _REG(data_port));
>> +
>> +		writel(b_map[OSD_OETF_LUT_SIZE - 1],
>> +			priv->io_base + _REG(data_port));
>> +
>> +		if (csc_on)
>> +			writel_bits_relaxed(0x7 << 29, 7 << 29,
>> +					    priv->io_base + _REG(ctrl_port));
>> +		else
>> +			writel_bits_relaxed(0x7 << 29, 0,
>> +					    priv->io_base + _REG(ctrl_port));
>> +	} else if (lut_sel == VIU_LUT_OSD_EOTF) {
>> +		writel(0, priv->io_base + _REG(addr_port));
>> +
>> +		for (i = 0; i < 20; i++)
>> +			writel(r_map[i * 2] | (r_map[i * 2 + 1] << 16),
>> +				priv->io_base + _REG(data_port));
>> +
>> +		writel(r_map[OSD_EOTF_LUT_SIZE - 1] | (g_map[0] << 16),
>> +			priv->io_base + _REG(data_port));
>> +
>> +		for (i = 0; i < 20; i++)
>> +			writel(g_map[i * 2 + 1] | (g_map[i * 2 + 2] << 16),
>> +				priv->io_base + _REG(data_port));
>> +
>> +		for (i = 0; i < 20; i++)
>> +			writel(b_map[i * 2] | (b_map[i * 2 + 1] << 16),
>> +				priv->io_base + _REG(data_port));
>> +
>> +		writel(b_map[OSD_EOTF_LUT_SIZE - 1],
>> +			priv->io_base + _REG(data_port));
>> +
>> +		if (csc_on)
>> +			writel_bits_relaxed(7 << 27, 7 << 27,
>> +					    priv->io_base + _REG(ctrl_port));
>> +		else
>> +			writel_bits_relaxed(7 << 27, 0,
>> +					    priv->io_base + _REG(ctrl_port));
>> +
>> +		writel_bits_relaxed(BIT(31), BIT(31),
>> +				    priv->io_base + _REG(ctrl_port));
>> +	}
>> +}
>> +
>> +/* eotf lut: linear */
>> +static unsigned int eotf_33_linear_mapping[OSD_EOTF_LUT_SIZE] = {
>> +	0x0000,	0x0200,	0x0400, 0x0600,
>> +	0x0800, 0x0a00, 0x0c00, 0x0e00,
>> +	0x1000, 0x1200, 0x1400, 0x1600,
>> +	0x1800, 0x1a00, 0x1c00, 0x1e00,
>> +	0x2000, 0x2200, 0x2400, 0x2600,
>> +	0x2800, 0x2a00, 0x2c00, 0x2e00,
>> +	0x3000, 0x3200, 0x3400, 0x3600,
>> +	0x3800, 0x3a00, 0x3c00, 0x3e00,
>> +	0x4000
>> +};
>> +
>> +/* osd oetf lut: linear */
>> +static unsigned int oetf_41_linear_mapping[OSD_OETF_LUT_SIZE] = {
>> +	0, 0, 0, 0,
>> +	0, 32, 64, 96,
>> +	128, 160, 196, 224,
>> +	256, 288, 320, 352,
>> +	384, 416, 448, 480,
>> +	512, 544, 576, 608,
>> +	640, 672, 704, 736,
>> +	768, 800, 832, 864,
>> +	896, 928, 960, 992,
>> +	1023, 1023, 1023, 1023,
>> +	1023
>> +};
> 
> Might be fun to expose this using the color manager stuff, see
> drm_crtc_enable_color_mgmt().

Yes, I'll use them when the HDMI stuff lands ! This will certainly need such helpers !

>> +
>> +static void meson_viu_load_matrix(struct meson_drm *priv)
>> +{
>> +	/* eotf lut bypass */
>> +	meson_viu_set_osd_lut(priv, VIU_LUT_OSD_EOTF,
>> +			      eotf_33_linear_mapping, /* R */
>> +			      eotf_33_linear_mapping, /* G */
>> +			      eotf_33_linear_mapping, /* B */
>> +			      false);
>> +
>> +	/* eotf matrix bypass */
>> +	meson_viu_set_osd_matrix(priv, VIU_MATRIX_OSD_EOTF,
>> +				 eotf_bypass_coeff,
>> +				 false);
>> +
>> +	/* oetf lut bypass */
>> +	meson_viu_set_osd_lut(priv, VIU_LUT_OSD_OETF,
>> +			      oetf_41_linear_mapping, /* R */
>> +			      oetf_41_linear_mapping, /* G */
>> +			      oetf_41_linear_mapping, /* B */
>> +			      false);
>> +
>> +	/* osd matrix RGB709 to YUV709 limit */
>> +	meson_viu_set_osd_matrix(priv, VIU_MATRIX_OSD,
>> +				 RGB709_to_YUV709l_coeff,
>> +				 true);
>> +}
>> +

Neil
