From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 15 Sep 2011 10:15:01 -0400
Subject: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <002c01cc738b$1c717df0$555479d0$%dae@samsung.com>
References: <1315568333-6704-1-git-send-email-inki.dae@samsung.com>
	<20110914214204.GA16666@phenom.oracle.com>
	<002c01cc738b$1c717df0$555479d0$%dae@samsung.com>
Message-ID: <20110915141501.GA19897@phenom.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 06:37:39PM +0900, Inki Dae wrote:
> Hello, Konrad Rzeszutek Wilk.
> 
> Your review and comments are so very detail. it was very helpful. thank you
> again.

.. snip ..
> > > +		/* FIXME: error check */
> > 
> > You might as well do it now - before you do the next posting.
> > 
> 
> Ok, get it. you mean, send this patch modified now, not next posting.?

When you are ready to send V5 (hopefully the last version) of these patches.

.. snip..
> > > + * @ops: pointer to samsung_drm_overlay_ops.
> > > + *
> > > + * this structure is common to Samsung SoC and would be copied
> > > + * to hardware specific overlay info.
> > 
> > Uh?
> 
> This means that contents of samsung_drm_overlay object will copied to fimd's
> one, struct fimd_win_data.

Ok, lets use that comment instead then.
> 
> > > + */
> > > +struct samsung_drm_overlay {
> > > +	unsigned int offset_x;
> > > +	unsigned int offset_y;
> > > +	unsigned int width;
> > > +	unsigned int height;
> > > +	unsigned int paddr;
> > 
> > You don't want to use 'dma_addr_t' ?
> > 
> 
> You are right. I will correct it. thank you.
> 
> > > +	void __iomem *vaddr;
> > > +	unsigned int buf_off;
> > > +	unsigned int end_buf_off;
> > > +	unsigned int buf_offsize;
> > > +	unsigned int line_size;
> > > +
> > > +	bool default_win;
> > > +	bool color_key;
> > > +	unsigned int index_color;
> > > +	bool local_path;
> > > +	bool transparency;
> > > +	bool activated;
> > > +};
> > > +
> > > +/**
> > > + * Samsung DRM Display Structure.
> > > + *	- this structure is common to analog tv, digital tv and lcd panel.
> > > + *
> > > + * @dev: pointer to specific device object.
> > 
> > ??
> 
> Ah, this should be removed. Thank you.
> 
> > > + * @is_connected: check for that display is connected or not.
> > > + * @get_edid: get edid modes from display driver.
> > > + * @get_timing: get timing object from display driver.
> > > + * @check_timing: check if timing is valid or not.
> > > + * @power_on: display device on or off.
> > > + */
> > > +struct samsung_drm_display {
> > > +	unsigned int type;
> > > +	bool (*is_connected)(struct device *dev);
> > > +	int (*get_edid)(struct device *dev, struct drm_connector *connector,
> > > +				u8 *edid, int len);
> > > +	void *(*get_timing)(struct device *dev);
> > > +	int (*check_timing)(struct device *dev, void *timing);
> > > +	int (*power_on)(struct device *dev, int mode);
> > > +};
> > > +
> > > +/**
> > > + * Samsung drm manager ops
> > > + *
> > > + * @mode_set: convert drm_display_mode to hw specific display mode and
> > > + *	      would be called by encoder->mode_set().
> > > + * @commit: set current hw specific display mode to hw.
> > > + * @enable_vblank: specific driver callback for enabling vblank
> > interrupt.
> > > + * @disable_vblank: specific driver callback for disabling vblank
> > interrupt.
> > > + */
> > > +struct samsung_drm_manager_ops {
> > > +	void (*mode_set)(struct device *subdrv_dev, void *mode);
> > > +	void (*commit)(struct device *subdrv_dev);
> > > +	int (*enable_vblank)(struct device *subdrv_dev);
> > > +	void (*disable_vblank)(struct device *subdrv_dev);
> > > +};
> > > +
> > > +/**
> > > + * Samsung drm common manager structure.
> > > + *
> > > + * @dev: pointer to device object for subdrv device driver.
> > > + * @ops: ops pointer to samsung drm common framebuffer.
> > > + *	 ops of fimd or hdmi driver should be set to this ones.
> > > + */
> > > +struct samsung_drm_manager {
> > > +	struct device *dev;
> > > +	int pipe;
> > 
> > No comment for that?
> 
> Ok, get it. I will add some comment for that. thank you.
> 
> > > +	struct samsung_drm_manager_ops *ops;
> > > +	struct samsung_drm_overlay_ops *overlay_ops;
> > > +	struct samsung_drm_display *display;
> > 
> > And you are missing the comments for these two.
> 
> Also.
> 
> > > +};
> > > +
> > > +/**
> > 
> > I just noticed it, but the '**' is not the kerneldoc
> > style comment. You might want to remove them from all the files.
> > 
> 
> Ok, get it. thank you.
> 
> > > + * Samsung drm private structure.
> > 
> > Ok, you are defining it in a public header so you should at
> > least document what the fields mean.
> > 
> 
> Ok, get it. I will add comments to all fields and thank you for your
> pointing.
> 
> > If you don't want the public to use it - make another header
> > file, helpfully called 'xxx_private.h'
> > 
> > 
> > > + */
> > > +struct samsung_drm_private {
> > > +	struct drm_fb_helper *fb_helper;
> > > +
> > > +	/* for pageflip */
> > > +	struct list_head pageflip_event_list;
> > > +	bool pageflip_event;
> > > +
> > > +	struct drm_crtc *crtc[MAX_CRTC];
> > > +
> > > +	/* add some structures. */
> > 
> > Umm, which ones?
> > 
> 
> This comment will be removed. Thank you.
> 
> > > +};
> > > +
> > > +struct samsung_drm_subdrv {
> > > +	struct list_head list;
> > > +	struct drm_device *drm_dev;
> > > +
> > > +	/* driver ops */
> > > +	int (*probe)(struct drm_device *dev);
> > > +	void (*remove)(struct drm_device *dev);
> > > +
> > > +	struct samsung_drm_manager manager;
> > > +	struct drm_encoder *encoder;
> > > +	struct drm_connector *connector;
> > > +};
> > > +
> > > +int samsung_drm_device_register(struct drm_device *dev);
> > > +void samsung_drm_device_unregister(struct drm_device *dev);
> > > +int samsung_drm_subdrv_register(struct samsung_drm_subdrv *drm_subdrv);
> > > +void samsung_drm_subdrv_unregister(struct samsung_drm_subdrv
> > *drm_subdrv);
> > > +
> > > +#endif
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_encoder.c
> > b/drivers/gpu/drm/samsung/samsung_drm_encoder.c
> > > new file mode 100644
> > > index 0000000..c875968
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_encoder.c
> > > @@ -0,0 +1,261 @@
> > > +/*
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Authors:
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *	SeungWoo Kim <sw0312.kim@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#include "drmP.h"
> > > +#include "drm_crtc_helper.h"
> > > +
> > > +#include "samsung_drm_drv.h"
> > > +#include "samsung_drm_crtc.h"
> > > +#include "samsung_drm_encoder.h"
> > > +
> > > +#define to_samsung_encoder(x)	container_of(x, struct
> > samsung_drm_encoder,\
> > > +				drm_encoder)
> > > +
> > > +struct samsung_drm_encoder {
> > > +	struct drm_encoder		drm_encoder;
> > > +	struct samsung_drm_manager	*manager;
> > > +};
> > > +
> > > +static void samsung_drm_encoder_dpms(struct drm_encoder *encoder, int
> > mode)
> > > +{
> > > +	struct drm_device *dev = encoder->dev;
> > > +	struct drm_connector *connector;
> > > +	struct samsung_drm_manager *manager =
> > samsung_drm_get_manager(encoder);
> > > +
> > > +	DRM_DEBUG_KMS("%s, encoder dpms: %d\n", __FILE__, mode);
> > > +
> > > +	list_for_each_entry(connector, &dev->mode_config.connector_list,
> > head) {
> > > +		if (connector->encoder == encoder) {
> > > +			struct samsung_drm_display *display =
> manager->display;
> > > +
> > > +			if (display && display->power_on)
> > > +				display->power_on(manager->dev, mode);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static bool
> > > +samsung_drm_encoder_mode_fixup(struct drm_encoder *encoder,
> > > +			       struct drm_display_mode *mode,
> > > +			       struct drm_display_mode *adjusted_mode)
> > > +{
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void samsung_drm_encoder_mode_set(struct drm_encoder *encoder,
> > > +					 struct drm_display_mode *mode,
> > > +					 struct drm_display_mode
> *adjusted_mode)
> > > +{
> > > +	struct drm_device *dev = encoder->dev;
> > > +	struct drm_connector *connector;
> > > +	struct samsung_drm_manager *manager =
> > samsung_drm_get_manager(encoder);
> > > +	struct samsung_drm_manager_ops *manager_ops = manager->ops;
> > > +	struct samsung_drm_overlay_ops *overlay_ops = manager->overlay_ops;
> > > +	struct samsung_drm_overlay *overlay = get_samsung_drm_overlay(dev,
> > > +						encoder->crtc);
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	mode = adjusted_mode;
> > > +
> > > +	list_for_each_entry(connector, &dev->mode_config.connector_list,
> > head) {
> > > +		if (connector->encoder == encoder) {
> > > +			if (manager_ops && manager_ops->mode_set)
> > > +				manager_ops->mode_set(manager->dev, mode);
> > > +
> > > +			if (overlay_ops && overlay_ops->mode_set)
> > > +				overlay_ops->mode_set(manager->dev,
> overlay);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static void samsung_drm_encoder_prepare(struct drm_encoder *encoder)
> > > +{
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +}
> > > +
> > > +static void samsung_drm_encoder_commit(struct drm_encoder *encoder)
> > > +{
> > > +	struct samsung_drm_manager *manager =
> > samsung_drm_get_manager(encoder);
> > > +	struct samsung_drm_manager_ops *manager_ops = manager->ops;
> > > +	struct samsung_drm_overlay_ops *overlay_ops = manager->overlay_ops;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	if (manager_ops && manager_ops->commit)
> > > +		manager_ops->commit(manager->dev);
> > > +
> > > +	if (overlay_ops && overlay_ops->commit)
> > > +		overlay_ops->commit(manager->dev);
> > > +}
> > > +
> > > +static struct drm_crtc *
> > > +samsung_drm_encoder_get_crtc(struct drm_encoder *encoder)
> > > +{
> > > +	return encoder->crtc;
> > > +}
> > > +
> > > +static struct drm_encoder_helper_funcs samsung_encoder_helper_funcs = {
> > > +	.dpms		= samsung_drm_encoder_dpms,
> > > +	.mode_fixup	= samsung_drm_encoder_mode_fixup,
> > > +	.mode_set	= samsung_drm_encoder_mode_set,
> > > +	.prepare	= samsung_drm_encoder_prepare,
> > > +	.commit		= samsung_drm_encoder_commit,
> > > +	.get_crtc	= samsung_drm_encoder_get_crtc,
> > > +};
> > > +
> > > +static void samsung_drm_encoder_destroy(struct drm_encoder *encoder)
> > > +{
> > > +	struct samsung_drm_encoder *samsung_encoder =
> > > +		to_samsung_encoder(encoder);
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	samsung_encoder->manager->pipe = -1;
> > > +
> > > +	drm_encoder_cleanup(encoder);
> > > +	encoder->dev->mode_config.num_encoder--;
> > > +	kfree(samsung_encoder);
> > > +}
> > > +
> > > +static struct drm_encoder_funcs samsung_encoder_funcs = {
> > > +	.destroy = samsung_drm_encoder_destroy,
> > > +};
> > > +
> > > +struct drm_encoder *
> > > +samsung_drm_encoder_create(struct drm_device *dev,
> > > +			   struct samsung_drm_manager *manager,
> > > +			   unsigned int possible_crtcs)
> > > +{
> > > +	struct drm_encoder *encoder;
> > > +	struct samsung_drm_encoder *samsung_encoder;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	if (!manager || !possible_crtcs)
> > > +		return NULL;
> > > +
> > > +	if (!manager->dev)
> > > +		return NULL;
> > > +
> > > +	samsung_encoder = kzalloc(sizeof(*samsung_encoder), GFP_KERNEL);
> > > +	if (!samsung_encoder) {
> > > +		DRM_ERROR("failed to allocate encoder\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	samsung_encoder->manager = manager;
> > > +	encoder = &samsung_encoder->drm_encoder;
> > > +	encoder->possible_crtcs = possible_crtcs;
> > > +
> > > +	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
> > > +
> > > +	drm_encoder_init(dev, encoder, &samsung_encoder_funcs,
> > > +			DRM_MODE_ENCODER_TMDS);
> > > +
> > > +	drm_encoder_helper_add(encoder, &samsung_encoder_helper_funcs);
> > > +
> > > +	DRM_DEBUG_KMS("encoder has been created\n");
> > > +
> > > +	return encoder;
> > > +}
> > > +
> > > +struct samsung_drm_manager *samsung_drm_get_manager(struct drm_encoder
> > *encoder)
> > > +{
> > > +	return to_samsung_encoder(encoder)->manager;
> > > +}
> > > +
> > > +void samsung_drm_fn_encoder(struct drm_crtc *crtc, void *data,
> > > +			    void (*fn)(struct drm_encoder *, void *))
> > > +{
> > > +	struct drm_device *dev = crtc->dev;
> > > +	struct drm_encoder *encoder;
> > > +
> > > +	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head)
> > {
> > > +		if (encoder->crtc != crtc)
> > > +			continue;
> > > +
> > > +		fn(encoder, data);
> > > +	}
> > > +}
> > > +
> > > +void samsung_drm_enable_vblank(struct drm_encoder *encoder, void *data)
> > > +{
> > > +	struct samsung_drm_manager *manager =
> > > +		to_samsung_encoder(encoder)->manager;
> > > +	struct samsung_drm_manager_ops *manager_ops = manager->ops;
> > > +	int crtc = *(int *)data;
> > > +
> > > +	if (manager->pipe == -1)
> > > +		manager->pipe = crtc;
> > > +
> > > +	/* old_crtc checking needs? FIXME!!! */
> > 
> > Is this still pertient?
> > 
> 
> I will remove this comment after looking over more. Thank you.
> 
> > > +
> > > +	if (manager_ops->enable_vblank)
> > > +		manager_ops->enable_vblank(manager->dev);
> > > +}
> > > +
> > > +void samsung_drm_disable_vblank(struct drm_encoder *encoder, void
> *data)
> > > +{
> > > +	struct samsung_drm_manager *manager =
> > > +		to_samsung_encoder(encoder)->manager;
> > > +	struct samsung_drm_manager_ops *manager_ops = manager->ops;
> > > +	int crtc = *(int *)data;
> > 
> > You don't want to check whether data is NULL before you
> > derefernce it?
> > 
> 
> Ok, get it. thank you.
> 
> > > +
> > > +	if (manager->pipe == -1)
> > > +		manager->pipe = crtc;
> > > +
> > > +	/* old_crtc checking needs? FIXME!!! */
> > 
> > I am not really sure what it means.. It probably means something to you -
> > but
> > perhaps it might make sense to expand it in case somebody else wants to
> > implement this?
> > 
> 
> As I mentioned above, I will remove this comment after looking over more.
> Thank you.
> 
> > > +
> > > +	if (manager_ops->disable_vblank)
> > > +		manager_ops->disable_vblank(manager->dev);
> > > +}
> > > +
> > > +void samsung_drm_encoder_crtc_commit(struct drm_encoder *encoder, void
> > *data)
> > > +{
> > > +	struct samsung_drm_manager *manager =
> > > +		to_samsung_encoder(encoder)->manager;
> > > +	struct samsung_drm_overlay_ops *overlay_ops = manager->overlay_ops;
> > > +
> > > +	overlay_ops->commit(manager->dev);
> > > +}
> > > +
> > > +void samsung_drm_encoder_crtc_mode_set(struct drm_encoder *encoder,
> > void *data)
> > > +{
> > > +	struct samsung_drm_manager *manager =
> > > +		to_samsung_encoder(encoder)->manager;
> > > +	struct samsung_drm_overlay_ops *overlay_ops = manager->overlay_ops;
> > > +	struct samsung_drm_overlay *overlay = data;
> > > +
> > > +	overlay_ops->mode_set(manager->dev, overlay);
> > > +}
> > > +
> > > +MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
> > 
> > You don't want to include the rest of the authors?
> 
> Definitely no. I will add other authors. Thank you.
> 
> > > +MODULE_DESCRIPTION("Samsung SoC DRM Encoder Driver");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_encoder.h
> > b/drivers/gpu/drm/samsung/samsung_drm_encoder.h
> > > new file mode 100644
> > > index 0000000..99040b2
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_encoder.h
> > > @@ -0,0 +1,45 @@
> > > +/*
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Authors:
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *	SeungWoo Kim <sw0312.kim@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef _SAMSUNG_DRM_ENCODER_H_
> > > +#define _SAMSUNG_DRM_ENCODER_H_
> > > +
> > > +struct samsung_drm_manager;
> > > +
> > > +struct drm_encoder *samsung_drm_encoder_create(struct drm_device *dev,
> > > +					       struct samsung_drm_manager
> *mgr,
> > > +					       unsigned int possible_crtcs);
> > > +struct samsung_drm_manager *
> > > +samsung_drm_get_manager(struct drm_encoder *encoder);
> > > +void samsung_drm_fn_encoder(struct drm_crtc *crtc, void *data,
> > > +			    void (*fn)(struct drm_encoder *, void *));
> > > +void samsung_drm_enable_vblank(struct drm_encoder *encoder, void
> *data);
> > > +void samsung_drm_disable_vblank(struct drm_encoder *encoder, void
> > *data);
> > > +void samsung_drm_encoder_crtc_commit(struct drm_encoder *encoder, void
> > *data);
> > > +void samsung_drm_encoder_crtc_mode_set(struct drm_encoder *encoder,
> > void *data);
> > > +
> > > +#endif
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_fb.c
> > b/drivers/gpu/drm/samsung/samsung_drm_fb.c
> > > new file mode 100644
> > > index 0000000..f087ecf
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_fb.c
> > > @@ -0,0 +1,262 @@
> > > +/*
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Authors:
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *	SeungWoo Kim <sw0312.kim@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#include "drmP.h"
> > > +#include "drm_crtc.h"
> > > +#include "drm_crtc_helper.h"
> > > +
> > > +#include "samsung_drm_fb.h"
> > > +#include "samsung_drm_buf.h"
> > > +#include "samsung_drm_gem.h"
> > > +
> > > +#define to_samsung_fb(x)	container_of(x, struct samsung_drm_fb,
> > fb)
> > > +
> > > +struct samsung_drm_fb {
> > > +	struct drm_framebuffer		fb;
> > > +	struct samsung_drm_gem_obj	*samsung_gem_obj;
> > > +
> > > +	unsigned int			fb_size;
> > > +	dma_addr_t			paddr;
> > > +	void __iomem			*vaddr;
> > > +};
> > > +
> > > +static void samsung_drm_fb_destroy(struct drm_framebuffer *fb)
> > > +{
> > > +	struct samsung_drm_fb *samsung_fb = to_samsung_fb(fb);
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	drm_framebuffer_cleanup(fb);
> > > +
> > > +	/* default framebuffer has no gem object so it releases buffer. */
> > 
> > What is 'it' ?
> > 
> 
> Please, ignore 'it'. and  I will correct this comment. Thank you.
> 
> > > +	if (!samsung_fb->samsung_gem_obj)
> > > +		samsung_drm_buf_destroy(fb->dev,
> > > +				samsung_fb->samsung_gem_obj->entry);
> > > +
> > > +	kfree(samsung_fb);
> > 
> > samsung_fb = NULL;
> > 
> 
> Thank you.
> 
> > > +}
> > > +
> > > +static int samsung_drm_fb_create_handle(struct drm_framebuffer *fb,
> > > +					struct drm_file *file_priv,
> > > +					unsigned int *handle)
> > > +{
> > > +	struct samsung_drm_fb *samsung_fb = to_samsung_fb(fb);
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	return drm_gem_handle_create(file_priv,
> > > +					&samsung_fb->samsung_gem_obj->base,
> > > +					handle);
> > > +}
> > > +
> > > +static int samsung_drm_fb_dirty(struct drm_framebuffer *fb,
> > > +				struct drm_file *file_priv, unsigned flags,
> > > +				unsigned color, struct drm_clip_rect *clips,
> > > +				unsigned num_clips)
> > > +{
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	/*
> > > +	 * update framebuffer and its hardware.
> > > +	 * - this callback would be called by user application
> > > +	 *	with DRM_IOCTL_MODE_DIRTYFB command.
> > > +	 *
> > > +	 * ps. Userspace can notify the driver via this callback
> > > +	 * that an area of the framebuffer has been changed then should
> > > +	 * be flushed to the display hardware.
> > > +	 */
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct drm_framebuffer_funcs samsung_drm_fb_funcs = {
> > > +	.destroy	= samsung_drm_fb_destroy,
> > > +	.create_handle	= samsung_drm_fb_create_handle,
> > > +	.dirty		= samsung_drm_fb_dirty,
> > > +};
> > > +
> > > +static struct drm_framebuffer *
> > > +samsung_drm_fb_init(struct drm_file *file_priv, struct drm_device *dev,
> > > +		    struct drm_mode_fb_cmd *mode_cmd)
> > > +{
> > > +	struct samsung_drm_fb *samsung_fb;
> > > +	struct drm_framebuffer *fb;
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj = NULL;
> > > +	struct drm_gem_object *obj;
> > > +	unsigned int size;
> > > +	int ret;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	mode_cmd->pitch = max(mode_cmd->pitch,
> > > +			mode_cmd->width * (mode_cmd->bpp >> 3));
> > > +
> > > +	DRM_LOG_KMS("drm fb create(%dx%d)\n",
> > > +			mode_cmd->width, mode_cmd->height);
> > > +
> > > +	samsung_fb = kzalloc(sizeof(*samsung_fb), GFP_KERNEL);
> > > +	if (!samsung_fb) {
> > > +		DRM_ERROR("failed to allocate samsung drm framebuffer.\n");
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	fb = &samsung_fb->fb;
> > > +	ret = drm_framebuffer_init(dev, fb, &samsung_drm_fb_funcs);
> > > +	if (ret) {
> > > +		DRM_ERROR("failed to initialize framebuffer.\n");
> > > +		goto err_init;
> > > +	}
> > > +
> > > +	DRM_LOG_KMS("create: fb id: %d\n", fb->base.id);
> > > +
> > > +	size = mode_cmd->pitch * mode_cmd->height;
> > > +
> > > +	/*
> > > +	 * mode_cmd->handle could be pointer to a buffer allocated by user
> > > +	 * application using KMS library.
> > > +	 */
> > > +	if (!mode_cmd->handle) {
> > > +		/*
> > > +		 * in case that file_priv is NULL, it allocates only buffer
> > and
> > > +		 * this buffer would be used for default framebuffer.
> > > +		 */
> > > +		if (!file_priv) {
> > > +			struct samsung_drm_buf_entry *entry;
> > > +
> > > +			entry = samsung_drm_buf_create(dev, size);
> > > +			if (IS_ERR(entry)) {
> > > +				ret = PTR_ERR(entry);
> > > +				goto err_buf_create;
> > > +			}
> > > +
> > > +			samsung_fb->vaddr = entry->vaddr;
> > > +			samsung_fb->paddr = entry->paddr;
> > > +
> > > +			DRM_LOG_KMS("default fb: paddr = 0x%x, size =
> 0x%x\n",
> > > +					entry->paddr, size);
> > > +
> > > +			goto out;
> > > +		} else {
> > > +			samsung_gem_obj = samsung_drm_gem_create(file_priv,
> > dev,
> > > +							size,
> > > +							&mode_cmd->handle);
> > > +			if (IS_ERR(samsung_gem_obj)) {
> > > +				ret = PTR_ERR(samsung_gem_obj);
> > > +				goto err_gem_create;
> > > +			}
> > > +		}
> > > +	} else {
> > > +		obj = drm_gem_object_lookup(dev, file_priv, mode_cmd-
> > >handle);
> > > +		if (!obj) {
> > > +			DRM_ERROR("failed to lookup gem object.\n");
> > > +			goto err_lookup;
> > > +		}
> > > +
> > > +		samsung_gem_obj = to_samsung_gem_obj(obj);
> > > +
> > > +		drm_gem_object_unreference_unlocked(obj);
> > > +	}
> > > +
> > > +	/*
> > > +	 * in case of getting samsung_gem_obj from either handle or
> > > +	 * new creation.
> > > +	 */
> > > +	samsung_fb->vaddr = samsung_gem_obj->entry->vaddr;
> > > +	samsung_fb->paddr = samsung_gem_obj->entry->paddr;
> > > +
> > > +	DRM_LOG_KMS("paddr = 0x%x, size = 0x%x, gem object = 0x%x\n",
> > > +			samsung_fb->paddr, size,
> (u32)&samsung_gem_obj->base);
> > 
> > Why truncating it to be 4GB? Is it potentially possible that this
> > could run a machine with 5GB?
> > 
> 
> You are right. I will correct it. thank you.
> 
> > > +
> > > +out:
> > > +	samsung_fb->samsung_gem_obj = samsung_gem_obj;
> > > +	samsung_fb->fb_size = size;
> > > +
> > > +	drm_helper_mode_fill_fb_struct(fb, mode_cmd);
> > > +
> > > +	return fb;
> > > +
> > > +err_lookup:
> > > +err_gem_create:
> > > +err_buf_create:
> > 
> > Why don't you just coalesce them all together and call it:
> > err:
> > 
> 
> Ok, get it. your saying is more clean. Thank you.
> 
> 
> > > +	drm_framebuffer_cleanup(fb);
> > > +
> > > +err_init:
> > > +	kfree(samsung_fb);
> > > +
> > > +	return ERR_PTR(ret);
> > > +}
> > > +
> > > +struct drm_framebuffer *samsung_drm_fb_create(struct drm_device *dev,
> > > +					      struct drm_file *file_priv,
> > > +					      struct drm_mode_fb_cmd
> *mode_cmd)
> > > +{
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	return samsung_drm_fb_init(file_priv, dev, mode_cmd);
> > > +}
> > > +
> > > +void samsung_drm_fb_update_buf_off(struct drm_framebuffer *fb,
> > > +				   unsigned int x, unsigned int y,
> > > +				   struct samsung_drm_buffer_info *info)
> > > +{
> > > +	struct samsung_drm_fb *samsung_fb = to_samsung_fb(fb);
> > > +	unsigned long offset;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	offset = x * (fb->bits_per_pixel >> 3);
> > > +	offset += y * fb->pitch;
> > > +
> > > +	info->base_addr = samsung_fb->paddr;
> > > +	info->vaddr = samsung_fb->vaddr + offset;
> > > +	info->paddr = samsung_fb->paddr + offset;
> > > +
> > > +	DRM_DEBUG_KMS("updated vaddr = 0x%x, paddr = 0x%x, offset = 0x%x\n",
> > > +			(unsigned int)info->vaddr,
> > > +			(unsigned int)info->paddr,
> > > +			(unsigned int)offset);
> > > +}
> > > +
> > > +static struct drm_mode_config_funcs samsung_drm_mode_config_funcs = {
> > > +	.fb_create = samsung_drm_fb_create,
> > > +};
> > > +
> > > +void samsung_drm_mode_config_init(struct drm_device *dev)
> > > +{
> > > +	dev->mode_config.min_width = 0;
> > > +	dev->mode_config.min_height = 0;
> > > +
> > > +	/*
> > > +	 * It sets max width and height as default value(4096x4096).
> > > +	 * this value would be used to check for framebuffer size
> > limitation
> > > +	 * at drm_mode_addfb().
> > > +	 */
> > > +	dev->mode_config.max_width = 4096;
> > > +	dev->mode_config.max_height = 4096;
> > > +
> > > +	dev->mode_config.funcs = &samsung_drm_mode_config_funcs;
> > > +}
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_fb.h
> > b/drivers/gpu/drm/samsung/samsung_drm_fb.h
> > > new file mode 100644
> > > index 0000000..6256089
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_fb.h
> > > @@ -0,0 +1,47 @@
> > > +/*
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Authors:
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *	SeungWoo Kim <sw0312.kim@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef _SAMSUNG_DRM_FB_H_
> > > +#define _SAMSUNG_DRM_FB_H
> > > +
> > > +struct samsung_drm_buffer_info {
> > > +	unsigned long base_addr;
> > > +	dma_addr_t paddr;
> > > +	void __iomem *vaddr;
> > > +};
> > > +
> > > +void samsung_drm_fb_update_buf_off(struct drm_framebuffer *fb,
> > > +				   unsigned int x, unsigned int y,
> > > +				   struct samsung_drm_buffer_info *info);
> > > +
> > > +struct drm_framebuffer *samsung_drm_fb_create(struct drm_device *dev,
> > > +					      struct drm_file *filp,
> > > +					      struct drm_mode_fb_cmd
> *mode_cmd);
> > > +
> > > +void samsung_drm_mode_config_init(struct drm_device *dev);
> > > +
> > > +#endif
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_fbdev.c
> > b/drivers/gpu/drm/samsung/samsung_drm_fbdev.c
> > > new file mode 100644
> > > index 0000000..1c46bc6
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_fbdev.c
> > > @@ -0,0 +1,409 @@
> > > +/*
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Authors:
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *	SeungWoo Kim <sw0312.kim@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#include "drmP.h"
> > > +#include "drm_crtc.h"
> > > +#include "drm_fb_helper.h"
> > > +#include "drm_crtc_helper.h"
> > > +
> > > +#include "samsung_drm_drv.h"
> > > +#include "samsung_drm_fb.h"
> > > +
> > > +#define to_samsung_fbdev(x)	container_of(x, struct
> > samsung_drm_fbdev,\
> > > +				drm_fb_helper)
> > > +
> > > +struct samsung_drm_fbdev {
> > > +	struct drm_fb_helper	drm_fb_helper;
> > > +	struct drm_framebuffer	*fb;
> > > +};
> > > +
> > > +static inline unsigned int chan_to_field(unsigned int chan,
> > > +					 struct fb_bitfield *bf)
> > > +{
> > > +	chan &= 0xffff;
> > > +	chan >>= 16 - bf->length;
> > 
> > Any chance that bf->length can be bigger than 16? And cause this
> > to return um wrong vlaues?
> > 
> > perhaps chan >>= (16 - max(16,bf->length));
> > 
> 
> Ok, get it. thank you.
> 
> > ?
> > > +
> > > +	return chan << bf->offset;
> > > +}
> > > +
> > > +static int samsung_drm_fbdev_setcolreg(unsigned regno, unsigned red,
> > > +				       unsigned green, unsigned blue,
> > > +				       unsigned transp, struct fb_info
> *info)
> > > +{
> > > +	unsigned int val;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	switch (info->fix.visual) {
> > > +	case FB_VISUAL_TRUECOLOR:
> > > +		if (regno < 16) {
> > 
> > Not <=?
> 
> Ah, you are right. 16bit is high color. thank you.
> 
> > > +			u32 *pal = info->pseudo_palette;
> > > +
> > > +			val = chan_to_field(red, &info->var.red);
> > > +			val |= chan_to_field(green, &info->var.green);
> > > +			val |= chan_to_field(blue, &info->var.blue);
> > > +
> > > +			pal[regno] = val;
> > > +		}
> > 
> > so if regno > 16 then we still return 0. Should we return -EINVAL instead.
> > 
> 
> Ok, get it. thank you.
> 
> > > +		break;
> > > +	default:
> > > +		return 1;
> > 
> > -EINVAL?
> > 
> 
> Thank you.
> 
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct fb_ops samsung_drm_fb_ops = {
> > > +	.owner		= THIS_MODULE,
> > > +	.fb_fillrect	= cfb_fillrect,
> > > +	.fb_copyarea	= cfb_copyarea,
> > > +	.fb_imageblit	= cfb_imageblit,
> > > +	.fb_check_var	= drm_fb_helper_check_var,
> > > +	.fb_set_par	= drm_fb_helper_set_par,
> > > +	.fb_setcolreg	= samsung_drm_fbdev_setcolreg,
> > > +	.fb_blank	= drm_fb_helper_blank,
> > > +	.fb_pan_display	= drm_fb_helper_pan_display,
> > > +	.fb_setcmap	= drm_fb_helper_setcmap,
> > > +};
> > > +
> > > +static void samsung_drm_fbdev_update(struct drm_fb_helper *helper,
> > > +				     struct drm_framebuffer *fb,
> > > +				     unsigned int fb_width,
> > > +				     unsigned int fb_height)
> > > +{
> > > +	struct fb_info *fbi = helper->fbdev;
> > > +	struct drm_device *dev = helper->dev;
> > > +	struct samsung_drm_fbdev *samsung_fb = to_samsung_fbdev(helper);
> > > +	struct samsung_drm_buffer_info buffer_info;
> > > +	unsigned int size = fb_width * fb_height * (fb->bits_per_pixel >>
> > 3);
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	samsung_fb->fb = fb;
> > > +
> > > +	drm_fb_helper_fill_fix(fbi, fb->pitch, fb->depth);
> > > +	drm_fb_helper_fill_var(fbi, helper, fb_width, fb_height);
> > > +
> > > +	samsung_drm_fb_update_buf_off(fb, fbi->var.xoffset, fbi-
> > >var.yoffset,
> > > +			&buffer_info);
> > > +
> > > +	dev->mode_config.fb_base = buffer_info.base_addr;
> > > +
> > > +	fbi->screen_base = buffer_info.vaddr;
> > > +	fbi->screen_size = size;
> > > +	fbi->fix.smem_start = buffer_info.paddr;
> > > +	fbi->fix.smem_len = size;
> > > +}
> > > +
> > > +static int samsung_drm_fbdev_create(struct drm_fb_helper *helper,
> > > +				    struct drm_fb_helper_surface_size
> *sizes)
> > > +{
> > > +	struct samsung_drm_fbdev *samsung_fbdev = to_samsung_fbdev(helper);
> > > +	struct drm_device *dev = helper->dev;
> > > +	struct fb_info *fbi;
> > > +	struct drm_mode_fb_cmd mode_cmd = { 0 };
> > > +	struct platform_device *pdev = dev->platformdev;
> > > +	int ret;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	DRM_DEBUG_KMS("surface width(%d), height(%d) and bpp(%d\n",
> > > +			sizes->surface_width, sizes->surface_height,
> > > +			sizes->surface_bpp);
> > > +
> > > +	mode_cmd.width = sizes->surface_width;
> > > +	mode_cmd.height = sizes->surface_height;
> > > +	mode_cmd.bpp = sizes->surface_bpp;
> > > +	mode_cmd.depth = sizes->surface_depth;
> > > +
> > > +	mutex_lock(&dev->struct_mutex);
> > > +
> > > +	fbi = framebuffer_alloc(0, &pdev->dev);
> > > +	if (!fbi) {
> > > +		DRM_ERROR("failed to allocate fb info.\n");
> > > +		ret = -ENOMEM;
> > > +		goto out;
> > > +	}
> > > +
> > > +	samsung_fbdev->fb = samsung_drm_fb_create(dev, NULL, &mode_cmd);
> > > +	if (IS_ERR(samsung_fbdev->fb)) {
> > 
> > You probably want to do IS_ERR_OR_NULL?
> > 
> 
> Ok, that's more safe. thank you.
> 
> > > +		DRM_ERROR("failed to create drm dramebuffer.\n");
> > > +		ret = PTR_ERR(samsung_fbdev->fb);
> > 
> > framebuffer_release ?
> > > +		goto out;
> > > +	}
> > > +
> 
> I missed it. thank you.
> 
> > > +	helper->fb = samsung_fbdev->fb;
> > > +	helper->fbdev = fbi;
> > > +
> > > +	fbi->par = helper;
> > > +	fbi->flags = FBINFO_FLAG_DEFAULT;
> > > +	fbi->fbops = &samsung_drm_fb_ops;
> > > +
> > > +	ret = fb_alloc_cmap(&fbi->cmap, 256, 0);
> > > +	if (ret) {
> > 
> > framebuffer_release ?
> > 
> 
> Also. Thank you.
> 
> > Or just add a new label that will make that call.
> > 
> > > +		DRM_ERROR("failed to allocate cmap.\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	samsung_drm_fbdev_update(helper, helper->fb, sizes->fb_width,
> > > +			sizes->fb_height);
> > > +
> > > +out:
> > > +	mutex_unlock(&dev->struct_mutex);
> > > +	return ret;
> > > +}
> > > +
> > > +static bool
> > > +samsung_drm_fbdev_is_samefb(struct drm_framebuffer *fb,
> > > +			    struct drm_fb_helper_surface_size *sizes)
> > > +{
> > > +	if (fb->width != sizes->surface_width)
> > > +		return false;
> > > +	if (fb->height != sizes->surface_height)
> > > +		return false;
> > > +	if (fb->bits_per_pixel != sizes->surface_bpp)
> > > +		return false;
> > > +	if (fb->depth != sizes->surface_depth)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static int samsung_drm_fbdev_recreate(struct drm_fb_helper *helper,
> > > +				      struct drm_fb_helper_surface_size
> *sizes)
> > > +{
> > > +	struct drm_device *dev = helper->dev;
> > > +	struct samsung_drm_fbdev *samsung_fbdev = to_samsung_fbdev(helper);
> > > +	struct drm_framebuffer *fb = samsung_fbdev->fb;
> > > +	struct drm_mode_fb_cmd mode_cmd = { 0 };
> > > +
> > > +	if (helper->fb != fb) {
> > > +		DRM_ERROR("drm framebuffer is different\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (samsung_drm_fbdev_is_samefb(fb, sizes))
> > > +		return 0;
> > > +
> > > +	mode_cmd.width = sizes->surface_width;
> > > +	mode_cmd.height = sizes->surface_height;
> > > +	mode_cmd.bpp = sizes->surface_bpp;
> > > +	mode_cmd.depth = sizes->surface_depth;
> > > +
> > > +	if (fb->funcs->destroy)
> > > +		fb->funcs->destroy(fb);
> > > +
> > > +	samsung_fbdev->fb = samsung_drm_fb_create(dev, NULL, &mode_cmd);
> > > +	if (IS_ERR(samsung_fbdev->fb)) {
> > > +		DRM_ERROR("failed to allocate fb.\n");
> > > +		return PTR_ERR(samsung_fbdev->fb);
> > > +	}
> > > +
> > > +	helper->fb = samsung_fbdev->fb;
> > > +	samsung_drm_fbdev_update(helper, helper->fb, sizes->fb_width,
> > > +			sizes->fb_height);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int samsung_drm_fbdev_probe(struct drm_fb_helper *helper,
> > > +				   struct drm_fb_helper_surface_size *sizes)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	if (!helper->fb) {
> > > +		ret = samsung_drm_fbdev_create(helper, sizes);
> > > +		if (ret < 0) {
> > > +			DRM_ERROR("failed to create fbdev.\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		/*
> > > +		 * fb_helper expects a value more than 1 if succeed
> > > +		 * because register_framebuffer() should be called.
> > > +		 */
> > > +		ret = 1;
> > > +	} else {
> > > +		ret = samsung_drm_fbdev_recreate(helper, sizes);
> > > +		if (ret < 0) {
> > > +			DRM_ERROR("failed to reconfigure fbdev\n");
> > > +			return ret;
> > > +		}
> > 
> > No need to do the same thing you did before?
> > 
> 
> Ah, I will correct it. thank you.
> 
> >  ret = 1?
> > 
> 
> This code must be strange. please, see new_fb =
> (*fb_helper->funcs->fb_prob)(fb_helper, &sizes) of
> drm_fb_helper_single_fb_probe(). drm_fb_helper.c requires three return
> values.

So confusing...
> 
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static struct drm_fb_helper_funcs samsung_drm_fb_helper_funcs = {
> > > +	.fb_probe =	samsung_drm_fbdev_probe,
> > > +};
> > > +
> > > +int samsung_drm_fbdev_init(struct drm_device *dev)
> > > +{
> > > +	struct samsung_drm_fbdev *fbdev;
> > > +	struct samsung_drm_private *private = dev->dev_private;
> > > +	struct drm_fb_helper *helper;
> > > +	unsigned int num_crtc;
> > > +	int ret;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	if (!dev->mode_config.num_crtc || !dev->mode_config.num_connector)
> > > +		return 0;
> > > +
> > > +	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
> > > +	if (!fbdev) {
> > > +		DRM_ERROR("failed to allocate drm fbdev.\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	private->fb_helper = helper = &fbdev->drm_fb_helper;
> > > +	helper->funcs = &samsung_drm_fb_helper_funcs;
> > > +
> > > +	num_crtc = dev->mode_config.num_crtc;
> > > +
> > > +	ret = drm_fb_helper_init(dev, helper, num_crtc, 4);
> > 
> > Is that value '4'
> 
> Yes, this driver is going to provide maximum four connectors.
> 
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to initialize drm fb helper.\n");
> > > +		goto fail;
> > > +	}
> > > +
> > > +	ret = drm_fb_helper_single_add_all_connectors(helper);
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to register drm_fb_helper_connector.\n");
> > > +		goto fail;
> > > +
> > > +	}
> > > +
> > > +	ret = drm_fb_helper_initial_config(helper, 32);
> > 
> > and '32' should perhaps be in #defines?
> 
> Ok, get it. thank you.
> 
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to set up hw configuration.\n");
> > 
> > Which I think leaks memory. The drm_fb_helper_single_add_all_connectors
> > does a bunch of kzallocs. Should you free them here?
> > 
> 
> Ah, you are right. thank you.
> 
> > > +		goto fail;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +fail:
> > > +	private->fb_helper = NULL;
> > > +	kfree(fbdev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void samsung_drm_fbdev_destroy(struct drm_device *dev,
> > > +				      struct drm_fb_helper *fb_helper)
> > > +{
> > > +	struct drm_framebuffer *fb;
> > > +	struct fb_info *info;
> > > +
> > > +	/* release drm framebuffer and real buffer */
> > > +	if (fb_helper->fb && fb_helper->fb->funcs) {
> > > +		fb = fb_helper->fb;
> > > +		if (fb->funcs->destroy)
> > > +			fb->funcs->destroy(fb);
> > > +	}
> > > +
> > > +	/* release linux framebuffer */
> > > +	if (fb_helper->fbdev) {
> > 
> > You can declare the 'info' here.
> 
> Ok, get it. thank you.
> 
> > > +		info = fb_helper->fbdev;
> > > +		unregister_framebuffer(info);
> > > +		if (info->cmap.len)
> > > +			fb_dealloc_cmap(&info->cmap);
> > > +		framebuffer_release(info);
> > > +	}
> > > +
> > > +	drm_fb_helper_fini(fb_helper);
> > > +}
> > > +
> > > +void samsung_drm_fbdev_fini(struct drm_device *dev)
> > > +{
> > > +	struct samsung_drm_private *private = dev->dev_private;
> > > +	struct samsung_drm_fbdev *fbdev;
> > > +
> > > +	if (!private || !private->fb_helper)
> > > +		return;
> > > +
> > > +	fbdev = to_samsung_fbdev(private->fb_helper);
> > > +
> > > +	samsung_drm_fbdev_destroy(dev, private->fb_helper);
> > > +	kfree(fbdev);
> > > +	private->fb_helper = NULL;
> > > +}
> > > +
> > > +void samsung_drm_fbdev_restore_mode(struct drm_device *dev)
> > > +{
> > > +	struct samsung_drm_private *private = dev->dev_private;
> > > +
> > > +	if (!private || !private->fb_helper)
> > > +		return;
> > > +
> > > +	drm_fb_helper_restore_fbdev_mode(private->fb_helper);
> > > +}
> > > +
> > > +int samsung_drm_fbdev_reinit(struct drm_device *dev)
> > > +{
> > > +	struct samsung_drm_private *private = dev->dev_private;
> > > +	int ret;
> > > +
> > > +	if (!private)
> > > +		return -EINVAL;
> > > +
> > > +	if (!dev->mode_config.num_connector) {
> > > +		samsung_drm_fbdev_fini(dev);
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (private->fb_helper) {
> > > +		struct drm_fb_helper *fb_helper = private->fb_helper;
> > > +
> > > +		drm_fb_helper_fini(fb_helper);
> > > +
> > > +		ret = drm_fb_helper_init(dev, fb_helper,
> > > +				dev->mode_config.num_crtc, 4);
> > > +		if (ret < 0) {
> > > +			DRM_ERROR("failed to initialize drm fb helper\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret = drm_fb_helper_single_add_all_connectors(fb_helper);
> > > +		if (ret < 0) {
> > > +			DRM_ERROR("failed to add fb helper to
> connectors\n");
> > 
> > You should free what drm_fb_helper_init allocated
> 
> Ok, get it. thank you.
> 
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret = drm_fb_helper_initial_config(fb_helper, 32);
> > > +		if (ret < 0) {
> > 
> > .. and free what drm_fb_helper_single_add_all_connectors allocated too.
> > 
> 
> Ok, thank you.
> 
> > > +			DRM_ERROR("failed to set up hw configuration.\n");
> > > +			return ret;
> > > +		}
> > > +	} else
> > > +		ret = samsung_drm_fbdev_init(dev);
> > > +
> > > +	return ret;
> > > +}
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_fbdev.h
> > b/drivers/gpu/drm/samsung/samsung_drm_fbdev.h
> > > new file mode 100644
> > > index 0000000..3ef4e0d
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_fbdev.h
> > > @@ -0,0 +1,37 @@
> > > +/*
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + *
> > > + * Authors:
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *	SeungWoo Kim <sw0312.kim@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef _SAMSUNG_DRM_FBDEV_H_
> > > +#define _SAMSUNG_DRM_FBDEV_H_
> > > +
> > > +int samsung_drm_fbdev_init(struct drm_device *dev);
> > > +int samsung_drm_fbdev_reinit(struct drm_device *dev);
> > > +void samsung_drm_fbdev_fini(struct drm_device *dev);
> > > +void samsung_drm_fbdev_restore_mode(struct drm_device *dev);
> > > +
> > > +#endif
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_fimd.c
> > b/drivers/gpu/drm/samsung/samsung_drm_fimd.c
> > > new file mode 100644
> > > index 0000000..d823e19
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_fimd.c
> > > @@ -0,0 +1,643 @@
> > > +/*
> > > + * Copyright (C) 2011 Samsung Electronics Co.Ltd
> > > + * Authors:
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *
> > > + * This program is free software; you can redistribute  it and/or
> > modify it
> > > + * under  the terms of  the GNU General  Public License as published by
> > the
> > > + * Free Software Foundation;  either version 2 of the  License, or (at
> > your
> > > + * option) any later version.
> > > + *
> > > + */
> > 
> > What is 'FIMD'? Is there an explanation of what that stands for?
> > 
> 
> That's Fully Interactive Mobile Display and this is display controller. 

OK, can you include that comment and perhaps a link to the specification?
(if such thing exists).
> 
> 
> > > +
> > > +/*
> > > + * TODO list
> > > + *  - Code cleanup(FIXME and TODO parts)
> > > + *  - Clock gating and Power management
> > > + *  - Writeback feature
> > > + */
> > > +
> > > +#include "drmP.h"
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/clk.h>
> > > +
> > > +#include <drm/samsung_drm.h>
> > > +#include <plat/regs-fb-v4.h>
> > > +
> > > +#include "samsung_drm_drv.h"
> > > +#include "samsung_drm_fbdev.h"
> > > +#include "samsung_drm_crtc.h"
> > > +
> > > +/* irq_flags bits */
> > > +#define FIMD_VSYNC_IRQ_EN	0
> > 
> > Which is just one value right? 0?
> > 
> 
> This definition isn't needed. so I will remove it and directly use 0
> instead.
> 
> > 
> > > +
> > > +#define VIDOSD_A(win)	(VIDOSD_BASE + 0x00 + (win) * 16)
> > > +#define VIDOSD_B(win)	(VIDOSD_BASE + 0x04 + (win) * 16)
> > > +#define VIDOSD_C(win)	(VIDOSD_BASE + 0x08 + (win) * 16)
> > > +#define VIDOSD_D(win)	(VIDOSD_BASE + 0x0C + (win) * 16)
> > 
> > What about a comment for these very important low-level values?
> > > +
> 
> I think it's good to leave some comments to them also. I will add some
> comments. thank you.
> 
> 
> > > +#define VIDWx_BUF_START(win, buf)	(VIDW_BUF_START(buf) + (win) * 8)
> > > +#define VIDWx_BUF_END(win, buf)		(VIDW_BUF_END(buf) + (win)
> > * 8)
> > > +#define VIDWx_BUF_SIZE(win, buf)	(VIDW_BUF_SIZE(buf) + (win) * 4)
> > > +
> > > +#define WINDOWS_NR	5
> > > +
> > > +#define get_fimd_context(dev)
> > 	platform_get_drvdata(to_platform_device(dev))
> > > +
> > > +struct fimd_win_data {
> > > +	unsigned int		offset_x;
> > > +	unsigned int		offset_y;
> > > +	unsigned int		width;
> > > +	unsigned int		height;
> > > +	unsigned int		paddr;
> > 
> > dma_addr_t ?
> > 
> 
> Get it. thank you.
> 
> > > +	void __iomem		*vaddr;
> > > +	unsigned int		end_buf_off;
> > 
> > buf_off ?
> 
> I have a feeling that this variable could be removed. thank you.
> 
> > > +	unsigned int		buf_offsize;
> > > +	unsigned int		line_size;	/* bytes */
> > > +};
> > > +
> > > +struct fimd_context {
> > > +	struct samsung_drm_subdrv	subdrv;
> > > +	int				irq_no;
> > 
> > Just 'irq'
> 
> Ok, get it.
> 
> > 
> > > +	struct drm_crtc			*crtc;
> > > +	struct clk			*bus_clk;
> > > +	struct clk			*lcd_clk;
> > > +	struct resource			*regs_res;
> > > +	void __iomem			*regs;
> > > +	struct fimd_win_data		win_data[WINDOWS_NR];
> > > +	unsigned int			clkdiv;
> > > +	unsigned int			default_win;
> > > +	unsigned int			bpp;
> > > +	unsigned long			irq_flags;
> > > +	u32				vidcon0;
> > > +	u32				vidcon1;
> > > +
> > > +	struct fb_videomode		*timing;
> > > +};
> > > +
> > > +static bool fimd_display_is_connected(struct device *dev)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +
> > > +	/* TODO. */
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void *fimd_get_timing(struct device *dev)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +
> > > +	return ctx->timing;
> > > +}
> > > +
> > > +static int fimd_check_timing(struct device *dev, void *timing)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +
> > > +	/* TODO. */
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int fimd_display_power_on(struct device *dev, int mode)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +
> > > +	/* TODO. */
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct samsung_drm_display fimd_display = {
> > > +	.type = SAMSUNG_DISPLAY_TYPE_LCD,
> > > +	.is_connected = fimd_display_is_connected,
> > > +	.get_timing = fimd_get_timing,
> > > +	.check_timing = fimd_check_timing,
> > > +	.power_on = fimd_display_power_on,
> > > +};
> > > +
> > > +static void fimd_commit(struct device *dev)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +	void __iomem *regs = ctx->regs;
> > > +	struct fb_videomode *timing = ctx->timing;
> > > +	u32 val;
> > > +
> > > +	/* vidcon0 */
> > > +	val = ctx->vidcon0;
> > > +	val &= ~(VIDCON0_CLKVAL_F_MASK | VIDCON0_CLKDIR);
> > > +
> > > +	if (ctx->clkdiv > 1)
> > > +		val |= VIDCON0_CLKVAL_F(ctx->clkdiv - 1) | VIDCON0_CLKDIR;
> > > +	else
> > > +		val &= ~VIDCON0_CLKDIR;	/* 1:1 clock */
> > > +
> > > +	val |= VIDCON0_ENVID | VIDCON0_ENVID_F;
> > > +	writel(val, regs + VIDCON0);
> > > +
> > > +	/* vidcon1 */
> > 
> > That comment is bit useless.. It is clear what you are
> > doing.
> 
> Ok, get it. thank you.
> 
> > > +	writel(ctx->vidcon1, regs + VIDCON1);
> > > +
> > > +	/* vidtcon0 */
> > 
> > Ah, so the order is important. Perhaps you should
> > just have a comment before you do any writes that
> > enumarates in which order it should be done?
> > 
> 
> The order hasn't implications for working. no problem if this setting is
> done before dma of fimd is enabled. Ah.. such comments should be added.
> thank you.
> 
> > And why the order is important (in case the future
> > chipsets have it fixed/changed).
> > 
> 
> I understood what you mean. Thank you for your pointing.
> 
> > > +	val = VIDTCON0_VBPD(timing->upper_margin - 1) |
> > > +	       VIDTCON0_VFPD(timing->lower_margin - 1) |
> > > +	       VIDTCON0_VSPW(timing->vsync_len - 1);
> > > +	writel(val, regs + VIDTCON0);
> > > +
> > > +	/* vidtcon1 */
> > > +	val = VIDTCON1_HBPD(timing->left_margin - 1) |
> > > +	       VIDTCON1_HFPD(timing->right_margin - 1) |
> > > +	       VIDTCON1_HSPW(timing->hsync_len - 1);
> > > +	writel(val, regs + VIDTCON1);
> > > +
> > > +	/* vidtcon2 */
> > > +	val = VIDTCON2_LINEVAL(timing->yres - 1) |
> > > +	       VIDTCON2_HOZVAL(timing->xres - 1);
> > > +	writel(val, regs + VIDTCON2);
> > > +}
> > > +
> > > +static int fimd_enable_vblank(struct device *dev)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +	void __iomem *regs = ctx->regs;
> > > +	u32 val;
> > > +
> > > +	if (!test_and_set_bit(FIMD_VSYNC_IRQ_EN, &ctx->irq_flags)) {
> > > +		val = readl(regs + VIDINTCON0);
> > > +
> > > +		val |= VIDINTCON0_INT_ENABLE;
> > > +		val |= VIDINTCON0_INT_FRAME;
> > > +
> > > +		val &= ~VIDINTCON0_FRAMESEL0_MASK;
> > > +		val |= VIDINTCON0_FRAMESEL0_VSYNC;
> > > +		val &= ~VIDINTCON0_FRAMESEL1_MASK;
> > > +		val |= VIDINTCON0_FRAMESEL1_NONE;
> > > +
> > > +		writel(val, regs + VIDINTCON0);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void fimd_disable_vblank(struct device *dev)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +	void __iomem *regs = ctx->regs;
> > > +	u32 val;
> > > +
> > > +	if (test_and_clear_bit(FIMD_VSYNC_IRQ_EN, &ctx->irq_flags)) {
> > > +		val = readl(regs + VIDINTCON0);
> > > +
> > > +		val &= ~VIDINTCON0_INT_FRAME;
> > > +		val &= ~VIDINTCON0_INT_ENABLE;
> > > +
> > > +		writel(val, regs + VIDINTCON0);
> > > +	}
> > > +}
> > > +
> > > +static struct samsung_drm_manager_ops fimd_manager_ops = {
> > > +	.commit = fimd_commit,
> > > +	.enable_vblank = fimd_enable_vblank,
> > > +	.disable_vblank = fimd_disable_vblank,
> > > +};
> > > +
> > > +static void fimd_win_mode_set(struct device *dev,
> > > +			      struct samsung_drm_overlay *overlay)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +	struct fimd_win_data *win_data;
> > > +
> > > +	if (!overlay) {
> > > +		dev_err(dev, "overlay is NULL\n");
> > > +		return;
> > > +	}
> > > +
> > > +	win_data = &ctx->win_data[ctx->default_win];
> > > +
> > > +	win_data->offset_x = overlay->offset_x;
> > > +	win_data->offset_y = overlay->offset_y;
> > > +	win_data->width = overlay->width;
> > > +	win_data->height = overlay->height;
> > > +	win_data->paddr = overlay->paddr;
> > > +	win_data->vaddr = overlay->vaddr;
> > > +	win_data->end_buf_off = overlay->end_buf_off * (ctx->bpp >> 3);
> > > +	win_data->buf_offsize = overlay->buf_offsize * (ctx->bpp >> 3);
> > > +	win_data->line_size = overlay->line_size * (ctx->bpp >> 3);
> > > +}
> > > +
> > > +static void fimd_win_commit(struct device *dev)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +	void __iomem *regs = ctx->regs;
> > > +	struct fimd_win_data *win_data;
> > > +	int win = ctx->default_win;
> > > +	u32 val;
> > > +
> > > +	if (win < 0 || win > WINDOWS_NR)
> > > +		return;
> > > +
> > > +	win_data = &ctx->win_data[win];
> > > +
> > > +	/* protect windows */
> > > +	val = readl(regs + SHADOWCON);
> > > +	val |= SHADOWCON_WINx_PROTECT(win);
> > > +	writel(val, regs + SHADOWCON);
> > > +
> > > +	/* buffer start address */
> > > +	val = win_data->paddr;
> > > +	writel(val, regs + VIDWx_BUF_START(win, 0));
> > > +
> > > +	/* buffer end address */
> > > +	val = win_data->paddr + win_data->end_buf_off;
> > > +	writel(val, regs + VIDWx_BUF_END(win, 0));
> > > +
> > > +	/* buffer size */
> > > +	val = VIDW_BUF_SIZE_OFFSET(win_data->buf_offsize) |
> > > +		VIDW_BUF_SIZE_PAGEWIDTH(win_data->line_size);
> > > +	writel(val, regs + VIDWx_BUF_SIZE(win, 0));
> > > +
> > > +	/* OSD position */
> > > +	val = VIDOSDxA_TOPLEFT_X(win_data->offset_x) |
> > > +		VIDOSDxA_TOPLEFT_Y(win_data->offset_y);
> > > +	writel(val, regs + VIDOSD_A(win));
> > > +
> > > +	val = VIDOSDxB_BOTRIGHT_X(win_data->offset_x + win_data->width - 1)
> > |
> > > +		VIDOSDxB_BOTRIGHT_Y(win_data->offset_y + win_data->height -
> > 1);
> > > +	writel(val, regs + VIDOSD_B(win));
> > > +
> > > +	/* TODO: OSD alpha */
> > > +
> > > +	/* OSD size */
> > > +	if (win != 3 && win != 4) {
> > > +		u32 offset = VIDOSD_D(win);
> > > +		if (win == 0)
> > > +			offset = VIDOSD_C(win);
> > > +		val = win_data->width * win_data->height;
> > > +		writel(val, regs + offset);
> > > +	}
> > > +
> > > +	/* FIXME: remove fixed values */
> > 
> > <nods> Yes.
> > 
> 
> That FIXME would be updated soon. :)
> 
> > > +	val = WINCONx_ENWIN;
> > > +	val |= WINCON0_BPPMODE_24BPP_888;
> > > +	val |= WINCONx_WSWP;
> > > +	val |= WINCONx_BURSTLEN_16WORD;
> > > +	writel(val, regs + WINCON(win));
> > > +
> > > +	/* TODO: colour key */
> > > +
> > > +	/* Enable DMA channel and unprotect windows */
> > > +	val = readl(regs + SHADOWCON);
> > > +	val |= SHADOWCON_CHx_ENABLE(win);
> > > +	val &= ~SHADOWCON_WINx_PROTECT(win);
> > > +	writel(val, regs + SHADOWCON);
> > > +}
> > > +
> > > +static void fimd_win_disable(struct device *dev)
> > > +{
> > > +	struct fimd_context *ctx = get_fimd_context(dev);
> > > +	void __iomem *regs = ctx->regs;
> > > +	struct fimd_win_data *win_data;
> > > +	int win = ctx->default_win;
> > > +	u32 val;
> > > +
> > > +	if (win < 0 || win > WINDOWS_NR)
> > > +		return;
> > > +
> > > +	win_data = &ctx->win_data[win];
> > > +
> > > +	/* protect windows */
> > > +	val = readl(regs + SHADOWCON);
> > > +	val |= SHADOWCON_WINx_PROTECT(win);
> > > +	writel(val, regs + SHADOWCON);
> > > +
> > > +	/* wincon */
> > > +	val = readl(regs + WINCON(win));
> > > +	val &= ~WINCONx_ENWIN;
> > > +	writel(val, regs + WINCON(win));
> > > +
> > > +	/* unprotect windows */
> > > +	val = readl(regs + SHADOWCON);
> > > +	val &= ~SHADOWCON_CHx_ENABLE(win);
> > > +	val &= ~SHADOWCON_WINx_PROTECT(win);
> > > +	writel(val, regs + SHADOWCON);
> > > +}
> > > +
> > > +static struct samsung_drm_overlay_ops fimd_overlay_ops = {
> > > +	.mode_set = fimd_win_mode_set,
> > > +	.commit = fimd_win_commit,
> > > +	.disable = fimd_win_disable,
> > > +};
> > > +
> > > +/* for pageflip event */
> > > +static void fimd_finish_pageflip(struct drm_device *drm_dev, int crtc)
> > > +{
> > > +	struct samsung_drm_private *dev_priv = drm_dev->dev_private;
> > > +	struct drm_pending_vblank_event *e, *t;
> > > +	struct timeval now;
> > > +	unsigned long flags;
> > > +
> > > +	if (!dev_priv->pageflip_event)
> > > +		return;
> > > +
> > > +	spin_lock_irqsave(&drm_dev->event_lock, flags);
> > > +
> > > +	list_for_each_entry_safe(e, t, &dev_priv->pageflip_event_list,
> > > +			base.link) {
> > > +		do_gettimeofday(&now);
> > > +		e->event.sequence = 0;
> > > +		e->event.tv_sec = now.tv_sec;
> > > +		e->event.tv_usec = now.tv_usec;
> > > +
> > > +		list_move_tail(&e->base.link, &e->base.file_priv-
> > >event_list);
> > > +		wake_up_interruptible(&e->base.file_priv->event_wait);
> > > +	}
> > > +
> > > +	drm_vblank_put(drm_dev, crtc);
> > 
> > You can make this call outside the spinlock. But it looks like pretty
> > much everybody is doing it this way?
> > 
> 
> No problem to move it outside(to fimd_irq_handler) and spinlock is used only
> here. thank you.
> 
> > > +	dev_priv->pageflip_event = false;
> > > +
> > > +	spin_unlock_irqrestore(&drm_dev->event_lock, flags);
> > > +}
> > > +
> > > +static irqreturn_t fimd_irq_handler(int irq, void *dev_id)
> > > +{
> > > +	struct fimd_context *ctx = (struct fimd_context *)dev_id;
> > > +	struct samsung_drm_subdrv *subdrv = &ctx->subdrv;
> > > +	struct drm_device *drm_dev = subdrv->drm_dev;
> > > +	struct device *dev = subdrv->manager.dev;
> > > +	struct samsung_drm_manager *manager = &subdrv->manager;
> > > +	void __iomem *regs = ctx->regs;
> > > +	u32 val;
> > > +
> > > +	val = readl(regs + VIDINTCON1);
> > > +
> > > +	if (val & VIDINTCON1_INT_FRAME)
> > > +		/* VSYNC interrupt */
> > > +		writel(VIDINTCON1_INT_FRAME, regs + VIDINTCON1);
> > > +
> > > +	drm_handle_vblank(drm_dev, manager->pipe);
> > > +	fimd_finish_pageflip(drm_dev, manager->pipe);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int fimd_subdrv_probe(struct drm_device *drm_dev)
> > > +{
> > > +	struct drm_driver *drm_driver = drm_dev->driver;
> > > +
> > > +	drm_dev->irq_enabled = 1;
> > 
> > Hehe.. Just like that ,eh?
> > 
> 
> I will add some comments. :)
> 
> > > +
> > > +	/* TODO. */
> > > +
> > > +	/* FIXME */
> > > +	drm_dev->vblank_disable_allowed = 1;
> > > +
> 
> Ditto.
> 
> > > +	return 0;
> > > +}
> > > +
> > > +static void fimd_subdrv_remove(struct drm_device *drm_dev)
> > > +{
> > > +	struct drm_driver *drm_driver = drm_dev->driver;
> > > +
> > > +	/* TODO. */
> > > +}
> > > +
> > > +static int fimd_calc_clkdiv(struct fimd_context *ctx,
> > > +			    struct fb_videomode *timing)
> > > +{
> > > +	unsigned long clk = clk_get_rate(ctx->lcd_clk);
> > > +	u32 retrace;
> > > +	u32 clkdiv;
> > > +	u32 best_framerate = 0;
> > > +	u32 framerate;
> > > +
> > > +	retrace = timing->left_margin + timing->hsync_len +
> > > +				timing->right_margin + timing->xres;
> > > +	retrace *= timing->upper_margin + timing->vsync_len +
> > > +				timing->lower_margin + timing->yres;
> > > +
> > > +	/* default framerate is 60Hz */
> > > +	if (!timing->refresh)
> > > +		timing->refresh = 60;
> > > +
> > > +	clk /= retrace;
> > > +
> > > +	for (clkdiv = 1; clkdiv < 0x100; clkdiv++) {
> > > +		int tmp;
> > > +
> > > +		/* get best framerate */
> > > +		framerate = clk / clkdiv;
> > > +		tmp = timing->refresh - framerate;
> > > +		if (tmp < 0) {
> > > +			best_framerate = framerate;
> > > +			continue;
> > > +		} else {
> > > +			if (!best_framerate)
> > > +				best_framerate = framerate;
> > > +			else if (tmp < (best_framerate - framerate))
> > > +				best_framerate = framerate ;
> > 
> > The ';' at the end should be moved.
> 
> Ah, get it. thank you.
> 
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	return clkdiv;
> > > +}
> > > +
> > > +static void fimd_clear_win(struct fimd_context *ctx, int win)
> > > +{
> > > +	void __iomem *regs = ctx->regs;
> > > +	u32 val;
> > > +
> > > +	writel(0, regs + WINCON(win));
> > > +	writel(0, regs + VIDOSD_A(win));
> > > +	writel(0, regs + VIDOSD_B(win));
> > > +	writel(0, regs + VIDOSD_C(win));
> > > +
> > > +	if (win == 1 || win == 2)
> > > +		writel(0, regs + VIDOSD_D(win));
> > > +
> > > +	val = readl(regs + SHADOWCON);
> > > +	val &= ~SHADOWCON_WINx_PROTECT(win);
> > > +	writel(val, regs + SHADOWCON);
> > > +}
> > > +
> > > +static int __devinit fimd_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct fimd_context *ctx;
> > > +	struct samsung_drm_subdrv *subdrv;
> > > +	struct samsung_drm_fimd_pdata *pdata;
> > > +	struct fb_videomode *timing;
> > > +	struct resource *res;
> > > +	int win;
> > > +	int ret = -EINVAL;
> > > +
> > > +	printk(KERN_DEBUG "[%d] %s\n", __LINE__, __func__);
> > 
> > Hm printk? Use pr_dbg instead.
> > 
> 
> Ok, get it. thank you.
> 
> > > +
> > > +	pdata = pdev->dev.platform_data;
> > > +	if (!pdata) {
> > > +		dev_err(dev, "no platform data specified\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	timing = &pdata->timing;
> > > +	if (!timing) {
> > > +		dev_err(dev, "timing is null.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > > +	if (!ctx)
> > > +		return -ENOMEM;
> > > +
> > > +	ctx->bus_clk = clk_get(dev, "fimd");
> > > +	if (IS_ERR(ctx->bus_clk)) {
> > > +		dev_err(dev, "failed to get bus clock\n");
> > > +		ret = PTR_ERR(ctx->bus_clk);
> > > +		goto err_clk_get;
> > > +	}
> > > +
> > > +	clk_enable(ctx->bus_clk);
> > > +
> > > +	ctx->lcd_clk = clk_get(dev, "sclk_fimd");
> > > +	if (IS_ERR(ctx->lcd_clk)) {
> > > +		dev_err(dev, "failed to get lcd clock\n");
> > > +		ret = PTR_ERR(ctx->lcd_clk);
> > > +		goto err_bus_clk;
> > > +	}
> > > +
> > > +	clk_enable(ctx->lcd_clk);
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	if (!res) {
> > > +		dev_err(dev, "failed to find registers\n");
> > > +		ret = -ENOENT;
> > > +		goto err_clk;
> > > +	}
> > > +
> > > +	ctx->regs_res = request_mem_region(res->start, resource_size(res),
> > > +					   dev_name(dev));
> > > +	if (!ctx->regs_res) {
> > > +		dev_err(dev, "failed to claim register region\n");
> > > +		ret = -ENOENT;
> > > +		goto err_clk;
> > > +	}
> > > +
> > > +	ctx->regs = ioremap(res->start, resource_size(res));
> > > +	if (!ctx->regs) {
> > > +		dev_err(dev, "failed to map registers\n");
> > > +		ret = -ENXIO;
> > > +		goto err_req_region_io;
> > > +	}
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > > +	if (!res) {
> > > +		dev_err(dev, "irq request failed.\n");
> > > +		goto err_req_region_irq;
> > > +	}
> > > +
> > > +	ctx->irq_no = res->start;
> > > +
> > > +	for (win = 0; win < WINDOWS_NR; win++)
> > > +		fimd_clear_win(ctx, win);
> > > +
> > > +	ret = request_irq(ctx->irq_no, fimd_irq_handler, 0, "drm_fimd",
> > ctx);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "irq request failed.\n");
> > > +		goto err_req_irq;
> > > +	}
> > > +
> > > +	ctx->clkdiv = fimd_calc_clkdiv(ctx, timing);
> > > +	ctx->vidcon0 = pdata->vidcon0;
> > > +	ctx->vidcon1 = pdata->vidcon1;
> > > +	ctx->default_win = pdata->default_win;
> > > +	ctx->bpp = pdata->bpp;
> > > +	ctx->timing = timing;
> > > +
> > > +	timing->pixclock = clk_get_rate(ctx->lcd_clk) / ctx->clkdiv;
> > > +
> > > +	subdrv = &ctx->subdrv;
> > > +
> > > +	subdrv->probe = fimd_subdrv_probe;
> > > +	subdrv->remove = fimd_subdrv_remove;
> > > +	subdrv->manager.pipe = -1;
> > > +	subdrv->manager.ops = &fimd_manager_ops;
> > > +	subdrv->manager.overlay_ops = &fimd_overlay_ops;
> > > +	subdrv->manager.display = &fimd_display;
> > > +	subdrv->manager.dev = dev;
> > > +
> > > +	platform_set_drvdata(pdev, ctx);
> > > +	samsung_drm_subdrv_register(subdrv);
> > > +
> > > +	return 0;
> > > +
> > > +err_req_irq:
> > > +err_req_region_irq:
> > > +	iounmap(ctx->regs);
> > > +
> > > +err_req_region_io:
> > > +	release_resource(ctx->regs_res);
> > > +	kfree(ctx->regs_res);
> > > +
> > > +err_clk:
> > > +	clk_disable(ctx->lcd_clk);
> > > +	clk_put(ctx->lcd_clk);
> > > +
> > > +err_bus_clk:
> > > +	clk_disable(ctx->bus_clk);
> > > +	clk_put(ctx->bus_clk);
> > > +
> > > +err_clk_get:
> > > +	kfree(ctx);
> > > +	return ret;
> > > +}
> > > +
> > > +static int __devexit fimd_remove(struct platform_device *pdev)
> > > +{
> > > +	struct fimd_context *ctx = platform_get_drvdata(pdev);
> > > +
> > > +	samsung_drm_subdrv_unregister(&ctx->subdrv);
> > > +
> > > +	clk_disable(ctx->lcd_clk);
> > > +	clk_disable(ctx->bus_clk);
> > > +	clk_put(ctx->lcd_clk);
> > > +	clk_put(ctx->bus_clk);
> > > +
> > 
> > free_irq ?
> 
> Ah , I missed it. thank you.
> 
> > > +	iounmap(ctx->regs);
> > > +	release_resource(ctx->regs_res);
> > > +	kfree(ctx->regs_res);
> > > +
> > > +	kfree(ctx);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct platform_driver fimd_driver = {
> > > +	.probe		= fimd_probe,
> > > +	.remove		= __devexit_p(fimd_remove),
> > > +	.driver		= {
> > > +		.name	= "exynos4-fb",
> > > +		.owner	= THIS_MODULE,
> > > +	},
> > > +};
> > > +
> > > +static int __init fimd_init(void)
> > > +{
> > > +	return platform_driver_register(&fimd_driver);
> > > +}
> > > +
> > > +static void __exit fimd_exit(void)
> > > +{
> > > +	platform_driver_unregister(&fimd_driver);
> > > +}
> > > +
> > > +module_init(fimd_init);
> > > +module_exit(fimd_exit);
> > > +
> > > +MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
> > > +MODULE_DESCRIPTION("Samsung DRM FIMD Driver");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_gem.c
> > b/drivers/gpu/drm/samsung/samsung_drm_gem.c
> > > new file mode 100644
> > > index 0000000..8f71ef0
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_gem.c
> > > @@ -0,0 +1,492 @@
> > > +/* samsung_drm_gem.c
> > > + *
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Author: Inki Dae <inki.dae@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#include "drmP.h"
> > > +#include "drm.h"
> > > +
> > > +#include <drm/samsung_drm.h>
> > > +
> > > +#include "samsung_drm_drv.h"
> > > +#include "samsung_drm_gem.h"
> > > +#include "samsung_drm_buf.h"
> > > +
> > > +static unsigned int convert_to_vm_err_msg(int msg)
> > > +{
> > > +	unsigned int out_msg;
> > > +
> > > +	switch (msg) {
> > > +	case 0:
> > > +	case -ERESTARTSYS:
> > > +	case -EINTR:
> > > +		out_msg = VM_FAULT_NOPAGE;
> > > +		break;
> > > +
> > > +	case -ENOMEM:
> > > +		out_msg = VM_FAULT_OOM;
> > > +		break;
> > > +
> > > +	default:
> > > +		out_msg = VM_FAULT_SIGBUS;
> > > +		break;
> > > +	}
> > > +
> > > +	return out_msg;
> > > +}
> > > +
> > > +static unsigned int get_gem_mmap_offset(struct drm_gem_object *obj)
> > > +{
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	return (unsigned int)obj->map_list.hash.key << PAGE_SHIFT;
> > > +}
> > > +
> > > +/**
> > > + * samsung_drm_gem_create_mmap_offset - create a fake mmap offset for
> > an object
> > > + * @obj: obj in question
> > > + *
> > > + * GEM memory mapping works by handing back to userspace a fake mmap
> > offset
> > > + * it can use in a subsequent mmap(2) call.  The DRM core code then
> > looks
> > > + * up the object based on the offset and sets up the various memory
> > mapping
> > > + * structures.
> > > + *
> > > + * This routine allocates and attaches a fake offset for @obj.
> > > + */
> > > +static int
> > > +samsung_drm_gem_create_mmap_offset(struct drm_gem_object *obj)
> > > +{
> > > +	struct drm_device *dev = obj->dev;
> > > +	struct drm_gem_mm *mm = dev->mm_private;
> > > +	struct drm_map_list *list;
> > > +	struct drm_local_map *map;
> > > +	int ret = 0;
> > > +
> > > +	/* Set the object up for mmap'ing */
> > > +	list = &obj->map_list;
> > > +	list->map = kzalloc(sizeof(struct drm_map_list), GFP_KERNEL);
> > > +	if (!list->map)
> > > +		return -ENOMEM;
> > > +
> > > +	map = list->map;
> > > +	map->type = _DRM_GEM;
> > > +	map->size = obj->size;
> > > +	map->handle = obj;
> > > +
> > > +	/* Get a DRM GEM mmap offset allocated... */
> > > +	list->file_offset_node = drm_mm_search_free(&mm->offset_manager,
> > > +						    obj->size / PAGE_SIZE,
> > > +						    0, 0);
> > > +	if (!list->file_offset_node) {
> > > +		DRM_ERROR("failed to allocate offset for bo %d\n",
> > > +			  obj->name);
> > > +		ret = -ENOSPC;
> > > +		goto out_free_list;
> > > +	}
> > > +
> > > +	list->file_offset_node = drm_mm_get_block(list->file_offset_node,
> > > +						  obj->size / PAGE_SIZE,
> > > +						  0);
> > > +	if (!list->file_offset_node) {
> > > +		ret = -ENOMEM;
> > > +		goto out_free_list;
> > > +	}
> > > +
> > > +	list->hash.key = list->file_offset_node->start;
> > > +	ret = drm_ht_insert_item(&mm->offset_hash, &list->hash);
> > > +	if (ret) {
> > > +		DRM_ERROR("failed to add to map hash\n");
> > > +		goto out_free_mm;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +out_free_mm:
> > > +	drm_mm_put_block(list->file_offset_node);
> > > +out_free_list:
> > > +	kfree(list->map);
> > > +	list->map = NULL;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void
> > > +samsung_drm_gem_free_mmap_offset(struct drm_gem_object *obj)
> > > +{
> > > +	struct drm_device *dev = obj->dev;
> > > +	struct drm_gem_mm *mm = dev->mm_private;
> > > +	struct drm_map_list *list = &obj->map_list;
> > > +
> > > +	drm_ht_remove_item(&mm->offset_hash, &list->hash);
> > > +	drm_mm_put_block(list->file_offset_node);
> > > +	kfree(list->map);
> > > +	list->map = NULL;
> > > +}
> > > +
> > > +struct samsung_drm_gem_obj *samsung_drm_gem_create(struct drm_file
> > *file_priv,
> > > +		struct drm_device *dev, unsigned int size,
> > > +		unsigned int *handle)
> > > +{
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj;
> > > +	struct samsung_drm_buf_entry *entry;
> > > +	struct drm_gem_object *obj;
> > > +	int ret;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	size = roundup(size, PAGE_SIZE);
> > > +
> > > +	samsung_gem_obj = kzalloc(sizeof(*samsung_gem_obj), GFP_KERNEL);
> > > +	if (!samsung_gem_obj) {
> > > +		DRM_ERROR("failed to allocate samsung gem object.\n");
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	/* allocate the new buffer object and memory region. */
> > > +	entry = samsung_drm_buf_create(dev, size);
> > > +	if (!entry) {
> > > +		kfree(samsung_gem_obj);
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	samsung_gem_obj->entry = entry;
> > > +
> > > +	obj = &samsung_gem_obj->base;
> > > +
> > > +	ret = drm_gem_object_init(dev, obj, size);
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to initailize gem object.\n");
> > > +		goto err_obj_init;
> > > +	}
> > > +
> > > +	DRM_DEBUG_KMS("created file object = 0x%x\n", (unsigned int)obj-
> > >filp);
> > > +
> > > +	ret = samsung_drm_gem_create_mmap_offset(obj);
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to allocate mmap offset.\n");
> > > +		goto err_create_mmap_offset;
> > > +	}
> > > +
> > > +	/**
> > > +	 * allocate a id of idr table where the obj is registered
> > > +	 * and handle has the id what user can see.
> > > +	 */
> > > +	ret = drm_gem_handle_create(file_priv, obj, handle);
> > > +	if (ret)
> > > +		goto err_handle_create;
> > > +
> > > +	DRM_DEBUG_KMS("gem handle = 0x%x\n", *handle);
> > > +
> > > +	/* drop reference from allocate - handle holds it now. */
> > > +	drm_gem_object_unreference_unlocked(obj);
> > > +
> > > +	return samsung_gem_obj;
> > > +
> > > +err_handle_create:
> > > +	samsung_drm_gem_free_mmap_offset(obj);
> > > +	drm_gem_object_release(obj);
> > > +
> > > +err_create_mmap_offset:
> > > +	/* add exception. FIXME. */
> > > +
> > > +err_obj_init:
> > > +	samsung_drm_buf_destroy(dev, samsung_gem_obj->entry);
> > > +
> > > +	kfree(samsung_gem_obj);
> > > +
> > > +	return ERR_PTR(ret);
> > > +}
> > > +
> > > +int samsung_drm_gem_create_ioctl(struct drm_device *dev, void *data,
> > > +		struct drm_file *file_priv)
> > > +{
> > > +	struct drm_samsung_gem_create *args = data;
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj;
> > > +
> > > +	DRM_DEBUG_KMS("%s : size = 0x%x\n", __FILE__, args->size);
> > > +
> > > +	samsung_gem_obj = samsung_drm_gem_create(file_priv, dev, args->size,
> > > +			&args->handle);
> > > +	if (IS_ERR(samsung_gem_obj))
> > > +		return PTR_ERR(samsung_gem_obj);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int samsung_drm_gem_map_offset_ioctl(struct drm_device *dev, void
> *data,
> > > +		struct drm_file *file_priv)
> > > +{
> > > +	struct drm_samsung_gem_map_off *args = data;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	DRM_DEBUG_KMS("handle = 0x%x, offset = 0x%x\n",
> > > +			args->handle, (u32)args->offset);
> > > +
> > > +	if (!(dev->driver->driver_features & DRIVER_GEM)) {
> > > +		DRM_ERROR("not support GEM.\n");
> > 
> > Um, You can make that error read better. Perhaps
> > 
> > drv_err(dev->dev,"Does not support GEM.\n");
> > 
> 
> Ok, get it. thank you.
> 
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	return samsung_drm_gem_dumb_map_offset(file_priv, dev, args->handle,
> > > +			&args->offset);
> > > +}
> > > +
> > > +static int samsung_drm_gem_mmap_buffer(struct file *filp,
> > > +		struct vm_area_struct *vma)
> > > +{
> > > +	struct drm_gem_object *obj = filp->private_data;
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj =
> > to_samsung_gem_obj(obj);
> > > +	struct samsung_drm_buf_entry *entry;
> > > +	unsigned long pfn, size;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	vma->vm_flags |= (VM_IO | VM_RESERVED);
> > > +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > +	vma->vm_file = filp;
> > > +
> > > +	size = vma->vm_end - vma->vm_start;
> > > +	entry = samsung_gem_obj->entry;
> > > +
> > > +	/* check if the region to be mapped is valid or not. */
> > > +	if ((entry->paddr + vma->vm_pgoff + size) >
> > > +			(entry->paddr + entry->size)) {
> > > +		drm_gem_object_unreference_unlocked(obj);
> > > +		DRM_ERROR("desired size is bigger then real size.\n");
> > 
> > So .. you can't continue by just using the real size instead?
> > 
> 
> I am afraid I don't understand what you mean but I think that condition is
> fine. size is a vm area to user-desired size and you could request mapping
> as specific size. so it just check user-requested virtual space region it
> bigger than allocated physical memory region to be mapped. if there is my
> missing points, I would be happy to you give me your comments. thank you.

I meant that you return -EINVAL. But I am wondering if it would be possible
to just continue on, but ignore what the user specified.

I think the issue here is that you are outputing the DRM_ERROR and
I am not sure if it is that neccessary. Perhaps DRM_DEBUG, but DRM_ERROR
just seems a bit.. heavy handed.

> 
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	pfn = (samsung_gem_obj->entry->paddr + vma->vm_pgoff) >> PAGE_SHIFT;
> > > +
> > > +	DRM_DEBUG_KMS("offset = 0x%x, pfn to be mapped = 0x%x\n",
> > > +			(u32)vma->vm_pgoff, (u32)pfn);
> > 
> > You can drop those u32 and use %lx
> 
> Thank you.
> 
> > > +
> > > +	if (remap_pfn_range(vma, vma->vm_start, pfn,
> > > +				vma->vm_end - vma->vm_start,
> > > +				vma->vm_page_prot)) {
> > > +		DRM_ERROR("failed to remap pfn range.\n");
> > 
> > Perhaps also include more details. Say the PFN in question, the offset,
> > etc.
> > Something that will help in the field?
> > 
> 
> Ok, get it. thank you.
> 
> > > +		return -EAGAIN;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct file_operations samsung_drm_gem_fops = {
> > > +	.mmap = samsung_drm_gem_mmap_buffer,
> > > +};
> > > +
> > > +int samsung_drm_gem_mmap_ioctl(struct drm_device *dev, void *data,
> > > +		struct drm_file *file_priv)
> > > +{
> > > +	struct drm_samsung_gem_mmap *args = data;
> > > +	struct drm_gem_object *obj;
> > > +	unsigned int addr;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	if (!(dev->driver->driver_features & DRIVER_GEM)) {
> > > +		DRM_ERROR("not support GEM.\n");
> > 
> > Ditto.
> 
> Thank you.
> 
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	obj = drm_gem_object_lookup(dev, file_priv, args->handle);
> > > +	if (!obj) {
> > > +		DRM_ERROR("failed to lookup gem object.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	obj->filp->f_op = &samsung_drm_gem_fops;
> > > +	obj->filp->private_data = obj;
> > > +
> > > +	down_write(&current->mm->mmap_sem);
> > > +	addr = do_mmap(obj->filp, 0, args->size,
> > > +			PROT_READ | PROT_WRITE, MAP_SHARED, args->offset);
> > > +	up_write(&current->mm->mmap_sem);
> > > +
> > > +	drm_gem_object_unreference_unlocked(obj);
> > > +
> > > +	if (IS_ERR((void *)addr))
> > > +		return PTR_ERR((void *)addr);
> > > +
> > > +	args->mapped = addr;
> > > +
> > > +	DRM_DEBUG_KMS("mapped = 0x%x\n", (u32)args->mapped);
> > 
> > Is all this casting to (u32) that neccessary?
> 
> Definitely no, this casting should be changed to 64bit type. thank you.
> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int samsung_drm_gem_init_object(struct drm_gem_object *obj)
> > > +{
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void samsung_drm_gem_free_object(struct drm_gem_object *gem_obj)
> > > +{
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	DRM_DEBUG_KMS("handle count = %d\n",
> > > +			atomic_read(&gem_obj->handle_count));
> > > +
> > > +	if (gem_obj->map_list.map)
> > > +		samsung_drm_gem_free_mmap_offset(gem_obj);
> > > +
> > > +	/* release file pointer to gem object. */
> > > +	drm_gem_object_release(gem_obj);
> > > +
> > > +	samsung_gem_obj = to_samsung_gem_obj(gem_obj);
> > > +
> > > +	samsung_drm_buf_destroy(gem_obj->dev, samsung_gem_obj->entry);
> > > +}
> > > +
> > > +int samsung_drm_gem_dumb_create(struct drm_file *file_priv,
> > > +		struct drm_device *dev, struct drm_mode_create_dumb *args)
> > > +{
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	/**
> > > +	 * alocate memory to be used for framebuffer.
> > > +	 * - this callback would be called by user application
> > > +	 *	with DRM_IOCTL_MODE_CREATE_DUMB command.
> > > +	 */
> > > +
> > > +	args->pitch = args->width * args->bpp >> 3;
> > > +	args->size = args->pitch * args->height;
> > > +
> > > +	samsung_gem_obj = samsung_drm_gem_create(file_priv, dev, args->size,
> > > +							&args->handle);
> > > +	if (IS_ERR(samsung_gem_obj))
> > > +		return PTR_ERR(samsung_gem_obj);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int samsung_drm_gem_dumb_map_offset(struct drm_file *file_priv,
> > > +		struct drm_device *dev, uint32_t handle, uint64_t *offset)
> > > +{
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj;
> > > +	struct drm_gem_object *obj;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	mutex_lock(&dev->struct_mutex);
> > > +
> > > +	/**
> > > +	 * get offset of memory allocated for drm framebuffer.
> > > +	 * - this callback would be called by user application
> > > +	 *	with DRM_IOCTL_MODE_MAP_DUMB command.
> > > +	 */
> > > +
> > > +	obj = drm_gem_object_lookup(dev, file_priv, handle);
> > > +	if (!obj) {
> > > +		DRM_ERROR("failed to lookup gem object.\n");
> > > +		mutex_unlock(&dev->struct_mutex);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	samsung_gem_obj = to_samsung_gem_obj(obj);
> > > +
> > > +	*offset = get_gem_mmap_offset(&samsung_gem_obj->base);
> > > +
> > > +	drm_gem_object_unreference(obj);
> > > +
> > > +	DRM_DEBUG_KMS("offset = 0x%x\n", (unsigned int)*offset);
> > > +
> > > +	mutex_unlock(&dev->struct_mutex);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int samsung_drm_gem_fault(struct vm_area_struct *vma, struct vm_fault
> > *vmf)
> > > +{
> > > +	struct drm_gem_object *obj = vma->vm_private_data;
> > > +	struct samsung_drm_gem_obj *samsung_gem_obj =
> > to_samsung_gem_obj(obj);
> > > +	struct drm_device *dev = obj->dev;
> > > +	unsigned long pfn;
> > > +	pgoff_t page_offset;
> > > +	int ret;
> > > +
> > > +	page_offset = ((unsigned long)vmf->virtual_address -
> > > +			vma->vm_start) >> PAGE_SHIFT;
> > > +
> > > +	mutex_lock(&dev->struct_mutex);
> > > +
> > > +	pfn = (samsung_gem_obj->entry->paddr >> PAGE_SHIFT) + page_offset;
> > > +
> > > +	ret = vm_insert_mixed(vma, (unsigned long)vmf->virtual_address,
> > pfn);
> > > +
> > > +	mutex_unlock(&dev->struct_mutex);
> > > +
> > > +	return convert_to_vm_err_msg(ret);
> > > +}
> > > +
> > > +int samsung_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
> > > +{
> > > +	int ret;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	/* set vm_area_struct. */
> > > +	ret = drm_gem_mmap(filp, vma);
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to mmap.\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	vma->vm_flags &= ~VM_PFNMAP;
> > > +	vma->vm_flags |= VM_MIXEDMAP;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +
> > > +int samsung_drm_gem_dumb_destroy(struct drm_file *file_priv,
> > > +		struct drm_device *dev, unsigned int handle)
> > > +{
> > > +	int ret;
> > > +
> > > +	DRM_DEBUG_KMS("%s\n", __FILE__);
> > > +
> > > +	/**
> > > +	 * obj->refcount and obj->handle_count are decreased and
> > > +	 * if both them are 0 then samsung_drm_gem_free_object()
> > > +	 * would be called by callback to release resources.
> > > +	 */
> > > +	ret = drm_gem_handle_delete(file_priv, handle);
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("failed to delete drm_gem_handle.\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
> > > +MODULE_DESCRIPTION("Samsung SoC DRM GEM Module");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/gpu/drm/samsung/samsung_drm_gem.h
> > b/drivers/gpu/drm/samsung/samsung_drm_gem.h
> > > new file mode 100644
> > > index 0000000..c6cd5e5
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/samsung/samsung_drm_gem.h
> > > @@ -0,0 +1,98 @@
> > > +/* samsung_drm_gem.h
> > > + *
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Authoer: Inki Dae <inki.dae@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef _SAMSUNG_DRM_GEM_H_
> > > +#define _SAMSUNG_DRM_GEM_H_
> > > +
> > > +#define to_samsung_gem_obj(x)	container_of(x,\
> > > +			struct samsung_drm_gem_obj, base)
> > > +
> > > +/**
> > > + * samsung drm buffer structure.
> > > + *
> > > + * @entry: pointer to samsung drm buffer entry object.
> > > + * @flags: it means memory type to be alloated or cache attributes.
> > 
> > Hm, that sounds like an enum? Or a candidate for enums?
> 
> 
> Yes, it's better to use enums. Thank you.
> 
> 
> > > + * @handle: gem handle.
> > 
> > You are missing @base
> > 
> 
> Yes, I missed it. thank you.
> 
> > > + *
> > > + * ps. this object would be transfered to user as kms_bo.handle so
> > 
> > It is 'P.S.'
> 
> Thank you.
> 
> > > + *	user can access to memory through kms_bo.handle.
> > > + */
> > > +struct samsung_drm_gem_obj {
> > > +	struct drm_gem_object base;
> > > +	struct samsung_drm_buf_entry *entry;
> > > +	unsigned int flags;
> > 
> > Actually, I don't think you are using this? Could it be chopped off?
> 
> Could you give me your more comments. I am afraid what is 'it'. I assume
> maybe it's flags. Yes, flags isn't used yet. I will remove it until this
> feature would be added. thank you.


Yup. That is the one I was thinking off.
> 
> > > +};
> > > +
> > > +
> > > +/* create a new buffer and get a new gem handle. */
> > > +struct samsung_drm_gem_obj *samsung_drm_gem_create(struct drm_file
> > *file_priv,
> > > +		struct drm_device *dev, unsigned int size,
> > > +		unsigned int *handle);
> > > +
> > > +/*
> > > + * request gem object creation and buffer allocation as the size
> > > + * that it is calculated with framebuffer information such as width,
> > > + * height and bpp.
> > > + */
> > > +int samsung_drm_gem_create_ioctl(struct drm_device *dev, void *data,
> > > +		struct drm_file *file_priv);
> > > +
> > > +/* get buffer offset to map to user space. */
> > > +int samsung_drm_gem_map_offset_ioctl(struct drm_device *dev, void
> *data,
> > > +		struct drm_file *file_priv);
> > > +
> > > +/* unmap a buffer from user space. */
> > > +int samsung_drm_gem_munmap_ioctl(struct drm_device *dev, void *data,
> > > +		struct drm_file *file_priv);
> > > +
> > > +/* initialize gem object. */
> > > +int samsung_drm_gem_init_object(struct drm_gem_object *obj);
> > > +
> > > +/* free gem object. */
> > > +void samsung_drm_gem_free_object(struct drm_gem_object *gem_obj);
> > > +
> > > +/* create memory region for drm framebuffer. */
> > > +int samsung_drm_gem_dumb_create(struct drm_file *file_priv,
> > > +		struct drm_device *dev, struct drm_mode_create_dumb *args);
> > > +
> > > +/* map memory region for drm framebuffer to user space. */
> > > +int samsung_drm_gem_dumb_map_offset(struct drm_file *file_priv,
> > > +		struct drm_device *dev, uint32_t handle, uint64_t *offset);
> > > +
> > > +/* page fault handler and mmap fault address(virtual) to physical
> > memory. */
> > > +int samsung_drm_gem_fault(struct vm_area_struct *vma, struct vm_fault
> > *vmf);
> > > +
> > > +/* mmap gem object. */
> > > +int samsung_drm_gem_mmap_ioctl(struct drm_device *dev, void *data,
> > > +		struct drm_file *file_priv);
> > > +
> > > +/* set vm_flags and we can change vm attribute to other here. */
> > > +int samsung_drm_gem_mmap(struct file *filp, struct vm_area_struct
> *vma);
> > > +
> > > +/* destroy memory region allocated. */
> > > +int samsung_drm_gem_dumb_destroy(struct drm_file *file_priv,
> > > +		struct drm_device *dev, unsigned int handle);
> > > +
> > > +#endif
> > > diff --git a/include/drm/samsung_drm.h b/include/drm/samsung_drm.h
> > > new file mode 100644
> > > index 0000000..5f89cf1
> > > --- /dev/null
> > > +++ b/include/drm/samsung_drm.h
> > > @@ -0,0 +1,103 @@
> > > +/* samsung_drm.h
> > > + *
> > > + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> > > + * Authors:
> > > + *	Inki Dae <inki.dae@samsung.com>
> > > + *	Joonyoung Shim <jy0922.shim@samsung.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > > + * copy of this software and associated documentation files (the
> > "Software"),
> > > + * to deal in the Software without restriction, including without
> > limitation
> > > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > > + * and/or sell copies of the Software, and to permit persons to whom
> > the
> > > + * Software is furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice (including the
> > next
> > > + * paragraph) shall be included in all copies or substantial portions
> > of the
> > > + * Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > > + * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef _SAMSUNG_DRM_H_
> > > +#define _SAMSUNG_DRM_H_
> > > +
> > > +/**
> > > + * User-desired buffer creation information structure.
> > > + *
> > > + * @size: requested size for the object.
> > > + *	- this size value would be page-aligned internally.
> > > + * @flags: user request for setting memory type or cache attributes.
> > > + * @handle: returned handle for the object.
> > > + */
> > > +struct drm_samsung_gem_create {
> > > +	unsigned int size;
> > > +	unsigned int flags;
> > > +
> > 
> > You can deleta that space.
> 
> Ok, get it. thank you.
> 
> > > +	unsigned int handle;
> > > +};
> > > +
> > > +/**
> > > + * A structure for getting buffer offset.
> > > + *
> > > + * @handle: a pointer to gem object created.
> > > + * @offset: relatived offset value of the memory region allocated.
> > > + *	- this value should be set by user.
> > > + */
> > > +struct drm_samsung_gem_map_off {
> > > +	unsigned int handle;
> > > +	uint64_t offset;
> > > +};
> > > +
> > > +/**
> > > + * A structure for mapping buffer.
> > > + *
> > > + * @handle: a pointer to gem object created.
> > > + * @offset: relatived offset value of the memory region allocated.
> > > + *	- this value should be set by user.
> > > + * @size: memory size to be mapped.
> > > + * @mapped: user virtual address to be mapped.
> > > + */
> > > +struct drm_samsung_gem_mmap {
> > > +	unsigned int handle;
> > > +	uint64_t offset;
> > > +	unsigned int size;
> > > +
> > 
> > Ditto
> 
> Thank you.
> 
> > > +	uint64_t mapped;
> > > +};
> > > +
> > > +#define DRM_SAMSUNG_GEM_CREATE		0x00
> > > +#define DRM_SAMSUNG_GEM_MAP_OFFSET	0x01
> > > +#define DRM_SAMSUNG_GEM_MMAP		0x02
> > > +
> > > +#define DRM_IOCTL_SAMSUNG_GEM_CREATE
> DRM_IOWR(DRM_COMMAND_BASE +
> > \
> > > +		DRM_SAMSUNG_GEM_CREATE, struct drm_samsung_gem_create)
> > > +
> > > +#define DRM_IOCTL_SAMSUNG_GEM_MAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE +
> > \
> > > +		DRM_SAMSUNG_GEM_MAP_OFFSET, struct drm_samsung_gem_map_off)
> > > +
> > > +#define DRM_IOCTL_SAMSUNG_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + \
> > > +		DRM_SAMSUNG_GEM_MMAP, struct drm_samsung_gem_mmap)
> > > +
> > > +/**
> > > + * Platform Specific Structure for DRM based FIMD.
> > > + *
> > > + * @timing: default video mode for initializing
> > > + * @default_win: default window layer number to be used for UI.
> > > + * @bpp: default bit per pixel.
> > > + */
> > > +struct samsung_drm_fimd_pdata {
> > > +	struct fb_videomode		timing;
> > > +	u32				vidcon0;
> > > +	u32				vidcon1;
> > > +	unsigned int			default_win;
> > > +	unsigned int			bpp;
> > > +};
> > > +
> > > +#endif
> > > --
> > > 1.7.0.4


You might also include in V5 the comments about CMA/DMA and about
exhaustion so that if somebody looks at the code in a year they
won't wonder about it anymore.
