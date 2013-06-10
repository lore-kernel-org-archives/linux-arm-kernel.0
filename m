From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 18:06:49 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
Message-ID: <20130610170648.GX18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:57:32AM -0400, Rob Clark wrote:
> On Sun, Jun 9, 2013 at 3:29 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > This patch adds support for the pair of LCD controllers on the Marvell
> > Armada 510 SoCs.  This driver supports:
> > - multiple contiguous scanout buffers for video and graphics
> > - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
> >   acceleration
> > - dual lcd0 and lcd1 crt operation
> > - video overlay on each LCD crt
> 
> Any particular reason for not exposing the overlays as drm_plane's?
> That is probably something that should change before merging the
> driver.

Only through not understanding much of DRM when I started this.
Provided DRM planes can do everything that I'm already doing with
the overlay support, then yes.  Otherwise, I want to stick with this
which is modelled after the i915 overlay interface.

The big question that this brings up is that the plane stuff looks
a lot more heavyweight in terms of the computation done.  I'm already
concerned that I'm doing too much with the overlay code - it occasionally
misses getting the next frame of video ready before the VBLANK event
in certain circumstances which I haven't been able to quantify.  I'd
rather avoid adding too much additional work here, which would then
make overlay pretty useless for what it's meant for - video playback.

... and it looks to me like it can't - because I sometimes get blocks
of physical memory with the YUV data already in appropriately formatted
for scanout that I really would like to avoid having to expensively
copy.

> > - page flipping of the main scanout buffers
> >
> > Included in this commit is the core driver with no output support; output
> > support is platform and encoder driver dependent.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> 
> [snip]
> 
> > diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> > new file mode 100644
> > index 0000000..e5ab4cb
> > --- /dev/null
> > +++ b/drivers/gpu/drm/armada/armada_crtc.c
> > @@ -0,0 +1,766 @@
> > +/*
> > + * Copyright (C) 2012 Russell King
> > + *  Rewritten from the dovefb driver, and Armada510 manuals.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/clk.h>
> > +#include <drm/drmP.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include "armada_crtc.h"
> > +#include "armada_drm.h"
> > +#include "armada_fb.h"
> > +#include "armada_gem.h"
> > +#include "armada_hw.h"
> > +
> > +struct armada_frame_work {
> > +       struct drm_pending_vblank_event *event;
> > +       struct armada_regs regs[4];
> > +       struct drm_gem_object *old_fb_obj;
> > +       struct work_struct work;
> > +};
> > +
> > +/*
> > + * A note about interlacing.  Let's consider HDMI 1920x1080i.
> > + * The timing parameters we have from X are:
> > + *  Hact HsyA HsyI Htot  Vact VsyA VsyI Vtot
> > + *  1920 2448 2492 2640  1080 1084 1094 1125
> > + * Which get translated to:
> > + *  Hact HsyA HsyI Htot  Vact VsyA VsyI Vtot
> > + *  1920 2448 2492 2640   540  542  547  562
> > + *
> > + * This is how it is defined by CEA-861-D - line and pixel numbers are
> > + * referenced to the rising edge of VSYNC and HSYNC.  Total clocks per
> > + * line: 2640.  The odd frame, the first active line is at line 21, and
> > + * the even frame, the first active line is 584.
> > + *
> > + * LN:    560     561     562     563             567     568    569
> > + * DE:    ~~~|____________________________//__________________________
> > + * HSYNC: ____|~|_____|~|_____|~|_____|~|_//__|~|_____|~|_____|~|_____
> > + * VSYNC: _________________________|~~~~~~//~~~~~~~~~~~~~~~|__________
> > + *  22 blanking lines.  VSYNC at 1320 (referenced to the HSYNC rising edge).
> > + *
> > + * LN:    1123   1124    1125      1               5       6      7
> > + * DE:    ~~~|____________________________//__________________________
> > + * HSYNC: ____|~|_____|~|_____|~|_____|~|_//__|~|_____|~|_____|~|_____
> > + * VSYNC: ____________________|~~~~~~~~~~~//~~~~~~~~~~|_______________
> > + *  23 blanking lines
> > + *
> > + * The Armada LCD Controller line and pixel numbers are, like X timings,
> > + * referenced to the top left of the active frame.
> > + *
> > + * So, translating these to our LCD controller:
> > + *  Odd frame, 563 total lines, VSYNC at line 543-548, pixel 1128.
> > + *  Even frame, 562 total lines, VSYNC at line 542-547, pixel 2448.
> > + * Note: Vsync front porch remains constant!
> > + *
> > + * if (odd_frame) {
> > + *   vtotal = mode->crtc_vtotal + 1;
> > + *   vbackporch = mode->crtc_vsync_start - mode->crtc_vdisplay + 1;
> > + *   vhorizpos = mode->crtc_hsync_start - mode->crtc_htotal / 2
> > + * } else {
> > + *   vtotal = mode->crtc_vtotal;
> > + *   vbackporch = mode->crtc_vsync_start - mode->crtc_vdisplay;
> > + *   vhorizpos = mode->crtc_hsync_start;
> > + * }
> > + * vfrontporch = mode->crtc_vtotal - mode->crtc_vsync_end;
> > + *
> > + * So, we need to reprogram these registers on each vsync event:
> > + *  LCD_SPU_V_PORCH, LCD_SPU_ADV_REG, LCD_SPUT_V_H_TOTAL
> 
> ouch, proof that some hw designers must really hate driver writers ;-)

Yep - and interlace support is not something that can be done in a stable
way with the way the Linux kernel deals with interrupts (iow, with no
priority and strictly single-threaded.)  The problem is to do this
properly, you need the LCD interrupt able to interrupt any other interrupt
handler so you can reprogram the LCD controller within a very tight
timeframe (less than one display field.)

It works, but occasionally you will get a hiccup (mainly that's the
fault of the USB stack taking 2.25ms over some of its keyboard/mouse
interrupts!)

> > +/* The mode_config.mutex will be held for this call */
> > +static int armada_drm_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
> > +       struct drm_framebuffer *old_fb)
> > +{
> > +       struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
> > +       struct armada_regs regs[4];
> > +       unsigned i;
> > +
> > +       i = armada_drm_crtc_calc_fb(crtc->fb, crtc->x, crtc->y, regs, dcrtc->interlaced);
> > +       armada_reg_queue_end(regs, i);
> > +
> > +       /* Wait for pending flips to complete */
> > +       wait_event(dcrtc->frame_wait, !dcrtc->frame_work);
> > +
> > +       /* Take a reference to the new fb as we're using it */
> > +       drm_gem_object_reference(&drm_fb_obj(crtc->fb)->obj);
> 
> note that you probably want to ref/unref the fb (and let the fb hold a
> ref to the gem bo).. that will make life easier for planar formats too
> (as the fb should hold ref's to the bo for each plane)

I'll look into it, but it will take some time as the refcounting is far
from trivial or obvious in DRM...

>From what I can see there's no intrinsic refcounting between the fb
and the gem bo.

> > diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> [snip]
> > +
> > +static struct drm_ioctl_desc armada_ioctls[] = {
> > +       DRM_IOCTL_DEF_DRV(ARMADA_GEM_CREATE, armada_gem_create_ioctl, DRM_UNLOCKED),
> > +       DRM_IOCTL_DEF_DRV(ARMADA_GEM_CREATE_PHYS, armada_gem_create_phys_ioctl, DRM_UNLOCKED),
> 
> you might want just a single ioctl for creating gem objects, with a
> 'scanout' flag..  perhaps some future version of the hw doesn't need
> phys contig for scanout, and this would probably be easier to handle
> with a single ioctl that has an 'if (flags & SCANOUT &&
> device_needs_phys_contig_scanout()) .. '

The purposes of these two ioctls are quite different.  ARMADA_GEM_CREATE
is to create any gem buffer object that needs shmem backing - eg,
non-scanout pixmaps and the like.

ARMADA_GEM_CREATE_PHYS is to deal with creating a gem buffer object for
a chunk of physical memory allocated by other means (eg, the Vmeta stuff.)
This allows my X server to remain compatible with the XF86 Dove driver,
which permits the passing of the physical address of the video frame to
the X server (otherwise we're into rewriting a whole load more code than
is really desirable - and I really don't have time to rewrite bits of
gstreamer and other stuff.)

Lastly, the DUMB stuff is used for the graphics scanout buffer.

> > diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> [snip]
> > +int armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
> > +{
> > +       struct armada_private *priv = dev->dev_private;
> > +       size_t size = obj->obj.size;
> > +
> > +       if (obj->page || obj->linear)
> > +               return 0;
> > +
> > +       /* If it is a small allocation, try to get it from the system */
> > +       if (size < 1048576) {
> > +               unsigned int order = get_order(size);
> > +               struct page *p = alloc_pages(GFP_KERNEL, order);
> > +
> > +               if (p) {
> > +                       unsigned sz = (size + 31) & ~31;
> > +                       uintptr_t ptr;
> > +
> > +                       obj->phys_addr = page_to_phys(p);
> > +                       obj->dev_addr = obj->phys_addr;
> > +
> > +                       /* FIXME: Hack around dirty cache */
> > +                       ptr = (uintptr_t)phys_to_virt(obj->phys_addr);
> > +                       memset((void *)ptr, 0, PAGE_ALIGN(size));
> > +                       while (sz) {
> > +                               asm volatile("mcr p15, 0, %0, c7, c14, 1" : : "r" (ptr));
> > +                               ptr += 32;
> > +                               sz -= 32;
> > +                       }
> > +                       dsb();
> > +
> > +                       obj->page = p;
> > +               }
> > +       }
> 
> maybe leave out the small size case until there is a better way to
> deal with cache, since this seems like just an optimization..
> 
> although I wonder why not just use CMA?  (Other than maybe
> performance.. but I guess this is only for allocating scanout buffers,
> in which case all the bazillion of temporary pixmaps that X11
> creates/deletes won't be hitting this path..)

Those won't hit this path anyway.  Anyone with a shred of sanity wouldn't
create something like that for such a hotpath.  Calling into the kernel
isn't cheap, certainly calling into the kernel memory allocators isn't.
Maybe this is telling:

root at cubox:~# uptime
 17:32:35 up 4 days,  6:16,  2 users,  load average: 0.00, 0.01, 0.05
root at cubox:~# cat /sys/kernel/debug/dri/0/clients
a dev   pid    uid      magic     ioctls

y   0  1180     0          0     102829
root at cubox:~# ps aux | grep 1180
root      1180  0.1  3.2  39916 23564 tty7     Ss+  Jun06   6:43 /usr/bin/X :0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch

I cache the pixmaps in userspace for up to three seconds, which means
X's temporary pixmaps are not constantly allocated and freed... much like
the Intel i915 driver does.

Last point here - this path is _never_ used for X pixmaps.  The only
things which it's used for are the DUMB gem objects, so the scanout
buffer and the cursor pixmap.  So yes, the above could be removed,
which would place the cursor pixmap into the linear memory.

Why not CMA?  Apart from my violent distaste of that thing, and that it
ignores all the issues I brought up about multiple different mappings...
I refuse to use CMA.

> > +int armada_gem_prop_ioctl(struct drm_device *dev, void *data,
> > +       struct drm_file *file)
> > +{
> > +       struct drm_armada_gem_prop *arg = data;
> > +       struct armada_gem_object *dobj;
> > +       int ret;
> > +
> > +       ret = mutex_lock_interruptible(&dev->struct_mutex);
> > +       if (ret)
> > +               return ret;
> > +
> > +       dobj = armada_gem_object_lookup(dev, file, arg->handle);
> > +       if (dobj == NULL) {
> > +               ret = -ENOENT;
> > +               goto unlock;
> > +       }
> > +
> > +       arg->phys = dobj->phys_addr;
> 
> ugg, do you really need to expose phys addr to userspace?  Any chance
> to just teach the gpu bits about dmabuf instead?

Thankfully its usage is limited - and no, I'm not going to investigate
yet another chunk of massive DRM code called dmabuf.  The above is
needed to provide the physical address of the GEM buffers to the Vivante
GPU libraries and back into the kernel galcore driver.  Especially
important for proper fencing.

> > +struct drm_armada_gem_create {
> > +       uint32_t height;
> > +       uint32_t width;
> > +       uint32_t bpp;
> 
> just fwiw, typically height/width/bpp are properties of the fb but not
> the bo.. (except in some cases where kernel needs to know this to
> setup GTT correctly for tiled buffers)

This was there originally because it is required that these objects be
a certain pitch.  I've since moved that logic into the userspace buffer
manager, so the above three aren't used in my latest userspace.  I didn't
want to change the API yet again before all the RFC's were done, but
this will be gone.

> > +       uint32_t handle;
> > +       uint32_t pitch;
> > +       uint32_t size;
> > +};
> > +#define DRM_IOCTL_ARMADA_GEM_CREATE \
> > +       ARMADA_IOCTL(IOWR, GEM_CREATE, gem_create)
> > +
> > +struct drm_armada_gem_create_phys {
> > +       uint32_t size;
> > +       uint32_t handle;
> > +       uint64_t phys;
> > +};
> > +#define DRM_IOCTL_ARMADA_GEM_CREATE_PHYS \
> > +       ARMADA_IOCTL(IOWR, GEM_CREATE_PHYS, gem_create_phys)
> > +
> > +struct drm_armada_gem_mmap {
> > +       uint32_t handle;
> > +       uint32_t pad;
> > +       uint64_t offset;
> > +       uint64_t size;
> > +       uint64_t addr;
> > +};
> > +#define DRM_IOCTL_ARMADA_GEM_MMAP \
> > +       ARMADA_IOCTL(IOWR, GEM_MMAP, gem_mmap)
> > +
> > +struct drm_armada_gem_pwrite {
> > +       uint32_t handle;
> > +       uint32_t offset;
> > +       uint32_t size;
> 
> probably want a uint32_t padding here, or move the uint64_t up in the
> struct to avoid 32 vs 64b alignment differences.

Yes.
