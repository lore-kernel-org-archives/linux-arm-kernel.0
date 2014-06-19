From: thunder.leizhen@huawei.com (leizhen)
Date: Thu, 19 Jun 2014 09:58:25 +0800
Subject: [PATCH RFC v2 3/3] documentation/iommu: Add description of
 Hisilicon SMMU private binding
In-Reply-To: <20140618133258.GC2186@arm.com>
References: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
 <1402549692-5224-4-git-send-email-thunder.leizhen@huawei.com>
 <20140616163930.GX16758@arm.com> <539FF33C.7020007@huawei.com>
 <20140617093326.GC13020@arm.com> <53A0EB3E.2080202@huawei.com>
 <20140618133258.GC2186@arm.com>
Message-ID: <53A243C1.9030700@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/6/18 21:32, Will Deacon wrote:
> On Wed, Jun 18, 2014 at 02:28:30AM +0100, leizhen wrote:
>> On 2014/6/17 17:33, Will Deacon wrote:
>>> On Tue, Jun 17, 2014 at 08:50:20AM +0100, leizhen wrote:
>>>> The latter case. Some masters driver want use cacheable(WB) attribute to access
>>>> memory, but the masters can not bring cacheable attribute. So, can not use
>>>> bypass(or transaction) mode. In fact, the master driver can use iommu_map to
>>>> create map and specify IOMMU_CACHE. But maybe the driver does not want to
>>>> map, if the memory access is very dynamically, frequently map and unmap will
>>>> decrease performance.
>>>
>>> You seem to be highlighting a perceived deficiency in the IOMMU API which
>>> you're attempting to work-around with new device-tree properties. Instead,
>>> why not propose an extension to the IOMMU API in Linux?
>>>
>>
>> The private properties or new IOMMU APIs, just in order to optimize performance
>> or simplify master driver code, I will consider it later. I think it's good to
>> support base functions first.
>>
>> Sorry, I just only known ARM SMMU and Hisilicon SMMU, not familiar with others.
>> Add a common API may meet more difficulty.
>>
>> If I have time, I will try to do it.
> 
> Ok, so we're agreeing to drop those properties for now?
> 
>>>> Actually, I think smmu-force-memtype maybe suitable for arm-smmu too. But now,
>>>> if nobody declear need it, I will just implement it in hisi-smmu.c
>>>
>>> I don't want to see hisi-smmu.c at all. You need to make your driver fit
>>> into the code we already have.
>>>
>>> Do you have a specification available describing the hardware you have
>>> created?
>>>
>>
>> Although I have the Hisilicon SMMU specification, but it was written in Chinese.
>> I have told this to hardware engineers.
> 
> Having access to a specification I can understand would help to assess
> exactly what you've gone and built.
> 
>> OK. I will try my best to merge two drivers into one file. Maybe need to use many
>> #if#else.
> 
> The fact of the matter is that you've got a device that isn't
> architecturally compliant. That leaves me in a fairly undesirable position
> with a small set of options:
> 
>   (1) We can duplicate lots of the code we already have and you end up with a
>       separate driver. This is obviously bad because of the code duplication,
>       associated maintenance headaches, driver divergence, etc. It also brings
>       into question the point of having a driver written to the architecture
>       when the hardware has gone off and done something different.
> 
>   (2) We try to fit your SMMU into the existing driver. I'd like to see what
>       this looks like, but if it's as much #ifdeffery as you suggest, then
>       that's also bad for many of the same reasons as above.
> 
>   (3) We don't support your device in the Linux kernel. We could just treat
>       your SMMU as a broken ARM SMMU implementation and not support it. If
>       this was a CPU instead of an SMMU this would unquestionably be the
>       correct approach.
> 
> Unless you can come up with something compelling for point (2), I'm going to
> err on the side of (3). So, please, *please*, don't do a rushed job of
> merging the drivers. You need to convince me why I should bother supporting
> this device in my driver, which means using clean abstractions and extending
> the code we already have. If this isn't possible, then perhaps you'll
> consider following the architecture next time around.
> 
> Will
> 
> .
> 
Yeah, I konw. I also a software engineer. A victim of this SMMU.
