From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 13 Aug 2015 23:17:55 +0200
Subject: [PATCH 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <87d1yqq5po.fsf@eliezer.anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-4-git-send-email-eric@anholt.net>
 <20150813075141.GX17734@phenom.ffwll.local>
 <87d1yqq5po.fsf@eliezer.anholt.net>
Message-ID: <20150813211755.GE17734@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 01:44:03PM -0700, Eric Anholt wrote:
> Daniel Vetter <daniel@ffwll.ch> writes:
> 
> > On Wed, Aug 12, 2015 at 05:56:16PM -0700, Eric Anholt wrote:
> >> This is the start of a full VC4 driver.  Right now this just supports
> >> configuring the display using a pre-existing video mode (because
> >> changing the pixel clock isn't available yet, and doesn't work when it
> >> is).  However, this is enough for fbcon and bringing up X using
> >> xf86-video-modesetting.
> >> 
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >> ---
> >>  drivers/gpu/drm/Kconfig           |   2 +
> >>  drivers/gpu/drm/Makefile          |   1 +
> >>  drivers/gpu/drm/vc4/Kconfig       |  14 +
> >>  drivers/gpu/drm/vc4/Makefile      |  18 ++
> >>  drivers/gpu/drm/vc4/vc4_bo.c      |  54 ++++
> >>  drivers/gpu/drm/vc4/vc4_crtc.c    | 583 ++++++++++++++++++++++++++++++++++
> >>  drivers/gpu/drm/vc4/vc4_debugfs.c |  38 +++
> >>  drivers/gpu/drm/vc4/vc4_drv.c     | 249 +++++++++++++++
> >>  drivers/gpu/drm/vc4/vc4_drv.h     | 123 +++++++
> >>  drivers/gpu/drm/vc4/vc4_hdmi.c    | 651 ++++++++++++++++++++++++++++++++++++++
> >>  drivers/gpu/drm/vc4/vc4_hvs.c     | 172 ++++++++++
> >>  drivers/gpu/drm/vc4/vc4_kms.c     |  84 +++++
> >>  drivers/gpu/drm/vc4/vc4_plane.c   | 320 +++++++++++++++++++
> >>  drivers/gpu/drm/vc4/vc4_regs.h    | 562 ++++++++++++++++++++++++++++++++
> >>  14 files changed, 2871 insertions(+)
> >>  create mode 100644 drivers/gpu/drm/vc4/Kconfig
> >>  create mode 100644 drivers/gpu/drm/vc4/Makefile
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_bo.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_crtc.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_debugfs.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_drv.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_drv.h
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_hvs.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_kms.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_plane.c
> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_regs.h
> >
> > Made a quick pass and found a few things to update to latest drm
> > developments. Of course didn't look at the hardware details since no clue,
> > but looks really nice overall.
> 
> If you have anything about the hardware that you were curious about, I'd
> be interested in trying to explain them in the comments to the extent
> that I can.  It's unfortunate that we haven't shipped docs for the
> display side of things, but had to do a lot of reading of the verilog
> just to get this far, anyway.

The only thing I spotted is that you right now only register a primary and
cursor plane. I guess the plan we once discussed about exposing piles of
planes for -modesetting accel isn't there yet?

But otherwise I really didn't go into the hardware details.

> >> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> >> index c46ca31..1730a76 100644
> >> --- a/drivers/gpu/drm/Kconfig
> >> +++ b/drivers/gpu/drm/Kconfig
> >> @@ -240,3 +240,5 @@ source "drivers/gpu/drm/sti/Kconfig"
> >>  source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> >>  
> >>  source "drivers/gpu/drm/imx/Kconfig"
> >> +
> >> +source "drivers/gpu/drm/vc4/Kconfig"
> >> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> >> index 5713d05..b991ac5 100644
> >> --- a/drivers/gpu/drm/Makefile
> >> +++ b/drivers/gpu/drm/Makefile
> >> @@ -42,6 +42,7 @@ obj-$(CONFIG_DRM_MGA)	+= mga/
> >>  obj-$(CONFIG_DRM_I810)	+= i810/
> >>  obj-$(CONFIG_DRM_I915)  += i915/
> >>  obj-$(CONFIG_DRM_MGAG200) += mgag200/
> >> +obj-$(CONFIG_DRM_VC4)  += vc4/
> >>  obj-$(CONFIG_DRM_CIRRUS_QEMU) += cirrus/
> >>  obj-$(CONFIG_DRM_SIS)   += sis/
> >>  obj-$(CONFIG_DRM_SAVAGE)+= savage/
> >> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> >> new file mode 100644
> >> index 0000000..130cc94
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/vc4/Kconfig
> >> @@ -0,0 +1,14 @@
> >> +config DRM_VC4
> >> +	tristate "Broadcom VC4 Graphics"
> >> +	depends on ARCH_BCM2835
> >> +	depends on DRM
> >> +	select DRM_KMS_HELPER
> >> +	select DRM_KMS_FB_HELPER
> >> +	select DRM_KMS_CMA_HELPER
> >
> > drm-misc/linux-next already has Archit's patches to enable/disable fbdev
> > in the core code, so you don't need to bother about these selects here any
> > more, it'll no-op out if drm fbdev emulation isn't enabled. Since you're
> > reusing cma fbdev helpers I don't think there's any need for other changes
> > because of this.
> 
> It sounds like I should rebase on that, then?

Yeah probably simplest. I made a pull request for drm-misc and a tag and
cc'ed you on it so you have a baseline.

> >> +	help
> >> +	  Choose this option if you have a system that has a Broadcom
> >> +	  VC4 GPU, such as the Raspberry Pi or other BCM2708/BCM2835.
> >> +
> >> +	  This driver requires that "avoid_warnings=2" be present in
> >> +	  the config.txt for the firmware, to keep it from smashing
> >> +	  our display setup.
> >> diff --git a/drivers/gpu/drm/vc4/Makefile b/drivers/gpu/drm/vc4/Makefile
> >> new file mode 100644
> >> index 0000000..4aa07ca
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/vc4/Makefile
> >> @@ -0,0 +1,18 @@
> >> +ccflags-y := -Iinclude/drm
> >> +
> >> +# Please keep these build lists sorted!
> >> +
> >> +# core driver code
> >> +vc4-y := \
> >> +	vc4_bo.o \
> >> +	vc4_crtc.o \
> >> +	vc4_drv.o \
> >> +	vc4_kms.o \
> >> +	vc4_hdmi.o \
> >> +	vc4_hvs.o \
> >> +	vc4_plane.o \
> >> +	$()
> >> +
> >> +vc4-$(CONFIG_DEBUG_FS) += vc4_debugfs.o
> >> +
> >> +obj-$(CONFIG_DRM_VC4)  += vc4.o
> >> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> >> new file mode 100644
> >> index 0000000..fee8cac
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> >> @@ -0,0 +1,54 @@
> >> +/*
> >> + *  Copyright ? 2015 Broadcom
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> >> +/* DOC: VC4 GEM BO management support.
> >> + *
> >> + * The VC4 GPU architecture (both scanout and rendering) has direct
> >> + * access to system memory with no MMU in between.  To support it, we
> >> + * use the GEM CMA helper functions to allocate contiguous ranges of
> >> + * physical memory for our BOs.
> >> + */
> >
> > Since you're doing kerneldoc considered pulling it all into a new vc4
> > section in the drm docbook template?
> 
> I hadn't found the docbook template.  Interesting.  I'll try to cook up
> some general vc4 docs for that.  I think that could be a separate
> commit, though?

Sure. Really just for yourself and other people hacking on this. btw
there's some work intel sponsors from collabora to improve kerneldoc
comments with automated hyperlinking, markdown and a few other things. But
unfortunately not yet merged.

> >> +
> >> +#include "vc4_drv.h"
> >> +
> >> +struct vc4_bo *vc4_bo_create(struct drm_device *dev, size_t size)
> >> +{
> >> +	struct drm_gem_cma_object *cma_obj;
> >> +
> >> +	cma_obj = drm_gem_cma_create(dev, size);
> >> +	if (IS_ERR(cma_obj))
> >> +		return NULL;
> >> +	else
> >> +		return to_vc4_bo(&cma_obj->base);
> >> +}
> >> +
> >> +int vc4_dumb_create(struct drm_file *file_priv,
> >> +		    struct drm_device *dev,
> >> +		    struct drm_mode_create_dumb *args)
> >> +{
> >> +	int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> >> +	struct vc4_bo *bo = NULL;
> >> +	int ret;
> >> +
> >> +	if (args->pitch < min_pitch)
> >> +		args->pitch = min_pitch;
> >> +
> >> +	if (args->size < args->pitch * args->height)
> >> +		args->size = args->pitch * args->height;
> >> +
> >> +	mutex_lock(&dev->struct_mutex);
> >> +	bo = vc4_bo_create(dev, roundup(args->size, PAGE_SIZE));
> >> +	mutex_unlock(&dev->struct_mutex);
> >
> > I'm on a struct_mutex crusade (trying to get rid of it in core and allow
> > drivers to live without it). On a quick look there doesn't seem to be
> > anything that needs struct_mutex here, so please just remove it. If there
> > is indeed something vc4-internal you want to protect, please use your own
> > driver-internal mutex (e.g. for drm_mm or command submission or whatever).
> >
> > btw the last bit in the drm core for modern drivers that needs
> > struct_mutex is mmap_offset gem object lookup. I plan to replace that with
> > kref_get_unless_zero trickery, which would make the core and a lot of
> > drivers struct_mutex free and so relegate it mostly to a legacy role (and
> > can be forgotten).
> 
> Struct mutex is here because this code is from the V3D series, with the
> in-kernel BO cache ripped out (it turns out that the CMA allocator is
> slow, and you can't just userspace cache since we have to do allocations
> within the kernel to the tune of a couple per draw and that's too much).
> 
> I'll pull the mutex calls out for now until the cache stuff is
> submitted.

Yeah I suspected that's for later. If feasible it'd be great if you could
rearchtect it to use a driver-private lock, just to not grow another place
using it.

> >> +static bool vc4_crtc_mode_fixup(struct drm_crtc *crtc,
> >> +				const struct drm_display_mode *mode,
> >> +				struct drm_display_mode *adjusted_mode)
> >> +{
> >> +	return true;
> >> +}
> >
> > mode_fixup on crtcs is optional since 840bfe953384a and I just merged a
> > patch to make it optional for encoders too (when using atomic helpers
> > which you do). You can remove them both.
> 
> Great!  It felt like there was a *lot* of boilerplate when I was first
> writing this stuff, and things are way better than they used to be.

Just noticed that crtc->atomic_begin is optional too. btw if you spot
boilerplate somewhere else please raise it on irc, there's still a lot of
room for improvement for atomic helpers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
