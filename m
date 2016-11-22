From: frowand.list@gmail.com (Frank Rowand)
Date: Tue, 22 Nov 2016 10:21:44 -0800
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <800171a8-2e2c-2afb-f96d-800a17eaa17a@ti.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
 <a309a738-7fa7-3aab-4457-f7d693e6b37f@ti.com> <5833A2DA.40701@gmail.com>
 <800171a8-2e2c-2afb-f96d-800a17eaa17a@ti.com>
Message-ID: <58348CB8.7050304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/16 22:25, Sekhar Nori wrote:
> Hi Frank,
> 
> On Tuesday 22 November 2016 07:13 AM, Frank Rowand wrote:
>> On 11/21/16 08:33, Sekhar Nori wrote:
>>> On Monday 31 October 2016 08:15 PM, Bartosz Golaszewski wrote:
>>>> +static int da8xx_ddrctl_probe(struct platform_device *pdev)
>>>> +{
>>>> +	const struct da8xx_ddrctl_config_knob *knob;
>>>> +	const struct da8xx_ddrctl_setting *setting;
>>>> +	struct device_node *node;
>>>> +	struct resource *res;
>>>> +	void __iomem *ddrctl;
>>>> +	struct device *dev;
>>>> +	u32 reg;
>>>> +
>>>> +	dev = &pdev->dev;
>>>> +	node = dev->of_node;
>>>> +
>>>> +	setting = da8xx_ddrctl_get_board_settings();
>>>> +	if (!setting) {
>>>> +		dev_err(dev, "no settings for board '%s'\n",
>>>> +			of_flat_dt_get_machine_name());
>>>> +		return -EINVAL;
>>>> +	}
>>>
>>> This causes a section mismatch because of_flat_dt_get_machine_name() 
>>> has an __init annotation. I did not notice that before, sorry.
>>>
>>> It can be fixed with a patch like below:
>>>
>>> ---8<---
>>> diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
>>> index a20e7bbbcbe0..9ca5aab3ac54 100644
>>> --- a/drivers/memory/da8xx-ddrctl.c
>>> +++ b/drivers/memory/da8xx-ddrctl.c
>>> @@ -102,6 +102,18 @@ static const struct da8xx_ddrctl_setting *da8xx_ddrctl_get_board_settings(void)
>>>  	return NULL;
>>>  }
>>>  
>>> +static const char* da8xx_ddrctl_get_machine_name(void)
>>> +{
>>> +	const char *str;
>>> +	int ret;
>>> +
>>> +	ret = of_property_read_string(of_root, "model", &str);
>>> +	if (ret)
>>> +		ret = of_property_read_string(of_root, "compatible", &str);
>>> +
>>> +	return str;
>>> +}
>>> +
>>>  static int da8xx_ddrctl_probe(struct platform_device *pdev)
>>>  {
>>>  	const struct da8xx_ddrctl_config_knob *knob;
>>> @@ -118,7 +130,7 @@ static int da8xx_ddrctl_probe(struct platform_device *pdev)
>>>  	setting = da8xx_ddrctl_get_board_settings();
>>>  	if (!setting) {
>>>  		dev_err(dev, "no settings for board '%s'\n",
>>> -			of_flat_dt_get_machine_name());
>>
>> da8xx_ddrctl_get_board_settings() tries to match based on the "compatible"
>> property in the root node.  The "model" property in the root node has
>> nothing to do with the failure to match. So creating and then using
>> da8xx_ddrctl_get_machine_name() to potentially report model is not useful.
>>
>> It should be sufficient to simply report that no compatible matched.
> 
> I agree with you on this. Even if model name is printed, you will have
> to go back and check the compatible anyway. But I think it will be
> useful to print the compatible instead of just reporting that nothing
> matched.
> 
> Bartosz, if you agree too, could you send a fix patch just printing the
> compatible?

Please note that the compatible property might contain several strings, not just
a single string.

> 
> Thanks,
> Sekhar
> 
