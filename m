From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 31 May 2018 21:49:22 +0800
Subject: [PATCH 0/7] add non-strict mode support for arm-smmu-v3
In-Reply-To: <d65f87a4-db61-3cd2-1a6f-0322025840a8@arm.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <d65f87a4-db61-3cd2-1a6f-0322025840a8@arm.com>
Message-ID: <96cc25b9-b21f-6067-384d-f52e6b8b25e7@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 2018/5/31 19:24, Robin Murphy wrote:
> On 31/05/18 08:42, Zhen Lei wrote:
>> In common, a IOMMU unmap operation follow the below steps:
>> 1. remove the mapping in page table of the specified iova range
>> 2. execute tlbi command to invalid the mapping which is cached in TLB
>> 3. wait for the above tlbi operation to be finished
>> 4. free the IOVA resource
>> 5. free the physical memory resource
>>
>> This maybe a problem when unmap is very frequently, the combination of tlbi
>> and wait operation will consume a lot of time. A feasible method is put off
>> tlbi and iova-free operation, when accumulating to a certain number or
>> reaching a specified time, execute only one tlbi_all command to clean up
>> TLB, then free the backup IOVAs. Mark as non-strict mode.
>>
>> But it must be noted that, although the mapping has already been removed in
>> the page table, it maybe still exist in TLB. And the freed physical memory
>> may also be reused for others. So a attacker can persistent access to memory
>> based on the just freed IOVA, to obtain sensible data or corrupt memory. So
>> the VFIO should always choose the strict mode.
>>
>> Some may consider put off physical memory free also, that will still follow
>> strict mode. But for the map_sg cases, the memory allocation is not controlled
>> by IOMMU APIs, so it is not enforceable.
>>
>> Fortunately, Intel and AMD have already applied the non-strict mode, and put
>> queue_iova() operation into the common file dma-iommu.c., and my work is based
>> on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
>> unmap, but Intel and AMD IOMMU drivers are not.
>>
>> Below is the performance data of strict vs non-strict for NVMe device:
>> Randomly Read? IOPS: 146K(strict) vs 573K(non-strict)
>> Randomly Write IOPS: 143K(strict) vs 513K(non-strict)
> 
> What hardware is this on? If it's SMMUv3 without MSIs (e.g. D05), then you'll still be using the rubbish globally-blocking sync implementation. If that is the case, I'd be very interested to see how much there is to gain from just improving that - I've had a patch kicking around for a while[1] (also on a rebased branch at [2]), but don't have the means for serious performance testing.

The hardware is the new D06 which the SMMU with MSIs,
it's not D05 :)

Thanks
Hanjun
