From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 13:52:14 +0100
Subject: [PATCH v2 31/43] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
In-Reply-To: <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-32-paul.kocialkowski@bootlin.com>
 <20181123113019.43vrzvj42l35el7z@DESKTOP-E1NTVVP.localdomain>
Message-ID: <c838df0a552cfc34de426dc2bc61bcff4a858e10.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2018-11-23 at 11:30 +0000, Brian Starkey wrote:
> Hi Paul,
> 
> On Fri, Nov 23, 2018 at 10:25:03AM +0100, Paul Kocialkowski wrote:
> > This introduces a dedicated ioctl for allocating buffers for the VPU
> > tiling mode. It allows setting up buffers that comply to the hardware
> > alignment requirements, by aligning the stride and height to 32 bytes.
> > 
> > Only YUV semiplanar and planar formats are allowed by the ioctl, as the
> > hardware does not support the tiling mode for other formats.
> 
> What's the general feeling about a more generic version of this ioctl?
> There doesn't seem to be anything Allwinner-specific in the ioctl
> arguments.

That's a great suggestion, I am totally in favour of making a generic
fashion of this!

It would also remove the need for a new header dedicated to the sun4i-
drm driver, which was really only motivated by the need for this ioctl.

> It effectively boils down to:
> 
> 	size = driver->get_fb_size_with_modifier(...);
>  	cma_obj = drm_gem_cma_create(drm, size);
> 
> It would look exactly the same for Mali-DP, and probably others too.
> Is it better to try and define something we can share instead of Arm
> adding another nearly identical ioctl() later?
> 
> I think the minimal viable thing would be to just add modifiers to
> your structure (I put them first because padding):
> 
>   struct drm_gem_create_with_modifiers {
>   	__u64 modifiers[4];
>   	__u32 height;
>   	__u32 width;
>   	__u32 format;
>   	/* handle, offsets, pitches, size will be returned */
>   	__u32 handle;
>   	__u32 pitches[4];
>   	__u32 offsets[4];
>   	__u64 size;
>   };

That would totally work for me and our usecase.

Cheers,

Paul

> Thanks,
> -Brian
> 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> > drivers/gpu/drm/sun4i/sun4i_drv.c | 89 +++++++++++++++++++++++++++++++
> > include/uapi/drm/sun4i_drm.h      | 42 +++++++++++++++
> > 2 files changed, 131 insertions(+)
> > create mode 100644 include/uapi/drm/sun4i_drm.h
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > index ccdeae6299eb..5ae32973cf34 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -21,6 +21,7 @@
> > #include <drm/drm_gem_cma_helper.h>
> > #include <drm/drm_fb_helper.h>
> > #include <drm/drm_of.h>
> > +#include <drm/sun4i_drm.h>
> > 
> > #include "sun4i_drv.h"
> > #include "sun4i_frontend.h"
> > @@ -28,6 +29,92 @@
> > #include "sun4i_tcon.h"
> > #include "sun8i_tcon_top.h"
> > 
> > +int drm_sun4i_gem_create_tiled(struct drm_device *drm, void *data,
> > +			       struct drm_file *file_priv)
> > +{
> > +	struct drm_sun4i_gem_create_tiled *args = data;
> > +	struct drm_gem_cma_object *cma_obj;
> > +	struct drm_gem_object *gem_obj;
> > +	uint32_t luma_stride, chroma_stride;
> > +	uint32_t luma_height, chroma_height;
> > +	uint32_t chroma_width;
> > +	const struct drm_format_info *info;
> > +	int ret;
> > +
> > +	info = drm_format_info(args->format);
> > +	if (!info)
> > +		return -EINVAL;
> > +
> > +	/* The tiled output format only applies to non-packed YUV formats. */
> > +	if (!info->is_yuv || info->num_planes == 1)
> > +		return -EINVAL;
> > +
> > +	memset(args->pitches, 0, sizeof(args->pitches));
> > +	memset(args->offsets, 0, sizeof(args->offsets));
> > +
> > +	/* Stride and height are aligned to 32 bytes for our tiled format. */
> > +	luma_stride = ALIGN(args->width, 32);
> > +	luma_height = ALIGN(args->height, 32);
> > +
> > +	chroma_width = args->width;
> > +
> > +	/* Semiplanar formats have both U and V data in their chroma plane. */
> > +	if (drm_format_info_is_yuv_semiplanar(info))
> > +		chroma_width *= 2;
> > +
> > +	chroma_stride = ALIGN(DIV_ROUND_UP(chroma_width, info->hsub), 32);
> > +	chroma_height = ALIGN(DIV_ROUND_UP(args->height, info->vsub), 32);
> > +
> > +	if (drm_format_info_is_yuv_semiplanar(info)) {
> > +		args->pitches[0] = luma_stride;
> > +		args->pitches[1] = chroma_stride;
> > +
> > +		args->offsets[0] = 0;
> > +		args->offsets[1] = luma_stride * luma_height;
> > +
> > +		args->size = luma_stride * luma_height +
> > +			     chroma_stride * chroma_height;
> > +	} else if (drm_format_info_is_yuv_planar(info)) {
> > +		args->pitches[0] = luma_stride;
> > +		args->pitches[1] = chroma_stride;
> > +		args->pitches[2] = chroma_stride;
> > +
> > +		args->offsets[0] = 0;
> > +		args->offsets[1] = luma_stride * luma_height;
> > +		args->offsets[2] = luma_stride * luma_height +
> > +				   chroma_stride * chroma_height;
> > +
> > +		args->size = luma_stride * luma_height +
> > +			     chroma_stride * chroma_height * 2;
> > +	} else {
> > +		/* No support for other formats in tiled mode. */
> > +		return -EINVAL;
> > +	}
> > +
> > +	cma_obj = drm_gem_cma_create(drm, args->size);
> > +	if (IS_ERR(cma_obj))
> > +		return PTR_ERR(cma_obj);
> > +
> > +	gem_obj = &cma_obj->base;
> > +
> > +	/*
> > +	 * allocate a id of idr table where the obj is registered
> > +	 * and handle has the id what user can see.
> > +	 */
> > +	ret = drm_gem_handle_create(file_priv, gem_obj, &args->handle);
> > +	/* drop reference from allocate - handle holds it now. */
> > +	drm_gem_object_put_unlocked(gem_obj);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return PTR_ERR_OR_ZERO(cma_obj);
> > +}
> > +
> > +static const struct drm_ioctl_desc sun4i_drv_ioctls[] = {
> > +	DRM_IOCTL_DEF_DRV(SUN4I_GEM_CREATE_TILED, drm_sun4i_gem_create_tiled,
> > +			  DRM_UNLOCKED),
> > +};
> > +
> > static int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
> > 				     struct drm_device *drm,
> > 				     struct drm_mode_create_dumb *args)
> > @@ -44,6 +131,8 @@ static struct drm_driver sun4i_drv_driver = {
> > 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_ATOMIC,
> > 
> > 	/* Generic Operations */
> > +	.ioctls			= sun4i_drv_ioctls,
> > +	.num_ioctls		= ARRAY_SIZE(sun4i_drv_ioctls),
> > 	.fops			= &sun4i_drv_fops,
> > 	.name			= "sun4i-drm",
> > 	.desc			= "Allwinner sun4i Display Engine",
> > diff --git a/include/uapi/drm/sun4i_drm.h b/include/uapi/drm/sun4i_drm.h
> > new file mode 100644
> > index 000000000000..2c77584b057b
> > --- /dev/null
> > +++ b/include/uapi/drm/sun4i_drm.h
> > @@ -0,0 +1,42 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/* sun4i_drm.h
> > + *
> > + * Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > + *
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#ifndef _UAPI_SUN4I_DRM_H_
> > +#define _UAPI_SUN4I_DRM_H_
> > +
> > +#include "drm.h"
> > +
> > +#if defined(__cplusplus)
> > +extern "C" {
> > +#endif
> > +
> > +struct drm_sun4i_gem_create_tiled {
> > +	__u32 height;
> > +	__u32 width;
> > +	__u32 format;
> > +	/* handle, offsets, pitches, size will be returned */
> > +	__u32 handle;
> > +	__u32 pitches[4];
> > +	__u32 offsets[4];
> > +	__u64 size;
> > +};
> > +
> > +#define DRM_SUN4I_GEM_CREATE_TILED	0x00
> > +
> > +#define DRM_IOCTL_SUN4I_GEM_CREATE_TILED \
> > +	DRM_IOWR(DRM_COMMAND_BASE + DRM_SUN4I_GEM_CREATE_TILED, \
> > +		 struct drm_sun4i_gem_create_tiled)
> > +
> > +#if defined(__cplusplus)
> > +}
> > +#endif
> > +
> > +#endif /* _UAPI_SUN4I_DRM_H_ */
> > -- 
> > 2.19.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/16ea2f4d/attachment-0001.sig>
