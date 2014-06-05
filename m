From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 05 Jun 2014 10:26:19 +0200
Subject: XADC
In-Reply-To: <ab98c363-f3a0-4260-8226-7d159c9c0979@BN1AFFO11FD052.protection.gbl>
References: <e2cd1349-5cfb-4456-a1f5-74e7affff085@BN1AFFO11FD006.protection.gbl>
 <alpine.DEB.2.01.1406040843120.32323@pmeerw.net>
 <538ECA49.8030207@metafoo.de>
 <ab98c363-f3a0-4260-8226-7d159c9c0979@BN1AFFO11FD052.protection.gbl>
Message-ID: <539029AB.9010406@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 04:27 PM, S?ren Brinkmann wrote:
> Hi Lars, Peter,
>
> On Wed, 2014-06-04 at 09:27AM +0200, Lars-Peter Clausen wrote:
>> On 06/04/2014 08:47 AM, Peter Meerwald wrote:
>>> Hello,
>>>
>>>> I recently found that you developed a driver for XADC and I thought I
>>>> enable it (see patch below). But it seems something is not working
>>>> correctly. The values I tested don't seem to be right and also fixed.
>>>> I.e. they don't change over time or across boards:
>>>>
>>>>    # cat in_temp0_scale
>>>>    123.040771484
>>>>    # cat in_voltage0_vccint_scale
>>>>    0.732421875
>>>>    # cat in_voltage0_vccint_raw
>>>>    1384
>>>>    # cat in_voltage1_vccaux_s[ 1203.660637] random: nonblocking pool is initialized
>>>>    # cat in_voltage1_vccaux_scale
>>>>    0.732421875
>>>>    # cat in_voltage3_vccpint_scale
>>>>    0.732421875
>>>
>>> the _scale values are supposed to be constant; their purpose is to scale a
>>> measurement so that the result is in a given unit
>>>
>>> e.g. in_temp0_scale scales in_temp0_raw so that the result
>>> (in_temp0_raw * in_temp0_scale) in milli Celsius
>>>
>>> in_voltage0_vccint_raw * in_voltage0_vccint_scale is supposed to give
>>> milli Volts
>>>
>>> so in_voltage0_vccint_raw should vary accross time / boards (and voltage
>>> hopefully :), but not the _scales
>>
>> Yep, as Peter said scale and offset will be constant, raw should
>> change though, e.g. both voltage and temperature should a slight
>> jitter if you repeatedly read them. If not something is broken. We
>> had the driver in our images for Zynq board for a while now and so
>> far it worked fine. I think Mrinal and Radhey from Xilinx also
>> tested the driver.
>
> Okay, thanks for the answers. Since the _scale value was the only one
> close to a Celsius or Fahrenheit value I thought that would be the
> final temperature. Anyway, the raw values do show some jitter. So far,
> so good, but the math doesn't add up I think:
>
>   # cat in_temp0_raw in_temp0_scale
>   2559
>   123.040771484
>
> multiplying those values gives
> 2559 * 123.040771484 = 304156.787108
>
> Even if that is mC, that would mean my chip is at 304 degrees C. I'm pretty
> sure my chip's not on fire :)
> (I have the feeling I just did another beginner's mistake here though).
> A 10x error might be in there somewhere. 30 degrees sounds realistic.

There is also a in_temp0_offset attribute which needs to be added to 
in_temp0_raw

temperature = (in_temp0_raw + in_temp0_offset) * in_temp0_scale.

In your case that is: (2559 - 2219) * 123.040771484 = 41833.86

>
> I didn't test all voltages, but those look better.
>
> Also, is there a way to directly obtain a reading in a reasonable scale?
> This approach needs to read two sysfs files, one of those even giving a
> float.

No.

- Lars
