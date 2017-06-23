From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 23 Jun 2017 16:15:10 +0100
Subject: [RFC,20/30] iommu/arm-smmu-v3: Enable PCI PASID in masters
In-Reply-To: <fad6510f-922a-550b-0429-bc59f857c307@codeaurora.org>
References: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
 <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
 <fad6510f-922a-550b-0429-bc59f857c307@codeaurora.org>
Message-ID: <f47b89f9-2fee-22d4-9cac-476a20f8e93b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2017 03:39 PM, Sinan Kaya wrote:
> Hi Jean-Philippe,
>  
>> On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
>> Enable PASID for PCI devices that support it.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 63 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 499dc1cd07eb..37fd061405e9 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -730,6 +730,8 @@ struct arm_smmu_master_data {
>>  
>>  	struct arm_smmu_stream		*streams;
>>  	struct rb_root			contexts;
>> +
>> +	u32				avail_contexts;
>>  };
>>  
> 
> According to the PASID ECN here (https://pcisig.com/sites/default/files/specification_documents/ECN-PASID-ATS-2011-03-31.pdf),
> PASID should be enabled only if all switches between the root port and
> a device support TLP prefix. 
>  
> I'm only seeing a call to pci_enable_pasid() in this patch but I don't
> see anybody checking for TLP prefix support on the hierarchy.
> 
> This could potentially be an addition to the PCI core code.

Good point, I think we should inspect bit "End-End TLP Prefix Supported"
in the PCI_EXP_DEVCAP2 capability of all bridges between the endpoint
and the IOMMU. And it should probably be done inside pci_enable_pasid().

Thanks,
Jean
