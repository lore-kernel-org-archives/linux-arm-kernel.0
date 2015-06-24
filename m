From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Wed, 24 Jun 2015 09:34:45 +0200
Subject: [RESEND PATCH 1/4] leds: leds-ns2: move LED modes mapping outside
 of the driver
In-Reply-To: <20150623181203.GE4853@kw.sim.vm.gnt>
References: <1434640650-28086-1-git-send-email-simon.guinot@sequanux.org>
 <1434640650-28086-2-git-send-email-simon.guinot@sequanux.org>
 <55881C85.1050809@samsung.com> <20150623181203.GE4853@kw.sim.vm.gnt>
Message-ID: <558A5D95.9040807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 06/23/2015 08:12 PM, Simon Guinot wrote:
[...]
>
>>> +	led = leds;
>>>   	for_each_child_of_node(np, child) {
>>>   		const char *string;
>>> -		int ret;
>>> +		int ret, i, num_modes;
>>> +		struct ns2_led_modval *modval;
>>>
>>>   		ret = of_get_named_gpio(child, "cmd-gpio", 0);
>>>   		if (ret < 0)
>>>   			return ret;
>>> -		leds[i].cmd = ret;
>>> +		led->cmd = ret;
>>>   		ret = of_get_named_gpio(child, "slow-gpio", 0);
>>>   		if (ret < 0)
>>>   			return ret;
>>> -		leds[i].slow = ret;
>>> +		led->slow = ret;
>>>   		ret = of_property_read_string(child, "label", &string);
>>> -		leds[i].name = (ret == 0) ? string : child->name;
>>> +		led->name = (ret == 0) ? string : child->name;
>>>   		ret = of_property_read_string(child, "linux,default-trigger",
>>>   					      &string);
>>>   		if (ret == 0)
>>> -			leds[i].default_trigger = string;
>>> +			led->default_trigger = string;
>>> +
>>> +		ret = of_property_count_u32_elems(child, "modes-map");
>>
>> I think that we shouldn't fail if the property is absent, but default
>> to the mapping that is currently hard coded in the driver. Otherwise
>> we would break existing users.
>
> I don't think there is a risk of breaking existing users. On platforms
> where the leds-ns2 driver is used, DTB will be updated with the kernel
> image. Moreover, removing the hard coded mapping is a nice clean-up.
>
> Let me know if you still want me to add a fallback.

Since you modify also dts file in this patch set this is OK.
You can keep this part as is.

-- 
Best Regards,
Jacek Anaszewski
