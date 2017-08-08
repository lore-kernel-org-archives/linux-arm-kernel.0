From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 8 Aug 2017 13:14:18 +0100
Subject: [PATCH 2/2] iommu/arm-smmu: Add system PM support
In-Reply-To: <20170808111816.GD13355@arm.com>
References: <71247263f4d88e7776f483fb1cc1139b516c0835.1500381551.git.robin.murphy@arm.com>
 <d8d6f3b606ed05d53b47d36e1c6a7f4b74eb3afc.1500381551.git.robin.murphy@arm.com>
 <20170808111816.GD13355@arm.com>
Message-ID: <7d0d846b-8ada-6514-ec27-22f4d8487014@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/17 12:18, Will Deacon wrote:
> On Tue, Jul 18, 2017 at 01:44:42PM +0100, Robin Murphy wrote:
>> With all our hardware state tracked in such a way that we can naturally
>> restore it as part of the necessary reset, resuming is trivial, and
>> there's nothing to do on suspend at all.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 86897b7b81d8..0f5f06e9abfa 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -2356,10 +2356,22 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>> +{
> 
> Did you actually get a warning here without the __maybe_unused annotation?
> It looks like some other drivers just guard the thing with CONFIG_PM_SLEEP.

I'm under the impression that the annotation is preferred over #ifdefs
for new code (for the sake of coverage, I guess).

>> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +	arm_smmu_device_reset(smmu);
>> +	return 0;
>> +}
>> +
>> +
>> +static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>> +
>>  static struct platform_driver arm_smmu_driver = {
>>  	.driver	= {
>>  		.name		= "arm-smmu",
>>  		.of_match_table	= of_match_ptr(arm_smmu_of_match),
>> +		.pm = &arm_smmu_pm_ops,
> 
> Cosmetic: can you tab-align this assignment please?

Oops, I missed that - will do.

Robin.
