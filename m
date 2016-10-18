From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 18 Oct 2016 09:49:22 +0200
Subject: [PATCH v4 3/9] drm/hisilicon/hibmc: Add support for frame buffer
In-Reply-To: <1476763284-100508-4-git-send-email-zourongrong@gmail.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
 <1476763284-100508-4-git-send-email-zourongrong@gmail.com>
Message-ID: <20161018074922.GZ20761@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 12:01:18PM +0800, Rongrong Zou wrote:
> Add support for fbdev and framebuffer.
> 
> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile          |   2 +-
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  25 +++
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  25 +++
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 257 ++++++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c       |  67 ++++++
>  5 files changed, 375 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index d5c40b8..810a37e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,5 @@
>  ccflags-y := -Iinclude/drm
> -hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_power.o hibmc_ttm.o
> +hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_fbdev.o hibmc_drm_power.o hibmc_ttm.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC)	+=hibmc-drm.o
>  #obj-y	+= hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index e118f3b..8ddb763 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -66,11 +66,31 @@ static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
>  
>  static int hibmc_pm_suspend(struct device *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +	struct hibmc_drm_device *hidev = drm_dev->dev_private;
> +
> +	if (hidev->fbdev.initialized) {

What do you need these checks for? This looks a bit fishy tbh ...

> +		console_lock();
> +		drm_fb_helper_set_suspend(&hidev->fbdev.helper, 1);
> +		console_unlock();

drm_fb_helper_set_suspend_unlocked is the new fancy one. Please use that
one instead. Also, that has the check you might need already included,
which means you can nuke this entire function here and just call it
directly.
-Daniel

> +	}
> +
>  	return 0;
>  }
>  
>  static int hibmc_pm_resume(struct device *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +	struct hibmc_drm_device *hidev = drm_dev->dev_private;
> +
> +	if (hidev->fbdev.initialized) {
> +		console_lock();
> +		drm_fb_helper_set_suspend(&hidev->fbdev.helper, 0);
> +		console_unlock();
> +	}
> +
>  	return 0;
>  }
>  
> @@ -170,6 +190,7 @@ static int hibmc_unload(struct drm_device *dev)
>  {
>  	struct hibmc_drm_device *hidev = dev->dev_private;
>  
> +	hibmc_fbdev_fini(hidev);
>  	hibmc_hw_fini(hidev);
>  	dev->dev_private = NULL;
>  	return 0;
> @@ -194,6 +215,10 @@ static int hibmc_load(struct drm_device *dev, unsigned long flags)
>  	if (ret)
>  		goto err;
>  
> +	ret = hibmc_fbdev_init(hidev);
> +	if (ret)
> +		goto err;
> +
>  	return 0;
>  
>  err:
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 00bb153..4f5887f 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -20,9 +20,23 @@
>  #define HIBMC_DRM_DRV_H
>  
>  #include <drm/drmP.h>
> +#include <drm/drm_fb_helper.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/drm_gem.h>
>  
> +struct hibmc_framebuffer {
> +	struct drm_framebuffer fb;
> +	struct drm_gem_object *obj;
> +	bool is_fbdev_fb;
> +};
> +
> +struct hibmc_fbdev {
> +	struct drm_fb_helper helper;
> +	struct hibmc_framebuffer fb;
> +	int size;
> +	bool initialized;
> +};
> +
>  struct hibmc_drm_device {
>  	/* hw */
>  	void __iomem   *mmio;
> @@ -41,9 +55,13 @@ struct hibmc_drm_device {
>  		bool initialized;
>  	} ttm;
>  
> +	/* fbdev */
> +	struct hibmc_fbdev fbdev;
>  	bool mm_inited;
>  };
>  
> +#define to_hibmc_framebuffer(x) container_of(x, struct hibmc_framebuffer, fb)
> +
>  struct hibmc_bo {
>  	struct ttm_buffer_object bo;
>  	struct ttm_placement placement;
> @@ -65,8 +83,15 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
>  
>  #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
>  
> +int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
> +void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
> +
>  int hibmc_gem_create(struct drm_device *dev, u32 size, bool iskernel,
>  		     struct drm_gem_object **obj);
> +int hibmc_framebuffer_init(struct drm_device *dev,
> +			   struct hibmc_framebuffer *gfb,
> +			   const struct drm_mode_fb_cmd2 *mode_cmd,
> +			   struct drm_gem_object *obj);
>  
>  int hibmc_mm_init(struct hibmc_drm_device *hibmc);
>  int hibmc_bo_pin(struct hibmc_bo *bo, u32 pl_flag, u64 *gpu_addr);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> new file mode 100644
> index 0000000..ea2d86a
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> @@ -0,0 +1,257 @@
> +/* Hisilicon Hibmc SoC drm driver
> + *
> + * Based on the bochs drm driver.
> + *
> + * Copyright (c) 2016 Huawei Limited.
> + *
> + * Author:
> + *	Rongrong Zou <zourongrong@huawei.com>
> + *	Rongrong Zou <zourongrong@gmail.com>
> + *	Jianhua Li <lijianhua@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +
> +#include "hibmc_drm_drv.h"
> +
> +/* ---------------------------------------------------------------------- */
> +
> +static int hibmcfb_create_object(
> +				struct hibmc_drm_device *hidev,
> +				const struct drm_mode_fb_cmd2 *mode_cmd,
> +				struct drm_gem_object **gobj_p)
> +{
> +	struct drm_gem_object *gobj;
> +	struct drm_device *dev = hidev->dev;
> +	u32 size;
> +	int ret = 0;
> +
> +	size = mode_cmd->pitches[0] * mode_cmd->height;
> +	ret = hibmc_gem_create(dev, size, true, &gobj);
> +	if (ret)
> +		return ret;
> +
> +	*gobj_p = gobj;
> +	return ret;
> +}
> +
> +static struct fb_ops hibmc_drm_fb_ops = {
> +	.owner = THIS_MODULE,
> +	.fb_check_var = drm_fb_helper_check_var,
> +	.fb_set_par = drm_fb_helper_set_par,
> +	.fb_fillrect = drm_fb_helper_sys_fillrect,
> +	.fb_copyarea = drm_fb_helper_sys_copyarea,
> +	.fb_imageblit = drm_fb_helper_sys_imageblit,
> +	.fb_pan_display = drm_fb_helper_pan_display,
> +	.fb_blank = drm_fb_helper_blank,
> +	.fb_setcmap = drm_fb_helper_setcmap,
> +};
> +
> +static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
> +			       struct drm_fb_helper_surface_size *sizes)
> +{
> +	struct hibmc_fbdev *gfbdev =
> +		container_of(helper, struct hibmc_fbdev, helper);
> +	struct hibmc_drm_device *hidev =
> +		container_of(helper, struct hibmc_drm_device, fbdev.helper);
> +	struct fb_info *info;
> +	struct drm_framebuffer *fb;
> +	struct drm_mode_fb_cmd2 mode_cmd;
> +	struct drm_gem_object *gobj = NULL;
> +	int ret = 0;
> +	size_t size;
> +	unsigned int bytes_per_pixel;
> +	struct hibmc_bo *bo = NULL;
> +
> +	DRM_DEBUG_DRIVER("surface width(%d), height(%d) and bpp(%d)\n",
> +			 sizes->surface_width, sizes->surface_height,
> +			 sizes->surface_bpp);
> +	sizes->surface_depth = 32;
> +
> +	bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
> +
> +	mode_cmd.width = sizes->surface_width;
> +	mode_cmd.height = sizes->surface_height;
> +	mode_cmd.pitches[0] = mode_cmd.width * bytes_per_pixel;
> +	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
> +							  sizes->surface_depth);
> +
> +	size = roundup(mode_cmd.pitches[0] * mode_cmd.height, PAGE_SIZE);
> +
> +	ret = hibmcfb_create_object(hidev, &mode_cmd, &gobj);
> +	if (ret) {
> +		DRM_ERROR("failed to create fbcon backing object %d\r\n", ret);
> +		return -ENOMEM;
> +	}
> +
> +	bo = gem_to_hibmc_bo(gobj);
> +
> +	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = hibmc_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
> +	if (ret) {
> +		DRM_ERROR("failed to pin fbcon\n");
> +		return ret;
> +	}
> +
> +	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
> +
> +	if (ret) {
> +		DRM_ERROR("failed to kmap fbcon\n");
> +		ttm_bo_unreserve(&bo->bo);
> +		return ret;
> +	}
> +
> +	ttm_bo_unreserve(&bo->bo);
> +
> +	info = drm_fb_helper_alloc_fbi(helper);
> +	if (IS_ERR(info))
> +		ret = PTR_ERR(info);
> +
> +	info->par = gfbdev;
> +
> +	ret = hibmc_framebuffer_init(hidev->dev, &hidev->fbdev.fb,
> +				     &mode_cmd, gobj);
> +	if (ret) {
> +		drm_fb_helper_release_fbi(helper);
> +		return ret;
> +	}
> +
> +	hidev->fbdev.size = size;
> +	fb = &gfbdev->fb.fb;
> +	if (!fb) {
> +		DRM_INFO("fb is NULL\n");
> +		return -EINVAL;
> +	}
> +
> +	gfbdev->helper.fb = fb;
> +
> +	strcpy(info->fix.id, "hibmcdrmfb");
> +
> +	info->flags = FBINFO_DEFAULT;
> +	info->fbops = &hibmc_drm_fb_ops;
> +
> +	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->depth);
> +	drm_fb_helper_fill_var(info, &hidev->fbdev.helper, sizes->fb_width,
> +			       sizes->fb_height);
> +
> +	info->screen_base = bo->kmap.virtual;
> +	info->screen_size = size;
> +
> +	info->fix.smem_start = bo->bo.mem.bus.offset + bo->bo.mem.bus.base;
> +	info->fix.smem_len = size;
> +
> +	return 0;
> +}
> +
> +static int hibmc_fbdev_destroy(struct drm_device *dev,
> +			       struct hibmc_fbdev *fbdev)
> +{
> +	struct hibmc_framebuffer *gfb = &fbdev->fb;
> +	struct drm_fb_helper *fbh = &fbdev->helper;
> +
> +	DRM_DEBUG_DRIVER("hibmc_fbdev_destroy\n");
> +
> +	drm_fb_helper_unregister_fbi(fbh);
> +	drm_fb_helper_release_fbi(fbh);
> +
> +	if (gfb->obj) {
> +		drm_gem_object_unreference_unlocked(gfb->obj);
> +		gfb->obj = NULL;
> +	}
> +
> +	drm_fb_helper_fini(fbh);
> +
> +	drm_framebuffer_unregister_private(&gfb->fb);
> +	drm_framebuffer_cleanup(&gfb->fb);
> +
> +	return 0;
> +}
> +
> +static const struct drm_fb_helper_funcs hibmc_fbdev_helper_funcs = {
> +	.fb_probe = hibmc_drm_fb_create,
> +};
> +
> +int hibmc_fbdev_init(struct hibmc_drm_device *hidev)
> +{
> +	int ret;
> +	struct fb_var_screeninfo *var;
> +	struct fb_fix_screeninfo *fix;
> +
> +	drm_fb_helper_prepare(hidev->dev, &hidev->fbdev.helper,
> +			      &hibmc_fbdev_helper_funcs);
> +
> +	/* Now just one crtc and one channel */
> +	ret = drm_fb_helper_init(hidev->dev,
> +				 &hidev->fbdev.helper, 1, 1);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_fb_helper_single_add_all_connectors(&hidev->fbdev.helper);
> +	if (ret)
> +		goto fini;
> +
> +	ret = drm_fb_helper_initial_config(&hidev->fbdev.helper, 16);
> +	if (ret)
> +		goto fini;
> +
> +	hidev->fbdev.initialized = true;
> +
> +	var = &hidev->fbdev.helper.fbdev->var;
> +	fix = &hidev->fbdev.helper.fbdev->fix;
> +
> +	DRM_DEBUG("Member of info->var is :\n"
> +		 "xres=%d\n"
> +		 "yres=%d\n"
> +		 "xres_virtual=%d\n"
> +		 "yres_virtual=%d\n"
> +		 "xoffset=%d\n"
> +		 "yoffset=%d\n"
> +		 "bits_per_pixel=%d\n"
> +		 "...\n", var->xres, var->yres, var->xres_virtual,
> +		 var->yres_virtual, var->xoffset, var->yoffset,
> +		 var->bits_per_pixel);
> +	DRM_DEBUG("Member of info->fix is :\n"
> +		 "smem_start=%lx\n"
> +		 "smem_len=%d\n"
> +		 "type=%d\n"
> +		 "type_aux=%d\n"
> +		 "visual=%d\n"
> +		 "xpanstep=%d\n"
> +		 "ypanstep=%d\n"
> +		 "ywrapstep=%d\n"
> +		 "line_length=%d\n"
> +		 "accel=%d\n"
> +		 "capabilities=%d\n"
> +		 "...\n", fix->smem_start, fix->smem_len, fix->type,
> +		 fix->type_aux, fix->visual, fix->xpanstep,
> +		 fix->ypanstep, fix->ywrapstep, fix->line_length,
> +		 fix->accel, fix->capabilities);
> +
> +	return 0;
> +
> +fini:
> +	drm_fb_helper_fini(&hidev->fbdev.helper);
> +	return ret;
> +}
> +
> +void hibmc_fbdev_fini(struct hibmc_drm_device *hidev)
> +{
> +	if (!hidev->fbdev.initialized)
> +		return;
> +
> +	hibmc_fbdev_destroy(hidev->dev, &hidev->fbdev);
> +	hidev->fbdev.initialized = false;
> +}
> +
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> index 2dbef04..c8f7f6c 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> @@ -489,3 +489,70 @@ int hibmc_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
>  	return 0;
>  }
>  
> +/* ---------------------------------------------------------------------- */
> +
> +static void hibmc_user_framebuffer_destroy(struct drm_framebuffer *fb)
> +{
> +	struct hibmc_framebuffer *hibmc_fb = to_hibmc_framebuffer(fb);
> +
> +	drm_gem_object_unreference_unlocked(hibmc_fb->obj);
> +	drm_framebuffer_cleanup(fb);
> +	kfree(fb);
> +}
> +
> +static const struct drm_framebuffer_funcs hibmc_fb_funcs = {
> +	.destroy = hibmc_user_framebuffer_destroy,
> +};
> +
> +int hibmc_framebuffer_init(struct drm_device *dev,
> +			   struct hibmc_framebuffer *gfb,
> +			   const struct drm_mode_fb_cmd2 *mode_cmd,
> +			   struct drm_gem_object *obj)
> +{
> +	int ret;
> +
> +	drm_helper_mode_fill_fb_struct(&gfb->fb, mode_cmd);
> +	gfb->obj = obj;
> +	ret = drm_framebuffer_init(dev, &gfb->fb, &hibmc_fb_funcs);
> +	if (ret) {
> +		DRM_ERROR("drm_framebuffer_init failed: %d\n", ret);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static struct drm_framebuffer *
> +hibmc_user_framebuffer_create(struct drm_device *dev,
> +			      struct drm_file *filp,
> +			      const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	struct drm_gem_object *obj;
> +	struct hibmc_framebuffer *hibmc_fb;
> +	int ret;
> +
> +	DRM_DEBUG_DRIVER("%dx%d, format %c%c%c%c\n",
> +			 mode_cmd->width, mode_cmd->height,
> +			 (mode_cmd->pixel_format) & 0xff,
> +			 (mode_cmd->pixel_format >> 8)  & 0xff,
> +			 (mode_cmd->pixel_format >> 16) & 0xff,
> +			 (mode_cmd->pixel_format >> 24) & 0xff);
> +
> +	obj = drm_gem_object_lookup(filp, mode_cmd->handles[0]);
> +	if (!obj)
> +		return ERR_PTR(-ENOENT);
> +
> +	hibmc_fb = kzalloc(sizeof(*hibmc_fb), GFP_KERNEL);
> +	if (!hibmc_fb) {
> +		drm_gem_object_unreference_unlocked(obj);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ret = hibmc_framebuffer_init(dev, hibmc_fb, mode_cmd, obj);
> +	if (ret) {
> +		drm_gem_object_unreference_unlocked(obj);
> +		kfree(hibmc_fb);
> +		return ERR_PTR(ret);
> +	}
> +	return &hibmc_fb->fb;
> +}
> +
> -- 
> 1.9.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
