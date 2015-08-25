From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 25 Aug 2015 11:53:44 +0530
Subject: [PATCH-v3 2/2] regulator: 88pm800: Add support for configuration
 of dual phase on BUCK1
In-Reply-To: <55DBF3B9.4060602@samsung.com>
References: <1440420006-31556-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440420006-31556-3-git-send-email-vaibhav.hiremath@linaro.org>
 <55DBF3B9.4060602@samsung.com>
Message-ID: <55DC09F0.6010109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 25 August 2015 10:18 AM, Krzysztof Kozlowski wrote:
> On 24.08.2015 21:40, Vaibhav Hiremath wrote:
>> 88PM860 device supports dual phase mode on BUCK1 output.
>> In normal usecase, BUCK1A and BUCK1B operates independently with 3A
>> capacity. And they both can work as a dual phase providing 6A capacity.
>>
>> This patch updates the regulator driver to read the respective
>> DT property and enable dual-phase mode on BUCK1.
>> Note that if dual phase mode is enabled, then BUCK1B will not be
>> registered to the regulator framework and the current capacity of
>> BUCK1(A) would be set to 6A [3A of BUCK1A + 3A of BUCK1B].
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/regulator/88pm800.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/88pm80x.h |  3 +++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
>> index 365a154..7aca6d17 100644
>> --- a/drivers/regulator/88pm800.c
>> +++ b/drivers/regulator/88pm800.c
>> @@ -267,6 +267,37 @@ static struct pm800_regulator_info pm860_regulator_info[] = {
>>   	PM800_LDO(ldo20, LDO20, LDO_ENA1_3, 3, 10000, ldo_volt_table2),
>>   };
>>
>> +static int pm800_regulator_init(struct platform_device *pdev,
>> +		struct pm800_regulator_info *info)
>> +{
>> +	struct pm800_regulators *pm800_data = platform_get_drvdata(pdev);
>> +	struct pm80x_chip *chip = pm800_data->chip;
>> +	int ret = 0;
>> +
>> +	/* Currently only supported on 88pm860 device */
>> +	if (chip->type != CHIP_PM860)
>> +		return 0;
>> +
>> +	if (of_property_read_bool(pdev->dev.of_node,
>> +				"marvell,88pm860-buck1-dualphase-en")) {
>> +		/* Update the constraint  to [3A (BUCK1A) + 3A (BUCK1B)] */
>> +		info[PM800_ID_BUCK1].max_ua = 6000000;
>> +		/* Remove BUCK1B from the list, as we are in dual phase mode */
>> +		memset(&info[PM800_ID_BUCK1B], 0, sizeof(*info));
>> +		/* Enable dual phase mode */
>> +		ret = regmap_update_bits(chip->subchip->regmap_power,
>> +					PM860_BUCK1_MISC,
>> +					BUCK1_DUAL_PHASE_SEL,
>> +					BUCK1_DUAL_PHASE_SEL);
>> +		if (ret) {
>> +			dev_err(chip->dev, "failed to set dual-pase mode %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static int pm800_regulator_probe(struct platform_device *pdev)
>>   {
>>   	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
>> @@ -311,11 +342,20 @@ static int pm800_regulator_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>
>> +	ret = pm800_regulator_init(pdev, info);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to init 88pm800 regulator device\n");
>> +		return ret;
>> +	}
>> +
>>   	config.dev = chip->dev;
>>   	config.regmap = pm800_data->map;
>>   	for (i = 0; i < PM800_ID_RG_MAX; i++) {
>>   		struct regulator_dev *regulator;
>>
>> +		if (!info[i].desc.name)
>> +			continue;
>
> How the driver was working without this on 88PM800? There is a gap in
> pm800_regulator_info - three regulators are not set.
>

I have 88PM860 based board, where the whole array will be filled up.
So it was missed I guess :)

But when I introduced logic for skipping BUCK1B, I hit this.
And here is the fix.


> The patch itself looks good
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Thanks for your review.

Thanks,
Vaibhav
