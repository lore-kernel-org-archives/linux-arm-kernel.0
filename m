From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 15 Jun 2017 11:30:21 +0100
Subject: [PATCH 09/12] coresight tmc: Add capability information
In-Reply-To: <20170614182251.GE22030@xps15>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-10-git-send-email-suzuki.poulose@arm.com>
 <20170614182251.GE22030@xps15>
Message-ID: <f6440fa4-91e1-773f-8ca9-a5424ba8e672@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/17 19:22, Mathieu Poirier wrote:
> On Mon, Jun 12, 2017 at 03:36:48PM +0100, Suzuki K Poulose wrote:
>> This patch adds description of the capabilities of a given TMC.
>> This will help us to handle different versions of the TMC in the
>> same driver by checking the capabilities.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-tmc.c | 10 +++++++++-
>>  drivers/hwtracing/coresight/coresight-tmc.h | 18 ++++++++++++++++++
>>  2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
>> index 7152656..e88f2f3 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
>> @@ -399,16 +399,24 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>  	ret = misc_register(&drvdata->miscdev);
>>  	if (ret)
>>  		coresight_unregister(drvdata->csdev);
>> +	else if (id->data)
>> +		drvdata->caps = *(struct tmc_caps *)id->data;
>>  out:
>>  	return ret;
>>  }
>>
>> +static struct tmc_caps coresight_soc_400_tmc_caps = {
>> +	.caps = CORESIGHT_SOC_400_TMC_CAPS,
>> +};
>> +
>>  static struct amba_id tmc_ids[] = {
>>  	{
>> +		/* Coresight SoC 400 TMC */
>>  		.id     = 0x000bb961,
>>  		.mask   = 0x000fffff,
>> +		.data	= &coresight_soc_400_tmc_caps,
>
> Do we need this?  I don't see anywhere a check for TMC_CAP_ETR_SG_UNIT.  And
> I also suppose that the SoC600 suite also supports scatter-gather - is there a
> need to differenciate both that may not be implemented in this set?

Yes, the coresight SoC-600 doesn't come with an in built Scatter Gather unit.
Instead there is a dedicated component (Coresight Address Translation UNIT, CATU)
to do the Scatter Gather, which needs a driver. This is to make sure that if
somebody wants to use the SG, they should check it in the caps.


>
> I'm also wondering if capabilities for SoC600 could not be retrieved from HW
> registers rather than hard coded?

Unfortunately, no. There is no hardware description for the feature. So, we need
to depend on the PIDs to detect the features.

>> +#define TMC_CAP_ETR_SG_UNIT			(1U << 0)
>> +
>> +/**
>> + * struct tmc_cap - Describes the capabilities of the TMC.
>> + * @caps:	- Bitmask of the capacities
>> + */
>> +struct tmc_caps {
>> +	u32	caps;
>> +};
>> +
>> +#define CORESIGHT_SOC_400_TMC_CAPS	(TMC_CAP_ETR_SG_UNIT)
>> +
>>  /**
>>   * struct tmc_drvdata - specifics associated to an TMC component
>>   * @base:	memory mapped base address for this component.
>> @@ -110,6 +122,7 @@ struct tmc_drvdata {
>>  	void __iomem		*base;
>>  	struct device		*dev;
>>  	struct coresight_device	*csdev;
>> +	struct tmc_caps		caps;
>
> A simple u32 is probably best here rather than introducing a new structure.  If
> capabilites can't be retrieved from HW and have to be declared statically, a
> *u32 referencing ->data is sufficient rather than copying memory.

I think eventually the compiler may be able to do a register move to copy a 32bit
data. We could potentially add more fields there (e.g, whether a CATU is connected
to the device or not etc). Hence the abstraction.


Suzuki
