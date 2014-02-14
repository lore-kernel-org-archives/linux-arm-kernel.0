From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Feb 2014 12:49:38 +0100
Subject: [PATCH V2 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <CAPdUM4Pr7UC3wzYMsO+sYQHRDGixSNsR3XQuHBomsi-H-dfOZw@mail.gmail.com>
References: <1391577375-17625-1-git-send-email-rahul.sharma@samsung.com>
 <1391577375-17625-3-git-send-email-rahul.sharma@samsung.com>
 <52F38C42.5030508@samsung.com>
 <CAPdUM4NBwXcnL2KK9Rsi46GWQz_KQsXF0EEeSmCb=wB8WfgUKQ@mail.gmail.com>
 <52F9F59D.1090905@gmail.com>
 <CAPdUM4Pu-CbuNwwjrd_8itbSbjKqTBLE5u_T_vO89jreOy4=kQ@mail.gmail.com>
 <CAPdUM4Pr7UC3wzYMsO+sYQHRDGixSNsR3XQuHBomsi-H-dfOZw@mail.gmail.com>
Message-ID: <52FE02D2.7050305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.02.2014 12:28, Rahul Sharma wrote:
> On 14 February 2014 08:54, Rahul Sharma <r.sh.open@gmail.com> wrote:
>> Thanks Tomasz,
>>
>> I will add these changes to v3.
>>
>> Regards,
>> Rahul Sharma.
>>
>> On 11 February 2014 15:34, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> Hi Rahul,
>>>
>>>
>>> On 11.02.2014 06:22, Rahul Sharma wrote:
>>>>
>>>> Hi Tomasz,
>>>>
>>>> On 6 February 2014 18:51, Tomasz Figa <t.figa@samsung.com> wrote:
>>>>>
>>>>> Hi Rahul, Pankaj, Arun,
>>>>>
>>>>> [adding linux-arm-kernel, devicetree MLs and DT people on Cc]
>>>>>
>>>>> I think it's good time to stop accepting DTS files like this and force
>>>>> new
>>>>> ones to use the proper structure with soc node, labels for every node and
>>>>> node references.
>>>>
>>>>
>>>> I am unable to find information on SoC node and grouping inside SoC node.
>>>> Please
>>>> share some pointers.
>>>
>>>
>>> Well, there is not much information needed about this. Basically all the
>>> devices built into the SoC should be listed under respective bus nodes or a
>>> single soc node, instead of root level. Such node should be a "simple-bus"
>>> and just group the components together to separate board-specific devices
>>> (which are still at root level) from SoC devices.
>>>
>>> Even though it might seem useless, it improves DT readability a bit and
>>> still most of the platforms use this approach, so for consistency, Exynos
>>> should use too.
>>>
>>> Just for reference, back in April 2013, in his review of S3C64xx DT series
>>> [1], Rob Herring requested that we don't submit any new device trees using
>>> flat approach and start using bus hierarchy.
>>>
>>> [1]
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/163659.html
>>>
>>>
>>>>>
>>>>>> +               spi0_bus: spi0-bus {
>>>>>> +                       samsung,pins = "gpa2-0", "gpa2-1", "gpa2-2",
>>>>>> "gpa2-3";
>>>>>
>>>>>
>>>>>
>>>>> What is the reason for SPI0 to have 4 pins, while SPI1 has just 3?
>>>>>
>>>>
>>>> I should align SPI1 with SPI0.
>>>>
>>>
>>> Are you sure that SPI0 is the correct one? SPI usually uses four pins - SDI,
>>> SDO, SCK and nCS, but we always used to treat nCS as a simple GPIO, due to
>>> the fact that the controller can only support one dedicated chip select and
>>> with direct GPIO control you can have more.
>>>
>>> What is the fourth pin here?
>>>
>
> As you said, these are CLK, SS, MISO, MOSI (gpa2-0 to gpa2-3). Fourth pin is
> CS. It can be defined as a simple GPIO but better to include it in the
> SPI pingroup
> as it belongs to there.

I have to disagree here.

If you define a pin in pinctrl group then it is tied to this specific 
hardware function and you can't use it as GPIO.

Since it's board specific to use it as HW chip select or GPIO chip 
select (the usual setup), it should not be included in this group.

Best regards,
Tomasz
