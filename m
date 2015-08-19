From: info@lategoodbye.de (Stefan Wahren)
Date: Wed, 19 Aug 2015 23:37:14 +0200
Subject: [PATCH v2 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <1439934848-7196-4-git-send-email-eric@anholt.net>
References: <1439934848-7196-1-git-send-email-eric@anholt.net>
 <1439934848-7196-4-git-send-email-eric@anholt.net>
Message-ID: <55D4F70A.30508@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

only a few nits.

Am 18.08.2015 um 23:54 schrieb Eric Anholt:
> This is the start of a full VC4 driver.  Right now this just supports
> configuring the display using a pre-existing video mode (because
> changing the pixel clock isn't available yet, and doesn't work when it
> is).  However, this is enough for fbcon and bringing up X using
> xf86-video-modesetting.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Drop FB_HELPER select thanks to Archit's patches.  Do manual init
>      ordering instead of using the .load hook.  Structure registration
>      more like tegra's, but still using the typical "component" code.
>      Drop no-op hooks for atomic_begin and mode_fixup() now that
>      they're optional.  Drop sentinel in Makefile.  Fix minor style
>      nits I noticed on another reread.
>
>   drivers/gpu/drm/Kconfig           |   2 +
>   drivers/gpu/drm/Makefile          |   1 +
>   drivers/gpu/drm/vc4/Kconfig       |  13 +
>   drivers/gpu/drm/vc4/Makefile      |  17 +
>   drivers/gpu/drm/vc4/vc4_bo.c      |  52 ++++
>   drivers/gpu/drm/vc4/vc4_crtc.c    | 565 ++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/vc4/vc4_debugfs.c |  38 +++
>   drivers/gpu/drm/vc4/vc4_drv.c     | 271 ++++++++++++++++
>   drivers/gpu/drm/vc4/vc4_drv.h     | 120 ++++++++
>   drivers/gpu/drm/vc4/vc4_hdmi.c    | 633 ++++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/vc4/vc4_hvs.c     | 161 ++++++++++
>   drivers/gpu/drm/vc4/vc4_kms.c     |  84 +++++
>   drivers/gpu/drm/vc4/vc4_plane.c   | 320 +++++++++++++++++++
>   drivers/gpu/drm/vc4/vc4_regs.h    | 562 +++++++++++++++++++++++++++++++++
>   14 files changed, 2839 insertions(+)
>   create mode 100644 drivers/gpu/drm/vc4/Kconfig
>   create mode 100644 drivers/gpu/drm/vc4/Makefile
>   create mode 100644 drivers/gpu/drm/vc4/vc4_bo.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_crtc.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_debugfs.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_drv.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_drv.h
>   create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_hvs.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_kms.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_plane.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_regs.h
>
> [...]
> +static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
> +{
> +	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> +	struct drm_crtc_state *state = crtc->state;
> +	struct drm_display_mode *mode = &state->adjusted_mode;
> +	u32 vactive = (mode->vdisplay >>
> +		       ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? 1 : 0));
> +	u32 format = PV_CONTROL_FORMAT_24;
> +	bool debug_dump_regs = false;
> +
> +	if (debug_dump_regs) {
> +		DRM_INFO("CRTC %d regs before:\n", drm_crtc_index(crtc));
> +		vc4_crtc_dump_regs(vc4_crtc);
> +	}
> +
> +	/* This is where we would set the pixel clock. */
> +
> +	/* Reset the PV fifo. */
> +	CRTC_WRITE(PV_CONTROL, 0);
> +	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
> +	CRTC_WRITE(PV_CONTROL, 0);
> +
> +	CRTC_WRITE(PV_HORZA,
> +		   VC4_SET_FIELD(mode->htotal - mode->hsync_end,
> +				 PV_HORZA_HBP) |
> +		   VC4_SET_FIELD(mode->hsync_end - mode->hsync_start,
> +				 PV_HORZA_HSYNC));
> +	CRTC_WRITE(PV_HORZB,
> +		   VC4_SET_FIELD(mode->hsync_start - mode->hdisplay,
> +				 PV_HORZB_HFP) |
> +		   VC4_SET_FIELD(mode->hdisplay, PV_HORZB_HACTIVE));
> +
> +	CRTC_WRITE(PV_VERTA,
> +		   VC4_SET_FIELD(mode->vtotal - mode->vsync_end,
> +				 PV_VERTA_VBP) |
> +		   VC4_SET_FIELD(mode->vsync_end - mode->vsync_start,
> +				 PV_VERTA_VSYNC));
> +	CRTC_WRITE(PV_VERTB,
> +		   VC4_SET_FIELD(mode->vsync_start - mode->vdisplay,
> +				 PV_VERTB_VFP) |
> +		   VC4_SET_FIELD(vactive, PV_VERTB_VACTIVE));
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
> +		/* Write PV_VERTA_EVEN/VERTB_EVEN */
> +	}

checkpatch complains here. Is this intended to have only a comment? Is 
it a TODO?

> [...]
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright (C) 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "drmP.h"
> +#include "drm_gem_cma_helper.h"
> +
> +struct vc4_dev {
> +	struct drm_device *dev;
> +
> +	struct vc4_hdmi *hdmi;
> +	struct vc4_hvs *hvs;
> +	struct vc4_crtc *crtc[3];
> +};
> +
> +static inline struct vc4_dev *
> +to_vc4_dev(struct drm_device *dev)
> +{
> +	return (struct vc4_dev *)dev->dev_private;
> +}
> +
> +struct vc4_bo {
> +	struct drm_gem_cma_object base;
> +};
> +
> +static inline struct vc4_bo *
> +to_vc4_bo(struct drm_gem_object *bo)
> +{
> +	return (struct vc4_bo *)bo;
> +}
> +
> +struct vc4_hvs {
> +	struct platform_device *pdev;
> +	void __iomem *regs;
> +	void __iomem *dlist;
> +};
> +
> +struct vc4_crtc {
> +	struct drm_crtc base;
> +	void __iomem *regs;
> +
> +	/* Which HVS channel we're using for our CRTC. */
> +	int channel;
> +
> +	/* Pointer to the actual hardware display list memory for the
> +	 * crtc.
> +	 */
> +	u32 __iomem *dlist;
> +
> +	u32 dlist_size; /* in dwords */
> +
> +	struct drm_pending_vblank_event *event;
> +};
> +
> +static inline struct vc4_crtc *
> +to_vc4_crtc(struct drm_crtc *crtc)
> +{
> +	return (struct vc4_crtc *)crtc;
> +}
> +
> +struct vc4_plane {
> +	struct drm_plane base;
> +};
> +
> +static inline struct vc4_plane *
> +to_vc4_plane(struct drm_plane *plane)
> +{
> +	return (struct vc4_plane *)plane;
> +}
> +
> +#define HVS_READ(offset) readl(vc4->hvs->regs + offset)
> +#define HVS_WRITE(offset, val) writel(val, vc4->hvs->regs + offset)
> +
> +/* vc4_bo.c */

I'm not sure about these filename references.

> +void vc4_free_object(struct drm_gem_object *gem_obj);
> +struct vc4_bo *vc4_bo_create(struct drm_device *dev, size_t size);
> +int vc4_dumb_create(struct drm_file *file_priv,
> +		    struct drm_device *dev,
> +		    struct drm_mode_create_dumb *args);
> +struct dma_buf *vc4_prime_export(struct drm_device *dev,
> +				 struct drm_gem_object *obj, int flags);
> +
> +/* vc4_crtc.c */
> +extern struct platform_driver vc4_crtc_driver;
> +int vc4_enable_vblank(struct drm_device *dev, int crtc_id);
> +void vc4_disable_vblank(struct drm_device *dev, int crtc_id);
> +void vc4_cancel_page_flip(struct drm_crtc *crtc, struct drm_file *file);
> +int vc4_crtc_debugfs_regs(struct seq_file *m, void *arg);
> +
> +/* vc4_debugfs.c */
> +int vc4_debugfs_init(struct drm_minor *minor);
> +void vc4_debugfs_cleanup(struct drm_minor *minor);
> +
> +/* vc4_drv.c */
> +void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
> +
> +/* vc4_hdmi.c */
> +extern struct platform_driver vc4_hdmi_driver;
> +struct drm_encoder *vc4_hdmi_encoder_init(struct drm_device *dev);
> +struct drm_connector *vc4_hdmi_connector_init(struct drm_device *dev,
> +					      struct drm_encoder *encoder);
> +int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused);
> +
> +/* vc4_hvs.c */
> +extern struct platform_driver vc4_hvs_driver;
> +void vc4_hvs_dump_state(struct drm_device *dev);
> +int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
> +
> +/* vc4_kms.c */
> +int vc4_kms_load(struct drm_device *dev);
> +
> +/* vc4_plane.c */
> +struct drm_plane *vc4_plane_init(struct drm_device *dev,
> +				 enum drm_plane_type type);
> +u32 vc4_plane_write_dlist(struct drm_plane *plane, u32 __iomem *dlist);
> +u32 vc4_plane_dlist_size(struct drm_plane_state *state);
>
> [...]
> diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> new file mode 100644
> index 0000000..0eff631
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> @@ -0,0 +1,562 @@
> +/*
> + *  Copyright ? 2014-2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define VC4_MASK(high, low) (((1 << ((high) - (low) + 1)) - 1) << (low))
> +/* Using the GNU statement expression extension */
> +#define VC4_SET_FIELD(value, field)					\
> +	({								\
> +		uint32_t fieldval = (value) << field##_SHIFT;		\
> +		WARN_ON((fieldval & ~field##_MASK) != 0);		\
> +		fieldval & field##_MASK;				\
> +	 })
> +
> +#define VC4_GET_FIELD(word, field) (((word) & field##_MASK) >>		\
> +				    field##_SHIFT)
> +
> +#define V3D_IDENT0   0x00000
> +# define V3D_EXPECTED_IDENT0 \
> +	((2 << 24) | \
> +	('V' << 0) | \
> +	('3' << 8) | \
> +	 ('D' << 16))
> +
> +#define V3D_IDENT1   0x00004
> +/* Multiples of 1kb */
> +# define V3D_IDENT1_VPM_SIZE_MASK                      VC4_MASK(31, 28)
> +# define V3D_IDENT1_VPM_SIZE_SHIFT                     28
> +# define V3D_IDENT1_NSEM_MASK                          VC4_MASK(23, 16)
> +# define V3D_IDENT1_NSEM_SHIFT                         16
> +# define V3D_IDENT1_TUPS_MASK                          VC4_MASK(15, 12)
> +# define V3D_IDENT1_TUPS_SHIFT                         12
> +# define V3D_IDENT1_QUPS_MASK                          VC4_MASK(11, 8)
> +# define V3D_IDENT1_QUPS_SHIFT                         8
> +# define V3D_IDENT1_NSLC_MASK                          VC4_MASK(7, 4)
> +# define V3D_IDENT1_NSLC_SHIFT                         4
> +# define V3D_IDENT1_REV_MASK                           VC4_MASK(3, 0)
> +# define V3D_IDENT1_REV_SHIFT                          0
> +
> +#define V3D_IDENT2   0x00008
> +#define V3D_SCRATCH  0x00010
> +#define V3D_L2CACTL  0x00020
> +# define V3D_L2CACTL_L2CCLR                            (1 << 2)

Maybe you could use the BIT macro?

Thanks Stefan
