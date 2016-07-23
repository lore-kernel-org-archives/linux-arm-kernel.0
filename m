From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 23 Jul 2016 07:43:10 +0200
Subject: ADS1118: hwmon or iio ? [was: Re: [RCF 1/3] hwmon: Add ads1118
 driver]
In-Reply-To: <5792C64A.3090600@roeck-us.net>
References: <cover.1468626668.git.stillcompiling@gmail.com>
 <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
 <578990A1.6020300@roeck-us.net> <5792301A.6030206@gmail.com>
 <5792C64A.3090600@roeck-us.net>
Message-ID: <270ea0df-0972-6ec5-5f21-fb41cce29f11@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/16 03:20, Guenter Roeck wrote:
> On 07/22/2016 07:39 AM, Joshua Clayton wrote:
>> Greetings Guenter,
>>
>> Thank you for reviewing my submission.
>>
>> On 07/15/2016 06:40 PM, Guenter Roeck wrote:
>>> On 07/15/2016 05:18 PM, Joshua Clayton wrote:
>>>> Add new driver for Texas Instruments ADS1118 and and ADS1018.
>>>> This driver works with ADS1018, because of code borrowed
>>>> from asd1015, which is similar, but I can only test ADS1118
>>>>
>>>
>>> Browsing through the datasheet, I think this should probably be implemented
>>> as iio driver (and iio already has a driver for ads1015).
>>>
>>> Jonathan, what do you think ?
>>>
>>> Thanks,
>>> Guenter
>>>
>> No response from Jonathan as yet, but I am willing to rework the driver when I
>> have some time. It might be weeks before I can start, though.
>>
> 
> Changing the subject - maybe it helps to get Jonathan's attention.
Sorry bit of silly travelling for day job over the last few days has
left me rather behind.

Just had my first experience of missing the last train home from the airport
and having to sleep in a 'pod' hotel waiting for the first on in the morning.

'interesting' and I hope I never have to repeat it.

Anyhow, looking fairly quickly through the datasheet I agree with Guenter.
This is a reasonably standard looking ADC with a decent analog front
end.  Whilst they state thermal monitoring in the 'applications' and there
are a few design choices in there (such as really small over voltage
protection) that make sense for thermocouples, there is nothing that
specific.  Also as Guenter has pointed out above we already have some
thermocouple focused chips in IIO.

Sampling is quick enough (up to 860 sps) that you'll probably want
to use the 'buffer' support in IIO rather than just a simple
polled (hwmon like) driver - but that can always come in a follow
up patch.  There is a nice datardy output that can be used to drive
a general purpose trigger (used to sample other devices in parallel
with this one if you want to).

Anyhow, all in, looks like a good general purpose ADC to me.
So would be delighted to have a driver for it in IIO.

You could combine it with the existing ads1015 driver, but
there are probably enough differences to make that fiddly
even using regmap to deal with the different bus (i2c -> spi),
so I think it doesn't really make sense (feel free to tell me
otherwise as I've only glanced at the datasheet!)

Thanks,

Jonathan

> 
> Guenter
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
