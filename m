From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 15 Sep 2011 10:20:43 +0900
Subject: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <4E705E4D.5030206@shipmail.org>
References: <1315568333-6704-1-git-send-email-inki.dae@samsung.com>
	<4E6B6E5E.3010702@shipmail.org>
	<CAF6AEGt70bk8idsG48tmo_hgWY6M9kSNrEqyyLknYVYn83u4Rw@mail.gmail.com>
	<4E6D278C.6010508@shipmail.org> <4E6DA767.9080408@shipmail.org>
	<000501cc7282$7e7dcb70$7b796250$%dae@samsung.com>
	<CAF6AEGtE9fmbZ-_nV5Lr-x+W5hiGbLfk2GdFNzQgHwJ+hNvn-g@mail.gmail.com>
	<001c01cc72a2$d872c390$89584ab0$%dae@samsung.com>
	<4E705E4D.5030206@shipmail.org>
Message-ID: <000701cc7345$b03c9600$10b5c200$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Thomas.

> -----Original Message-----
> From: Thomas Hellstrom [mailto:thomas at shipmail.org]
> Sent: Wednesday, September 14, 2011 4:57 PM
> To: Inki Dae
> Cc: 'Rob Clark'; kyungmin.park at samsung.com; sw0312.kim at samsung.com; linux-
> arm-kernel at lists.infradead.org; dri-devel at lists.freedesktop.org
> Subject: Re: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
> 
> On 09/14/2011 07:55 AM, Inki Dae wrote:
> >
> >
> >> -----Original Message-----
> >> From: Rob Clark [mailto:robdclark at gmail.com]
> >> Sent: Wednesday, September 14, 2011 11:26 AM
> >> To: Inki Dae
> >> Cc: Thomas Hellstrom; kyungmin.park at samsung.com;
sw0312.kim at samsung.com;
> >> linux-arm-kernel at lists.infradead.org; dri-devel at lists.freedesktop.org
> >> Subject: Re: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
> >>
> >> On Tue, Sep 13, 2011 at 9:03 PM, Inki Dae<inki.dae@samsung.com>  wrote:
> >>
> >>> Hi Thomas.
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Thomas Hellstrom [mailto:thomas at shipmail.org]
> >>>> Sent: Monday, September 12, 2011 3:32 PM
> >>>> To: Rob Clark
> >>>> Cc: Inki Dae; kyungmin.park at samsung.com; sw0312.kim at samsung.com;
> linux-
> >>>> arm-kernel at lists.infradead.org; dri-devel at lists.freedesktop.org
> >>>> Subject: Re: [PATCH v4] DRM: add DRM Driver for Samsung SoC
> EXYNOS4210.
> >>>>
> >>>> On 09/11/2011 11:26 PM, Thomas Hellstrom wrote:
> >>>>
> >>>>> On 09/10/2011 07:31 PM, Rob Clark wrote:
> >>>>>
> >>>>>> On Sat, Sep 10, 2011 at 9:04 AM, Thomas
> >>>>>> Hellstrom<thomas@shipmail.org>    wrote:
> >>>>>>
> >>>>>>> On 09/09/2011 01:38 PM, Inki Dae wrote:
> >>>>>>>
> >>>>>>>> This patch is a DRM Driver for Samsung SoC Exynos4210 and now
> >>>>>>>>
> >> enables
> >>
> >>>>>>>> only FIMD yet but we will add HDMI support also in the future.
> >>>>>>>>
> >>>>>>>> from now on, I will remove RFC prefix because I think we have got
> >>>>>>>> comments
> >>>>>>>> enough.
> >>>>>>>>
> >>>>>>>> this patch is based on git repository below:
> >>>>>>>>
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git,
> >>>>>>>> branch name: drm-next
> >>>>>>>> commit-id: bcc65fd8e929a9d9d34d814d6efc1d2793546922
> >>>>>>>>
> >>>>>>>> you can refer to our working repository below:
> >>>>>>>> http://git.infradead.org/users/kmpark/linux-2.6-samsung
> >>>>>>>> branch name: samsung-drm
> >>>>>>>>
> >>>>>>>> We tried to re-use lowlevel codes of the FIMD driver(s3c-fb.c
> >>>>>>>> based on Linux framebuffer) but couldn't so because lowlevel
> codes
> >>>>>>>> of s3c-fb.c are included internally and so FIMD module of this
> >>>>>>>> driver has
> >>>>>>>> its own lowlevel codes.
> >>>>>>>>
> >>>>>>>> We used GEM framework for buffer management and DMA
> >>>>>>>>
> >> APIs(dma_alloc_*)
> >>
> >>>>>>>> for buffer allocation. by using DMA API, we could use CMA later.
> >>>>>>>>
> >>>>>>>> Refer to this link for CMA(Continuous Memory Allocator):
> >>>>>>>> http://lkml.org/lkml/2011/7/20/45
> >>>>>>>>
> >>>>>>>> this driver supports only physically continuous
memory(non-iommu).
> >>>>>>>>
> >>>>>>>> Links to previous versions of the patchset:
> >>>>>>>> v1:<      https://lwn.net/Articles/454380/>
> >>>>>>>> v2:<      http://www.spinics.net/lists/kernel/msg1224275.html>
> >>>>>>>> v3:<      http://www.gossamer-
> >>>>>>>>
> >> threads.com/lists/linux/kernel/1423684>
> >>
> >>>>>>>> Changelog v2:
> >>>>>>>> DRM: add DRM_IOCTL_SAMSUNG_GEM_MMAP ioctl command.
> >>>>>>>>
> >>>>>>>>       this feature maps user address space to physical memory
> >>>>>>>>
> >> region
> >>
> >>>>>>>>       once user application requests DRM_IOCTL_SAMSUNG_GEM_MMAP
> >>>>>>>>
> >> ioctl.
> >>
> >>>>>>>> DRM: code clean and add exception codes.
> >>>>>>>>
> >>>>>>>> Changelog v3:
> >>>>>>>> DRM: Support multiple irq.
> >>>>>>>>
> >>>>>>>>       FIMD and HDMI have their own irq handler but DRM Framework
> >>>>>>>>
> >> can
> >>
> >>>>>>>> regiter
> >>>>>>>>       only one irq handler this patch supports mutiple irq for
> >>>>>>>> Samsung SoC.
> >>>>>>>>
> >>>>>>>> DRM: Consider modularization.
> >>>>>>>>
> >>>>>>>>       each DRM, FIMD could be built as a module.
> >>>>>>>>
> >>>>>>>> DRM: Have indenpendent crtc object.
> >>>>>>>>
> >>>>>>>>       crtc isn't specific to SoC Platform so this patch gets a
> crtc
> >>>>>>>>       to be used as common object.
> >>>>>>>>       created crtc could be attached to any encoder object.
> >>>>>>>>
> >>>>>>>> DRM: code clean and add exception codes.
> >>>>>>>>
> >>>>>>>> Changelog v4:
> >>>>>>>> DRM: remove is_defult from samsung_fb.
> >>>>>>>>
> >>>>>>>>       is_default isn't used for default framebuffer.
> >>>>>>>>
> >>>>>>>> DRM: code refactoring to fimd module.
> >>>>>>>>       this patch is be considered with multiple display objects
> and
> >>>>>>>>       would use its own request_irq() to register a irq handler
> >>>>>>>> instead of
> >>>>>>>>       drm framework's one.
> >>>>>>>>
> >>>>>>>> DRM: remove find_samsung_drm_gem_object()
> >>>>>>>>
> >>>>>>>> DRM: move kernel private data structures and definitions to
> driver
> >>>>>>>> folder.
> >>>>>>>>
> >>>>>>>>       samsung_drm.h would contain only public information for
> >>>>>>>>
> >>> userspace
> >>>
> >>>>>>>>       ioctl interface.
> >>>>>>>>
> >>>>>>>> DRM: code refactoring to gem modules.
> >>>>>>>>       buffer module isn't dependent of gem module anymore.
> >>>>>>>>
> >>>>>>>> DRM: fixed security issue.
> >>>>>>>>
> >>>>>>>> DRM: remove encoder porinter from specific connector.
> >>>>>>>>
> >>>>>>>>       samsung connector doesn't need to have generic encoder.
> >>>>>>>>
> >>>>>>>> DRM: code clean and add exception codes.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Inki Dae<inki.dae@samsung.com>
> >>>>>>>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
> >>>>>>>> Signed-off-by: SeungWoo Kim<sw0312.kim@samsung.com>
> >>>>>>>> Signed-off-by: kyungmin.park<kyungmin.park@samsung.com>
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>> +static struct drm_ioctl_desc samsung_ioctls[] = {
> >>>>>>>> +       DRM_IOCTL_DEF_DRV(SAMSUNG_GEM_CREATE,
> >>>>>>>> samsung_drm_gem_create_ioctl,
> >>>>>>>> +                       DRM_UNLOCKED | DRM_AUTH),
> >>>>>>>>
> >>>>>>>>
> >>>>>>> Hi!
> >>>>>>>
> >>>>>>> With reference my previous security comment.
> >>>>>>>
> >>>>>>> Let's say you have a compromised video player running as a DRM
> >>>>>>> client, that
> >>>>>>> tries to repeatedly allocate huge GEM buffers...
> >>>>>>>
> >>>>>>> What will happen when all DMA memory is exhausted? Will this cause
> >>>>>>> other
> >>>>>>> device drivers to see an OOM, or only DRM?
> >>>>>>>
> >>>>>>> The old DRI model basically allowed any authorized DRI client to
> >>>>>>> exhaust
> >>>>>>> video ram or AGP memory, but never system memory. Newer DRI
> drivers
> >>>>>>> typically only allow DRI masters to do that.
> >>>>>>> as
> >>>>>>>
> >>>>>>> I don't think an authorized DRI client should be able to easily
> >>>>>>>
> >>>> exhaust
> >>>>
> >>>>>>> resources (DMA memory) used by other device drivers causing them
> to
> >>>>>>> fail.
> >>>>>>>
> >>>>>> I'm not entirely sure what else can be done, other than have a
> >>>>>> threshold on max MB allocatable of buffer memory..
> >>>>>>
> >>>>> Yes, I think that's what needs to be done, and that threshold should
> >>>>> be low enough to keep other device drivers running in the worst
> >>>>> allocation case.
> >>>>>
> >>>>>
> >>>>>> In the samsung driver case, he is only allocating scanout memory
> >>>>>>
> >> from
> >>
> >>>>>> CMA, so the limit will be the CMA region size.. beyond that you
> >>>>>>
> >> can't
> >>
> >>>>>> get physically contiguous memory.  So I think this driver is safe.
> >>>>>>
> >>>>> It's not really what well-behaved user-space drivers do that should
> >>>>>
> >> be
> >>
> >>>>> a concern, but what compromized application *might* do that is a
> >>>>>
> >>> concern.
> >>>
> >>>> Hmm. I might have missed your point here. If the buffer allocation
> >>>>
> >> ioctl
> >>
> >>>> only allows allocating CMA memory, then I agree the driver fits the
> old
> >>>> DRI security model, as long as no other devices on the platform will
> >>>> ever use CMA.
> >>>>
> >>>> But in that case, there really should be a way for the driver to say
> >>>> "Hey, all CMA memory on this system is mine", in the same way
> >>>> traditional video drivers can claim the VRAM PCI resource.
> >>>>
> >>>>
> >>> CMA could reserve memory region for a specific driver so DRM Client
> >>>
> >> could
> >>
> >>> request memory allocation from only the region.
> >>>
> >>>
> >>>> This is to avoid the possibility that future drivers that need CMA
> will
> >>>> be vulnerable to DOS-attacks from ill-behaved DRI clients.
> >>>>
> >>>>
> >>> Thomas, if any application has root authority for ill-purpose then
> isn't
> >>>
> >> it
> >>
> >>> possible to be vulnerable to DOS-attacks? I think DRM_AUTH means root
> >>> authority. I know DRM Framework gives any root application DRM_AUTH
> >>> authority for compatibility.
> >>>
> >> DRM_AUTH just means that the client has authenticated w/ X11 (meaning
> >> that it has permission to connect to x server)..
> >>
> >>
> > Yes, I understood so. but see drm_open_helper() of drm_fops.c file
> please.
> > in this function, you can see a line below.
> > /* for compatibility root is always authenticated */
> > priv->authenticated = capable(CAP_SYS_ADMIN)
> >
> > I think the code above says that any application with root permission is
> > authenticated.
> >
> >
> 
> Yes, that is true. A root client may be assumed to have AUTH
> permissions, but the inverse does not hold, meaning that an AUTH client
> may *not* be assumed to have root permissions. I think there is a
> ROOT_ONLY ioctl flag for that.
> 
> The problem I'm seeing compared to other drivers is the following:
> 
> Imagine for example that you have a disc driver that allocates temporary
> memory out of the same DMA pool as the DRM driver.
> 
> Now you have a video player that is a DRM client. It contains a security
> flaw and is compromized by somebody trying to play a specially crafted
> video stream. The video player starts to allocate gem buffers until it
> receives an -ENOMEM. Then it stops allocating and does nothing.
> 
> Now the system tries an important disc access (paging for example). This
> fails, because the video player has exhausted all DMA memory and the
> disc driver fails to allocate.
> 
> The system is dead.
> 

Ok, I understood. but in case of using CMA, DRM driver would have private
memory pool which is reserved only for itself. so although the video player
requested gem buffer allocation until it receives an -ENOMEM and then the
system is try to access the disc, it would work fine. because the region
requested by system and the region requested by DRM driver could entirely be
separated. DRM driver wouldn't have implications for the system region.

> The point is:
> 
> If there is a chance that other drivers will use the same DMA/CMA pool
> as the DRM driver, DRM must leave enough DMA/CMA memory for those
> drivers to work.
> 
> The difference compared to other drm drivers:
> 
> There are other drm drivers that work the same way, with a static
> allocator. For example "via" and "sis". But those drivers completely
> claim the resources they are using. Nobody else is expected to use VRAM
> / AGP.
> 

I think if we use private cma region for DRM driver then it is similar to
via and sis way.

> In the Samsung case, it's not clear to me whether the DMA/CMA pool *can*
> be shared with other devices.
> If it is, IMHO you must implement an allocation limit in DRM, if not,
> the driver should probably be safe.
> 

As your saying, we would implement an allocation limit in DRM; DRM driver
have private region that any other drivers can't access to this one. in
fact, such limitation should be set at machine code. if this way has any
problems for security also, we CAN CHANGE DRM permission anytime. :) thank
you for your detailed account and that was very helpful to me.

> Thanks,
> Thomas
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> >
> >> But I think that since memory allocation is limited to the size of the
> >> CMA region, that this puts a reasonable cap of the memory that can be
> >> allocated by the client.  If this is a problem, it certainly isn't the
> >> worst problem.  You could still limit via file permissions the users
> >> that can open the DRM device file, so it is really no worse than other
> >> devices like v4l2..
> >>
> >> BR,
> >> -R
> >>
> >>
> >>
> >>>> /Thomas
> >>>>
> >>>>
> >>>
> >>>
> >>>
> >
> 
