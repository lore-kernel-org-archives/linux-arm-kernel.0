From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Thu, 19 Oct 2017 11:00:45 +0800
Subject: [PATCH v2 1/3] iommu/arm-smmu-v3: put off the execution of TLBI*
 to reduce lock confliction
In-Reply-To: <20171018125849.GD4077@arm.com>
References: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
 <1505221238-9428-2-git-send-email-thunder.leizhen@huawei.com>
 <20171018125849.GD4077@arm.com>
Message-ID: <59E8155D.2070102@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/10/18 20:58, Will Deacon wrote:
> Hi Thunder,
> 
> On Tue, Sep 12, 2017 at 09:00:36PM +0800, Zhen Lei wrote:
>> Because all TLBI commands should be followed by a SYNC command, to make
>> sure that it has been completely finished. So we can just add the TLBI
>> commands into the queue, and put off the execution until meet SYNC or
>> other commands. To prevent the followed SYNC command waiting for a long
>> time because of too many commands have been delayed, restrict the max
>> delayed number.
>>
>> According to my test, I got the same performance data as I replaced writel
>> with writel_relaxed in queue_inc_prod.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 42 +++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> If we want to go down the route of explicit command batching, I'd much
> rather do it by implementing the iotlb_range_add callback in the driver,
> and have a fixed-length array of batched ranges on the domain. We could
I think even if iotlb_range_add callback is implemented, this patch is still valuable. The main purpose
of this patch is to reduce dsb operation. So in the scenario with iotlb_range_add implemented:
.iotlb_range_add:
spin_lock_irqsave(&smmu->cmdq.lock, flags);
...
add tlbi range-1 to cmq-queue
...
add tlbi range-n to cmq-queue			//n
dsb
...
spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

.iotlb_sync
spin_lock_irqsave(&smmu->cmdq.lock, flags);
...
add cmd_sync to cmq-queue
dsb
...
spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

Although iotlb_range_add can reduce n-1 dsb operations, but there are still 1 left. If n is not large enough,
this patch is helpful.


> potentially toggle this function pointer based on the compatible string too,
> if it shows only to benefit some systems.
[
On 2017/9/19 12:31, Nate Watterson wrote:
I tested these (2) patches on QDF2400 hardware and saw performance
improvements in line with those I reported when testing the original
series.
]

I'm not sure whether this patch can improve performance on QDF2400, because there are two patches. But at least
it seems harmless, maybe the other hardware platforms are the same.

> 
> Will
> 
> .
> 

-- 
Thanks!
BestRegards
