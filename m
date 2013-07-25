From: robherring2@gmail.com (Rob Herring)
Date: Thu, 25 Jul 2013 13:15:57 -0500
Subject: [PATCH] arm: l2x0: add support for prefetch and pwr control
 register configuration
In-Reply-To: <CANuQgHE2rEDCwP8tHhUFF442Nqa9Gyqa6gii-jQDTEUVdEYwcA@mail.gmail.com>
References: <1374572345-5763-1-git-send-email-chander.kashyap@linaro.org>
 <20130723102212.GD4833@e106331-lin.cambridge.arm.com>
 <51EE8183.9010703@gmail.com>
 <CANuQgHE2rEDCwP8tHhUFF442Nqa9Gyqa6gii-jQDTEUVdEYwcA@mail.gmail.com>
Message-ID: <51F16B5D.7050707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2013 11:11 PM, Chander Kashyap wrote:
> On 23 July 2013 18:43, Rob Herring <robherring2@gmail.com> wrote:
>> On 07/23/2013 05:22 AM, Mark Rutland wrote:
>>> Hi,
>>>
>>> [adding Rob Herring to Cc]
>>
>> Thanks.
>>
>>> On Tue, Jul 23, 2013 at 10:39:05AM +0100, Chander Kashyap wrote:
>>>> This patch adds support to configure prefetch and pwr control registers
>>>> of pl310 cache controllor.
>>>>
>>>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/l2cc.txt |    6 ++++
>>>>  arch/arm/include/asm/hardware/cache-l2x0.h     |   23 +++++++++++++
>>>>  arch/arm/mm/cache-l2x0.c                       |   44 ++++++++++++++++++++++++
>>>>  3 files changed, 73 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> index cbef09b..66876b6 100644
>>>> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> @@ -34,6 +34,12 @@ Optional properties:
>>>>  - arm,filter-ranges : <start length> Starting address and length of window to
>>>>    filter. Addresses in the filter window are directed to the M1 port. Other
>>>>    addresses will go to the M0 port.
>>>> +- arm,prefetch-control : Prefetch related configurations. Specifies 8 cells of
>>>> +  prefetch-offset, not-same-ID-on-exclusive-sequence-en, incr-double-Linefill-en,
>>>> +  prefetch-drop-en, data-prefetch-en, instruction-prefetch-en and
>>>> +  double-linefill-en.
>>>
>>> This looks like configuration rather than hardware specification.
>>
>> I think weigh whether this is configuration based on the h/w or just
>> user preference. This would be the former, but...
>>
>>> Is there any reason we couldn't have Linux configure this itself? I'm
>>> not sure having a fixed configuration of these values makes sense - the
>>> configuration values could interact badly with future changes to Linux
>>> (e.g. performance improvements or errata workarounds), and then we'd
>>> have to ignore the described values and/or decide on more suitable ones
>>> dynamically anyway.
>>
>> Does having a variable configuration for these make sense either? I mean
>> other than an errata work-around, why would you ever turn off prefetch
>> or double linefill?
>>
>> None of these fields can be set in NS world. We've already laid down the
>> law in regards to setting secure only bits for errata work-arounds. I
>> think this is no different and we should move towards the kernel doesn't
>> touch aux ctrl at all. There might be an exception with the event bus
>> enable, but you would still have the secure vs. non-secure issue and no
>> way to detect that.
> 
> So what is the suggestion here. Not to touch the prefetch register at all.
> But prefetch register values are saved and resumed in existing code,
> how to take care for that.

As I said, I think all aux ctrl setup should be in the bootloader and
out of the kernel.

If you need to do platform specific things like save and restore then
fine, but let's not encourage it since it can't work universally.

Rob
