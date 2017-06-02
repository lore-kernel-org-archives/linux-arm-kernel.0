From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 2 Jun 2017 11:50:29 +0800
Subject: [PATCH] acpi/iort, numa: Add numa node mapping for smmuv3 devices
In-Reply-To: <20170601162142.GC19003@red-moon>
References: <1496325937-21113-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170601162142.GC19003@red-moon>
Message-ID: <5930E085.8000404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+Cc Lv Zheng]

On 2017/6/2 0:21, Lorenzo Pieralisi wrote:
> On Thu, Jun 01, 2017 at 07:35:37PM +0530, Ganapatrao Kulkarni wrote:
>> ARM IORT specification has provision to define Proximity domain
>> in SMMUv3 IORT table. Adding required code to parse Proximity domain of
>> SMMUv3 IORT table. Parsed Proximity domain is used to set numa_node
>> of SMMUv3 platform devices.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 6 ++++++
>>  include/acpi/actbl2.h       | 4 ++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 69d8506..98c2319 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -2667,6 +2667,12 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
>>  	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
>>  		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>>  
>> +	/* set numa proximity domain for smmv3 device */
>> +	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_PXM) {
>> +		set_dev_node(dev, acpi_map_pxm_to_node(iort_smmu->pxm));
>> +		dev_info(dev, "on NUMA node %d\n", dev_to_node(dev));
> It should be done in acpi/arm64/iort.c at device creation time.

Agreed.

>
>> +	}
>> +
>>  	return 0;
>>  }
>>  #else
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 4b306a6..c16ced8 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -805,6 +805,9 @@ struct acpi_iort_smmu_v3 {
>>  	u32 pri_gsiv;
>>  	u32 gerr_gsiv;
>>  	u32 sync_gsiv;
>> +	u8 pxm;
>> +	u8 reserved1;
>> +	u16 reserved2;

I think changes to actbl2.h need to be split as a new patch
which go via ACPICA updates,  Lv, could you share
your comments here?

Thanks
Hanjun
