From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 25 Oct 2016 10:37:06 -0600
Subject: [PATCH] exynos-drm: Fix display manager failing to start without
 IOMMU problem
In-Reply-To: <49780a7f-59a4-d2b0-380c-4bd330660ba2@osg.samsung.com>
References: <CGME20160810214111epcas1p4dd2a581353b550a1992fc7695e846da7@epcas1p4.samsung.com>
 <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
 <57ABB1ED.1080301@samsung.com> <57ABB31E.1070802@osg.samsung.com>
 <57AE0736.6020705@osg.samsung.com> <57AE0CCB.1010708@osg.samsung.com>
 <57B29925.4020600@samsung.com>
 <ce7a035c-f881-82ac-97f6-869442d1ed47@osg.samsung.com>
 <CAAQKjZMFOe7Aa5Hq5gbMj7=h2VfgXq5jgqbB1wqcZcYZ0ZKZxA@mail.gmail.com>
 <49780a7f-59a4-d2b0-380c-4bd330660ba2@osg.samsung.com>
Message-ID: <fa4114e0-9382-0653-7dc6-a63f1312d616@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2016 04:27 PM, Shuah Khan wrote:
> On 10/19/2016 08:16 AM, Inki Dae wrote:
>> Hi Shuah,
>>
>> 2016-10-13 8:11 GMT+09:00 Shuah Khan <shuahkh@osg.samsung.com>:
>>> Hi Inki,
>>>
>>> On 08/15/2016 10:40 PM, Inki Dae wrote:
>>>
>>>>>
>>>>> okay the very first commit that added IOMMU support
>>>>> introduced the code that rejects non-contig gem memory
>>>>> type without IOMMU.
>>>>>
>>>>> commit 0519f9a12d0113caab78980c48a7902d2bd40c2c
>>>>> Author: Inki Dae <inki.dae@samsung.com>
>>>>> Date:   Sat Oct 20 07:53:42 2012 -0700
>>>>>
>>>>>     drm/exynos: add iommu support for exynos drm framework
>>>>>
>>>
>>> I haven't given up on this yet. I am still seeing the following failure:
>>>
>>> Additional debug messages I added:
>>> [   15.287403] exynos_drm_gem_create_ioctl() 1
>>> [   15.287419] exynos_drm_gem_create() flags 1
>>>
>>> [   15.311511] [drm:exynos_drm_framebuffer_init] *ERROR* Non-contiguous GEM memory is not supported.
>>>
>>> Additional debug message I added:
>>> [   15.318981] [drm:exynos_user_fb_create] *ERROR* failed to initialize framebuffer
>>>
>>> This is what happens:
>>>
>>> 1. exynos_drm_gem_create_ioctl() gets called with EXYNOS_BO_NONCONTIG request
>>> 2. exynos_drm_gem_create(0 goes ahead and creates the GEM buffers
>>> 3. exynos_user_fb_create() tries to associate GEM to fb and fails during
>>>    check_fb_gem_memory_type()
>>>
>>> At this point, there is no recovery and lightdm fails
>>>
>>> xf86-video-armsoc/src/drmmode_exynos/drmmode_exynos.c assumes contiguous
>>> allocations are not supported in some exynos drm versions: The following
>>> commit introduced this change:
>>>
>>> https://git.linaro.org/arm/xorg/driver/xf86-video-armsoc.git/commitdiff/3be1f6273441fe95dd442f44064387322e16b7e9
>>>
>>> excerpts from the diff:-       if (create_gem->buf_type == ARMSOC_BO_SCANOUT)
>>> -               create_exynos.flags = EXYNOS_BO_CONTIG;
>>> -       else
>>> -               create_exynos.flags = EXYNOS_BO_NONCONTIG;
>>> +
>>> +       /* Contiguous allocations are not supported in some exynos drm versions.
>>> +        * When they are supported all allocations are effectively contiguous
>>> +        * anyway, so for simplicity we always request non contiguous buffers.
>>> +        */
>>> +       create_exynos.flags = EXYNOS_BO_NONCONTIG;
>>>
>>
>> Above comment, "Contiguous allocations are not supported in some
>> exynos drm versions.", seems wrong assumption.
>> The root cause, contiguous allocation is not supported, would be that
>> they used Linux kernel which didn't have CMA region enough - as
>> default 16MB, or didn't declare CMA region enough for the DMA device.
>> So I think they should not force to flag EXYNOS_BO_NONCONTIG and they
>> should manage the error case if the allocation failed.
> 
> This assumption doesn't sound correct and forcing NONCONTIG isn't right
> either. 
> 
>>
>>> There might have been logic on exynos_drm that forced Contig when it coudn't
>>> support NONCONTIG. At least, that is what this comment suggests. This assumption
>>> doesn't appear to be a good one and not sure if this change was made to fix a bug.
>>>
>>> After the IOMMU support, this assumption is no longer true. Hence, with IOMMU
>>> support, latest kernels have a mismatch with the installed xf86-video-armsoc
>>>
>>> This is what I am running into. This leads to the following question:
>>>
>>> 1. How do we ensure exynos_drm kernel changes don't break user-space
>>>    specifically xf86-video-armsoc
>>> 2. This seems to have gone undetected for a while. I see a change in
>>>    exynos_drm_gem_dumb_create() that is probably addressing this type
>>>    of breakage. Commit 122beea84bb90236b1ae545f08267af58591c21b adds
>>>    handling for IOMMU NONCONTIG case.
>>
>> Seems this patch has a problem. This patch forces to flag NONCONTIG if
>> iommu is enabled. The flag should be depend on the argument from
>> user-space.
>> I.e., if user-space requested a gem allocation with CONTIG flag, then
>> Exynos drm driver should allocate contiguous memory even though iommu
>> is enabled.
>>
>>>
>>> Anyway, I am interested in getting the exynos_drm kernel side code
>>> and xf86-video-armsoc in sync to resolve the issue.
>>>
>>> Could you recommend a going forward plan?
>>
>> My opinion are,
>>
>> 1. Do not force to flag EXYNOS_BO_NONCONTIG at xf86-video-armsoc

Okay more on this. I fixed xf86-video-armso to ask for EXYNOS_BO_CONTIG
for ARMSOC_BO_SCANOUT and EXYNOS_BO_NONCONTIG in all other cases.

Revert of the commit: 3be1f6273441fe95dd442f44064387322e16b7e9

With this change, now display manager starts just fine. However, it turns
out xf86-video-armsoc is obsoleted in favor of xf86-video-modesetting. The
last update to xf86-video-armsoc git was 3 years ago.

I am not sure where to send the fix and doesn't look like it is being
maintained actively. I can pursue it further and try to get this into
xf86-video-armsoc provided I can find the maintainer for this seemingly
inactive project.

I brought in the latest xf86-video-modesetting bits from

https://cgit.freedesktop.org/xorg/driver/xf86-video-modesetting

I removed xf86-video-armsoc and installed xf86-video-modesetting and that
worked just fine. xf86-video-modesetting uses dumb_create interface instead
of DRM_IOCTL_EXYNOS_GEM_CREATE.

dumb_create interface eliminates the need for DRM_IOCTL_EXYNOS_GEM_CREATE
in userspace. libdrm-2.4.71 does call DRM_IOCTL_EXYNOS_GEM_CREATE.

The question is do we still need to continue to support the custom gem
create interface DRM_IOCTL_EXYNOS_GEM_CREATE? Some drm drivers seem to
support it and some don't. Unfortunately, if userspace requests noncontig
for scanout, we will continue to see problems with display manager when
iommu is disabled. dumb create hides all of that, are there good reasons
to continue to support it in exynos drm?

Exposing CONTIG and NONCONTIG to userspace appears to be causing problems
when exynos drm determines it can't support non-contig GEM buffers in fb
init after userspace allocates them.

>> 2. Do not force to flag NONCONTIG at Exynos drm driver even though
>> iommu is enabled and flag allocation type with the argument from
>> user-space.
>>

exynos_drm_gem_dumb_create() doesn't take any flags, there is no need
to change the above.

thanks,
-- Shuah
