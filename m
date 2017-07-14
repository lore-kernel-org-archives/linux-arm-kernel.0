From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 14 Jul 2017 12:17:23 -0500
Subject: [PATCH 1/2] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <20170714171148.GH22780@codeaurora.org>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-2-git-send-email-timur@codeaurora.org>
 <20170714171148.GH22780@codeaurora.org>
Message-ID: <6ca041fa-533d-6c6b-8c77-4c079cb7e9f6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2017 12:11 PM, Stephen Boyd wrote:

>> +/*
>> + * Request a GPIO. If the number of pins for this GPIO group is zero,
>> + * then assume that the GPIO is unavailable.
>> + */
>> +static int msm_request(struct pinctrl_dev *pctldev, unsigned int offset)
> 
> These names are awful. Reminds me of the serial driver that has
> functions like msm_reset(). But when in Rome this is how it goes
> I suppose.

I can change it to msm_pinctrl_request().

>> @@ -430,6 +445,14 @@ static int msm_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
>>   
>>   	g = &pctrl->soc->groups[offset];
>>   
>> +	/*
>> +	 * If the GPIO is unavailable, just return error.  This is necessary
>> +	 * because the GPIO layer tries to initialize the direction of all
>> +	 * the GPIOs, even the ones that are unavailable.
>> +	 */
>> +	if (!g->npins)
>> +		return -ENODEV;
>> +
> 
> gpiochips also have a request() hook. Can we use that before
> initializing direction to make sure the GPIO is accessible?

I'll try that.

>>   static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>> @@ -511,10 +539,8 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>>   	unsigned gpio = chip->base;
>>   	unsigned i;
>>   
>> -	for (i = 0; i < chip->ngpio; i++, gpio++) {
>> +	for (i = 0; i < chip->ngpio; i++, gpio++)
>>   		msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
>> -		seq_puts(s, "\n");
>> -	}
>>   }
> 
> Were these two hunks necessary? Looks like noise.

Yes, because otherwise there will be a whole bunch of blank lines for 
hidden GPIOs.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
