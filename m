From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 14 Mar 2018 13:10:01 +0000
Subject: [PATCH 35/37] iommu/arm-smmu-v3: Add support for PRI
In-Reply-To: <20180308172436.00006554@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-36-jean-philippe.brucker@arm.com>
 <20180308172436.00006554@huawei.com>
Message-ID: <2c3c608c-266c-b01f-819f-0c04d3d282f6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/18 16:24, Jonathan Cameron wrote:
> On Mon, 12 Feb 2018 18:33:50 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> For PCI devices that support it, enable the PRI capability and handle
>> PRI Page Requests with the generic fault handler.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> A couple of nitpicks.
> 
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 174 ++++++++++++++++++++++++++++++--------------
>>  1 file changed, 119 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 8d09615fab35..ace2f995b0c0 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -271,6 +271,7 @@
>>  #define STRTAB_STE_1_S1COR_SHIFT	4
>>  #define STRTAB_STE_1_S1CSH_SHIFT	6
>>  
>> +#define STRTAB_STE_1_PPAR		(1UL << 18)
>>  #define STRTAB_STE_1_S1STALLD		(1UL << 27)
>>  
>>  #define STRTAB_STE_1_EATS_ABT		0UL
>> @@ -346,9 +347,9 @@
>>  #define CMDQ_PRI_1_GRPID_SHIFT		0
>>  #define CMDQ_PRI_1_GRPID_MASK		0x1ffUL
>>  #define CMDQ_PRI_1_RESP_SHIFT		12
>> -#define CMDQ_PRI_1_RESP_DENY		(0UL << CMDQ_PRI_1_RESP_SHIFT)
>> -#define CMDQ_PRI_1_RESP_FAIL		(1UL << CMDQ_PRI_1_RESP_SHIFT)
>> -#define CMDQ_PRI_1_RESP_SUCC		(2UL << CMDQ_PRI_1_RESP_SHIFT)
>> +#define CMDQ_PRI_1_RESP_FAILURE		(0UL << CMDQ_PRI_1_RESP_SHIFT)
>> +#define CMDQ_PRI_1_RESP_INVALID		(1UL << CMDQ_PRI_1_RESP_SHIFT)
>> +#define CMDQ_PRI_1_RESP_SUCCESS		(2UL << CMDQ_PRI_1_RESP_SHIFT)
> Mixing fixing up this naming with the rest of the patch does make things a
> little harder to read than they would have been if done as separate patches.
> Worth splitting?

ok

[...]
> 
> The function ordering gets a bit random as you add all the new ones,
> Might be better to keep each disable following each enable.

Agreed

Thanks,
Jean
