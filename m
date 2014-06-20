From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 20 Jun 2014 20:15:06 +0800
Subject: [PATCH 1/2] drm/exynos/fbdev: don't set fix.smem/mmio_{start, len}
In-Reply-To: <20140620025938.2e80efa0@i7>
References: <1396603322-13585-1-git-send-email-djkurtz@chromium.org>
 <20140620025938.2e80efa0@i7>
Message-ID: <CAGS+omCT6u6rBz0QKTju3d=_+G29RD515M5BeX_KEbvWyANg9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 7:59 AM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
>
> On Fri,  4 Apr 2014 17:22:01 +0800
> Daniel Kurtz <djkurtz@chromium.org> wrote:
>
> > Kernel access to the eyxnos fbdev framebuffer is via its gem object's
> > kernel mapping (kvaddr, stored in info->screen_base).
> >
> > User space access is provided by mmap(), read() and write() of /dev/fb/fb0.
> > These functions also only use screen_base/screen_size().
> >
> > Therefore, it is not necessary to set fix->smem_{start,len} or
> > fix->mmio_{start,len} fields.
> >
> > This avoids leaking kernel, physical and dma mapped addresses to user
> > space via the ioctls FBIOGET_VSCREENINFO and FBIOGET_FSCREENINFO.
> >
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > index 5fa342e..2dcc589 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > @@ -123,14 +123,7 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
> >
> >       dev->mode_config.fb_base = (resource_size_t)buffer->dma_addr;
> >       fbi->screen_base = buffer->kvaddr + offset;
> > -     if (is_drm_iommu_supported(dev))
> > -             fbi->fix.smem_start = (unsigned long)
> > -                     (page_to_phys(sg_page(buffer->sgt->sgl)) + offset);
> > -     else
> > -             fbi->fix.smem_start = (unsigned long)buffer->dma_addr;
> > -
> >       fbi->screen_size = size;
> > -     fbi->fix.smem_len = size;
>
> Can we keep proper initialization of 'smem_len'? Some userland
> applications use it for calculating the size for mmap:
>
>     http://cgit.freedesktop.org/xorg/xserver/tree/hw/xfree86/fbdevhw/fbdevhw.c?id=xorg-server-1.15.99.903#n571
>
> >
> >       return 0;
> >  }
>
> Basically, this patch breaks the xf86-video-fbdev ddx and some users
> are already unhappy.


I'm so sorry this patch broke things for some users.
Can you upload a patch to correct it?
I'll happily review it.

-djk

>
>
> --
> Best regards,
> Siarhei Siamashka
