From: robdclark@gmail.com (Rob Clark)
Date: Mon, 10 Jun 2013 11:57:32 -0400
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
Message-ID: <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 3:29 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> This patch adds support for the pair of LCD controllers on the Marvell
> Armada 510 SoCs.  This driver supports:
> - multiple contiguous scanout buffers for video and graphics
> - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
>   acceleration
> - dual lcd0 and lcd1 crt operation
> - video overlay on each LCD crt

Any particular reason for not exposing the overlays as drm_plane's?
That is probably something that should change before merging the
driver.

Other than that, it looks reasonably good, with just a few (mostly
minor) comments below.

> - page flipping of the main scanout buffers
>
> Included in this commit is the core driver with no output support; output
> support is platform and encoder driver dependent.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

[snip]

> diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> new file mode 100644
> index 0000000..e5ab4cb
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_crtc.c
> @@ -0,0 +1,766 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *  Rewritten from the dovefb driver, and Armada510 manuals.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc_helper.h>
> +#include "armada_crtc.h"
> +#include "armada_drm.h"
> +#include "armada_fb.h"
> +#include "armada_gem.h"
> +#include "armada_hw.h"
> +
> +struct armada_frame_work {
> +       struct drm_pending_vblank_event *event;
> +       struct armada_regs regs[4];
> +       struct drm_gem_object *old_fb_obj;
> +       struct work_struct work;
> +};
> +
> +/*
> + * A note about interlacing.  Let's consider HDMI 1920x1080i.
> + * The timing parameters we have from X are:
> + *  Hact HsyA HsyI Htot  Vact VsyA VsyI Vtot
> + *  1920 2448 2492 2640  1080 1084 1094 1125
> + * Which get translated to:
> + *  Hact HsyA HsyI Htot  Vact VsyA VsyI Vtot
> + *  1920 2448 2492 2640   540  542  547  562
> + *
> + * This is how it is defined by CEA-861-D - line and pixel numbers are
> + * referenced to the rising edge of VSYNC and HSYNC.  Total clocks per
> + * line: 2640.  The odd frame, the first active line is at line 21, and
> + * the even frame, the first active line is 584.
> + *
> + * LN:    560     561     562     563             567     568    569
> + * DE:    ~~~|____________________________//__________________________
> + * HSYNC: ____|~|_____|~|_____|~|_____|~|_//__|~|_____|~|_____|~|_____
> + * VSYNC: _________________________|~~~~~~//~~~~~~~~~~~~~~~|__________
> + *  22 blanking lines.  VSYNC at 1320 (referenced to the HSYNC rising edge).
> + *
> + * LN:    1123   1124    1125      1               5       6      7
> + * DE:    ~~~|____________________________//__________________________
> + * HSYNC: ____|~|_____|~|_____|~|_____|~|_//__|~|_____|~|_____|~|_____
> + * VSYNC: ____________________|~~~~~~~~~~~//~~~~~~~~~~|_______________
> + *  23 blanking lines
> + *
> + * The Armada LCD Controller line and pixel numbers are, like X timings,
> + * referenced to the top left of the active frame.
> + *
> + * So, translating these to our LCD controller:
> + *  Odd frame, 563 total lines, VSYNC at line 543-548, pixel 1128.
> + *  Even frame, 562 total lines, VSYNC at line 542-547, pixel 2448.
> + * Note: Vsync front porch remains constant!
> + *
> + * if (odd_frame) {
> + *   vtotal = mode->crtc_vtotal + 1;
> + *   vbackporch = mode->crtc_vsync_start - mode->crtc_vdisplay + 1;
> + *   vhorizpos = mode->crtc_hsync_start - mode->crtc_htotal / 2
> + * } else {
> + *   vtotal = mode->crtc_vtotal;
> + *   vbackporch = mode->crtc_vsync_start - mode->crtc_vdisplay;
> + *   vhorizpos = mode->crtc_hsync_start;
> + * }
> + * vfrontporch = mode->crtc_vtotal - mode->crtc_vsync_end;
> + *
> + * So, we need to reprogram these registers on each vsync event:
> + *  LCD_SPU_V_PORCH, LCD_SPU_ADV_REG, LCD_SPUT_V_H_TOTAL

ouch, proof that some hw designers must really hate driver writers ;-)

[snip]

> +/* The mode_config.mutex will be held for this call */
> +static int armada_drm_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
> +       struct drm_framebuffer *old_fb)
> +{
> +       struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
> +       struct armada_regs regs[4];
> +       unsigned i;
> +
> +       i = armada_drm_crtc_calc_fb(crtc->fb, crtc->x, crtc->y, regs, dcrtc->interlaced);
> +       armada_reg_queue_end(regs, i);
> +
> +       /* Wait for pending flips to complete */
> +       wait_event(dcrtc->frame_wait, !dcrtc->frame_work);
> +
> +       /* Take a reference to the new fb as we're using it */
> +       drm_gem_object_reference(&drm_fb_obj(crtc->fb)->obj);

note that you probably want to ref/unref the fb (and let the fb hold a
ref to the gem bo).. that will make life easier for planar formats too
(as the fb should hold ref's to the bo for each plane)

[snip]

> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
[snip]
> +
> +static struct drm_ioctl_desc armada_ioctls[] = {
> +       DRM_IOCTL_DEF_DRV(ARMADA_GEM_CREATE, armada_gem_create_ioctl, DRM_UNLOCKED),
> +       DRM_IOCTL_DEF_DRV(ARMADA_GEM_CREATE_PHYS, armada_gem_create_phys_ioctl, DRM_UNLOCKED),

you might want just a single ioctl for creating gem objects, with a
'scanout' flag..  perhaps some future version of the hw doesn't need
phys contig for scanout, and this would probably be easier to handle
with a single ioctl that has an 'if (flags & SCANOUT &&
device_needs_phys_contig_scanout()) .. '

[snip]

> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
[snip]
> +int armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
> +{
> +       struct armada_private *priv = dev->dev_private;
> +       size_t size = obj->obj.size;
> +
> +       if (obj->page || obj->linear)
> +               return 0;
> +
> +       /* If it is a small allocation, try to get it from the system */
> +       if (size < 1048576) {
> +               unsigned int order = get_order(size);
> +               struct page *p = alloc_pages(GFP_KERNEL, order);
> +
> +               if (p) {
> +                       unsigned sz = (size + 31) & ~31;
> +                       uintptr_t ptr;
> +
> +                       obj->phys_addr = page_to_phys(p);
> +                       obj->dev_addr = obj->phys_addr;
> +
> +                       /* FIXME: Hack around dirty cache */
> +                       ptr = (uintptr_t)phys_to_virt(obj->phys_addr);
> +                       memset((void *)ptr, 0, PAGE_ALIGN(size));
> +                       while (sz) {
> +                               asm volatile("mcr p15, 0, %0, c7, c14, 1" : : "r" (ptr));
> +                               ptr += 32;
> +                               sz -= 32;
> +                       }
> +                       dsb();
> +
> +                       obj->page = p;
> +               }
> +       }

maybe leave out the small size case until there is a better way to
deal with cache, since this seems like just an optimization..

although I wonder why not just use CMA?  (Other than maybe
performance.. but I guess this is only for allocating scanout buffers,
in which case all the bazillion of temporary pixmaps that X11
creates/deletes won't be hitting this path..)

> +       /* Otherwise, grab it from our linear allocation */
> +       if (!obj->page) {
> +               struct drm_mm_node *free;
> +               unsigned align = min_t(unsigned, size, SZ_2M);
> +               void __iomem *ptr;
> +
> +               free = drm_mm_search_free(&priv->linear, size, align, 0);
> +               if (free)
> +                       obj->linear = drm_mm_get_block(free, size, align);
> +               if (!obj->linear)
> +                       return -ENOSPC;
> +
> +               /* Ensure that the memory we're returning is cleared. */
> +               ptr = ioremap_wc(obj->linear->start, size);
> +               if (!ptr) {
> +                       drm_mm_put_block(obj->linear);
> +                       obj->linear = NULL;
> +                       return -ENOMEM;
> +               }
> +
> +               memset_io(ptr, 0, size);
> +               iounmap(ptr);
> +
> +               obj->phys_addr = obj->linear->start;
> +               obj->dev_addr = obj->linear->start;
> +       }
> +
> +       DRM_DEBUG_DRIVER("obj %p phys %#x dev %#x\n",
> +                        obj, obj->phys_addr, obj->dev_addr);
> +
> +       return 0;
> +}

[snip]

> +int armada_gem_prop_ioctl(struct drm_device *dev, void *data,
> +       struct drm_file *file)
> +{
> +       struct drm_armada_gem_prop *arg = data;
> +       struct armada_gem_object *dobj;
> +       int ret;
> +
> +       ret = mutex_lock_interruptible(&dev->struct_mutex);
> +       if (ret)
> +               return ret;
> +
> +       dobj = armada_gem_object_lookup(dev, file, arg->handle);
> +       if (dobj == NULL) {
> +               ret = -ENOENT;
> +               goto unlock;
> +       }
> +
> +       arg->phys = dobj->phys_addr;

ugg, do you really need to expose phys addr to userspace?  Any chance
to just teach the gpu bits about dmabuf instead?

> +       ret = 0;
> +       drm_gem_object_unreference(&dobj->obj);
> +
> + unlock:
> +       mutex_unlock(&dev->struct_mutex);
> +
> +       return ret;
> +}

[snip]

> diff --git a/drivers/gpu/drm/armada/armada_ioctl.h b/drivers/gpu/drm/armada/armada_ioctl.h
> new file mode 100644
> index 0000000..619ec2c
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_ioctl.h
> @@ -0,0 +1,128 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *  With inspiration from the i915 driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef DRM_ARMADA_IOCTL_H
> +#define DRM_ARMADA_IOCTL_H
> +
> +#define DRM_ARMADA_GEM_CREATE          0x00
> +#define DRM_ARMADA_GEM_CREATE_PHYS     0x01
> +#define DRM_ARMADA_GEM_MMAP            0x02
> +#define DRM_ARMADA_GEM_PWRITE          0x03
> +#define DRM_ARMADA_GEM_PROP            0x04
> +#define DRM_ARMADA_OVERLAY_PUT_IMAGE   0x06
> +#define DRM_ARMADA_OVERLAY_ATTRS               0x07
> +
> +#define ARMADA_IOCTL(dir,name,str) \
> +       DRM_##dir(DRM_COMMAND_BASE + DRM_ARMADA_##name, struct drm_armada_##str)
> +
> +struct drm_armada_gem_create {
> +       uint32_t height;
> +       uint32_t width;
> +       uint32_t bpp;

just fwiw, typically height/width/bpp are properties of the fb but not
the bo.. (except in some cases where kernel needs to know this to
setup GTT correctly for tiled buffers)

> +       uint32_t handle;
> +       uint32_t pitch;
> +       uint32_t size;
> +};
> +#define DRM_IOCTL_ARMADA_GEM_CREATE \
> +       ARMADA_IOCTL(IOWR, GEM_CREATE, gem_create)
> +
> +struct drm_armada_gem_create_phys {
> +       uint32_t size;
> +       uint32_t handle;
> +       uint64_t phys;
> +};
> +#define DRM_IOCTL_ARMADA_GEM_CREATE_PHYS \
> +       ARMADA_IOCTL(IOWR, GEM_CREATE_PHYS, gem_create_phys)
> +
> +struct drm_armada_gem_mmap {
> +       uint32_t handle;
> +       uint32_t pad;
> +       uint64_t offset;
> +       uint64_t size;
> +       uint64_t addr;
> +};
> +#define DRM_IOCTL_ARMADA_GEM_MMAP \
> +       ARMADA_IOCTL(IOWR, GEM_MMAP, gem_mmap)
> +
> +struct drm_armada_gem_pwrite {
> +       uint32_t handle;
> +       uint32_t offset;
> +       uint32_t size;

probably want a uint32_t padding here, or move the uint64_t up in the
struct to avoid 32 vs 64b alignment differences.

> +       uint64_t ptr;
> +};
> +#define DRM_IOCTL_ARMADA_GEM_PWRITE \
> +       ARMADA_IOCTL(IOW, GEM_PWRITE, gem_pwrite)
> +

[snip]

> diff --git a/drivers/gpu/drm/armada/armada_output.c b/drivers/gpu/drm/armada/armada_output.c

[snip]

> +/* Shouldn't this be a generic helper function? */

I didn't bother making it a generic helper, because in tilcdc I also
needed to check some crtc constraints.  Although if there is >1 other
drivers that don't need to, we can easily make it a helper.

> +int armada_drm_slave_encoder_mode_valid(struct drm_connector *conn,
> +       struct drm_display_mode *mode)
> +{
> +       struct drm_encoder *encoder = armada_drm_connector_encoder(conn);
> +       int valid = MODE_BAD;
> +
> +       if (encoder) {
> +               struct drm_encoder_slave *slave = to_encoder_slave(encoder);
> +
> +               valid = slave->slave_funcs->mode_valid(encoder, mode);
> +       }
> +       return valid;
> +}
> +

[snip]

> diff --git a/drivers/gpu/drm/armada/drm_helper.h b/drivers/gpu/drm/armada/drm_helper.h
> new file mode 100644
> index 0000000..d9f2e8d
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/drm_helper.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef DRM_HELPER_H
> +#define DRM_HELPER_H
> +
> +/* Useful helpers I wish the DRM core would provide */
> +

yeah, we should probably just add these in core

BR,
-R

> +#include <drm/drmP.h>
> +
> +static inline struct drm_crtc *drm_crtc_find(struct drm_device *dev,
> +       uint32_t id)
> +{
> +       struct drm_mode_object *mo;
> +       mo = drm_mode_object_find(dev, id, DRM_MODE_OBJECT_CRTC);
> +       return mo ? obj_to_crtc(mo) : NULL;
> +}
> +
> +static inline struct drm_encoder *drm_encoder_find(struct drm_device *dev,
> +       uint32_t id)
> +{
> +       struct drm_mode_object *mo;
> +       mo = drm_mode_object_find(dev, id, DRM_MODE_OBJECT_ENCODER);
> +       return mo ? obj_to_encoder(mo) : NULL;
> +}
> +
> +#endif
> --
> 1.7.4.4
>
