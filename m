From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Sep 2011 14:41:35 +0200
Subject: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <CAF6AEGtgfvbKdjiLpjFxArSVKFeb-GUdmNhN0ra0codPogvbUA@mail.gmail.com>
References: <1315568333-6704-1-git-send-email-inki.dae@samsung.com>
	<4E6B6E5E.3010702@shipmail.org>
	<CAF6AEGt70bk8idsG48tmo_hgWY6M9kSNrEqyyLknYVYn83u4Rw@mail.gmail.com>
	<4E6D278C.6010508@shipmail.org> <4E6DA767.9080408@shipmail.org>
	<000501cc7282$7e7dcb70$7b796250$%dae@samsung.com>
	<CAF6AEGtE9fmbZ-_nV5Lr-x+W5hiGbLfk2GdFNzQgHwJ+hNvn-g@mail.gmail.com>
	<001c01cc72a2$d872c390$89584ab0$%dae@samsung.com>
	<4E705E4D.5030206@shipmail.org>
	<CAF6AEGtgfvbKdjiLpjFxArSVKFeb-GUdmNhN0ra0codPogvbUA@mail.gmail.com>
Message-ID: <000d01cc785b$cc5cc290$651647b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, September 14, 2011 11:53 PM Rob Clark wrote:

> On Wed, Sep 14, 2011 at 2:57 AM, Thomas Hellstrom <thomas@shipmail.org> wrote:

(snipped)

> > Yes, that is true. A root client may be assumed to have AUTH permissions,
> > but the inverse does not hold, meaning that an AUTH client may *not* be
> > assumed to have root permissions. I think there is a ROOT_ONLY ioctl flag
> > for that.
> >
> > The problem I'm seeing compared to other drivers is the following:
> >
> > Imagine for example that you have a disc driver that allocates temporary
> > memory out of the same DMA pool as the DRM driver.
> >
> > Now you have a video player that is a DRM client. It contains a security
> > flaw and is compromized by somebody trying to play a specially crafted video
> > stream. The video player starts to allocate gem buffers until it receives an
> > -ENOMEM. Then it stops allocating and does nothing.
> >
> > Now the system tries an important disc access (paging for example). This
> > fails, because the video player has exhausted all DMA memory and the disc
> > driver fails to allocate.
> >
> > The system is dead.
> >
> > The point is:
> >
> > If there is a chance that other drivers will use the same DMA/CMA pool as
> > the DRM driver, DRM must leave enough DMA/CMA memory for those drivers to
> > work.
> 
> ah, ok, I get your point
> 
> > The difference compared to other drm drivers:
> >
> > There are other drm drivers that work the same way, with a static allocator.
> > For example "via" and "sis". But those drivers completely claim the
> > resources they are using. Nobody else is expected to use VRAM / AGP.
> >
> > In the Samsung case, it's not clear to me whether the DMA/CMA pool *can* be
> > shared with other devices.
> > If it is, IMHO you must implement an allocation limit in DRM, if not, the
> > driver should probably be safe.
> 
> It is possible to create a device private CMA pool..  although OTOH it
> might be desirable to let some other drivers (like v4l2) use buffers
> from the same pool..

Creating a device private CMA pool doesn't prevent other drivers to access
memory from it if there is a way to pass a buffer to them (i.e. using 
dma_buf method). However the driver must be able to address that memory.
CMA private pools were designed mainly to resolve the problem that some
weird hardware can access certain types of buffers only at particular
memory address ranges which matches particular memory bank.
 
> I'm not entirely sure what will happen w/ dma_alloc_coherent, etc, if
> the global CMA pool is exhausted.
> 
> Marek?  I guess you know what would happen?

The allocation will simply fail and dma_alloc_coherent will return NULL.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
