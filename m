From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 19 Feb 2016 08:44:20 +0530
Subject: [PATCH v2 2/4] iommu/arm-smmu: Invoke DT probe from
 arm_smmu_of_setup()
In-Reply-To: <001f01d16a43$ef47d3b0$cdd77b10$@codeaurora.org>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
 <1454908652-15317-3-git-send-email-anup.patel@broadcom.com>
 <001f01d16a43$ef47d3b0$cdd77b10$@codeaurora.org>
Message-ID: <CAALAos-62Oo8KxODCvkLto5yeKfaTaXKfdrfVUz8nEmTb2p68Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 5:30 PM, Sricharan <sricharan@codeaurora.org> wrote:
> Hi,
>
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Anup Patel
>> Sent: Monday, February 08, 2016 10:48 AM
>> To: Catalin Marinas; Joerg Roedel; Will Deacon; Robin Murphy; Sricharan R;
>> Linux IOMMU; Linux ARM Kernel
>> Cc: Mark Rutland; Device Tree; Scott Branden; Pawel Moll; Ian Campbell;
> Ray
>> Jui; Linux Kernel; Vikram Prakash; Rob Herring; BCM Kernel Feedback; Kumar
>> Gala; Anup Patel
>> Subject: [PATCH v2 2/4] iommu/arm-smmu: Invoke DT probe from
>> arm_smmu_of_setup()
>>
>> The SMMUv1/SMMUv2 driver is initialized very early using the
>> IOMMU_OF_DECLARE() but the actual platform device is probed via normal
>> DT probing.
>>
>> This patch uses of_platform_device_create() from arm_smmu_of_setup() to
>> ensure that SMMU platform device is probed immediately.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> ---
>>  drivers/iommu/arm-smmu.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
>> 2c8f871..02cd67d 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -40,6 +40,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_iommu.h>
>> +#include <linux/of_platform.h>
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>> @@ -1956,10 +1957,15 @@ static int __init arm_smmu_init(void)
>>
>>  static int __init arm_smmu_of_setup(struct device_node *np)  {
>> +     struct platform_device *pdev;
>>
>>       if (!init_done)
>>               arm_smmu_init();
>>
>> +     pdev = of_platform_device_create(np, NULL, NULL);
>> +     if (IS_ERR(pdev))
>> +             return PTR_ERR(pdev);
>> +
>>       of_iommu_set_ops(np, &arm_smmu_ops);
>
>  A question here is,  There was a probe deferral series [1], to take care of
> deferred
>  probing of devices behind iommus. With that this sort of early device
> probing during setup
>  should not be required and also it clears other dependencies of iommus on
> clocks, etc, if any.
>  My intention was to check whats the right way to do this  ? (or) point me
> to any updates
>  on the probe deferral series that I miss ?
>
> [1]  http://lkml.iu.edu/hypermail/linux/kernel/1505.3/03280.html

I think probe deferral is better way of handling this. I will drop this
patch.

Thanks,
Anup
