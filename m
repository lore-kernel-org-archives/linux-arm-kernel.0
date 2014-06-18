From: thunder.leizhen@huawei.com (leizhen)
Date: Wed, 18 Jun 2014 09:28:30 +0800
Subject: [PATCH RFC v2 3/3] documentation/iommu: Add description of
 Hisilicon SMMU private binding
In-Reply-To: <20140617093326.GC13020@arm.com>
References: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
 <1402549692-5224-4-git-send-email-thunder.leizhen@huawei.com>
 <20140616163930.GX16758@arm.com> <539FF33C.7020007@huawei.com>
 <20140617093326.GC13020@arm.com>
Message-ID: <53A0EB3E.2080202@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/6/17 17:33, Will Deacon wrote:
> On Tue, Jun 17, 2014 at 08:50:20AM +0100, leizhen wrote:
>> On 2014/6/17 0:39, Will Deacon wrote:
>>> On Thu, Jun 12, 2014 at 06:08:12AM +0100, Zhen Lei wrote:
>>>> This patch adds a description of private properties for the Hisilicon
>>>> System MMU architecture.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>> index f284b99..75b1351 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>> @@ -15,6 +15,7 @@ conditions.
>>>>                          "arm,smmu-v2"
>>>>                          "arm,mmu-400"
>>>>                          "arm,mmu-500"
>>>> +                        "hisilicon,smmu-v1"
>>>>
>>>>                    depending on the particular implementation and/or the
>>>>                    version of the architecture implemented.
>>>> @@ -54,6 +55,21 @@ conditions.
>>>>                    aliases of secure registers have to be used during
>>>>                    SMMU configuration.
>>>>
>>>> +** Hisilicon SMMU private properties:
>>>> +
>>>> +- smmu-force-memtype : A list of StreamIDs which not translate address but
>>>> +                  translate attributes. The StreamIDs list here can not be
>>>> +                  used for map(translation) mode again.
>>>> +                  StreamID first, then the type list below:
>>>> +                  1, cahceable, WBRAWA, Normal outer and inner write-back
>>>> +                  2, non-cacheable, Normal outer and inner non-cacheable
>>>> +                  3, device, nGnRE
>>>> +                  others, bypass
>>>> +
>>>> +- smmu-bypass-vmid   : Specify which context bank is used for bypass mode.
>>>> +                  If omit, vmid=255 is default. If bypass and map mode can
>>>> +                  share a same S2CR, config vmid=0.
>>>
>>> These don't feel like they belong in the device-tree to me. Is the list of
>>> StreamIDs described in smmu-force-memtype a property of the hardware
>>> configuration, or a software policy to allow you to generate cacheable
>>> traffic for particular masters?
>>>
>>> Will
>>>
>>> .
>>>
>> OK, I will put these description into a sperate file, hisilicon,smmu.txt
>> and mark a reference to arm,smmu.txt
> 
> No, don't do that. Delete the properties instead. I'm not a device-tree
> expert, but these don't feel like things we should be describing there at
> all.
> 
>> The latter case. Some masters driver want use cacheable(WB) attribute to access
>> memory, but the masters can not bring cacheable attribute. So, can not use
>> bypass(or transaction) mode. In fact, the master driver can use iommu_map to
>> create map and specify IOMMU_CACHE. But maybe the driver does not want to
>> map, if the memory access is very dynamically, frequently map and unmap will
>> decrease performance.
> 
> You seem to be highlighting a perceived deficiency in the IOMMU API which
> you're attempting to work-around with new device-tree properties. Instead,
> why not propose an extension to the IOMMU API in Linux?
> 

The private properties or new IOMMU APIs, just in order to optimize performance
or simplify master driver code, I will consider it later. I think it's good to
support base functions first.

Sorry, I just only known ARM SMMU and Hisilicon SMMU, not familiar with others.
Add a common API may meet more difficulty.

If I have time, I will try to do it.

>> Actually, I think smmu-force-memtype maybe suitable for arm-smmu too. But now,
>> if nobody declear need it, I will just implement it in hisi-smmu.c
> 
> I don't want to see hisi-smmu.c at all. You need to make your driver fit
> into the code we already have.
> 
> Do you have a specification available describing the hardware you have
> created?
> 

Although I have the Hisilicon SMMU specification, but it was written in Chinese.
I have told this to hardware engineers.

OK. I will try my best to merge two drivers into one file. Maybe need to use many
#if#else.

>> A big issue should be discussed now. When a master use bypass mode to access
>> memory, this means it can access all non-secure memory. So, if a master can
>> be operated in user mode, that means a user process can access any kernel
>> memory. In ARM smmu-v2 specification, SMMU_S2CRn.PRIVCFG is used for determine
>> output priviledge attribute. But if use bypass mode and output attribute is
>> Unprivileged, specification have no mention about where to decide memory access
>> is permitted or not. Do you think is a spec design bug or Implemention
>> defined, or find some description anywhere.
> 
> There are various overrides for the privilege controls but, as Varun said,
> you should be using VFIO for userspace device access.
> 
> Will
> 
> .
> 
