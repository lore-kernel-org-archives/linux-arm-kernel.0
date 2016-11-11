From: zourongrong@huawei.com (Rongrong Zou)
Date: Fri, 11 Nov 2016 21:16:06 +0800
Subject: [PATCH v6 3/9] drm/hisilicon/hibmc: Add support for frame buffer
In-Reply-To: <CAOw6vbJweGkWzXJwNSm7LmhDhW1gLG8=wu4dBw+dL-cvaBvaCw@mail.gmail.com>
References: <1477639682-22520-1-git-send-email-zourongrong@gmail.com>
 <1477639682-22520-4-git-send-email-zourongrong@gmail.com>
 <CAOw6vbJweGkWzXJwNSm7LmhDhW1gLG8=wu4dBw+dL-cvaBvaCw@mail.gmail.com>
Message-ID: <5825C496.5070905@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/11/11 2:30, Sean Paul ??:
> On Fri, Oct 28, 2016 at 3:27 AM, Rongrong Zou <zourongrong@gmail.com> wrote:
>> Add support for fbdev and kms fb management.
>>
>> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/Makefile          |   2 +-
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  17 ++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  24 ++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 255 ++++++++++++++++++++++
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c       |  66 ++++++
>>   5 files changed, 363 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> index d5c40b8..810a37e 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> @@ -1,5 +1,5 @@
>>   ccflags-y := -Iinclude/drm
>> -hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_power.o hibmc_ttm.o
>> +hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_fbdev.o hibmc_drm_power.o hibmc_ttm.o
>>
>>   obj-$(CONFIG_DRM_HISI_HIBMC)   +=hibmc-drm.o
>>   #obj-y += hibmc-drm.o
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index 81f4301..5ac7a7e 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -66,11 +66,23 @@ static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
>>
>>   static int hibmc_pm_suspend(struct device *dev)
>>   {
>> +       struct pci_dev *pdev = to_pci_dev(dev);
>> +       struct drm_device *drm_dev = pci_get_drvdata(pdev);
>> +       struct hibmc_drm_device *hidev = drm_dev->dev_private;
>> +
>> +       drm_fb_helper_set_suspend_unlocked(&hidev->fbdev->helper, 1);
>> +
>
> We have atomic helpers for suspend/resume now. Please use those.

drm_atomic_helper_suspend/resume()?

>
>>          return 0;
>>   }
>>
>>   static int hibmc_pm_resume(struct device *dev)
>>   {
>> +       struct pci_dev *pdev = to_pci_dev(dev);
>> +       struct drm_device *drm_dev = pci_get_drvdata(pdev);
>> +       struct hibmc_drm_device *hidev = drm_dev->dev_private;
>> +
>> +       drm_fb_helper_set_suspend_unlocked(&hidev->fbdev->helper, 0);
>> +
>>          return 0;
>>   }
>>
>> @@ -170,6 +182,7 @@ static int hibmc_unload(struct drm_device *dev)
>>   {
>>          struct hibmc_drm_device *hidev = dev->dev_private;
>>
>> +       hibmc_fbdev_fini(hidev);
>>          hibmc_mm_fini(hidev);
>>          hibmc_hw_fini(hidev);
>>          dev->dev_private = NULL;
>> @@ -195,6 +208,10 @@ static int hibmc_load(struct drm_device *dev, unsigned long flags)
>>          if (ret)
>>                  goto err;
>>
>> +       ret = hibmc_fbdev_init(hidev);
>> +       if (ret)
>> +               goto err;
>> +
>>          return 0;
>>
>>   err:
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index db8d80e..a40e9a7 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -20,9 +20,22 @@
>>   #define HIBMC_DRM_DRV_H
>>
>>   #include <drm/drmP.h>
>> +#include <drm/drm_fb_helper.h>
>>   #include <drm/ttm/ttm_bo_driver.h>
>>   #include <drm/drm_gem.h>
>>
>> +struct hibmc_framebuffer {
>> +       struct drm_framebuffer fb;
>> +       struct drm_gem_object *obj;
>> +       bool is_fbdev_fb;
>> +};
>> +
>> +struct hibmc_fbdev {
>> +       struct drm_fb_helper helper;
>> +       struct hibmc_framebuffer *fb;
>> +       int size;
>> +};
>> +
>>   struct hibmc_drm_device {
>>          /* hw */
>>          void __iomem   *mmio;
>> @@ -41,9 +54,13 @@ struct hibmc_drm_device {
>>                  bool initialized;
>>          } ttm;
>>
>> +       /* fbdev */
>> +       struct hibmc_fbdev *fbdev;
>>          bool mm_inited;
>>   };
>>
>> +#define to_hibmc_framebuffer(x) container_of(x, struct hibmc_framebuffer, fb)
>> +
>>   struct hibmc_bo {
>>          struct ttm_buffer_object bo;
>>          struct ttm_placement placement;
>> @@ -65,8 +82,15 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
>>
>>   #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
>>
>> +int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
>> +void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
>> +
>>   int hibmc_gem_create(struct drm_device *dev, u32 size, bool iskernel,
>>                       struct drm_gem_object **obj);
>> +struct hibmc_framebuffer *
>> +hibmc_framebuffer_init(struct drm_device *dev,
>> +                      const struct drm_mode_fb_cmd2 *mode_cmd,
>> +                      struct drm_gem_object *obj);
>>
>>   int hibmc_mm_init(struct hibmc_drm_device *hibmc);
>>   void hibmc_mm_fini(struct hibmc_drm_device *hibmc);
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
>> new file mode 100644
>> index 0000000..630124b
>> --- /dev/null
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
>> @@ -0,0 +1,255 @@
>> +/* Hisilicon Hibmc SoC drm driver
>> + *
>> + * Based on the bochs drm driver.
>> + *
>> + * Copyright (c) 2016 Huawei Limited.
>> + *
>> + * Author:
>> + *     Rongrong Zou <zourongrong@huawei.com>
>> + *     Rongrong Zou <zourongrong@gmail.com>
>> + *     Jianhua Li <lijianhua@huawei.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + */
>> +
>> +#include <drm/drm_crtc.h>
>> +#include <drm/drm_crtc_helper.h>
>> +#include <drm/drm_fb_helper.h>
>> +
>> +#include "hibmc_drm_drv.h"
>> +
>> +/* ---------------------------------------------------------------------- */
>
> Please remove

will do that, thanks.

>
>> +
>> +static int hibmcfb_create_object(
>> +                               struct hibmc_drm_device *hidev,
>> +                               const struct drm_mode_fb_cmd2 *mode_cmd,
>> +                               struct drm_gem_object **gobj_p)
>> +{
>> +       struct drm_gem_object *gobj;
>> +       struct drm_device *dev = hidev->dev;
>> +       u32 size;
>> +       int ret = 0;
>> +
>> +       size = mode_cmd->pitches[0] * mode_cmd->height;
>> +       ret = hibmc_gem_create(dev, size, true, &gobj);
>> +       if (ret)
>> +               return ret;
>> +
>> +       *gobj_p = gobj;
>> +       return ret;
>> +}
>> +
>> +static struct fb_ops hibmc_drm_fb_ops = {
>> +       .owner = THIS_MODULE,
>> +       .fb_check_var = drm_fb_helper_check_var,
>> +       .fb_set_par = drm_fb_helper_set_par,
>> +       .fb_fillrect = drm_fb_helper_sys_fillrect,
>> +       .fb_copyarea = drm_fb_helper_sys_copyarea,
>> +       .fb_imageblit = drm_fb_helper_sys_imageblit,
>> +       .fb_pan_display = drm_fb_helper_pan_display,
>> +       .fb_blank = drm_fb_helper_blank,
>> +       .fb_setcmap = drm_fb_helper_setcmap,
>> +};
>> +
>> +static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
>> +                              struct drm_fb_helper_surface_size *sizes)
>> +{
>> +       struct hibmc_fbdev *hi_fbdev =
>> +               container_of(helper, struct hibmc_fbdev, helper);
>> +       struct hibmc_drm_device *hidev =
>> +               (struct hibmc_drm_device *)helper->dev->dev_private;
>> +       struct fb_info *info;
>> +       struct hibmc_framebuffer *hibmc_fb;
>> +       struct drm_framebuffer *fb;
>> +       struct drm_mode_fb_cmd2 mode_cmd;
>> +       struct drm_gem_object *gobj = NULL;
>> +       int ret = 0;
>> +       size_t size;
>> +       unsigned int bytes_per_pixel;
>> +       struct hibmc_bo *bo = NULL;
>> +
>> +       DRM_DEBUG_DRIVER("surface width(%d), height(%d) and bpp(%d)\n",
>> +                        sizes->surface_width, sizes->surface_height,
>> +                        sizes->surface_bpp);
>> +       sizes->surface_depth = 32;
>> +
>> +       bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
>> +
>> +       mode_cmd.width = sizes->surface_width;
>> +       mode_cmd.height = sizes->surface_height;
>> +       mode_cmd.pitches[0] = mode_cmd.width * bytes_per_pixel;
>> +       mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
>> +                                                         sizes->surface_depth);
>> +
>> +       size = roundup(mode_cmd.pitches[0] * mode_cmd.height, PAGE_SIZE);
>
> It's somewhat curious that you used ALIGN in the previous patch and
> roundup here. But anyways, I think PAGE_ALIGN would be the most
> appropriate thing to do here.

agreed, thanks.

>
>> +
>> +       ret = hibmcfb_create_object(hidev, &mode_cmd, &gobj);
>> +       if (ret) {
>> +               DRM_ERROR("failed to create fbcon backing object %d\r\n",
> ret);
>
> \r, yikes!!!

will delete it, thanks.

>
>> +               return -ENOMEM;
>> +       }
>> +
>> +       bo = gem_to_hibmc_bo(gobj);
>> +
>> +       ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
>> +       if (ret)
>
> Print error here?

will do.

>
> How about cleaning up gobj?

you are right,

>
>> +               return ret;
>> +
>> +       ret = hibmc_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
>> +       if (ret) {
>> +               DRM_ERROR("failed to pin fbcon\n");
>
> Print ret
>
> ttm_bo_unreserve? It seems like you're missing clean-up in all of the
> error paths in this function. Can you please make sure everything is
> tidied up?

ok, thanks.

>
>> +               return ret;
>> +       }
>> +
>> +       ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
>> +
>
> nit: extra space

do you mean extra line?

>
>> +       if (ret) {
>> +               DRM_ERROR("failed to kmap fbcon\n");
>
> Print ret

ok, thanks.

>
>> +               ttm_bo_unreserve(&bo->bo);
>> +               return ret;
>> +       }
>> +
>> +       ttm_bo_unreserve(&bo->bo);
>
> Move this between ttm_bo_kmap and if (ret), then remove it from inside
> the conditional.

This is fine with me, thanks.

>
>> +
>> +       info = drm_fb_helper_alloc_fbi(helper);
>> +       if (IS_ERR(info))
>
> Print error

ok, thanks.

>
>> +               return PTR_ERR(info);
>> +
>> +       info->par = hi_fbdev;
>> +
>> +       hibmc_fb = hibmc_framebuffer_init(hidev->dev, &mode_cmd, gobj);
>> +       if (IS_ERR(hibmc_fb)) {
>> +               drm_fb_helper_release_fbi(helper);
>> +               return PTR_ERR(hibmc_fb);
>> +       }
>> +
>> +       hi_fbdev->fb = hibmc_fb;
>> +       hidev->fbdev->size = size;
>> +       fb = &hibmc_fb->fb;
>
> The fb variable isn't necessary, and really, the hibmc_fb doesn't
> really help either, it just masks what's actually happening IMO.

i will clean the two variables.

>
>> +       if (!fb) {
>> +               DRM_INFO("fb is NULL\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       hi_fbdev->helper.fb = fb;
>> +
>> +       strcpy(info->fix.id, "hibmcdrmfb");
>> +
>> +       info->flags = FBINFO_DEFAULT;
>> +       info->fbops = &hibmc_drm_fb_ops;
>> +
>> +       drm_fb_helper_fill_fix(info, fb->pitches[0], fb->depth);
>> +       drm_fb_helper_fill_var(info, &hidev->fbdev->helper, sizes->fb_width,
>> +                              sizes->fb_height);
>> +
>> +       info->screen_base = bo->kmap.virtual;
>> +       info->screen_size = size;
>> +
>> +       info->fix.smem_start = bo->bo.mem.bus.offset + bo->bo.mem.bus.base;
>> +       info->fix.smem_len = size;
>> +
>> +       return 0;
>> +}
>> +
>> +static void hibmc_fbdev_destroy(struct hibmc_fbdev *fbdev)
>> +{
>> +       struct hibmc_framebuffer *gfb = fbdev->fb;
>> +       struct drm_fb_helper *fbh = &fbdev->helper;
>> +
>> +       DRM_DEBUG_DRIVER("hibmc_fbdev_destroy\n");
>
> Not useful

ok, will remove.

>
>> +
>> +       drm_fb_helper_unregister_fbi(fbh);
>> +       drm_fb_helper_release_fbi(fbh);
>> +
>> +       drm_fb_helper_fini(fbh);
>> +
>> +       if (gfb)
>> +               drm_framebuffer_unreference(&gfb->fb);
>> +
>> +       kfree(fbdev);
>> +}
>> +
>> +static const struct drm_fb_helper_funcs hibmc_fbdev_helper_funcs = {
>> +       .fb_probe = hibmc_drm_fb_create,
>> +};
>> +
>> +int hibmc_fbdev_init(struct hibmc_drm_device *hidev)
>> +{
>> +       int ret;
>> +       struct fb_var_screeninfo *var;
>> +       struct fb_fix_screeninfo *fix;
>> +       struct hibmc_fbdev *hifbdev;
>> +
>> +       hifbdev = kzalloc(sizeof(*hifbdev), GFP_KERNEL);
>
> devm_kzalloc?

sounds good, so there need no kfree at hibmc_fbdev_destroy(),
thanks.

>
>> +       if (!hifbdev)
>> +               return -ENOMEM;
>> +
>> +       hidev->fbdev = hifbdev;
>> +       drm_fb_helper_prepare(hidev->dev, &hifbdev->helper,
>> +                             &hibmc_fbdev_helper_funcs);
>> +
>> +       /* Now just one crtc and one channel */
>> +       ret = drm_fb_helper_init(hidev->dev,
>> +                                &hifbdev->helper, 1, 1);
>> +
>
> nit: extra line

ok, thanks.

>
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = drm_fb_helper_single_add_all_connectors(&hifbdev->helper);
>> +       if (ret)
>> +               goto fini;
>> +
>> +       ret = drm_fb_helper_initial_config(&hifbdev->helper, 16);
>> +       if (ret)
>> +               goto fini;
>> +
>> +       var = &hifbdev->helper.fbdev->var;
>> +       fix = &hifbdev->helper.fbdev->fix;
>> +
>> +       DRM_DEBUG("Member of info->var is :\n"
>> +                "xres=%d\n"
>> +                "yres=%d\n"
>> +                "xres_virtual=%d\n"
>> +                "yres_virtual=%d\n"
>> +                "xoffset=%d\n"
>> +                "yoffset=%d\n"
>> +                "bits_per_pixel=%d\n"
>> +                "...\n", var->xres, var->yres, var->xres_virtual,
>> +                var->yres_virtual, var->xoffset, var->yoffset,
>> +                var->bits_per_pixel);
>> +       DRM_DEBUG("Member of info->fix is :\n"
>> +                "smem_start=%lx\n"
>> +                "smem_len=%d\n"
>> +                "type=%d\n"
>> +                "type_aux=%d\n"
>> +                "visual=%d\n"
>> +                "xpanstep=%d\n"
>> +                "ypanstep=%d\n"
>> +                "ywrapstep=%d\n"
>> +                "line_length=%d\n"
>> +                "accel=%d\n"
>> +                "capabilities=%d\n"
>> +                "...\n", fix->smem_start, fix->smem_len, fix->type,
>> +                fix->type_aux, fix->visual, fix->xpanstep,
>> +                fix->ypanstep, fix->ywrapstep, fix->line_length,
>> +                fix->accel, fix->capabilities);
>
> You've been using DRM_DEBUG_DRIVER elsewhere, you should probably use
> it here, too.

ok, thanks.

>
>> +
>> +       return 0;
>> +
>> +fini:
>> +       drm_fb_helper_fini(&hifbdev->helper);
>> +       return ret;
>> +}
>> +
>> +void hibmc_fbdev_fini(struct hibmc_drm_device *hidev)
>> +{
>> +       if (!hidev->fbdev)
>> +               return;
>> +
>> +       hibmc_fbdev_destroy(hidev->fbdev);
>> +       hidev->fbdev = NULL;
>> +}
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>> index 0802ebd..9822f62 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>> @@ -488,3 +488,69 @@ int hibmc_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
>>          drm_gem_object_unreference_unlocked(obj);
>>          return 0;
>>   }
>> +
>> +/* ---------------------------------------------------------------------- */
>> +
>
> Please remove

will do.

>
>> +static void hibmc_user_framebuffer_destroy(struct drm_framebuffer *fb)
>> +{
>> +       struct hibmc_framebuffer *hibmc_fb = to_hibmc_framebuffer(fb);
>> +
>> +       drm_gem_object_unreference_unlocked(hibmc_fb->obj);
>> +       drm_framebuffer_cleanup(fb);
>> +       kfree(hibmc_fb);
>> +}
>> +
>> +static const struct drm_framebuffer_funcs hibmc_fb_funcs = {
>> +       .destroy = hibmc_user_framebuffer_destroy,
>> +};
>> +
>> +struct hibmc_framebuffer *
>> +hibmc_framebuffer_init(struct drm_device *dev,
>> +                      const struct drm_mode_fb_cmd2 *mode_cmd,
>> +                      struct drm_gem_object *obj)
>> +{
>> +       struct hibmc_framebuffer *hibmc_fb;
>> +       int ret;
>> +
>> +       hibmc_fb = kzalloc(sizeof(*hibmc_fb), GFP_KERNEL);
>> +       if (!hibmc_fb)
>
> Print error

ok, thanks.

Regards,
Rongrong.

>
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       drm_helper_mode_fill_fb_struct(&hibmc_fb->fb, mode_cmd);
>> +       hibmc_fb->obj = obj;
>> +       ret = drm_framebuffer_init(dev, &hibmc_fb->fb, &hibmc_fb_funcs);
>> +       if (ret) {
>> +               DRM_ERROR("drm_framebuffer_init failed: %d\n", ret);
>> +               kfree(hibmc_fb);
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       return hibmc_fb;
>> +}
>> +
>> +static struct drm_framebuffer *
>> +hibmc_user_framebuffer_create(struct drm_device *dev,
>> +                             struct drm_file *filp,
>> +                             const struct drm_mode_fb_cmd2 *mode_cmd)
>> +{
>> +       struct drm_gem_object *obj;
>> +       struct hibmc_framebuffer *hibmc_fb;
>> +
>> +       DRM_DEBUG_DRIVER("%dx%d, format %c%c%c%c\n",
>> +                        mode_cmd->width, mode_cmd->height,
>> +                        (mode_cmd->pixel_format) & 0xff,
>> +                        (mode_cmd->pixel_format >> 8)  & 0xff,
>> +                        (mode_cmd->pixel_format >> 16) & 0xff,
>> +                        (mode_cmd->pixel_format >> 24) & 0xff);
>> +
>> +       obj = drm_gem_object_lookup(filp, mode_cmd->handles[0]);
>> +       if (!obj)
>> +               return ERR_PTR(-ENOENT);
>> +
>> +       hibmc_fb = hibmc_framebuffer_init(dev, mode_cmd, obj);
>> +       if (IS_ERR(hibmc_fb)) {
>> +               drm_gem_object_unreference_unlocked(obj);
>> +               return ERR_PTR((long)hibmc_fb);
>> +       }
>> +       return &hibmc_fb->fb;
>> +}
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>
> .
>
