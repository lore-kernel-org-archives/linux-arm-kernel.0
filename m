From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 20 Sep 2013 13:41:42 +0530
Subject: [PATCH] media: i2c: adv7343: fix the DT binding properties
In-Reply-To: <523B554A.2030701@gmail.com>
References: <1379073471-7244-1-git-send-email-prabhakar.csengg@gmail.com>
 <523395DC.5080009@wwwdotorg.org>
 <CA+V-a8sVyJ1TrTSiaj8vpaD+f_qJ5Hp287E3HuHJ_pRzzmdAvg@mail.gmail.com>
 <523730A8.9060201@wwwdotorg.org>
 <CA+V-a8vY-qsdUoUUH=3HOg-UAZZPujOLPHFC_udNWFtksgzRRA@mail.gmail.com>
 <523B554A.2030701@gmail.com>
Message-ID: <CA+V-a8s3PYr7qem6m8au0E7N2Xb_gD37_8uLcdXZjeHppBaC6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Fri, Sep 20, 2013 at 1:19 AM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> On 09/19/2013 06:06 PM, Prabhakar Lad wrote:
>>
>> On Mon, Sep 16, 2013 at 9:54 PM, Stephen Warren<swarren@wwwdotorg.org>
>> wrote:
>>>
>>> On 09/13/2013 11:23 PM, Prabhakar Lad wrote:
>>>>
>>>> On Sat, Sep 14, 2013 at 4:16 AM, Stephen Warren<swarren@wwwdotorg.org>
>>>> wrote:
>>>>>
>>>>> On 09/13/2013 05:57 AM, Prabhakar Lad wrote:
>>>>>>
>>>>>> From: "Lad, Prabhakar"<prabhakar.csengg@gmail.com>
>>>>>>
>>>>>> This patch fixes the DT binding properties of adv7343 decoder.
>>>>>> The pdata which was being read from the DT property, is removed
>>>>>> as this can done internally in the driver using cable detection
>>>>>> register.
>>>>>>
>>>>>> This patch also removes the pdata of ADV7343 which was passed from
>>>>>> DA850 machine.
>>>>>
>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7343.txt
>>>>>> b/Documentation/devicetree/bindings/media/i2c/adv7343.txt
>>>>>
>>>>>
>>>>>>   Required Properties :
>>>>>>   - compatible: Must be "adi,adv7343"
>>>>>> +- reg: I2C device address.
>>>>>> +- vddio-supply: I/O voltage supply.
>>>>>> +- vddcore-supply: core voltage supply.
>>>>>> +- vaa-supply: Analog power supply.
>>>>>> +- pvdd-supply: PLL power supply.
>>>>>
>>>>>
>>>>> Old DTs won't contain those properties. This breaks the DT ABI if those
>>>>> properties are required. Is that acceptable?
>>>>
>>>>
>>>> As of now adv7343 via DT binding is not enabled in any platforms
>>>> so this wont break any DT ABI.
>>>
>>>
>>> Well, if the binding has already been written, it technically already is
>>> an ABI. Perhaps the binding can be fixed if it isn't in use yet, but
>>> this is definitely not the correct approach to DT.
>
>
> The binding got merged for 3.12-rc1 and the intention of this patch was
> to correct that binding. There we some issues like mismatch between names
> of properties documented and used in the driver.
>
> After Mark's suggestion Prabhakar removed some properties and the platform
> data usage altogether. IMHO there should be only minimal changes in that
> "fixup" patch, i.e. no platform data usage should be removed. Perhaps it
> is fine since that's just code removal. I guess it is better to do this
> sort of cleanup for the next kernel release.
>
OK I will, just send out a fix up patch which fixes the mismatch between
names for the rc-cycle, and later send out a patch which removes the
platform data usage for next release with proper DT bindings.

> Also I believe the argument of backward compatibility shouldn't really be
> considered here. The $subject patch is supposed to correct the binding
> before it becomes and ABI.
>
>
>>>>> If it is, I think we should document that older versions of the binding
>>>>> didn't require those properties, so they may in fact be missing.
>>>>>
>>>>> I note that this patch doesn't actually update the driver to
>>>>> regulator_get() anything. Shouldn't it?
>>>>
>>>>
>>>> As of now the driver isn?t enabling/accepting the regulators,
>>>> so should I add those in DT properties or not ?
>>>
>>>
>>> The binding should describe the HW, not what the driver does/doesn't yet
>>> do. I wrote the above because it looked like the driver was broken, not
>>> to encourage you to remove properties from the binding.
>>
>> OK
>>
>>> How does the
>>> driver work if it doesn't enable the required regulators though, I
>>> wonder? I suppose the boards this driver has been tested on all must
>>> used fixed (non-SW-controlled) regulators.
>>>
>> on all the boards on which this decoder is connected the power to it
>> is provided by static circuit and not by regulators, So for this how would
>> you suggest to add the DT nodes for regulators ?
>
>
> I believe the regulator DT properties should be made optional. Since some
> (actually all upstream) boards don't bother with software controlled
> regulators. We might have specified them and have defined relevant fixed
> regulator(s) in DT. But I doubt it is sensible, given that it may never
> happen in practice the regulators are required to be controlled by software
> through the regulators API. Such devices can often be put in a low power
> mode by a write to one of the registers, where their supply current is at
> uA level. Looking at the datasheet ADV7343 has SLEEP_MODE in which its
> typical current consumption is 5 uA.
>
> That said the chip could be supplied from shared voltage regulators and
> the driver would then have to properly request and enable the regulators.
>
> Anyway I'm inclined to make the regulator properties optional.
>
I'm OK with making regulator properties as optional, But still it would
change the meaning of what DT is, we know that the VDD/VDD_IO .. etc
pins are required properties (but still making them as optional) :-(

I think there might several devices where this situation may arise so
just thinking of a alternative solution.

say we have property 'software-regulator' which takes true/false(0/1)
If set to true we make the regulators as required property or else we
assume it is handled and ignore it ?


Thanks,
--Prabhakar Lad
