From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 07 Jan 2013 11:13:30 +0200
Subject: [PATCH v2] ARM: PXA27x: fix workaround for AC97 reset
In-Reply-To: <50E9F871.6030105@newsguy.com>
References: <87fw2ebe1i.fsf@free.fr>
 <1357490881-19015-1-git-send-email-grinberg@compulab.co.il>
 <50E9F871.6030105@newsguy.com>
Message-ID: <50EA91BA.6030207@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/13 00:19, Mike Dunn wrote:
> On 01/06/2013 08:48 AM, Igor Grinberg wrote:
>> Fix the workaround to a hardware bug in the AC97 controller of PXA27x.
>> A bug in the controller's warm reset functionality requires that the MFP
>> used by the controller as the AC97_RESET_n line be temporarily
>> reconfigured as a GPIO (AF0) and manually held high for the duration of
>> the warm reset cycle.
>>
>> The workaround was broken long ago by commit fb1bf8cd
>> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset()).
>> The commit above changed the original workaround code in a way that
>> changed the MFP to AF0 (GPIO), but forgot to drive the GPIO high output.
>> This way, the GPIO state was left input (and undriven) and only worked
>> for boards with external pullup on the line.
>>
>> Fix the above breakage by actually configurring the GPIO for output high
>> in case of reset assert and returning it to default state
>> (AF1 - for GPIO95 and AF2 - for GPIO113) in case of reset deassert.
> 
> 
> Hi Igor,
> 
> I pulled patches 2, 3, and 4 from my patch set (patch #1 fixes an unrelated
> problem with ac97 cold reset) and replaced it with this, and warm reset works.
> My pxa270 uses gpio 95 for reset, BTW.  I don't have a platform that uses 113.

Thanks!

> 
> Honestly, I don't understand why it works :)  The pxa27x_assert_ac97reset()
> function calls pxa2xx_mfp_config() with an input direction configuration when it
> switches to gpio (AF0), so I don't see how the line remains an output driven
> high.  I think you tried to explain that in the email exchange, but I'm still
> confused.  I'm looking at __mfp_config_gpio(), and it looks like it's setting
> the GPDR register.

Yeah, I see your concern now...
Probably, we still need a combination of both: like in v1 of my patch,
just without changing the direction to input.

> 
> [..]
> 
> 
>>  
>>  void __init pxa_set_ac97_info(pxa2xx_audio_ops_t *ops)
>>  {
>> -	pxa_register_device(&pxa_device_ac97, ops);
>> +	int err = 0;
>> +
>> +	if (ops && gpio_is_valid(ops->reset_gpio)) {
>> +		err = gpio_request_one(ops->reset_gpio, GPIOF_INIT_HIGH,
>> +				       "ac97 rst");
>> +		if (err)
>> +			pr_err("%s: Failed requesting GPIO%d (ac97 rst): %d",
>> +			       __func__, ops->reset_gpio, err);
>> +	}
>> +
>> +	if (!err)
>> +		pxa_register_device(&pxa_device_ac97, ops);
>>  }
>>  
>>  #ifdef CONFIG_PXA25x
> 
> 
> On further thought, I'm not sure about doing this here.  This file is for all
> pxa's, no?  The gpio only needs to be obtained for pxa270. 

The only problem I can see here, is that the ops->reset_gpio
may be uninitialized ( = 0 ) and that will be a problem as 0 is a valid GPIO,
so there are several options here:
1) Change all the users of pxa_set_ac97_info() that provide non-NULL ops pointer
   to initialize the reset_gpio to -EINVAL (preferable)
2) We can check cpu_is_pxa27x().
3) We can check that provided GPIO is 95 or 113.

> And even in that
> case, the ac97 controller peripheral may not be used if no codec is attached, in
> which case the pins are free to be used for any kind of gpio. 

In such case you should not call pxa_set_ac97_info(), right?

> It might be
> better to have the ac97 driver request the gpio.

Thought about that, but this means we request the GPIO in the driver but
configure it (gpio_direction_out()) in the arch code - this is a bit awkward.

I would go for implementing 1), unless we have no problem requesting the GPIO
in the driver and driving it in the arch code...

-- 
Regards,
Igor.
