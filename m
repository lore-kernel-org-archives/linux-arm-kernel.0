From: syin@broadcom.com (Sherman Yin)
Date: Fri, 26 Apr 2013 22:02:47 +0000
Subject: [PATCH] ARM: Adds pin config API to set all configs in one
 function
In-Reply-To: <CACRpkdbT7f8ujCHZxKg26iMKcrAb+_yHW_2YsZwkoo892rkgTA@mail.gmail.com>
References: <1366841010-2823-1-git-send-email-syin@broadcom.com>
 <CACRpkdbT7f8ujCHZxKg26iMKcrAb+_yHW_2YsZwkoo892rkgTA@mail.gmail.com>
Message-ID: <051069C10411E24D9749790C498526FA1BCF5427@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> We discussed this already at the creation of the pinctrl framework.
> 
> What you should do is to add an optional pin_config_set_complete()
> and pin_config_group_set_complete()
> callback that is called after the framework has iterated over all
> configs.

Perhaps I have misunderstood you previously, as I thought you are ok with letting
the driver take care of the loop.  The difference being instead of just moving the for 
loop inside the driver's pin_config_set(), I followed Stephen's suggestion due to
concern about drivers duplicating the loop:  
(quote again here since I didn't send to the mail list last time)

[quote]

>>>>> pin_config_set() is called for each element of the array, one at a time:
>>>>>
>>>>> 328int pinconf_apply_setting(struct pinctrl_setting const *setting)
>>>>> ...
>>>>> 345             for (i = 0; i < setting->data.configs.num_configs; i++) {
>>>>> 346                     ret = ops->pin_config_set(pctldev,
>>>>> 347                                     setting->data.configs.group_or_pin,
>>>>> 348                                     setting->data.configs.configs[i]);
>>>>>
>>>>> Wouldn't it be more flexible if the for loop is moved inside the custom
>>>>> pin_config_set() function, and the core code pass in the whole
>>>>> configs[] array and num_configs?  This allows the driver to possibly
>>>>> combine different configs and make less write() calls to the registers.
>>>>
>>>> What you are saying is making a lot of sense.
>>>>
>>>> And I even think I have that problem where the batch of writes
>>>> may cause spurious IRQs that can be suppressed by disabling
>>>> IRQs in the driver when processing a queue of configs.
>>>>
>>>> Stephen what do you think?
>>>>
>>>> Sherman, would you be interested in writing a patch for this?
>>>>
>>>> You would have to patch all current users of the interface in
>>>> the same patch.
>>>>
>>>> You could actually provide a static inline helper to iterate over
>>>> the array to make it hard to do mistakes.
>>>
>>> I can see that applying all the configs at once might be useful.
>>>
>>> However, I don't think it makes sense to force all the drivers to
>>> iterate over all the configs themselves; that would just be duplicating
>>> the for loop in many drivers without any purpose.
>>>
>>> Instead, perhaps add a new "set_configs" operation in the driver
>>> structure. The core can call set_configs once if exists, and if not, the
>>> core can loop over each individual config and call the existing
>>> set_config function. This is just like the set_function operation, which
>>> can either be called once on a group, or once per pin, by the core.
>>
>> I don't mind writing the patch, once we agree on the method.  I can't test 
>> the other platforms though.
>>
>> Stephen, I'm not quite sure about duplicating the for loop - I was thinking 
>> just to remove the for loop in pinconf_apply_setting() and add the loop in 
>> the driver-defined function, so in the end there is still only 1 for loop.   
>> Functionally it shouldn't affect existing drivers, but it gives new drivers 
>> an opportunity to optimize based on their register design.
>
>I understand, but this forces all drivers to implement the loop
>themselves, and hence causes duplication. By making the new feature
>optional, you avoid that except where it's useful.
>
>But I suppose the loop itself is pretty small either way.

[/quote]

> This way the responsibility to resolve the sequence of config
> calls and validate the validity of that sequence is pushed down
> to the driver, it may do this incrementally or at pin_config_set_complete()
> and then write the resulting config to the hardware as an
> effect of pin_config_set_complete().

Please correctly if I'm wrong, but I think with the functions in my patch, the 
driver still have full control of / responsibility to resolve config sequence 
and perform validation.  The difference is instead of feeding the driver one 
config at time and telling it to write when the complete() function is called, 
my patch just gives the driver all configs in one call and expects the driver 
to parse, validate and write accordingly. 

> The driver takes care of caching intermediate settings for the pin
> until the complete() callback is called.
> Can you devise a patch like this instead?

I do have some concerns about the driver caching all the configs until complete()
is called...  I'm ok either way as long as it provides a way to consolidate pin config register 
writes.  Just want to clarify things with you before I go ahead and modify
my patch and driver.

> I am also very hesitant to merge this if there is no code using
> it, i.e. if you don't have a corresponding driver to submit
> at the same time, it will not be merged, as I don't like to
> maintain dead code.

I do plan to upstream a pinctrl driver that makes use of the new function, so I can make
this patch (or one that implements the pin_config_set_complete()) part of that commit.

Regards,
Sherman
