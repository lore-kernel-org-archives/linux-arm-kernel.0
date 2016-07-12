From: van.freenix@gmail.com (Peng Fan)
Date: Tue, 12 Jul 2016 09:24:15 +0800
Subject: [PATCH] iommu: arm-smmu: use devm_request_irq and devm_free_irq
In-Reply-To: <578375D7.7090609@arm.com>
References: <1467625102-9755-1-git-send-email-van.freenix@gmail.com>
 <578375D7.7090609@arm.com>
Message-ID: <20160712012412.GA11832@linux-7smt.suse>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,
On Mon, Jul 11, 2016 at 11:32:55AM +0100, Robin Murphy wrote:
>On 04/07/16 10:38, Peng Fan wrote:
>> Use devm_request_irq to simplify error handling path,
>> when probe smmu device.
>> 
>> Also devm_{request|free}_irq when init or destroy domain context.
>> 
>> Signed-off-by: Peng Fan <van.freenix@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> ---
>[...]
>> @@ -2050,7 +2046,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>  		dev_err(dev, "removing device with active domains!\n");
>>  
>>  	for (i = 0; i < smmu->num_global_irqs; ++i)
>> -		free_irq(smmu->irqs[i], smmu);
>> +		devm_free_irq(smmu->dev, smmu->irqs[i], smmu);
>
>There shouldn't be any need for this at all, since the very next thing
>called after drv->remove() is devres_release_all().

Thanks for comments. I'll fix this with a new patch.

Thanks,
Peng.

>
>Robin.
>
>>  
>>  	/* Turn the thing off */
>>  	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> 
>
