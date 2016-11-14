From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 14 Nov 2016 12:08:35 -0500
Subject: [PATCH v6 4/9] drm/hisilicon/hibmc: Add plane for DE
In-Reply-To: <5826A498.4000002@huawei.com>
References: <1477639682-22520-1-git-send-email-zourongrong@gmail.com>
 <1477639682-22520-5-git-send-email-zourongrong@gmail.com>
 <CAOw6vb+kibtOkViwB4+gEn=+u14esSoNVavhrasNxtrCoWhyJQ@mail.gmail.com>
 <5826A498.4000002@huawei.com>
Message-ID: <CAOw6vbK2XOBj_CJ3MPEb9MboZ2H0wH4PMTcaXD9cyGu+fsed7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 12:11 AM, Rongrong Zou <zourongrong@huawei.com> wrote:
> ? 2016/11/11 5:53, Sean Paul ??:
>>
>> On Fri, Oct 28, 2016 at 3:27 AM, Rongrong Zou <zourongrong@gmail.com>
>> wrote:
>>>
>>> Add plane funcs and helper funcs for DE.
>>>
>>> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
>>> ---
>>>   drivers/gpu/drm/hisilicon/hibmc/Kconfig         |   1 +
>>>   drivers/gpu/drm/hisilicon/hibmc/Makefile        |   2 +-
>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 170
>>> ++++++++++++++++++++++++
>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h  |  29 ++++
>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |  51 ++++++-
>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |   5 +
>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c     |   6 +
>>>   7 files changed, 261 insertions(+), 3 deletions(-)
>>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
>>>
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
>>> b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
>>> index bcb8c18..380622a 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
>>> @@ -1,6 +1,7 @@
>>>   config DRM_HISI_HIBMC
>>>          tristate "DRM Support for Hisilicon Hibmc"
>>>          depends on DRM && PCI
>>> +       select DRM_KMS_HELPER
>>>          select DRM_TTM
>>>
>>>          help
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile
>>> b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>>> index 810a37e..72e107e 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>>> @@ -1,5 +1,5 @@
>>>   ccflags-y := -Iinclude/drm
>>> -hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_fbdev.o hibmc_drm_power.o
>>> hibmc_ttm.o
>>> +hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_fbdev.o
>>> hibmc_drm_power.o hibmc_ttm.o
>>>
>>>   obj-$(CONFIG_DRM_HISI_HIBMC)   +=hibmc-drm.o
>>>   #obj-y += hibmc-drm.o
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>> new file mode 100644
>>> index 0000000..9c1a68c
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>> @@ -0,0 +1,170 @@
>>> +/* Hisilicon Hibmc SoC drm driver
>>> + *
>>> + * Based on the bochs drm driver.
>>> + *
>>> + * Copyright (c) 2016 Huawei Limited.
>>> + *
>>> + * Author:
>>> + *     Rongrong Zou <zourongrong@huawei.com>
>>> + *     Rongrong Zou <zourongrong@gmail.com>
>>> + *     Jianhua Li <lijianhua@huawei.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + */
>>> +
>>> +#include <drm/drm_atomic.h>
>>> +#include <drm/drm_atomic_helper.h>
>>> +#include <drm/drm_crtc_helper.h>
>>> +#include <drm/drm_plane_helper.h>
>>> +
>>> +#include "hibmc_drm_drv.h"
>>> +#include "hibmc_drm_regs.h"
>>> +#include "hibmc_drm_power.h"
>>> +
>>> +/*
>>> ---------------------------------------------------------------------- */
>>
>>
>> Remove
>
>
> ok, will do, thanks.
>
>>
>>> +
>>> +static int hibmc_plane_atomic_check(struct drm_plane *plane,
>>> +                                   struct drm_plane_state *state)
>>> +{
>>> +       struct drm_framebuffer *fb = state->fb;
>>> +       struct drm_crtc *crtc = state->crtc;
>>> +       struct drm_crtc_state *crtc_state;
>>> +       u32 src_x = state->src_x >> 16;
>>> +       u32 src_y = state->src_y >> 16;
>>> +       u32 src_w = state->src_w >> 16;
>>> +       u32 src_h = state->src_h >> 16;
>>> +       int crtc_x = state->crtc_x;
>>> +       int crtc_y = state->crtc_y;
>>> +       u32 crtc_w = state->crtc_w;
>>> +       u32 crtc_h = state->crtc_h;
>>
>>
>> I don't think you gain anything with the crtc_* vars
>
>
> It would work well, but looks redundant and not simple enough,
> will delete them, thanks.
>
>>
>>> +
>>> +       if (!crtc || !fb)
>>> +               return 0;
>>> +
>>> +       crtc_state = drm_atomic_get_crtc_state(state->state, crtc);
>>> +       if (IS_ERR(crtc_state))
>>> +               return PTR_ERR(crtc_state);
>>> +
>>> +       if (src_w != crtc_w || src_h != crtc_h) {
>>> +               DRM_ERROR("Scale not support!!!\n");
>>
>>
>> I like the enthusiasm, but I think DRM_DEBUG_ATOMIC would be better
>
>
> I'm sorry, can you explain why here should be an DRM_DEBUG_ATOMIC,
> when this condition is hit, it is really an error and atomic_commit will
> abort with failure.
>

I don't have strong opinions, but this class of failure isn't a driver
error, so much as invalid input from userspace. As such, I'd tend to
classify it as debug level.

At any rate, keep it ERROR if you really want.

Sean

>>
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       if (src_x + src_w > fb->width ||
>>> +           src_y + src_h > fb->height)
>>
>>
>> These should be already covered in drm_atomic_plane_check
>
>
> understood, thanks.
>
>>
>>> +               return -EINVAL;
>>> +
>>> +       if (crtc_x < 0 || crtc_y < 0)
>>
>>
>> Print DRM_DEBUG_ATOMIC message here
>
>
> agreed. thanks.
>
>>
>>> +               return -EINVAL;
>>> +
>>> +       if (crtc_x + crtc_w > crtc_state->adjusted_mode.hdisplay ||
>>> +           crtc_y + crtc_h > crtc_state->adjusted_mode.vdisplay)
>>
>>
>> DRM_DEBUG_ATOMIC here too
>
>
> ditto.
>
>>
>>> +               return -EINVAL;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void hibmc_plane_atomic_update(struct drm_plane *plane,
>>> +                                     struct drm_plane_state *old_state)
>>> +{
>>> +       struct drm_plane_state  *state  = plane->state;
>>> +       u32 reg;
>>> +       int ret;
>>> +       u64 gpu_addr = 0;
>>> +       unsigned int line_l;
>>> +       struct hibmc_drm_device *hidev =
>>> +               (struct hibmc_drm_device *)plane->dev->dev_private;
>>> +
>>
>>
>> nit: extra line
>
>
> will delete, thanks.
>
>>> +       struct hibmc_framebuffer *hibmc_fb;
>>> +       struct hibmc_bo *bo;
>>> +
>>> +       hibmc_fb = to_hibmc_framebuffer(state->fb);
>>> +       bo = gem_to_hibmc_bo(hibmc_fb->obj);
>>> +       ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
>>> +       if (ret)
>>
>>
>> Print error
>
>
> agreed, thanks.
>
>>
>>> +               return;
>>> +
>>> +       hibmc_bo_pin(bo, TTM_PL_FLAG_VRAM, &gpu_addr);
>>
>>
>> Check return value
>
>
> ok, thanks.
>
>>
>>> +       if (ret) {
>>> +               ttm_bo_unreserve(&bo->bo);
>>> +               return;
>>> +       }
>>> +
>>> +       ttm_bo_unreserve(&bo->bo);
>>
>>
>> Move this up before the conditional so you don't have to call it in
>> both branches
>
>
> understood, thanks.
>
>>
>>> +
>>> +       writel(gpu_addr, hidev->mmio + HIBMC_CRT_FB_ADDRESS);
>>> +
>>> +       reg = state->fb->width * (state->fb->bits_per_pixel >> 3);
>>> +       /* now line_pad is 16 */
>>> +       reg = PADDING(16, reg);
>>> +
>>> +       line_l = state->fb->width * state->fb->bits_per_pixel / 8;
>>
>>
>> above, you >> 3. here you / 8, pick one?
>
>
> i prefer /8 because it is more readable to human, although it is less
> effective
> in executing.
>

I think the compiler will optimize it, regardless.

Sean

>>
>>> +       line_l = PADDING(16, line_l);
>>> +       writel((HIBMC_CRT_FB_WIDTH_WIDTH(reg) &
>>> HIBMC_CRT_FB_WIDTH_WIDTH_MASK) |
>>> +              (HIBMC_CRT_FB_WIDTH_OFFS(line_l) &
>>> HIBMC_CRT_FB_WIDTH_OFFS_MASK),
>>> +              hidev->mmio + HIBMC_CRT_FB_WIDTH);
>>> +
>>> +       /* SET PIXEL FORMAT */
>>> +       reg = readl(hidev->mmio + HIBMC_CRT_DISP_CTL);
>>> +       reg = reg & ~HIBMC_CRT_DISP_CTL_FORMAT_MASK;
>>> +       reg = reg | (HIBMC_CRT_DISP_CTL_FORMAT(state->fb->bits_per_pixel
>>> >> 4) &
>>> +                    HIBMC_CRT_DISP_CTL_FORMAT_MASK);
>>> +       writel(reg, hidev->mmio + HIBMC_CRT_DISP_CTL);
>>> +}
>>> +
>>> +static void hibmc_plane_atomic_disable(struct drm_plane *plane,
>>> +                                      struct drm_plane_state *old_state)
>>> +{
>>> +}
>>
>>
>> The caller checks for NULL, no need to stub
>
>
> thanks for pointing it out,
> will remove.
>
> Regards,
> Rongrong.
>
>>
>>> +
>>> +static const u32 channel_formats1[] = {
>>> +       DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
>>> +       DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
>>> +       DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
>>> +       DRM_FORMAT_ABGR8888
>>> +};
>>> +
>>> +static struct drm_plane_funcs hibmc_plane_funcs = {
>>> +       .update_plane   = drm_atomic_helper_update_plane,
>>> +       .disable_plane  = drm_atomic_helper_disable_plane,
>>> +       .set_property = drm_atomic_helper_plane_set_property,
>>> +       .destroy = drm_plane_cleanup,
>>> +       .reset = drm_atomic_helper_plane_reset,
>>> +       .atomic_duplicate_state =
>>> drm_atomic_helper_plane_duplicate_state,
>>> +       .atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
>>> +};
>>> +
>>> +static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
>>> +       .atomic_check = hibmc_plane_atomic_check,
>>> +       .atomic_update = hibmc_plane_atomic_update,
>>> +       .atomic_disable = hibmc_plane_atomic_disable,
>>> +};
>>> +
>>> +int hibmc_plane_init(struct hibmc_drm_device *hidev)
>>> +{
>>> +       struct drm_device *dev = hidev->dev;
>>> +       struct drm_plane *plane = &hidev->plane;
>>> +       int ret = 0;
>>> +
>>> +       /*
>>> +        * plane init
>>> +        * TODO: Now only support primary plane, overlay planes
>>> +        * need to do.
>>> +        */
>>> +       ret = drm_universal_plane_init(dev, plane, 1, &hibmc_plane_funcs,
>>> +                                      channel_formats1,
>>> +                                      ARRAY_SIZE(channel_formats1),
>>> +                                      DRM_PLANE_TYPE_PRIMARY,
>>> +                                      NULL);
>>> +       if (ret) {
>>> +               DRM_ERROR("fail to init plane!!!\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
>>> +       return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
>>> new file mode 100644
>>> index 0000000..4ce0d7b
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
>>> @@ -0,0 +1,29 @@
>>> +/* Hisilicon Hibmc SoC drm driver
>>> + *
>>> + * Based on the bochs drm driver.
>>> + *
>>> + * Copyright (c) 2016 Huawei Limited.
>>> + *
>>> + * Author:
>>> + *     Rongrong Zou <zourongrong@huawei.com>
>>> + *     Rongrong Zou <zourongrong@gmail.com>
>>> + *     Jianhua Li <lijianhua@huawei.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + */
>>> +
>>> +#ifndef HIBMC_DRM_DE_H
>>> +#define HIBMC_DRM_DE_H
>>> +
>>> +struct panel_pll {
>>> +       unsigned long M;
>>> +       unsigned long N;
>>> +       unsigned long OD;
>>> +       unsigned long POD;
>>> +};
>>> +
>>> +#endif
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> index 5ac7a7e..7d96583 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> @@ -18,6 +18,7 @@
>>>
>>>   #include <linux/module.h>
>>>   #include <linux/console.h>
>>> +#include <drm/drm_crtc_helper.h>
>>>
>>>   #include "hibmc_drm_drv.h"
>>>   #include "hibmc_drm_regs.h"
>>> @@ -47,8 +48,8 @@ static void hibmc_disable_vblank(struct drm_device
>>> *dev, unsigned int pipe)
>>>   }
>>>
>>>   static struct drm_driver hibmc_driver = {
>>> -       .driver_features        = DRIVER_GEM,
>>> -
>>> +       .driver_features        = DRIVER_GEM | DRIVER_MODESET |
>>> +                                 DRIVER_ATOMIC,
>>>          .fops                   = &hibmc_fops,
>>>          .name                   = "hibmc",
>>>          .date                   = "20160828",
>>> @@ -70,6 +71,7 @@ static int hibmc_pm_suspend(struct device *dev)
>>>          struct drm_device *drm_dev = pci_get_drvdata(pdev);
>>>          struct hibmc_drm_device *hidev = drm_dev->dev_private;
>>>
>>> +       drm_kms_helper_poll_disable(drm_dev);
>>>          drm_fb_helper_set_suspend_unlocked(&hidev->fbdev->helper, 1);
>>>
>>>          return 0;
>>> @@ -81,7 +83,9 @@ static int hibmc_pm_resume(struct device *dev)
>>>          struct drm_device *drm_dev = pci_get_drvdata(pdev);
>>>          struct hibmc_drm_device *hidev = drm_dev->dev_private;
>>>
>>> +       drm_helper_resume_force_mode(drm_dev);
>>>          drm_fb_helper_set_suspend_unlocked(&hidev->fbdev->helper, 0);
>>> +       drm_kms_helper_poll_enable(drm_dev);
>>>
>>>          return 0;
>>>   }
>>> @@ -91,6 +95,41 @@ static int hibmc_pm_resume(struct device *dev)
>>>                                  hibmc_pm_resume)
>>>   };
>>>
>>> +static int hibmc_kms_init(struct hibmc_drm_device *hidev)
>>> +{
>>> +       int ret;
>>> +
>>> +       drm_mode_config_init(hidev->dev);
>>> +       hidev->mode_config_initialized = true;
>>> +
>>> +       hidev->dev->mode_config.min_width = 0;
>>> +       hidev->dev->mode_config.min_height = 0;
>>> +       hidev->dev->mode_config.max_width = 1920;
>>> +       hidev->dev->mode_config.max_height = 1440;
>>> +
>>> +       hidev->dev->mode_config.fb_base = hidev->fb_base;
>>> +       hidev->dev->mode_config.preferred_depth = 24;
>>> +       hidev->dev->mode_config.prefer_shadow = 0;
>>> +
>>> +       hidev->dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>>> +
>>> +       ret = hibmc_plane_init(hidev);
>>> +       if (ret) {
>>> +               DRM_ERROR("fail to init plane!!!\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void hibmc_kms_fini(struct hibmc_drm_device *hidev)
>>> +{
>>> +       if (hidev->mode_config_initialized) {
>>> +               drm_mode_config_cleanup(hidev->dev);
>>> +               hidev->mode_config_initialized = false;
>>> +       }
>>> +}
>>> +
>>>   static int hibmc_hw_config(struct hibmc_drm_device *hidev)
>>>   {
>>>          unsigned int reg;
>>> @@ -183,6 +222,7 @@ static int hibmc_unload(struct drm_device *dev)
>>>          struct hibmc_drm_device *hidev = dev->dev_private;
>>>
>>>          hibmc_fbdev_fini(hidev);
>>> +       hibmc_kms_fini(hidev);
>>>          hibmc_mm_fini(hidev);
>>>          hibmc_hw_fini(hidev);
>>>          dev->dev_private = NULL;
>>> @@ -208,6 +248,13 @@ static int hibmc_load(struct drm_device *dev,
>>> unsigned long flags)
>>>          if (ret)
>>>                  goto err;
>>>
>>> +       ret = hibmc_kms_init(hidev);
>>> +       if (ret)
>>> +               goto err;
>>> +
>>> +       /* reset all the states of crtc/plane/encoder/connector */
>>> +       drm_mode_config_reset(dev);
>>> +
>>>          ret = hibmc_fbdev_init(hidev);
>>>          if (ret)
>>>                  goto err;
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> index a40e9a7..49e39d2 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> @@ -45,6 +45,8 @@ struct hibmc_drm_device {
>>>
>>>          /* drm */
>>>          struct drm_device  *dev;
>>> +       struct drm_plane plane;
>>> +       bool mode_config_initialized;
>>>
>>>          /* ttm */
>>>          struct {
>>> @@ -82,6 +84,7 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct
>>> drm_gem_object *gem)
>>>
>>>   #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
>>>
>>> +int hibmc_plane_init(struct hibmc_drm_device *hidev);
>>>   int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
>>>   void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
>>>
>>> @@ -102,4 +105,6 @@ int hibmc_dumb_mmap_offset(struct drm_file *file,
>>> struct drm_device *dev,
>>>                             u32 handle, u64 *offset);
>>>   int hibmc_mmap(struct file *filp, struct vm_area_struct *vma);
>>>
>>> +extern const struct drm_mode_config_funcs hibmc_mode_funcs;
>>> +
>>>   #endif
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>>> index 9822f62..beb4d76 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>>> @@ -554,3 +554,9 @@ struct hibmc_framebuffer *
>>>          }
>>>          return &hibmc_fb->fb;
>>>   }
>>> +
>>> +const struct drm_mode_config_funcs hibmc_mode_funcs = {
>>> +       .atomic_check = drm_atomic_helper_check,
>>> +       .atomic_commit = drm_atomic_helper_commit,
>>> +       .fb_create = hibmc_user_framebuffer_create,
>>> +};
>>> --
>>> 1.9.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> _______________________________________________
>> linuxarm mailing list
>> linuxarm at huawei.com
>> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>>
>> .
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
