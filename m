From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 8 Feb 2016 18:13:11 +0530
Subject: [PATCH v2 4/4] iommu/arm-smmu: Add stub of_xlate() operation in
 SMMUv1/SMMUv2 driver
In-Reply-To: <20160208111829.GA13498@leverpostej>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
 <1454908652-15317-5-git-send-email-anup.patel@broadcom.com>
 <20160208111829.GA13498@leverpostej>
Message-ID: <CAALAos94ZHTKF5Gvjt7b56Yq+ZhhSSCN3xLdOWEpRvsrFohW6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2016 at 4:48 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Feb 08, 2016 at 10:47:32AM +0530, Anup Patel wrote:
>> To allow use of large memory (> 4Gb) with 32bit devices we need to use
>> IOMMU based DMA mappings for such 32bit devices. The IOMMU dt-bindings
>> allows us do this by specifying 'iommus' attribute in 32bit device DT
>> node. Unfortunately, specifying 'iommus' attribute does not work with
>> current SMMUv1/SMMUv2 driver because it requires of_xlate() operation
>> to be implemented by the driver.
>>
>> This patch adds a stub implementation of of_xlate() in SMMUv1/SMMUv2
>> driver to allow usage of 'iommus' attribute in DT for 32bit devices.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>  drivers/iommu/arm-smmu.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 02cd67d..8e090d8 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1398,6 +1398,16 @@ static int arm_smmu_init_platform_device(struct device *dev,
>>       return 0;
>>  }
>>
>> +int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>> +{
>> +     /*
>> +      * Nothing to do here because SMMU is already aware of all
>> +      * MMU masters and their stream IDs using mmu-master attibute
>> +      * SMMU DT node.
>> +      */
>> +     return 0;
>> +}
>
> NAK to this.

I had no intention in continuing this change if I knew some work
on generic IOMMU binding was in-progress. In fact, I had asked
about alternate options previously. (Refer,
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/403128.html)

>
> As previously mentioned by others [1], this is an abuse of the generic
> iommu binding support code.
>
> The SMMU binding currently does not define its implementation of the
> generic IOMMU binding. This series did not define what an SMMU's
> #iommu-cells would be nor what the contained values would represent.
> Therefore it is not valid to use an SMMU node with an iommus property as
> the SMMu doesn't follwo the generic IOMMU binding.
>
> There is ongoing work to have generic iommu binding support for the
> SMMU. In the absence of documentation for what this means for the
> binding, I am worried that this hack harms that effort.

Thanks for the info, I would like to try this on Broadcom SoCs.

Whats the ETA of patches for generic IOMMU binding for SMMU?

>
> To use features of the generic IOMMU binding, we must properly implement
> the generic IOMMU binding for the SMMU rather than bodging it onto the
> side of the existing binding.
>
> Thanks,
> Mark.
>

Regards,
Anup
