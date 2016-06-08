From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 08 Jun 2016 12:01:20 +0200
Subject: HDLCD crashes with 6d910bfa809e
In-Reply-To: <20160608090507.GG1165@e106497-lin.cambridge.arm.com>
References: <5756B8A8.8000902@arm.com>
 <20160607133535.GA1165@e106497-lin.cambridge.arm.com>
 <5756D602.4090305@arm.com>
 <20160607143425.GE1165@e106497-lin.cambridge.arm.com>
 <3c4d34f5-a924-587e-5956-c21d528f24bf@samsung.com>
 <20160608090507.GG1165@e106497-lin.cambridge.arm.com>
Message-ID: <69f6ce7f-2c60-319a-fa65-b52a74db5460@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,


On 2016-06-08 11:05, liviu.dudau at arm.com wrote:
> On Wed, Jun 08, 2016 at 08:58:33AM +0200, Marek Szyprowski wrote:
>> On 2016-06-07 16:34, liviu.dudau at arm.com wrote:
>>> On Tue, Jun 07, 2016 at 03:11:14PM +0100, Robin Murphy wrote:
>>>> Hi Liviu,
>>>>
>>>> On 07/06/16 14:35, liviu.dudau at arm.com wrote:
>>>>> On Tue, Jun 07, 2016 at 01:06:00PM +0100, Robin Murphy wrote:
>>>>>> Having just inadvertently merged -next into my working branch, I find
>>>>>> dev6d910bfa809e ("drm/hlcd: Use lockless gem BO free callback") adversely
>>>>>> affecting my board's ability to boot ;)
>>>>>>
>>>>>> Since I (intentionally) don't have sufficient CMA to create a framebuffer,
>>>>>> drm_gem_cma_create() fails, unconditionally calls the now-NULL
>>>>>> drm->driver->gem_free_object() in its cleanup path, and fiery death
>>>>>> ensues...
>>>>> Thanks for reporting this. What other changes other than reducing the CMA
>>>>> allocation size do you have that I might need in order to reproduce this?
>>>> I've just confirmed a plain checkout of next-20160602, using arm64 defconfig
>>>> + DRM + HDLCD + TDA998X and CMA_SIZE_MBYTES=1, booted on a Juno, does the
>>>> job:
>>>>
>>>> [    3.032402] hdlcd 7ff60000.hdlcd: bound 0-0070 (ops tda998x_ops)
>>>> [    3.038388] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>>>> [    3.044970] [drm] No driver support for vblank timestamp query.
>>>> [    3.076973] hdlcd 7ff60000.hdlcd: failed to allocate buffer with size
>>>> 7680000
>>>> [    3.084081] Bad mode in Synchronous Abort handler detected, code
>>>> 0x86000004 -- IABT (current EL)
>>>> [    3.092815] CPU: 3 PID: 6 Comm: kworker/u12:0 Not tainted
>>>> 4.7.0-rc1-next-20160602 #686
>>>> [    3.100682] Hardware name: ARM Juno development board (r1) (DT)
>>>> [    3.106567] Workqueue: deferwq deferred_probe_work_func
>>>> [    3.111761] task: ffff8009768a3e80 ti: ffff8009768e8000 task.ti:
>>>> ffff8009768e8000
>>>> [    3.119198] PC is at 0x0
>>>> [    3.121720] LR is at drm_gem_cma_create+0x128/0x130
>>>> ...and so on.
>>>>
>>>> Today's -next, on the other hand, dodges the bullet entirely:
>>>>
>>>> [    2.903645] [drm] found ARM HDLCD version r0p0
>>>> [    2.908122] hdlcd 7ff60000.hdlcd: master bind failed: -22
>>>> [    2.913505] tda998x: probe of 0-0070 failed with error -22
>>>> [    2.919141] [drm] found ARM HDLCD version r0p0
>>>> [    2.923609] hdlcd 7ff50000.hdlcd: master bind failed: -22
>>>> [    2.928991] tda998x: probe of 0-0071 failed with error -22
>>> OK, the problem is that commit 59ce4039727ef40 has changed the behaviour from when
>>> there is no "memory-region" phandle in the DT: before it used to return -ENODEV, now
>>> it returns -EINVAL.
>>>
>>> Marek, I quite liked the old behaviour to detect if the DT had the optional (from
>>> my driver's point of view) "memory-region" phandle. Plus the check for dev is superfluous
>>> when using of_reserved_mem_device_init() as that uses dev->of_node for np so it would
>>> crash before the check anyway. Maybe move the check there?
>>>
>>> Until then I suggest reverting the 59ce4039727ef40 commit.
>> I've just send a fix for this issue. I'm sorry for the regression. I hope
>> the fix fill
>> quickly get into next to solve your problem.
> Thanks for the patch, however I have some comments to it.
>
>> The additional check for null dev make sense, because the new function
>> of_reserved_mem_device_init_by_idx can be called with any device and node
>> pointer not
>> embedded with it, so I would like to keep it safe.
> And I have to admit I find that scary. Why do you accept any node that is *not* related to
> the device? If you want just the ability to parse multiple "memory-region" phandles (where
> are the bindings defined for that?) I would have modified of_reserved_mem_device_init() to
> the the parsing and accept either the single entry style or a node with multiple
> "memory-region" phandles in it. Otherwise I can steal the "memory-region" of another device
> and that device would have no idea that I have done this.

The idea is not to steal memory region from another device, but to let 
driver to use multiple
regions assigned to the supported device with dma-mapping api. To use 
them with dma-mapping
subsystem, one needs separate struct device for each reserved region. 
The idea is to create
child devices of the device, which has memory-region property. Then for 
each such child
device, driver can call of_reserved_mem_device_init_by_idx() to enable 
usage of dma-mapping
api based on the selected reserved region. Such approach was already 
used for long time in
the media/platform/s5p-mfc driver and now it has been converted to use 
generic reserved
memory regions.

If you feel scary about this approach, maybe a check if the device 
provided to
of_reserved_mem_device_init_by_idx() function is one of the successors 
of the device hidden
behind the provided node pointer (or points to the same device)?

> Can you point me to the latest thread where this patch has been discussed?

This patch is a part of "Exynos: MFC driver: reserved memory cleanup and 
IOMMU support" thread
and has been around for a while:
https://www.mail-archive.com/linux-media at vger.kernel.org/msg97645.html

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
