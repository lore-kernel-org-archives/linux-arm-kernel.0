From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Fri, 05 Sep 2014 10:18:48 +0530
Subject: [PATCH] pinctrl: st: Add remove function and remove gpio_chip
 on failure
In-Reply-To: <5408AA8C.7040100@linaro.org>
References: <1409409935-8775-1-git-send-email-pramod.gurav@smartplayin.com>
 <5408AA8C.7040100@linaro.org>
Message-ID: <540940B0.5090000@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

Thanks for review.

On 04-09-2014 11:38 PM, Srinivas Kandagatla wrote:
> Pramod,
> sorry for delay in reply as I was travelling, still in Jet lag.
>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>> ---
>>   drivers/pinctrl/pinctrl-st.c |   25 +++++++++++++++++++++++++
>>   1 files changed, 25 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
>> index 5475374..9296845 100644
>> --- a/drivers/pinctrl/pinctrl-st.c
>> +++ b/drivers/pinctrl/pinctrl-st.c
>> @@ -1517,6 +1517,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
>>   					   0, handle_simple_irq,
>>   					   IRQ_TYPE_LEVEL_LOW);
>>   		if (err) {
>> +			gpiochip_remove(&bank->gpio_chip);
> This change-set looks good.
> IMO, you can send a patch for this change set.
Will resend just this.

> 
>>   			dev_info(dev, "could not add irqchip\n");
>>   			return err;
>>   		}
>> @@ -1685,6 +1686,29 @@ static int st_pctl_probe(struct platform_device *pdev)
>>   	return 0;
>>   }
>>
> 
>> +static int st_pctl_remove(struct platform_device *pdev)
>> +{
> Ideally this driver will not be removed, as other drivers depend on 
> this, even the serial.
> 
> so I see no big achievement in adding the remove functionality, as this 
> is going to be a dead code and would never be tested.
> 
>> +	struct st_pinctrl *info = platform_get_drvdata(pdev);
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct device_node *child;
>> +	struct gpio_chip gpio_chip;
>> +	int bank = 0;
>> +
> 
>> +	if (info->nbanks) {
>> +		for_each_child_of_node(np, child) {
>> +			if (of_property_read_bool(child, "gpio-controller")) {
> We should not re-parse the DT nodes once we are done with it in the probe.
Thanks. :)
> 
>> +				gpio_chip = info->banks[bank].gpio_chip;
>> +				gpiochip_remove(&gpio_chip);
>> +				bank++;
>> +			}
>> +		}
>> +	}
>> +
> 
> I think the logic is very simple:
> 
> 	while (nbanks--)
> 		gpiochip_remove(&info->banks[bank++].gpio_chip))
Thanks again. Remove is not needed hence will not do this. But good know.
> 
> 
> thanks,
> srini
>> +	pinctrl_unregister(info->pctl);
>> +
>> +	return 0;
>> +}
>> +
>>   static struct platform_driver st_pctl_driver = {
>>   	.driver = {
>>   		.name = "st-pinctrl",
>> @@ -1692,6 +1716,7 @@ static struct platform_driver st_pctl_driver = {
>>   		.of_match_table = st_pctl_of_match,
>>   	},
>>   	.probe = st_pctl_probe,
>> +	.remove = st_pctl_remove,
>>   };
>>
>>   static int __init st_pctl_init(void)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
