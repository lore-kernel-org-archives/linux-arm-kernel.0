From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 15:33:10 -0600
Subject: [PATCH] media: i2c: adv7343: fix the DT binding properties
In-Reply-To: <3002978.Cb6jL1xtkE@avalon>
References: <1379073471-7244-1-git-send-email-prabhakar.csengg@gmail.com>
 <523C1AE0.9020603@samsung.com>
 <CA+V-a8u5_rhxTgkVgCbtmGpaZCt2ciu4vABW4t80aSp7csttnw@mail.gmail.com>
 <3002978.Cb6jL1xtkE@avalon>
Message-ID: <5240B396.2010705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 05:50 AM, Laurent Pinchart wrote:
> On Monday 23 September 2013 08:18:52 Prabhakar Lad wrote:
>> On Fri, Sep 20, 2013 at 3:22 PM, Sylwester Nawrocki wrote:
>>> On 09/20/2013 10:11 AM, Prabhakar Lad wrote:
>>>> OK I will, just send out a fix up patch which fixes the mismatch between
>>>> names for the rc-cycle, and later send out a patch which removes the
>>>> platform data usage for next release with proper DT bindings.
>>>
>>> I think the binding need to be fully corrected now, I just meant to not
>>> touch the board file, i.e. leave non-dt support unchanged.
>>
>> Ok
>>
>>>> I'm OK with making regulator properties as optional, But still it would
>>>> change the meaning of what DT is, we know that the VDD/VDD_IO .. etc
>>>> pins are required properties (but still making them as optional) :-(
>>>>
>>>> I think there might several devices where this situation may arise so
>>>> just thinking of a alternative solution.
>>>>
>>>> say we have property 'software-regulator' which takes true/false(0/1)
>>>> If set to true we make the regulators as required property or else we
>>>> assume it is handled and ignore it ?
>>>
>>> I don't think this is a good idea. You would have to add a similar
>>> platform data flag for non-dt, it doesn't sound right. I can see two
>>> options here:
>>>
>>> 1. Make the regulator properties mandatory and, e.g. define a fixed
>>>    voltage GPIO regulator in DT with an empty 'gpio' property. Then
>>>    pass a phandle to that regulator in the adv7343 *-supply properties.
>>>    For non-dt similarly a fixed voltage regulator(s) and voltage
>>>    supplies  would need to be defined in the board files.
>>>
>>> 2. Make the properties optional and use (devm_)regulator_get_optional()
>>>    calls in the driver (a recently added function). I must admit I don't
>>>    fully understand description of this function, it currently looks
>>>    pretty much same as (devm_)regulator_get(). Thus the driver would
>>>    need to be handling regulator supplies only when non ERR_PTR() is
>>>    returned from regulator_get_optional() and otherwise assume a non
>>>    critical error. There is already quite a few example occurrences of
>>>    regulator_get_optional() usage.
>>
>> Thanks for pointing it I'll choose option 2 and post the patch.
> 
> Isn't regulator_get_optional() intended for devices that can have supplies 
> unconnected in normal use ?

I believe so, yes.

> The ADV7343 supplies are mandatory from a hardware 
> point of view, so I think we should use regulator_get(). Otherwise the driver 
> won't be able to tell the difference between a regulator that isn't present 
> yet (for instance because the regulator device/driver hasn't been probed yet), 
> which should result in deferred probing, and an always-on regulator that has 
> been left out.

So I think you want to make the supply properties mandatory in DT (since
some form of supply is mandatory in HW), yet make the driver support
broken DTs which don't have those properties, by error-checking the
return value from regulator_get(). You might want to put a note into DT
saying that a previous version of the binding didn't require those
supply properties, so they may be missing from older DTs.
