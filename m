From: inki.dae@samsung.com (Inki Dae)
Date: Wed, 14 Sep 2011 10:39:02 +0900
Subject: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <4E6B6E5E.3010702@shipmail.org>
References: <1315568333-6704-1-git-send-email-inki.dae@samsung.com>
	<4E6B6E5E.3010702@shipmail.org>
Message-ID: <000101cc727f$14f4eab0$3edec010$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas.
Sorry for being late.

> -----Original Message-----
> From: Thomas Hellstrom [mailto:thomas at shipmail.org]
> Sent: Saturday, September 10, 2011 11:04 PM
> To: Inki Dae
> Cc: airlied at linux.ie; dri-devel at lists.freedesktop.org;
> sw0312.kim at samsung.com; kyungmin.park at samsung.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
> 
> On 09/09/2011 01:38 PM, Inki Dae wrote:
> > This patch is a DRM Driver for Samsung SoC Exynos4210 and now enables
> > only FIMD yet but we will add HDMI support also in the future.
> >
> > from now on, I will remove RFC prefix because I think we have got
> comments
> > enough.
> >
> > this patch is based on git repository below:
> > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git,
> > branch name: drm-next
> > commit-id: bcc65fd8e929a9d9d34d814d6efc1d2793546922
> >
> > you can refer to our working repository below:
> > http://git.infradead.org/users/kmpark/linux-2.6-samsung
> > branch name: samsung-drm
> >
> > We tried to re-use lowlevel codes of the FIMD driver(s3c-fb.c
> > based on Linux framebuffer) but couldn't so because lowlevel codes
> > of s3c-fb.c are included internally and so FIMD module of this driver
> has
> > its own lowlevel codes.
> >
> > We used GEM framework for buffer management and DMA APIs(dma_alloc_*)
> > for buffer allocation. by using DMA API, we could use CMA later.
> >
> > Refer to this link for CMA(Continuous Memory Allocator):
> > http://lkml.org/lkml/2011/7/20/45
> >
> > this driver supports only physically continuous memory(non-iommu).
> >
> > Links to previous versions of the patchset:
> > v1:<  https://lwn.net/Articles/454380/>
> > v2:<  http://www.spinics.net/lists/kernel/msg1224275.html>
> > v3:<  http://www.gossamer-threads.com/lists/linux/kernel/1423684>
> >
> > Changelog v2:
> > DRM: add DRM_IOCTL_SAMSUNG_GEM_MMAP ioctl command.
> >
> >      this feature maps user address space to physical memory region
> >      once user application requests DRM_IOCTL_SAMSUNG_GEM_MMAP ioctl.
> >
> > DRM: code clean and add exception codes.
> >
> > Changelog v3:
> > DRM: Support multiple irq.
> >
> >      FIMD and HDMI have their own irq handler but DRM Framework can
> regiter
> >      only one irq handler this patch supports mutiple irq for Samsung
SoC.
> >
> > DRM: Consider modularization.
> >
> >      each DRM, FIMD could be built as a module.
> >
> > DRM: Have indenpendent crtc object.
> >
> >      crtc isn't specific to SoC Platform so this patch gets a crtc
> >      to be used as common object.
> >      created crtc could be attached to any encoder object.
> >
> > DRM: code clean and add exception codes.
> >
> > Changelog v4:
> > DRM: remove is_defult from samsung_fb.
> >
> >      is_default isn't used for default framebuffer.
> >
> > DRM: code refactoring to fimd module.
> >      this patch is be considered with multiple display objects and
> >      would use its own request_irq() to register a irq handler instead
of
> >      drm framework's one.
> >
> > DRM: remove find_samsung_drm_gem_object()
> >
> > DRM: move kernel private data structures and definitions to driver
> folder.
> >
> >      samsung_drm.h would contain only public information for userspace
> >      ioctl interface.
> >
> > DRM: code refactoring to gem modules.
> >      buffer module isn't dependent of gem module anymore.
> >
> > DRM: fixed security issue.
> >
> > DRM: remove encoder porinter from specific connector.
> >
> >      samsung connector doesn't need to have generic encoder.
> >
> > DRM: code clean and add exception codes.
> >
> > Signed-off-by: Inki Dae<inki.dae@samsung.com>
> > Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
> > Signed-off-by: SeungWoo Kim<sw0312.kim@samsung.com>
> > Signed-off-by: kyungmin.park<kyungmin.park@samsung.com>
> > ---
> >
> > +static struct drm_ioctl_desc samsung_ioctls[] = {
> > +	DRM_IOCTL_DEF_DRV(SAMSUNG_GEM_CREATE, samsung_drm_gem_create_ioctl,
> > +			DRM_UNLOCKED | DRM_AUTH),
> >
> 
> Hi!
> 
> With reference my previous security comment.
> 
> Let's say you have a compromised video player running as a DRM client,
> that tries to repeatedly allocate huge GEM buffers...
> 
> What will happen when all DMA memory is exhausted? Will this cause other
> device drivers to see an OOM, or only DRM?
> 

Out driver allocates physically continuous memory from the region reserved
by CMA or DMA Region in case of not using CMA. if all memory is exhausted at
allocation moment, it just returns "Allocation fail" and then the
application would be terminated.

> The old DRI model basically allowed any authorized DRI client to exhaust
> video ram or AGP memory, but never system memory. Newer DRI drivers
> typically only allow DRI masters to do that.
> as
> 

I thought it's enough for an authorized DRI client to request memory
allocation. because an authorized DRI client has root authority. I know, in
case of v4l2 based device drivers, the applications can request buffer
allocation through v4l2 interface, REQBUFS. and also if memory allocation is
repeated, we can see any error in the near future. and I wonder why only DRM
master could do that. it might be my missing points so I am happy to you
give me your words?

> I don't think an authorized DRI client should be able to easily exhaust
> resources (DMA memory) used by other device drivers causing them to fail.
> 
> /Thomas
> 
> 
> > +	DRM_IOCTL_DEF_DRV(SAMSUNG_GEM_MAP_OFFSET,
> > +			samsung_drm_gem_map_offset_ioctl, DRM_UNLOCKED |
> > +				DRM_AUTH),
> > +	DRM_IOCTL_DEF_DRV(SAMSUNG_GEM_MMAP,
> > +			samsung_drm_gem_mmap_ioctl, DRM_UNLOCKED |
DRM_AUTH),
> > +};
> >
> >
> 
