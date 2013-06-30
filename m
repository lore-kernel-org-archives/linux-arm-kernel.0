From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Jun 2013 13:52:38 +0100
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130630115941.GG18285@phenom.ffwll.local>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
Message-ID: <20130630125238.GH3353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 30, 2013 at 01:59:41PM +0200, Daniel Vetter wrote:
> On Sat, Jun 29, 2013 at 11:53:22PM +0100, Russell King wrote:
> > +static uint32_t armada_drm_crtc_calculate_csc(struct armada_crtc *dcrtc)
> > +{
> > +	struct drm_display_mode *adj = &dcrtc->crtc.mode;
> > +	uint32_t val = 0;
> > +
> > +	if (dcrtc->csc_yuv_mode == CSC_YUV_CCIR709)
> > +		val |= CFG_CSC_YUV_CCIR709;
> > +	if (dcrtc->csc_rgb_mode == CSC_RGB_STUDIO)
> > +		val |= CFG_CSC_RGB_STUDIO;
> > +
> > +	/*
> > +	 * In auto mode, set the colorimetry, based upon the HDMI spec.
> > +	 * 1280x720p, 1920x1080p and 1920x1080i use ITU709, others use
> > +	 * ITU601.  It may be more appropriate to set this depending on
> > +	 * the source - but what if the graphic frame is YUV and the
> > +	 * video frame is RGB?
> > +	 */
> > +	if ((adj->hdisplay == 1280 && adj->vdisplay == 720 &&
> > +	     !(adj->flags & DRM_MODE_FLAG_INTERLACE)) ||
> > +	    (adj->hdisplay == 1920 && adj->vdisplay == 1080)) {
> > +		if (dcrtc->csc_yuv_mode == CSC_AUTO)
> > +			val |= CFG_CSC_YUV_CCIR709;
> > +	}
> > +
> > +	/*
> > +	 * We assume we're connected to a TV-like device, so the YUV->RGB
> > +	 * conversion should produce a limited range.  We should set this
> > +	 * depending on the connectors attached to this CRTC, and what
> > +	 * kind of device they report being connected.
> > +	 */
> > +	if (dcrtc->csc_rgb_mode == CSC_AUTO)
> > +		val |= CFG_CSC_RGB_STUDIO;
> 
> In the intel driver we check whether it's an cea mode with
> drm_match_cea_mode, e.g. in intel_hdmi.c:
> 
> 	if (intel_hdmi->color_range_auto) {
> 		/* See CEA-861-E - 5.1 Default Encoding Parameters */
> 		if (intel_hdmi->has_hdmi_sink &&
> 		    drm_match_cea_mode(adjusted_mode) > 1)
> 			intel_hdmi->color_range = HDMI_COLOR_RANGE_16_235;
> 		else
> 			intel_hdmi->color_range = 0;
> 	}
> 
> (The color_range gets then propageted to the right place since different
> platforms have different ways to do that in intel hw).

Unfortunately, this disagrees with the HDMI v1.3a specification:

| Default Colorimetry
| 
| ...
| 
| 480p, 480i, 576p, 576i, 240p and 288p
| 
| The default colorimetry for all 480-line, 576-line, 240-line, and 288-line
| video formats described in CEA-861-D is based on SMPTE 170M.
| 
| 1080i, 1080p and 720p
| 
| The default colorimetry for high-definition video formats (1080i, 1080p and
| 720p) described in CEA-861-D is based on ITU-R BT.709-5.

As the HDMI spec refers to the CEA-861 specs, the HDMI spec overrides
CEA when dealing with HDMI specifics.

So, according to the HDMI specification, the default is that it's only
1080i, 1080p and 720p which are 709, the others are 601.  This does not
correspond with "drm_match_cea_mode(adjusted_mode) > 1".

Unfortunately, given DRM's structure, there's no way for the CRTC layer
to really know what its driving, and this setting is at the CRTC layer,
not the output layer.  It may be that you have the CRTC duplicated
between two different display devices with different characteristics,
which means you have to "choose" one - or just not bother.  I've chosen
the latter because it's a simpler solution, and is in no way any more
correct than any other solution.

This is also why these are exported to userspace via properties, so if
userspace knows better, it can deal with those issues.

> > +struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
> > +	struct drm_mode_fb_cmd2 *mode, struct armada_gem_object *obj)
> > +{
> > +	struct armada_framebuffer *dfb;
> > +	uint8_t format, config;
> > +	int ret;
> > +
> > +	switch (mode->pixel_format) {
> > +#define FMT(drm, fmt, mod)		\
> > +	case DRM_FORMAT_##drm:		\
> > +		format = CFG_##fmt;	\
> > +		config = mod;		\
> > +		break
> > +	FMT(RGB565,	565,		CFG_SWAPRB);
> > +	FMT(BGR565,	565,		0);
> > +	FMT(ARGB1555,	1555,		CFG_SWAPRB);
> > +	FMT(ABGR1555,	1555,		0);
> > +	FMT(RGB888,	888PACK,	CFG_SWAPRB);
> > +	FMT(BGR888,	888PACK,	0);
> > +	FMT(XRGB8888,	X888,		CFG_SWAPRB);
> > +	FMT(XBGR8888,	X888,		0);
> > +	FMT(ARGB8888,	8888,		CFG_SWAPRB);
> > +	FMT(ABGR8888,	8888,		0);
> > +	FMT(YUYV,	422PACK,	CFG_YUV2RGB | CFG_SWAPYU | CFG_SWAPUV);
> > +	FMT(UYVY,	422PACK,	CFG_YUV2RGB);
> > +	FMT(VYUY,	422PACK,	CFG_YUV2RGB | CFG_SWAPUV);
> > +	FMT(YVYU,	422PACK,	CFG_YUV2RGB | CFG_SWAPYU);
> > +	FMT(YUV422,	422,		CFG_YUV2RGB | CFG_SWAPUV);
> > +	FMT(YVU422,	422,		CFG_YUV2RGB);
> > +	FMT(YUV420,	420,		CFG_YUV2RGB | CFG_SWAPUV);
> > +	FMT(YVU420,	420,		CFG_YUV2RGB);
> > +	FMT(C8,		PSEUDO8,	0);
> > +#undef FMT
> > +	default:
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	dfb = kzalloc(sizeof(*dfb), GFP_KERNEL);
> > +	if (!dfb) {
> > +		DRM_ERROR("failed to allocate Armada fb object\n");
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	dfb->fmt = format;
> > +	dfb->mod = config;
> > +
> > +	ret = drm_framebuffer_init(dev, &dfb->fb, &armada_fb_funcs);
> > +	if (ret) {
> > +		kfree(dfb);
> > +		return ERR_PTR(ret);
> > +	}
> 
> drm_framebuffer_init publishes the fb object to the world, hence
> initialization of all invariant state _must_ be done beforehand. This is a
> new requirement since the kms locking rework. So all the below should be
> moved above.

The constant rewriting of DRM is a right pain in the arse.  I'm dealing
with v3.9 here, and v3.9 only... However, it doesn't harm moving the
below so I'll do that.  When v3.10 comes along, that's the kernel I'll
care about, and not v3.10-rcwhatever.

> > +
> > +	drm_helper_mode_fill_fb_struct(&dfb->fb, mode);
> > +
> > +	/*
> > +	 * Take a reference on our object - the caller is expected
> > +	 * to drop their reference to it.
> > +	 */
> > +	drm_gem_object_reference(&obj->obj);
> > +	dfb->obj = obj;
> > +
> > +	return dfb;
> > +}
> 
> [snip]
> 
> > +static int armada_fb_create(struct drm_fb_helper *fbh,
> > +	struct drm_fb_helper_surface_size *sizes)
> > +{
> > +	struct drm_device *dev = fbh->dev;
> > +	struct drm_mode_fb_cmd2 mode;
> > +	struct armada_framebuffer *dfb;
> > +	struct armada_gem_object *obj;
> > +	struct fb_info *info;
> > +	int size, ret;
> > +	void *ptr;
> > +
> > +	memset(&mode, 0, sizeof(mode));
> > +	mode.width = sizes->surface_width;
> > +	mode.height = sizes->surface_height;
> > +	mode.pitches[0] = armada_pitch(mode.width, sizes->surface_bpp);
> > +	mode.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
> > +					sizes->surface_depth);
> > +
> > +	size = mode.pitches[0] * mode.height;
> > +	obj = armada_gem_alloc_private_object(dev, size);
> > +	if (!obj) {
> > +		DRM_ERROR("failed to allocate fb memory\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = armada_gem_linear_back(dev, obj);
> > +	if (ret) {
> > +		drm_gem_object_unreference_unlocked(&obj->obj);
> > +		return ret;
> > +	}
> > +
> > +	ptr = armada_gem_map_object(dev, obj);
> > +	if (!ptr) {
> > +		drm_gem_object_unreference_unlocked(&obj->obj);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dfb = armada_framebuffer_create(dev, &mode, obj);
> > +	if (IS_ERR(dfb)) {
> > +		ret = PTR_ERR(dfb);
> > +		goto err_fbcreate;
> > +	}
> > +
> > +	mutex_lock(&dev->struct_mutex);
> 
> I don't understand what exactly the dev->struct_mutex protects here, I
> think it can be dropped.
> 
> I'm just trying to reduce proliferation of that lock as much as possible,
> since it's deeply interwoven with the legacy drm dragons ...

Bear in mind much of this was written when I had very little clue as to
what DRM required, so there's lots of stuff which was worked out from
the i915 driver - if the i915 driver did something like that, then I
initially copied that pattern.

You may wish to ask the exact same question of the i915 driver which still
takes that lock over a similar section of code.

> > +static int armada_gem_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> > +{
> > +	struct armada_gem_object *obj = drm_to_armada_gem(vma->vm_private_data);
> > +	unsigned long addr = (unsigned long)vmf->virtual_address;
> > +	unsigned long pfn = obj->phys_addr >> PAGE_SHIFT;
> > +	int ret;
> > +
> > +	pfn += (addr - vma->vm_start) >> PAGE_SHIFT;
> > +	ret = vm_insert_pfn(vma, addr, pfn);
> > +
> > +	switch (ret) {
> > +	case -EIO:
> > +	case -EAGAIN:
> > +		set_need_resched();
> > +	case 0:
> > +	case -ERESTARTSYS:
> > +	case -EINTR:
> > +		return VM_FAULT_NOPAGE;
> > +	case -ENOMEM:
> > +		return VM_FAULT_OOM;
> > +	default:
> 
> You don't handle -EBUSY from vm_insert_pfn here. This can happen when
> mulitple threads concurrently fault on the same address. See
> 
> commit e79e0fe380847493266fba557217e2773c61bd1b
> Author: Dmitry Rogozhkin <dmitry.v.rogozhkin@intel.com>
> Date:   Wed Oct 3 17:15:26 2012 +0300
> 
>     drm/i915: EBUSY status handling added to i915_gem_fault().

Ok.

> 
> > +		return VM_FAULT_SIGBUS;
> > +	}
> > +}
> 
> [snip]
> 
> > diff --git a/drivers/gpu/drm/armada/drm_helper.h b/drivers/gpu/drm/armada/drm_helper.h
> > new file mode 100644
> > index 0000000..d9f2e8d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/armada/drm_helper.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * Copyright (C) 2012 Russell King
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#ifndef DRM_HELPER_H
> > +#define DRM_HELPER_H
> > +
> > +/* Useful helpers I wish the DRM core would provide */
> 
> With the addition of variants for connectors/planes and rolling it out in
> drm_crtc.c this sounds like a nice up-front patch. I agree that this
> doesn't really belong in drivers ;-)

If DRM people want to take this and do that, then that's fine, but
otherwise I have more than enough on my plate that moving those and
then fixing up all the DRM drivers is way beyond what I'm prepared
to do.  (Consider that it has been more than two weeks between this
posting and the previous posting...)

In any case, I disagree with the idea that they should find their way
into drm_crtc.c - they're small enough to go into a header file as
inline functions as I've shown in this patch.  Do we really need the
overhead of function calls for this, especially when these may be used
in various fast paths?

However, at least I've taken the time to _think_ about what I'm doing
and realise that there _is_ scope here for the DRM core to improve,
rather than burying this stuff deep inside my driver like everyone else
has.  That's no reason to penalise patches from the "good guys" who think
about what they're doing while accepting drivers from people who don't
(like everyone else who's submitted a DRM driver recently without doing
this.)
