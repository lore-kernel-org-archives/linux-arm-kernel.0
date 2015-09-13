From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Sep 2015 19:33:36 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <20150913152224.GU9885@lukather>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
 <20150907205603.GX31584@lukather> <55EE9230.70209@redhat.com>
 <20150913152224.GU9885@lukather>
Message-ID: <55F5B370.7040203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13-09-15 17:22, Maxime Ripard wrote:
> On Tue, Sep 08, 2015 at 09:45:52AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 07-09-15 22:56, Maxime Ripard wrote:
>>> On Mon, Sep 07, 2015 at 09:05:29AM +0200, Hans de Goede wrote:
>>>>>> +&reg_ldo3 {
>>>>>> +	/*
>>>>>> +	 * We need to always power the camera sensor, otherwhise all access
>>>>>> +	 * to i2c1 is blocked.
>>>>>> +	 */
>>>>>> +	regulator-always-on;
>>>>>> +	regulator-min-microvolt = <2800000>;
>>>>>> +	regulator-max-microvolt = <2800000>;
>>>>>> +	regulator-name = "vdd-csi";
>>>>>> +};
>>>>>
>>>>> What is connected on i2c1 ? Just the camera sensor? or it has some
>>>>> other devices there?
>>>>
>>>> The bma250 accelerometer sits there, and the kernel already has a driver
>>>> for it. That driver needs to have devicetree binding support added, and
>>>> then we should be able to use the accelerometer.
>>>
>>> Ok, so if this regulator is disable, you can't access the other
>>> devices as well, right?
>>
>> Right, the controller reports the bus as being stuck.
>
> Which is pretty bad... :/

Yes.

>>> Do you know why? Is it the regulator providing
>>> the pull-up voltage?
>>
>> I've tried enabling the pull ups on the SoC i2c pins, so I do not think
>> that it is that, it seems that somehow when not powered the camera sensor is
>> actively keeping the lines low. Either it has multiple power planes, or
>> it is using normally-on fet-s between ground and its i2c lines.
>
> Well, if a regulator is powered down, it's also tied to the ground,

? I do not believe that that is necessarily always the case, that would
require an extra fet in the output logic of the pmic which actually
connects it to the ground when powered down. I would expect it to simply
be floating when not enabled.

> which means you would actually have pull-down. Maybe the in-SoC
> pullups simply aren't strong enough in such a case.

This all assumes that that regulator is actually tied to the pull-ups,
something which we've no knowledge of whatsoever.

> Anyway. In both cases, the regulator really shouldn't be drifting
> along like this.

Right which is why I've added the always-on property.

> If the i2c bus needs a regulator to be operationaly,
> then we can just add an optional bus-supply property or something to
> give that to the i2c driver so that it can enable it when needed.

I agree that that would be sensible if this regulator were tied to
the pull-ups, but I've my doubts that it is. We've not seen anything
similar on any other allwinner tablet, other then ChenYu-s Ippo-q8-v5
tablet.

This tablet is sort of a high-end tablet (with a nice ips screen) and
such it also uses a different (better) sensor for its frontcam, a
gc2015 rather then the usual gc0308. I believe that this is the
culprit.

Which would make modelling this as some sort of i2c-bus power-supply
wrong, and I've checked and none of the existing i2c bindings under
Documentation/devicetree/bindings/i2c contain such a thing, so we
would be the first and we will likely have a hard time selling a
binding for this upstream, esp. since we do not know what exactly
is going on.

So all in all I strongly believe that just setting always-on
on the regulator in question is the best solution.

Regards,

Hans





>
> Maxime
>
