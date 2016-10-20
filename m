From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Oct 2016 15:37:25 +0530
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <CAMpxmJXT8hcSc0-svbwAq5r_JOFsYV852gtE0vuXL8hHykXnRQ@mail.gmail.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
 <65fde145-0820-794d-d345-621f66cdacc0@ti.com>
 <7a2ffcd0-fe1d-c887-53b7-7cb5e1e61222@ti.com> <4975084.EGQPv58AK6@avalon>
 <daf49046-ad0a-d9e2-d744-1e06085c6585@ti.com>
 <CAMpxmJXT8hcSc0-svbwAq5r_JOFsYV852gtE0vuXL8hHykXnRQ@mail.gmail.com>
Message-ID: <6c6fcceb-c6f2-219d-492a-a8b38fd83093@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 October 2016 07:31 PM, Bartosz Golaszewski wrote:
> 2016-10-17 14:29 GMT+02:00 Tomi Valkeinen <tomi.valkeinen@ti.com>:
>> On 17/10/16 14:40, Laurent Pinchart wrote:
>>> Hello,
>>>
>>> On Monday 17 Oct 2016 10:33:58 Tomi Valkeinen wrote:
>>>> On 17/10/16 10:12, Sekhar Nori wrote:
>>>>> On Monday 17 October 2016 11:26 AM, Tomi Valkeinen wrote:
>>>>>> On 15/10/16 20:42, Sekhar Nori wrote:
>>>>>>>> diff --git a/arch/arm/boot/dts/da850.dtsi
>>>>>>>> b/arch/arm/boot/dts/da850.dtsi
>>>>>>>> index f79e1b9..32908ae 100644
>>>>>>>> --- a/arch/arm/boot/dts/da850.dtsi
>>>>>>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>>>>>>> @@ -399,6 +420,14 @@
>>>>>>>>                                  <&edma0 0 1>;
>>>>>>>>                          dma-names = "tx", "rx";
>>>>>>>>                  };
>>>>>>>> +
>>>>>>>> +                display: display at 213000 {
>>>>>>>> +                        compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";
>>>>>>>
>>>>>>> This should instead be:
>>>>>>>
>>>>>>> compatible = "ti,da850-tilcdc", "ti,am33xx-tilcdc";
>>>>>>>
>>>>>>> as the closest match should appear first in the list.
>>>>>>
>>>>>> Actually I don't think that's correct. The LCDC on da850 is not
>>>>>> compatible with the LCDC on AM335x. I think it should be just
>>>>>> "ti,da850-tilcdc".
>>>>>
>>>>> So if "ti,am33xx-tilcdc" is used, the display wont work at all? If thats
>>>>> the case, I wonder how the patch passed testing. Bartosz?
>>>>
>>>> AM3 has "version 2" of LCDC, whereas DA850 is v1. They are quite
>>>> similar, but different.
>>>>
>>>> The driver gets the version number from LCDC's register, and acts based
>>>> on that, so afaik the compatible string doesn't really affect the
>>>> functionality (as long as it matches).
>>>>
>>>> But even if it works with the current driver, I don't think
>>>> "ti,am33xx-tilcdc" and "ti,da850-tilcdc" are compatible in the HW level.
>>>
>>> If the hardware provides IP revision information, how about just "ti,lcdc" ?
>>
>> Maybe, and I agree that's the "correct" way, but looking at the history,
>> it's not just once or twice when we've suddenly found out some
>> difference or bug or such in an IP revision, or the integration to a
>> SoC, that can't be found based on the IP revision.
>>
>> That's why I feel it's usually safer to have the SoC revision there in
>> the compatible string.

I agree with Tomi here. Lets keep the soc part number in the compatible
string. More often than not, some undocumented, undiscovered issue pops
up over time. Its much safer to have the SoC revision in there.

>>
>> That said, we have only a few different old SoCs with LCDC (compared to,
>> say, OMAP DSS) so in this case perhaps just "ti,lcdc" would be fine.
>>
>>  Tomi
>>
> 
> I Sekhar is ok with this, I'll send a follow-up patch for that.

Per me, compatible property is an ordered list precisely for the reason
that things should continue to "work" with as closely matched driver as
possible. So even if someone is running a kernel which does not
recognize "ti,da850-tilcdc", it should still be able to probe the driver
based on "ti,am33xx-tilcdc" and provide as close to full functionality
as possible.

That said, I will not insist on keeping it around if Tomi is
uncomfortable. And having read the binding documentation accepted by
Jyri, it actually says the compatible property should be __one of__
"ti,am33xx-tilcdc" or "ti,da850-tilcdc".

Thanks,
Sekhar
