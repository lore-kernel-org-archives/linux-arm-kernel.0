From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Fri, 13 Jul 2018 09:48:06 +0800
Subject: [PATCH 1/1] iommu/arm-smmu-v3: prevent any devices access to
 memory without registration
In-Reply-To: <20180712170120.GC26935@arm.com>
References: <1531387723-3592-1-git-send-email-thunder.leizhen@huawei.com>
 <20180712170120.GC26935@arm.com>
Message-ID: <5B4804D6.4050508@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/7/13 1:01, Will Deacon wrote:
> On Thu, Jul 12, 2018 at 05:28:43PM +0800, Zhen Lei wrote:
>> Stream bypass is not security. A malicious device can be hot plugged
>> without match any drivers, but it can access to any memory. So change to
>> disable bypass by default.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Whilst this sounds nice, I *bet* you it will break some systems. In
> particular, those where the SMMU is described but the toplogical information
> is either incorrect or incomplete.

Suppose this scene exists, maybe we should consider updating IORT specification,
to indicate whether a smmu treats all unregistered devices as stream bypass or not, --- global control
to indicate whether a single device default use stream bypass or not, --- local control
that will be more flexible. But we still disable bypass by default.

> 
> I guess we could put it into next and see if anybody complains. What do
> others think?
> 
> Will
> 
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 1d64710..b0ec28d 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -366,7 +366,7 @@
>>  #define MSI_IOVA_BASE			0x8000000
>>  #define MSI_IOVA_LENGTH			0x100000
>>
>> -static bool disable_bypass;
>> +static bool disable_bypass = 1;
>>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>>  MODULE_PARM_DESC(disable_bypass,
>>  	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
>> --
>> 1.8.3
>>
>>
> 
> .
> 

-- 
Thanks!
BestRegards
