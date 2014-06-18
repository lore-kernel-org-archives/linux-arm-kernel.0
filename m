From: thunder.leizhen@huawei.com (leizhen)
Date: Wed, 18 Jun 2014 20:34:50 +0800
Subject: [PATCH RFC v2 3/3] documentation/iommu: Add description of
 Hisilicon SMMU private binding
In-Reply-To: <ec7da7c5e94a440b90ff7a0743742d74@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
 <1402549692-5224-4-git-send-email-thunder.leizhen@huawei.com>
 <20140616163930.GX16758@arm.com> <539FF33C.7020007@huawei.com>
 <20140617093326.GC13020@arm.com> <53A0EB3E.2080202@huawei.com>
 <ec7da7c5e94a440b90ff7a0743742d74@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <53A1876A.7090300@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/6/18 20:03, Varun Sethi wrote:
> Hi Will/Zhen,
> 
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of leizhen
>> Sent: Wednesday, June 18, 2014 6:59 AM
>> To: Will Deacon
>> Cc: huxinwei at huawei.com; Catalin Marinas; Zefan Li; linux-arm-kernel
>> Subject: Re: [PATCH RFC v2 3/3] documentation/iommu: Add description of
>> Hisilicon SMMU private binding
>>
>> On 2014/6/17 17:33, Will Deacon wrote:
>>> On Tue, Jun 17, 2014 at 08:50:20AM +0100, leizhen wrote:
>>>> On 2014/6/17 0:39, Will Deacon wrote:
>>>>> On Thu, Jun 12, 2014 at 06:08:12AM +0100, Zhen Lei wrote:
>>>>>> This patch adds a description of private properties for the
>>>>>> Hisilicon System MMU architecture.
>>>>>>
>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 16
>>>>>> ++++++++++++++++
>>>>>>  1 file changed, 16 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>>>> b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>>>> index f284b99..75b1351 100644
>>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>>>> @@ -15,6 +15,7 @@ conditions.
>>>>>>                          "arm,smmu-v2"
>>>>>>                          "arm,mmu-400"
>>>>>>                          "arm,mmu-500"
>>>>>> +                        "hisilicon,smmu-v1"
>>>>>>
>>>>>>                    depending on the particular implementation and/or
>> the
>>>>>>                    version of the architecture implemented.
>>>>>> @@ -54,6 +55,21 @@ conditions.
>>>>>>                    aliases of secure registers have to be used
>> during
>>>>>>                    SMMU configuration.
>>>>>>
>>>>>> +** Hisilicon SMMU private properties:
>>>>>> +
>>>>>> +- smmu-force-memtype : A list of StreamIDs which not translate
>> address but
>>>>>> +                  translate attributes. The StreamIDs list here can
>> not be
>>>>>> +                  used for map(translation) mode again.
>>>>>> +                  StreamID first, then the type list below:
>>>>>> +                  1, cahceable, WBRAWA, Normal outer and inner
>> write-back
>>>>>> +                  2, non-cacheable, Normal outer and inner non-
>> cacheable
>>>>>> +                  3, device, nGnRE
>>>>>> +                  others, bypass
>>>>>> +
>>>>>> +- smmu-bypass-vmid   : Specify which context bank is used for
>> bypass mode.
>>>>>> +                  If omit, vmid=255 is default. If bypass and map
>> mode can
>>>>>> +                  share a same S2CR, config vmid=0.
>>>>>
>>>>> These don't feel like they belong in the device-tree to me. Is the
>>>>> list of StreamIDs described in smmu-force-memtype a property of the
>>>>> hardware configuration, or a software policy to allow you to
>>>>> generate cacheable traffic for particular masters?
>>>>>
>>>>> Will
>>>>>
>>>>> .
>>>>>
>>>> OK, I will put these description into a sperate file,
>>>> hisilicon,smmu.txt and mark a reference to arm,smmu.txt
>>>
>>> No, don't do that. Delete the properties instead. I'm not a
>>> device-tree expert, but these don't feel like things we should be
>>> describing there at all.
>>>
>>>> The latter case. Some masters driver want use cacheable(WB) attribute
>>>> to access memory, but the masters can not bring cacheable attribute.
>>>> So, can not use bypass(or transaction) mode. In fact, the master
>>>> driver can use iommu_map to create map and specify IOMMU_CACHE. But
>>>> maybe the driver does not want to map, if the memory access is very
>>>> dynamically, frequently map and unmap will decrease performance.
>>>
>>> You seem to be highlighting a perceived deficiency in the IOMMU API
>>> which you're attempting to work-around with new device-tree
>>> properties. Instead, why not propose an extension to the IOMMU API in
>> Linux?
>>>
>>
>> The private properties or new IOMMU APIs, just in order to optimize
>> performance or simplify master driver code, I will consider it later. I
>> think it's good to support base functions first.
>>
>> Sorry, I just only known ARM SMMU and Hisilicon SMMU, not familiar with
>> others.
>> Add a common API may meet more difficulty.
>>
>> If I have time, I will try to do it.
>>
> [Sethi Varun-B16395] We can introduce SMMU specific attributes (to use with iommu set attribute API call) for setting memory cacheability attributes. These could be used for setting the MAIR per context bank. Actually, we would require this for out platform. However, I am not sure how memory attribute translation would work if S2CR is set for bypass?
> 
> -Varun
> 
> 
> 
> .
> 
The ARM SMMU v2 specification describes that:
If the transaction is successfully matched in the Stream mapping table, SMMU_S2CRn determines the initial
context. If SMMU_S2CRn specifies Bypass mode:
? The address is not translated, meaning that the output address is identical to the input address.
? Output attributes are a function of the input attributes and the SMMU_S2CRn fields.
