From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 1 Jul 2016 14:05:58 +0100
Subject: [PATCH v3 8/9] iommu/arm-smmu: Support non-PCI devices with SMMUv3
In-Reply-To: <20160701124036.GK12735@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
 <19b0d973e170bebfa57157047bf76499de2a6d33.1467123945.git.robin.murphy@arm.com>
 <20160701124036.GK12735@arm.com>
Message-ID: <57766AB6.6030706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/16 13:40, Will Deacon wrote:
> On Tue, Jun 28, 2016 at 04:48:27PM +0100, Robin Murphy wrote:
>> With the device <-> stream ID relationship suitably abstracted and
>> of_xlate() hooked up, the PCI dependency now looks, and is, entirely
>> arbitrary. Any bus using the of_dma_configure() mechanism will work,
>> so extend support to the platform and AMBA buses which do just that.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v3: Now actually tested; improve comment about duplicate IDs.
>>
>>  drivers/iommu/Kconfig       |  2 +-
>>  drivers/iommu/arm-smmu-v3.c | 42 ++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index ad0860383cb3..d1c66afefeed 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -308,7 +308,7 @@ config ARM_SMMU
>>  
>>  config ARM_SMMU_V3
>>  	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>> -	depends on ARM64 && PCI
>> +	depends on ARM64
>>  	select IOMMU_API
>>  	select IOMMU_IO_PGTABLE_LPAE
>>  	select GENERIC_MSI_IRQ_DOMAIN
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 8ce2a4f9342b..735690e03818 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -35,6 +35,8 @@
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>>  
>> +#include <linux/amba/bus.h>
>> +
>>  #include "io-pgtable.h"
>>  
>>  /* MMIO registers */
>> @@ -1822,6 +1824,25 @@ static void arm_smmu_remove_device(struct device *dev)
>>  	iommu_fwspec_free(dev);
>>  }
>>  
>> +static struct iommu_group *arm_smmu_device_group(struct device *dev)
>> +{
>> +	struct iommu_group *group;
>> +
>> +	/*
>> +	 * The difficulty of efficient stream-ID-to-device lookup prevents us
>> +	 * from reasonably detecting aliasing outside of PCI buses, but for the
>> +	 * the same underlying reason (a sparse 32-bit ID space) there's also
> 
> extra 'the'

Oops, thanks.

>> +	 * little excuse for systems to be wired up with non-unique IDs in the
>> +	 * first place; consider them unsupported.
>> +	 */
> 
> This is a long-winded way of saying "we don't support aliasing SIDs outside
> of PCI".

It is. Someone said of the original terse 2-line comment "Worse: what if
a SID in the DT aliases with a PCI master? It might be nice to have some
basic sanity checking, at least.", so I expanded it to better clarify
why there isn't. I'll try making it a little less florid.

Robin.

> 
> Will
> 
