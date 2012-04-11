From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 11 Apr 2012 21:22:47 +0100
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120411212247.3e40f2a4@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int sdrm_suspend(struct drm_device *drm, pm_message_t state)
> +{
> +	/* TODO */
> +
> +	return 0;
> +}
> +
> +static int sdrm_resume(struct drm_device *drm)
> +{
> +	/* TODO */
> +
> +	return 0;
> +}

These probably need to call into the sdrm device specific handling.


> +static int sdrm_get_irq(struct drm_device *dev)
> +{
> +	/*
> +	 * Return an arbitrary number to make the core happy.
> +	 * We can't return anything meaningful here since drm
> +	 * devices in general have multiple irqs
> +	 */
> +	return 1234;
> +}

If there isn't a meaningful IRQ then surely 0 should be returned.
Actually I'd suggest returning sdrm->irq or similar, because some simple
DRM type use cases will have a single IRQ (notably 2 on older PC hardware)

> + * sdrm_device_get - find or allocate sdrm device with unique name
> + *
> + * This function returns the sdrm device with the unique name 'name'
> + * If this already exists, return it, otherwise allocate a new
> + * object.

This naming is a bit confusing because the kernel mid layers etc tend to
use _get and _put for ref counting not lookup ?


> +	/*
> +	 * enable drm irq mode.
> +	 * - with irq_enabled = 1, we can use the vblank feature.
> +	 *
> +	 * P.S. note that we wouldn't use drm irq handler but
> +	 *      just spsdrmific driver own one instead bsdrmause
> +	 *      drm framework supports only one irq handler and
> +	 *      drivers can well take care of their interrupts
> +	 */
> +	drm->irq_enabled = 1;

We've got a couple of assumptions here I think I'd question for generality

1. That its a platform device
2. That it can't use the standard IRQ helpers in some cases.

Probably it should take a struct device and a struct of the bits you'd
fish out from platform or pci or other device type. And yes probably
there would be a platform_ version that wraps it.


> +static int sdrm_fb_dirty(struct drm_framebuffer *fb,
> +		struct drm_file *file_priv, unsigned flags,
> +		unsigned color, struct drm_clip_rect *clips,
> +		unsigned num_clips)
> +{
> +	/* TODO */
> +
> +	return 0;
> +}

Probably a helper method.

> +static struct fb_ops sdrm_fb_ops = {
> +	.owner		= THIS_MODULE,
> +	.fb_fillrect	= cfb_fillrect,
> +	.fb_copyarea	= cfb_copyarea,
> +	.fb_imageblit	= cfb_imageblit,
> +	.fb_check_var	= drm_fb_helper_check_var,
> +	.fb_set_par	= drm_fb_helper_set_par,
> +	.fb_blank	= drm_fb_helper_blank,
> +	.fb_pan_display	= drm_fb_helper_pan_display,
> +	.fb_setcmap	= drm_fb_helper_setcmap,
> +};

If you re assuming any kind of gtt then you should probably allow for gtt
based scrolling eventually, but thats an optimisation.


> +int sdrm_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> +{
> +	struct drm_gem_object *obj = vma->vm_private_data;
> +	struct sdrm_gem_obj *sdrm_gem_obj = to_sdrm_gem_obj(obj);
> +	struct drm_device *dev = obj->dev;
> +	unsigned long pfn;
> +	pgoff_t page_offset;
> +	int ret;

For dumb hardware take a look how gma500 and some other bits do this -
you can premap the entire buffer when you take the first fault, which for
a dumb fb is a good bet.



Looking at it from the point of view of x86 legacy devices then the
things I see are

- Device is quite possibly PCI (but may be platform eg vesa)
- Memory will probably be allocated in the PCI space
- Mappings are probably write combining but not on all hardware

There's probably a case for pinning/unpinning scanout buffers according
to whether they are used. On some hardware the io mapping needed is a
precious resource. Also for stuff with a fixed fb space it means you can
combine it with invalidating the mmap mappings of an object and copying
objects in/out of the frame buffer to provide the expected interfaces to
allocate/release framebuffers.

Alan
