From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 May 2012 09:47:10 +0200
Subject: [PATCH 1/2] DRM: add Freescale i.MX LCDC driver
In-Reply-To: <CAF6AEGuhyRpMo+bsFDwq7A0YOD5BstUtA-z7dRWwwxPK9ru6bg@mail.gmail.com>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
 <1337344032-25431-2-git-send-email-s.hauer@pengutronix.de>
 <CAF6AEGuhyRpMo+bsFDwq7A0YOD5BstUtA-z7dRWwwxPK9ru6bg@mail.gmail.com>
Message-ID: <20120523074710.GP30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, May 22, 2012 at 03:28:20PM -0600, Rob Clark wrote:
> just a few comments from a cursory review..  I need a bit more time
> for a more in-depth review but that won't be tonight so I thought I'd
> send what I have so far..

Thanks for this.

> > +++ b/drivers/gpu/drm/imx/Kconfig
> > @@ -0,0 +1,18 @@
> > +config DRM_IMX
> > + ? ? ? tristate "DRM Support for Freescale i.MX"
> > + ? ? ? select DRM_KMS_HELPER
> > + ? ? ? depends on DRM && ARCH_MXC
> > +
> > +config DRM_IMX_FB_HELPER
> > + ? ? ? tristate "provide legacy framebuffer /dev/fb0"
> > + ? ? ? depends on DRM_IMX
> > +
> > +config DRM_IMX_LCDC
> > + ? ? ? tristate "DRM Support for Freescale i.MX1 and i.MX2"
> > + ? ? ? depends on DRM_IMX
> > + ? ? ? help
> > + ? ? ? ? Choose this if you have a i.MX1, i.MX21, i.MX25 or i.MX27 processor.
> 
> do you have something like cpu_is_imx2() type macros?  It would be
> preferable not to have a compile time config option for building for
> certain hw versions.  Ie. on OMAP we could do something like 'if
> (cpu_is_omap3xxx()) { ... }' if there was something that needed to be
> done different on omap3 family of devices.  This way you could choose
> to build a kernel supporting either a single omap variants, or all
> omap variants.

Yes, we have cpu_is_* macros. I don't see though why we should use them
here. The result of DRM_IMX_LCDC will be a platform driver for which a
suitable device exists only on the correct SoCs. There will be a second
DRM_IMX_IPU option next to this one for the newer i.MX SoCs which will
be a second platform driver.

> > +
> > + ? ? ? /*
> > + ? ? ? ?* without file_priv we are called from imx_drm_fbdev_create in which
> > + ? ? ? ?* case we only create a framebuffer without a handle.
> > + ? ? ? ?*/
> > + ? ? ? if (!file_priv) {
> > + ? ? ? ? ? ? ? struct imx_drm_buf_entry *entry;
> > +
> > + ? ? ? ? ? ? ? entry = imx_drm_buf_create(dev, size);
> > + ? ? ? ? ? ? ? if (IS_ERR(entry)) {
> > + ? ? ? ? ? ? ? ? ? ? ? ret = PTR_ERR(entry);
> > + ? ? ? ? ? ? ? ? ? ? ? goto err_buffer;
> > + ? ? ? ? ? ? ? }
> > +
> > + ? ? ? ? ? ? ? imx_drm_fb->entry = entry;
> > + ? ? ? } else {
> > + ? ? ? ? ? ? ? obj = drm_gem_object_lookup(dev, file_priv, mode_cmd->handles[0]);
> > + ? ? ? ? ? ? ? if (!obj) {
> > + ? ? ? ? ? ? ? ? ? ? ? ret = -EINVAL;
> > + ? ? ? ? ? ? ? ? ? ? ? goto err_buffer;
> > + ? ? ? ? ? ? ? }
> > +
> > + ? ? ? ? ? ? ? imx_drm_fb->imx_drm_gem_obj = to_imx_drm_gem_obj(obj);
> > +
> > + ? ? ? ? ? ? ? drm_gem_object_unreference_unlocked(obj);
> 
> 
> the fb probably should hold the reference to the GEM obj until it is
> deleted..  so you don't end up freeing the buffer you are scanning out
> until you are done scanning it out.  Possibly this gets a bit more
> straightforward if you don't have to special case the default/fbcon
> framebuffer?
> 
> IIRC, Laurent had sent a patch recently to fix the same issue in the
> exynos driver.

Yes, just for reference, here is a link:

http://permalink.gmane.org/gmane.comp.video.dri.devel/69203

Will fix this.

> > +
> > +static int imx_drm_gem_mmap_buffer(struct file *filp,
> > + ? ? ? ? ? ? ? struct vm_area_struct *vma)
> > +{
> > + ? ? ? struct drm_gem_object *obj = filp->private_data;
> > + ? ? ? struct imx_drm_gem_obj *imx_drm_gem_obj = to_imx_drm_gem_obj(obj);
> > + ? ? ? struct imx_drm_buf_entry *entry;
> > + ? ? ? unsigned long pfn, vm_size;
> > +
> > + ? ? ? vma->vm_flags |= VM_IO | VM_RESERVED;
> > +
> > + ? ? ? vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> pgprot_writecombine()?

copied from the exynos driver. The exynos driver recently gained support
for different cache attribute flags and I could do the same. I would
prefer not to even have to think about it by using some generic code
here instead of duplicating other peoples bugs.

Do you think it's possible to share this code as suggested by Lars?
Every SoC not having a IOMMU could share the same code here, it's just
not clear to me how we can put this in a form that is acceptable
upstream.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
