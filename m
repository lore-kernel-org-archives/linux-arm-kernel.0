From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 24 Feb 2016 16:27:54 +0900
Subject: [PATCH] ARM: dts: add support for gpio buttons for
 exynos5422-odroidxu3
In-Reply-To: <CANAwSgR17csDub4fszP5+=M5qrG5FbHu=rmfny6-5e8x6bWBFg@mail.gmail.com>
References: <1456214467-3344-1-git-send-email-linux.amoon@gmail.com>
 <56CC167A.8040303@samsung.com> <56CC194F.6080905@samsung.com>
 <CANAwSgTRu6pb9cdA50AzBSNLS+Y+sssyc_CX7FKuV=FDYWaOsA@mail.gmail.com>
 <CAJKOXPftm7P44Zxn9rHt1THJOX3Oxu-mg5GD7=T3se4iRe1DkA@mail.gmail.com>
 <CANAwSgR17csDub4fszP5+=M5qrG5FbHu=rmfny6-5e8x6bWBFg@mail.gmail.com>
Message-ID: <56CD5B7A.10908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.02.2016 23:16, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 23 February 2016 at 17:32, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> 2016-02-23 18:17 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>> Hi Krzysztof,
>>>
>>> On 23 February 2016 at 14:03, Krzysztof Kozlowski
>>>>>>      };
>>>>>> +
>>>>>> +    gpio_keys {
>>>>>> +            compatible = "gpio-keys";
>>>>>> +            pinctrl-names = "default";
>>>>>> +            pinctrl-0 = <&gpio_power_key>;
>>>>>> +
>>>>>> +            power_key {
>>>>>> +                    interrupt-parent = <&gpx0>;
>>>>>> +                    interrupts = <3 IRQ_TYPE_NONE>;
>>>>>
>>>>> Hmmm.... why you specify the interrupts?
>>>>>
>>>>>> +                    gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
>>>>
>>>> Please, explain it to me. The SW2 key is connected to PWRON of PMIC.
>>>> However you are adding a GPIO key for external interrupt source 3
>>>> (XE.INT3)... which comes from PMIC's ONOB.
>>>>
>>>> It's interesting.... how does it work? The PMIC will generate ONOB
>>>> interrupt on PWRON low->high change (when PWRHOLD is high)?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> I have re-base my changes on HK dts.
>>> I could not find much details for the schematic diagram.
>>> I don't know much low level detains on this.
>>
>> If I understand this correctly: you just took some vendor code,
>> similar to existing code of Odroid U3, and without full understanding
>> of the code nor checking with public schematics, you sent it.
>>
>> Taking vendor stuff is okay but you need to think about it, use it as
>> an example and deliver proper solution based on that. Not copy-paste.
>>
>>> How dose this works: This changes will initial the shudown/reboot on Ubuntu.
>>> I have also tested this similar feature on Odroid U3.
>>
>> Great :), yes it works because ONOB interrupt from PMIC is generated
>> on key press. However this is not a strictly speaking key... I don't
>> really know what to do with this commit and your explanation
>> (Hardkernel has such code) is not sufficient to convince me.
>>
>> Best regards,
>> Krzysztof
> 
> Nothing come easy to me, I had to do bit of work on this.
> Internally I might not know the detail of the board and features of
> the registers of the PMIC.
> I have to improvise some time for changes. I don't know who is the
> original author of the code.
> 
> It's relay hard to convince you on the changes, as I continue to
> repeat the mistake.
> I will try to improve my commits a be specific to the changes in the future.

No worries. :)

Anand,

Anyway I was thinking about this and discussed it even offline. This is
a little bit funny design choice because:
1. The generated interrupt (on line ONOB) is not coming from the
physical key. It is coming from the PMIC, after receiving the change of
PWRON level (which comes from the key).

2. The behaviour and correlation between PWRON and ONOB is poorly
described in datasheet. Only one place mentions it.

3. The other funny idea we had, was to add a input driver for PMIC...
but that IMHO won't solve anything. It won't even make this logically
correct.

4. What I don't like personally, that I had to discover all of it,
instead of reading this in commit message coming from you. I would like
to see the explanation of this design (ONOB, PWRON etc) in comment in
DTS. Written with your own words, not mine (which would be a
confirmation that you understood the code you wrote and sent).
Why? Because you are adding a gpio-key for something which is not a key.
Funny, isn't it? :)

5. If anyone else has some ideas how to solve this (a key-PMIC mixture),
please share!

Best regards,
Krzysztof
