From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 20 Oct 2015 23:59:49 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <20151019194313.GY2711@lukather>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
 <20150907205603.GX31584@lukather> <55EE9230.70209@redhat.com>
 <20150913152224.GU9885@lukather> <55F5B370.7040203@redhat.com>
 <20150922150242.GF4684@lukather> <560172B5.8090709@redhat.com>
 <20151019194313.GY2711@lukather>
Message-ID: <5626B955.3070906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/19/2015 09:43 PM, Maxime Ripard wrote:
> On Tue, Sep 22, 2015 at 05:24:37PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 22-09-15 17:02, Maxime Ripard wrote:
>>> On Sun, Sep 13, 2015 at 07:33:36PM +0200, Hans de Goede wrote:
>>>>> Anyway. In both cases, the regulator really shouldn't be drifting
>>>>> along like this.
>>>>
>>>> Right which is why I've added the always-on property.
>>>
>>> Which is exactly what I meant by drifting along: that regulator will
>>> never be associated to the i2c bus, and will always be enabled even
>>> though the i2c bus might not even be accessible in the first place
>>> (driver not selected, compiled as a module and not loaded yet), which
>>> is just as bad.
>>>
>>>>> If the i2c bus needs a regulator to be operationaly,
>>>>> then we can just add an optional bus-supply property or something to
>>>>> give that to the i2c driver so that it can enable it when needed.
>>>>
>>>> I agree that that would be sensible if this regulator were tied to
>>>> the pull-ups, but I've my doubts that it is. We've not seen anything
>>>> similar on any other allwinner tablet, other then ChenYu-s Ippo-q8-v5
>>>> tablet.
>>>>
>>>> This tablet is sort of a high-end tablet (with a nice ips screen) and
>>>> such it also uses a different (better) sensor for its frontcam, a
>>>> gc2015 rather then the usual gc0308. I believe that this is the
>>>> culprit.
>>>>
>>>> Which would make modelling this as some sort of i2c-bus power-supply
>>>> wrong, and I've checked and none of the existing i2c bindings under
>>>> Documentation/devicetree/bindings/i2c contain such a thing, so we
>>>> would be the first and we will likely have a hard time selling a
>>>> binding for this upstream, esp. since we do not know what exactly
>>>> is going on.
>>>
>>> Well, strictly speaking, it is a supply needed to get the bus to
>>> work. We should really try to avoid having always-on for regulators,
>>> especially for devices that are already represented in the DT.
>>>
>>>> So all in all I strongly believe that just setting always-on
>>>> on the regulator in question is the best solution.
>>>
>>> It's a hack we can avoid.
>>
>> How? By adding a regulator property to the i2c controller node
>> and then have the i2c controller driver enable this on probe ?
>
> Yes.

Ok, I'll send a v2 marking i2c1 as failed for now, as you've done with
sun6i-a31-hummingbird.dts, and drop the ldo3 node.

And I'll put looking into fixing this via a supply property for the
i2c-host node on my todo list.

Regards,

Hans
