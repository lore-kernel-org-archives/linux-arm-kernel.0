From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 26 Jun 2014 13:26:47 +0200
Subject: [PATCH v4 10/14] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <1403777337.27156.19.camel@AMDC1943>
References: <1403723019-6212-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403723019-6212-11-git-send-email-javier.martinez@collabora.co.uk>
 <1403777337.27156.19.camel@AMDC1943>
Message-ID: <53AC0377.40104@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

Thanks a lot for your feedback.

On 06/26/2014 12:08 PM, Krzysztof Kozlowski wrote:
> On ?ro, 2014-06-25 at 21:03 +0200, Javier Martinez Canillas wrote:
>> The MAX77802 PMIC has 10 high-efficiency Buck and 32 Low-dropout
>> (LDO) regulators. This patch adds support for all these regulators
>> found on the MAX77802 PMIC and is based on a driver added by Simon
>> Glass to the Chrome OS kernel 3.8 tree.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>> 
>> Changes since v3:
>>  - Set the supply_name for regulators to lookup their parent supply node.
>>    Suggested by Mark Brown.
>>  - Change Exyno5 for Exynos5420/Exynos5800 in regulator driver Kconfig.
>>    Suggested by Doug Anderson.
>> 
>> Changes since v2:
>>  - Use dev_warn() instead pr_warn(). Suggested by Mark Brown.
>>  - Add a generic function to regmap core to copy registers instead of
>>    having a driver-specific function. Suggested by Mark Brown.
>>  - Remove unnecessary probe debug log. Suggested by Mark Brown.
>>  - Set struct regulator_config dev field to MFD instead of the platform dev.
>>    Suggested by Mark Brown.
>>  - Read the regulators operational mode from the hardware registers instead
>>    of setting to normal as default on probe. Suggested by Mark Brown.
>>  - Remove unnecessary cross-subsystem dependencies. Suggested by Lee Jones.
>> 
>> Changes since v1:
>>  - Remove unneeded check if num_regulators != MAX77802_MAX_REGULATORS.
>>  - Fix .set_suspend_mode handler comment and split regulators ops for
>>    regulators that behave differently. Suggested by Mark Brown.
>>  - Use module_platform_driver() instead of having init/exit functions.
>>    Suggested by Mark Brown.
>>  - Use the new descriptor-based GPIO interface instead of the deprecated
>>    integer based GPIO one. Suggested by Mark Brown.
>>  - Look for "regulators" child node instead of "voltage-regulators" to be
>>    consistent with other PMIC drivers. Suggested by Mark Brown.
> 
> (...)
> 
>> +
>> +#ifdef CONFIG_OF
>> +static int max77802_pmic_dt_parse_pdata(struct platform_device *pdev,
>> +					struct max77802_platform_data *pdata)
>> +{
>> +	struct max77802_dev *iodev = dev_get_drvdata(pdev->dev.parent);
>> +	struct device_node *pmic_np, *regulators_np;
>> +	struct max77802_regulator_data *rdata;
>> +	struct of_regulator_match rmatch;
>> +	unsigned int i;
>> +
>> +	pmic_np = iodev->dev->of_node;
>> +	regulators_np = of_get_child_by_name(pmic_np, "regulators");
>> +	if (!regulators_np) {
>> +		dev_err(&pdev->dev, "could not find regulators sub-node\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pdata->num_regulators = ARRAY_SIZE(regulators);
>> +	rdata = devm_kzalloc(&pdev->dev, sizeof(*rdata) *
>> +			     pdata->num_regulators, GFP_KERNEL);
>> +	if (!rdata) {
>> +		of_node_put(regulators_np);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (i = 0; i < pdata->num_regulators; i++) {
>> +		rmatch.name = regulators[i].name;
>> +		rmatch.init_data = NULL;
>> +		rmatch.of_node = NULL;
>> +		if (of_regulator_match(&pdev->dev, regulators_np, &rmatch,
>> +				       1) != 1) {
>> +			dev_warn(&pdev->dev, "No matching regulator for '%s'\n",
>> +				 rmatch.name);
>> +			continue;
>> +		}
>> +		rdata[i].initdata = rmatch.init_data;
>> +		rdata[i].of_node = rmatch.of_node;
>> +		rdata[i].id = regulators[i].id;
>> +	}
> 
> I think instead of matching one by one you can alternatively match
> everything at once:
> 
> static struct of_regulator_match regulator_matches[] = {
> 	{ .name = "LDO1", },
> 	....
> };
> 
> if (of_regulator_match(&pdev->dev, regulators_np, regulator_matches,
> 			ARRAY_SIZE(regulator_matches)) {
> 
> The code would be smaller although you would have to create an array
> with names of regulators. I'll leave it up to you since I don't have
> preference for it.
>

It's true that the code will be smaller and even more efficient by passing an
array of struct of_regulator_match instad but as you said I'll have to add
yet-another-table with duplicates information that is already present in the
struct regulator_desc regulators[] array.

That's why I prefer the code as it right now since I think that there are just
too many data structures in this driver. But I don't mind to use the other
approach though if you think that it's better.

> Best regards,
> Krzysztof
> 
> 
> 
> 

Best regards,
Javier
