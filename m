From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 15 Sep 2011 08:14:36 +0900
Subject: [Linaro-mm-sig] [PATCH v4] DRM: add DRM Driver for Samsung SoC
	EXYNOS4210.
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
Message-ID: <CAH9JG2WeyoNJP0x0oHaizATZpWEkW9s2SpO4sX=PVp6YdX56PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 6:53 AM, Rob Clark <robdclark@gmail.com> wrote:
> On Wed, Sep 14, 2011 at 2:57 AM, Thomas Hellstrom <thomas@shipmail.org> wrote:
>>>>>>>>>>
>>>>>>>>>> +static struct drm_ioctl_desc samsung_ioctls[] = {
>>>>>>>>>> + ? ? ? DRM_IOCTL_DEF_DRV(SAMSUNG_GEM_CREATE,
>>>>>>>>>> samsung_drm_gem_create_ioctl,
>>>>>>>>>> + ? ? ? ? ? ? ? ? ? ? ? DRM_UNLOCKED | DRM_AUTH),
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi!
>>>>>>>>>
>>>>>>>>> With reference my previous security comment.
>>>>>>>>>
>>>>>>>>> Let's say you have a compromised video player running as a DRM
>>>>>>>>> client, that
>>>>>>>>> tries to repeatedly allocate huge GEM buffers...
>>>>>>>>>
>>>>>>>>> What will happen when all DMA memory is exhausted? Will this cause
>>>>>>>>> other
>>>>>>>>> device drivers to see an OOM, or only DRM?
>>>>>>>>>
>>>>>>>>> The old DRI model basically allowed any authorized DRI client to
>>>>>>>>> exhaust
>>>>>>>>> video ram or AGP memory, but never system memory. Newer DRI drivers
>>>>>>>>> typically only allow DRI masters to do that.
>>>>>>>>> as
>>>>>>>>>
>>>>>>>>> I don't think an authorized DRI client should be able to easily
>>>>>>>>>
>>>>>>
>>>>>> exhaust
>>>>>>
>>>>>>>>>
>>>>>>>>> resources (DMA memory) used by other device drivers causing them to
>>>>>>>>> fail.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'm not entirely sure what else can be done, other than have a
>>>>>>>> threshold on max MB allocatable of buffer memory..
>>>>>>>>
>>>>>>>
>>>>>>> Yes, I think that's what needs to be done, and that threshold should
>>>>>>> be low enough to keep other device drivers running in the worst
>>>>>>> allocation case.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> In the samsung driver case, he is only allocating scanout memory
>>>>>>>>
>>>>
>>>> from
>>>>
>>>>>>>>
>>>>>>>> CMA, so the limit will be the CMA region size.. beyond that you
>>>>>>>>
>>>>
>>>> can't
>>>>
>>>>>>>>
>>>>>>>> get physically contiguous memory. ?So I think this driver is safe.
>>>>>>>>
>>>>>>>
>>>>>>> It's not really what well-behaved user-space drivers do that should
>>>>>>>
>>>>
>>>> be
>>>>
>>>>>>>
>>>>>>> a concern, but what compromized application *might* do that is a
>>>>>>>
>>>>>
>>>>> concern.
>>>>>
>>>>>>
>>>>>> Hmm. I might have missed your point here. If the buffer allocation
>>>>>>
>>>>
>>>> ioctl
>>>>
>>>>>>
>>>>>> only allows allocating CMA memory, then I agree the driver fits the old
>>>>>> DRI security model, as long as no other devices on the platform will
>>>>>> ever use CMA.
>>>>>>
>>>>>> But in that case, there really should be a way for the driver to say
>>>>>> "Hey, all CMA memory on this system is mine", in the same way
>>>>>> traditional video drivers can claim the VRAM PCI resource.
>>>>>>
>>>>>>
>>>>>
>>>>> CMA could reserve memory region for a specific driver so DRM Client
>>>>>
>>>>
>>>> could
>>>>
>>>>>
>>>>> request memory allocation from only the region.
>>>>>
>>>>>
>>>>>>
>>>>>> This is to avoid the possibility that future drivers that need CMA will
>>>>>> be vulnerable to DOS-attacks from ill-behaved DRI clients.
>>>>>>
>>>>>>
>>>>>
>>>>> Thomas, if any application has root authority for ill-purpose then isn't
>>>>>
>>>>
>>>> it
>>>>
>>>>>
>>>>> possible to be vulnerable to DOS-attacks? I think DRM_AUTH means root
>>>>> authority. I know DRM Framework gives any root application DRM_AUTH
>>>>> authority for compatibility.
>>>>>
>>>>
>>>> DRM_AUTH just means that the client has authenticated w/ X11 (meaning
>>>> that it has permission to connect to x server)..
>>>>
>>>>
>>>
>>> Yes, I understood so. but see drm_open_helper() of drm_fops.c file please.
>>> in this function, you can see a line below.
>>> /* for compatibility root is always authenticated */
>>> priv->authenticated = capable(CAP_SYS_ADMIN)
>>>
>>> I think the code above says that any application with root permission is
>>> authenticated.
>>>
>>>
>>
>> Yes, that is true. A root client may be assumed to have AUTH permissions,
>> but the inverse does not hold, meaning that an AUTH client may *not* be
>> assumed to have root permissions. I think there is a ROOT_ONLY ioctl flag
>> for that.
>>
>> The problem I'm seeing compared to other drivers is the following:
>>
>> Imagine for example that you have a disc driver that allocates temporary
>> memory out of the same DMA pool as the DRM driver.
>>
>> Now you have a video player that is a DRM client. It contains a security
>> flaw and is compromized by somebody trying to play a specially crafted video
>> stream. The video player starts to allocate gem buffers until it receives an
>> -ENOMEM. Then it stops allocating and does nothing.
>>
>> Now the system tries an important disc access (paging for example). This
>> fails, because the video player has exhausted all DMA memory and the disc
>> driver fails to allocate.
>>
>> The system is dead.
>>
>> The point is:
>>
>> If there is a chance that other drivers will use the same DMA/CMA pool as
>> the DRM driver, DRM must leave enough DMA/CMA memory for those drivers to
>> work.
>
> ah, ok, I get your point
>
>
>> The difference compared to other drm drivers:
>>
>> There are other drm drivers that work the same way, with a static allocator.
>> For example "via" and "sis". But those drivers completely claim the
>> resources they are using. Nobody else is expected to use VRAM / AGP.
>>
>> In the Samsung case, it's not clear to me whether the DMA/CMA pool *can* be
>> shared with other devices.
>> If it is, IMHO you must implement an allocation limit in DRM, if not, the
>> driver should probably be safe.
>
> It is possible to create a device private CMA pool.. ?although OTOH it
> might be desirable to let some other drivers (like v4l2) use buffers
> from the same pool..
That's the final goal. memory sharing among multimedia devices (v4l2),
display(fimd, hdmi), and 3D (mali).
currently mali drivers is tightly coupled with UMP and it's hard to
use the CMA. it's need to solve this issue also.

In case of multimedia drivers, it has fixed memory area as scenario
and display also has similar restriction. I don't expect DRI request
the more memory than CMA pool has.
>
> I'm not entirely sure what will happen w/ dma_alloc_coherent, etc, if
> the global CMA pool is exhausted.
The primary goal of CMA is guarantee the memory for multimedia. So if
other device use the multimedia CMA pool, it should release the used
memory. and it's hard to release the memory. it should has display CMA
pool and don't share the other multimedia devices CMA pool.

CMA can share the same CMA pool and specify the device usage which CMA
pool used.
>
> Marek? ?I guess you know what would happen?

He will comeback when 21 Sep.

Thank you,
Kyungmin Park
