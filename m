From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 23 Nov 2018 14:35:48 +0900
Subject: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
In-Reply-To: <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
References: <20181119190805.19139-1-helen.koike@collabora.com>
 <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
 <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
 <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
 <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
Message-ID: <CAAFQd5DAti8Vf+jyLp6nVH5FiesE=jLNoLq3AFaqdm2FfY=v9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Fri, Nov 23, 2018 at 1:58 PM Michael Zoran <mzoran@crowfest.net> wrote:
>
> On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:
> >
> > The point here is not about setting and resetting the plane->fb
> > pointer. It's about what happens inside
> > drm_atomic_set_fb_for_plane().
> >
> > It calls drm_framebuffer_get() for the new fb and
> > drm_framebuffer_put() for the old fb. In result, if the fb changes,
> > the old fb, which had its reference count incremented in the atomic
> > commit that set it to the plane before, has its reference count
> > decremented. Moreover, if the new reference count becomes 0,
> > drm_framebuffer_put() will immediately free the buffer.
> >
> > Freeing a buffer when the hardware is still scanning out of it isn't
> > a
> > good idea, is it?
>
> No, it's not.  But the board I submitted the patch for doesn't have
> anything like hot swapable ram.  The ram access is still going to work,
> just it might display something it shouldn't. Say for example if that
> frame buffer got reused by somethig else and filled with new data in
> the very small window.

Thanks for a quick reply!

To clarify, on the Rockchip platform this patch is for (and many other
arm/arm64 SoCs) the display controller is behind an IOMMU. Freeing the
buffer would mean unmapping the related IOVAs from the IOMMU. If the
hardware is still scanning out from the unmapped addresses, it would
cause IOMMU page faults. We don't have any good IOMMU page fault
handling in the kernel, so on most platforms that would likely end up
stalling the display controller completely (on Rockchip it does).

>
> But yes, I agree the best solution would be to not release the buffer
> until the next vblank.
>
> Perhaps a good solution would be for the DRM api to have the concept of
> a deferred release?  Meaning if the put() call just added the frame
> buffer to a list that DRM core could walk during the vblank.  That
> might be better then every single driver trying to work up a custom
> solution.

Agreed.

Best regards,
Tomasz
