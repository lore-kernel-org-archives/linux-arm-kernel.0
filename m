From: robdclark@gmail.com (Rob Clark)
Date: Thu, 10 Oct 2013 17:25:15 -0400
Subject: [PATCH 2/5] DRM: Armada: Add Armada DRM driver
In-Reply-To: <E1VSwVU-0000hu-09@rmk-PC.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwVU-0000hu-09@rmk-PC.arm.linux.org.uk>
Message-ID: <CAF6AEGsvBaX5+c1P=ups+k=d1F3r+JphgYOt5wb7pEM3mihOQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 6, 2013 at 6:08 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> This patch adds support for the pair of LCD controllers on the Marvell
> Armada 510 SoCs.  This driver supports:
> - multiple contiguous scanout buffers for video and graphics
> - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
>   acceleration
> - dual lcd0 and lcd1 crt operation
> - video overlay on each LCD crt via DRM planes
> - page flipping of the main scanout buffers
> - DRM prime for buffer export/import
>
> This driver is trivial to extend to other Armada SoCs.
>
> Included in this commit is the core driver with no output support; output
> support is platform and encoder driver dependent.

w/ a couple minor comments below:

Reviewed-by: Rob Clark <robdclark@gmail.com>


> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/Kconfig                 |    2 +
>  drivers/gpu/drm/Makefile                |    1 +
>  drivers/gpu/drm/armada/Kconfig          |   15 +
>  drivers/gpu/drm/armada/Makefile         |    7 +
>  drivers/gpu/drm/armada/armada_510.c     |   86 +++
>  drivers/gpu/drm/armada/armada_crtc.c    |  861 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/armada/armada_crtc.h    |   74 +++
>  drivers/gpu/drm/armada/armada_debugfs.c |  183 +++++++
>  drivers/gpu/drm/armada/armada_drm.h     |  112 ++++
>  drivers/gpu/drm/armada/armada_drv.c     |  380 ++++++++++++++
>  drivers/gpu/drm/armada/armada_fb.c      |  170 ++++++
>  drivers/gpu/drm/armada/armada_fb.h      |   24 +
>  drivers/gpu/drm/armada/armada_fbdev.c   |  202 ++++++++
>  drivers/gpu/drm/armada/armada_gem.c     |  616 ++++++++++++++++++++++
>  drivers/gpu/drm/armada/armada_gem.h     |   52 ++
>  drivers/gpu/drm/armada/armada_hw.h      |  316 +++++++++++
>  drivers/gpu/drm/armada/armada_ioctlP.h  |   18 +
>  drivers/gpu/drm/armada/armada_output.c  |  158 ++++++
>  drivers/gpu/drm/armada/armada_output.h  |   39 ++
>  drivers/gpu/drm/armada/armada_overlay.c |  477 +++++++++++++++++
>  drivers/gpu/drm/armada/armada_slave.c   |  139 +++++
>  drivers/gpu/drm/armada/armada_slave.h   |   26 +
>  include/drm/drm_crtc.h                  |   17 +
>  include/uapi/drm/armada_drm.h           |   45 ++
>  24 files changed, 4020 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpu/drm/armada/Kconfig
>  create mode 100644 drivers/gpu/drm/armada/Makefile
>  create mode 100644 drivers/gpu/drm/armada/armada_510.c
>  create mode 100644 drivers/gpu/drm/armada/armada_crtc.c
>  create mode 100644 drivers/gpu/drm/armada/armada_crtc.h
>  create mode 100644 drivers/gpu/drm/armada/armada_debugfs.c
>  create mode 100644 drivers/gpu/drm/armada/armada_drm.h
>  create mode 100644 drivers/gpu/drm/armada/armada_drv.c
>  create mode 100644 drivers/gpu/drm/armada/armada_fb.c
>  create mode 100644 drivers/gpu/drm/armada/armada_fb.h
>  create mode 100644 drivers/gpu/drm/armada/armada_fbdev.c
>  create mode 100644 drivers/gpu/drm/armada/armada_gem.c
>  create mode 100644 drivers/gpu/drm/armada/armada_gem.h
>  create mode 100644 drivers/gpu/drm/armada/armada_hw.h
>  create mode 100644 drivers/gpu/drm/armada/armada_ioctlP.h
>  create mode 100644 drivers/gpu/drm/armada/armada_output.c
>  create mode 100644 drivers/gpu/drm/armada/armada_output.h
>  create mode 100644 drivers/gpu/drm/armada/armada_overlay.c
>  create mode 100644 drivers/gpu/drm/armada/armada_slave.c
>  create mode 100644 drivers/gpu/drm/armada/armada_slave.h
>  create mode 100644 include/uapi/drm/armada_drm.h
>
[snip]
> +/*
> + * Prepare for a mode set.  Turn off overlay to ensure that we don't end
> + * up with the overlay size being bigger than the active screen size.
> + * We rely upon X refreshing this state after the mode set has completed.
> + *
> + * The mode_config.mutex will be held for this call
> + */
> +static void armada_drm_crtc_prepare(struct drm_crtc *crtc)
> +{
> +       struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
> +       struct drm_plane *plane;
> +
> +       /*
> +        * If we have an overlay plane associated with this CRTC, disable
> +        * it before the modeset to avoid its coordinates being outside
> +        * the new mode parameters.  DRM doesn't provide help with this.
> +        */

Getting a bit off topic, but yeah.. I'd be in favor of "clarifying"
things by having crtc helpers disable planes on setcrtc (rather than
only doing this on fbdev/lastclose restore).  I
don't know of any userspace that this would cause problems for.  But
not really sure if it would be considered an interface break or just
"fixing a bug".. since we have different behavior on different
drivers, I'd lean towards the latter.

> +       plane = dcrtc->plane;
> +       if (plane) {
> +               struct drm_framebuffer *fb = plane->fb;
> +
> +               plane->funcs->disable_plane(plane);
> +               plane->fb = NULL;
> +               plane->crtc = NULL;
> +               drm_framebuffer_unreference(fb);
> +       }
> +}


> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> new file mode 100644
> index 0000000..c865a9a
> --- /dev/null
> +++ b/drivers/gpu/drm/armada/armada_gem.c
> @@ -0,0 +1,616 @@
> +/*
> + * Copyright (C) 2012 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/dma-buf.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/shmem_fs.h>
> +#include <drm/drmP.h>
> +#include "armada_drm.h"
> +#include "armada_gem.h"
> +#include <drm/armada_drm.h>
> +#include "armada_ioctlP.h"
> +
> +static int armada_gem_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> +{
> +       struct armada_gem_object *obj = drm_to_armada_gem(vma->vm_private_data);
> +       unsigned long addr = (unsigned long)vmf->virtual_address;
> +       unsigned long pfn = obj->phys_addr >> PAGE_SHIFT;
> +       int ret;
> +
> +       pfn += (addr - vma->vm_start) >> PAGE_SHIFT;
> +       ret = vm_insert_pfn(vma, addr, pfn);
> +
> +       switch (ret) {
> +       case -EIO:
> +       case -EAGAIN:
> +               set_need_resched();

probably this thread is applicable here too?

https://lkml.org/lkml/2013/9/12/417

(although.. we have at least a few  slightly differet variants on the
same errno -> VM_FAULT_x switch in different drivers.. maybe we should
do something better)

> +       case 0:
> +       case -ERESTARTSYS:
> +       case -EINTR:
> +       case -EBUSY:
> +               return VM_FAULT_NOPAGE;
> +       case -ENOMEM:
> +               return VM_FAULT_OOM;
> +       default:
> +               return VM_FAULT_SIGBUS;
> +       }
> +}
> +

[snip]

> +/* Prime support */
> +struct sg_table *
> +armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
> +       enum dma_data_direction dir)
> +{
> +       struct drm_gem_object *obj = attach->dmabuf->priv;
> +       struct armada_gem_object *dobj = drm_to_armada_gem(obj);
> +       struct scatterlist *sg;
> +       struct sg_table *sgt;
> +       int i, num;
> +
> +       sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> +       if (!sgt)
> +               return NULL;
> +
> +       if (dobj->obj.filp) {
> +               struct address_space *mapping;
> +               gfp_t gfp;
> +               int count;
> +
> +               count = dobj->obj.size / PAGE_SIZE;
> +               if (sg_alloc_table(sgt, count, GFP_KERNEL))
> +                       goto free_sgt;
> +
> +               mapping = file_inode(dobj->obj.filp)->i_mapping;
> +               gfp = mapping_gfp_mask(mapping);
> +
> +               for_each_sg(sgt->sgl, sg, count, i) {
> +                       struct page *page;
> +
> +                       page = shmem_read_mapping_page_gfp(mapping, i, gfp);

you could almost use drm_gem_get_pages().. although I guess you
otherwise have no need for the page[] array?

(the page array would be handy if you supported mmap on shmem backed
files.. which as long as they are cached should be the easy case)

> +                       if (IS_ERR(page)) {
> +                               num = i;
> +                               goto release;
> +                       }
> +
> +                       sg_set_page(sg, page, PAGE_SIZE, 0);
> +               }
> +
> +               if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
> +                       num = sgt->nents;
> +                       goto release;
> +               }
> +       } else if (dobj->page) {
> +               /* Single contiguous page */
> +               if (sg_alloc_table(sgt, 1, GFP_KERNEL))
> +                       goto free_sgt;
> +
> +               sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
> +
> +               if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
> +                       goto free_table;
> +       } else if (dobj->linear) {
> +               /* Single contiguous physical region - no struct page */
> +               if (sg_alloc_table(sgt, 1, GFP_KERNEL))
> +                       goto free_sgt;
> +               sg_dma_address(sgt->sgl) = dobj->dev_addr;
> +               sg_dma_len(sgt->sgl) = dobj->obj.size;
> +       } else {
> +               goto free_sgt;
> +       }
> +       return sgt;
> +
> + release:
> +       for_each_sg(sgt->sgl, sg, num, i)
> +               page_cache_release(sg_page(sg));
> + free_table:
> +       sg_free_table(sgt);
> + free_sgt:
> +       kfree(sgt);
> +       return NULL;
> +}
[snip]
> +> diff --git a/include/uapi/drm/armada_drm.h b/include/uapi/drm/armada_drm.h
> new file mode 100644
> index 0000000..8dec3fd
> --- /dev/null
> +++ b/include/uapi/drm/armada_drm.h
> @@ -0,0 +1,45 @@
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
> +#define DRM_ARMADA_GEM_MMAP            0x02
> +#define DRM_ARMADA_GEM_PWRITE          0x03
> +
> +#define ARMADA_IOCTL(dir, name, str) \
> +       DRM_##dir(DRM_COMMAND_BASE + DRM_ARMADA_##name, struct drm_armada_##str)
> +
> +struct drm_armada_gem_create {

Any reason not to throw in a 'uint32_t flags' field?  At least then
you could indicate what sort of backing memory you want, and do things
like allocate linear scanout buffer w/ your gem_create rather than
having to use dumb_create.  Maybe not something you need now, but
seems like eventually you'll come up with some reason or another to
want to pass some flags into gem_create.

> +       uint32_t handle;
> +       uint32_t size;
> +};
> +#define DRM_IOCTL_ARMADA_GEM_CREATE \
> +       ARMADA_IOCTL(IOWR, GEM_CREATE, gem_create)
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
> +       uint64_t ptr;
> +       uint32_t handle;
> +       uint32_t offset;
> +       uint32_t size;
> +};
> +#define DRM_IOCTL_ARMADA_GEM_PWRITE \
> +       ARMADA_IOCTL(IOW, GEM_PWRITE, gem_pwrite)
> +
> +#endif
> --
> 1.7.4.4
>
