From: puck.chen@hisilicon.com (Chen Feng)
Date: Tue, 21 Feb 2017 14:05:44 +0800
Subject: [Linaro-mm-sig] [RFCv3][PATCH 3/5] arm64: Implement
 ARCH_HAS_FORCE_CACHE
In-Reply-To: <b4a92c52-cbe8-9009-43bf-4c7b49e31916@redhat.com>
References: <1473715978-11633-1-git-send-email-labbott@redhat.com>
 <1473715978-11633-4-git-send-email-labbott@redhat.com>
 <20160913091946.GB7467@arm.com>
 <27805ccf-1f2d-81ea-044e-b21207be8e7f@redhat.com>
 <20160913151325.GF17731@arm.com>
 <b4a92c52-cbe8-9009-43bf-4c7b49e31916@redhat.com>
Message-ID: <58ABD8B8.6050204@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

When we enable kernel v4.4 or newer version on our platform, we meet the issue
of flushing cache without reference device. It seems that this patch set is
a solution. I'm curious the progress of the discussion. Do you have any plan
to fix it in v4.4 and newer kernel verison?

On 2016/9/14 2:41, Laura Abbott wrote:
> On 09/13/2016 08:14 AM, Will Deacon wrote:
>> On Tue, Sep 13, 2016 at 08:02:20AM -0700, Laura Abbott wrote:
>>> On 09/13/2016 02:19 AM, Will Deacon wrote:
>>>> On Mon, Sep 12, 2016 at 02:32:56PM -0700, Laura Abbott wrote:
>>>>>
>>>>> arm64 may need to guarantee the caches are synced. Implement versions of
>>>>> the kernel_force_cache API to allow this.
>>>>>
>>>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>>>> ---
>>>>> v3: Switch to calling cache operations directly instead of relying on
>>>>> DMA mapping.
>>>>> ---
>>>>> arch/arm64/include/asm/cacheflush.h |  8 ++++++++
>>>>> arch/arm64/mm/cache.S               | 24 ++++++++++++++++++++----
>>>>> arch/arm64/mm/flush.c               | 11 +++++++++++
>>>>> 3 files changed, 39 insertions(+), 4 deletions(-)
>>>>
>>>> I'm really hesitant to expose these cache routines as an API solely to
>>>> support a driver sitting in staging/. I appreciate that there's a chicken
>>>> and egg problem here, but we *really* don't want people using these routines
>>>> in preference to the DMA API, and I fear that we'll simply grow a bunch
>>>> more users of these things if we promote it as an API like you're proposing.
>>>>
>>>> Can the code not be contained under staging/, as part of ion?
>>>>
>>>
>>> I proposed that in V1 and it was suggested I make it a proper API
>>>
>>> http://www.mail-archive.com/driverdev-devel at linuxdriverproject.org/msg47654.html
>>> http://www.mail-archive.com/driverdev-devel at linuxdriverproject.org/msg47672.html
>>
>> :/ then I guess we're in disagreement. If ion really needs this stuff
>> (which I don't fully grok), perhaps we should be exposing something at
>> a higher level from the architecture, so it really can't be used for
>> anything other than ion.
> 
> I talked/complained about this at a past plumbers. The gist is that Ion
> ends up acting as a fake DMA layer for clients. It doesn't match nicely
> because clients can allocate both coherent and non-coherent memory.
> Trying to use dma_map doesn't work because a) a device for coherency isn't
> known at allocation time b) it kills performance. Part of the motivation
> for taking this approach is to avoid the need to rework the existing
> Android userspace and keep the existing behavior, as terrible as it
> is. Having Ion out of staging and not actually usable isn't helpful.
> 
> I'll give this all some more thought and hopefully have one or two more
> proposals before Connect/Plumbers.
> 
>>
>> Will
>>
> 
> Thanks,
> Laura
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-mm-sig
