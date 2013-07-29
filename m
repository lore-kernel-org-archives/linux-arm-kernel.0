From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 29 Jul 2013 17:14:26 +0200
Subject: [PATCH v2 00/42] ARM: at91: move to common clk framework
In-Reply-To: <CACQ1gAirPir5vCyeK7OKHjw806Sv_LTiorDAp5mvhObxNTE3FA@mail.gmail.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
 <51F28370.6050304@gmail.com> <51F2996B.6000406@overkiz.com>
 <51F2A556.8020109@overkiz.com>
 <CACQ1gAgw-v3z_sWcsk7SqFFW-ERLjS0RS5GTgAdd5Y1tj3Z1FA@mail.gmail.com>
 <51F63516.8090000@overkiz.com>
 <CACQ1gAi53KN=zE8zDxQO=+BY2zvQXakD=OSuzUqc0VLwWLySCA@mail.gmail.com>
 <51F67D7F.1050906@overkiz.com>
 <CACQ1gAirPir5vCyeK7OKHjw806Sv_LTiorDAp5mvhObxNTE3FA@mail.gmail.com>
Message-ID: <51F686D2.3020104@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/2013 17:09, Richard Genoud wrote:
> 2013/7/29 boris brezillon <b.brezillon@overkiz.com>:
>> On 29/07/2013 16:18, Richard Genoud wrote:
>>> 2013/7/29 boris brezillon <b.brezillon@overkiz.com>:
>>>> On 29/07/2013 10:00, Richard Genoud wrote:
>>>>> 2013/7/26 boris brezillon <b.brezillon@overkiz.com>:
>>>>>> On 26/07/2013 17:44, boris brezillon wrote:
>>>>>> I found 2 bugs:
>>>>>> 1) the main frequency ready test in recalc_rate function is wrong
>>>>>> 2) the common clk framework uses the first match for dt clk
>>>>>> registration
>>>>>>       and main clk has this compatible property:
>>>>>>       compatible = "atmel,at91rm9200-clk-main", "fixed-clock";
>>>>>>       As a result the main clk is always bound to the fixed-clock driver
>>>>>>       which set the clock frequency to 0 if 'clock-frequency' property
>>>>>> is
>>>>>>       missing.
>>>>>>
>>>>>> These bugs will be fixed in next version.
>>>>>> Tell me if you want need thesse patches for testing purpose.
>>>>> Hi Boris,
>>>>>
>>>>> I tested your patch, the clock is not at 0 anymore:
>>>>> AT91: PIT: mck rate = 8333333
>>>>>
>>>>> And it's booting correctly.
>>>>> There's a small bug I found in the at91sam9x5 dtsi file (ssc id is 28,
>>>>> not 27). (patch attached)
>>>>>
>>>>> And yes, I could use your patches for some more tests !
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Richard.
>>>> Hi Richard,
>>>>
>>>> Thanks for the bug report.
>>>>
>>>> You'll find in attachements the pre-v3 series fixing the detected bugs
>>>> (including the ssc clock id bug).
>>>>
>>>> If you need anything else please let me know.
>>> Working on sam9g35ek !
>>> you can add my:
>>> Tested-by: Richard Genoud <richard.genoud@gmail.com>
>>>
>>>
>>> One remark though:
>>> Maybe it would be interesting to keep using the defines in the device
>>> tree for peripheral IDs.
>>> For instance, in arch/arm/boot/dts/at91sam9x5.dtsi : (patch 33)
>>> ssc_clk at 28 {
>>>          id = <28>;
>>> };
>>> May be more readable with the SSC id AT91SAM9X5_ID_SSC, as it was
>>> defined in arch/arm/mach-at91/at91sam9x5.c (removed with patch 20)
>>>
>>> IMHO, all AT91SAM9X5_ID_xxx in
>>> arch/arm/mach-at91/include/mach/at91sam9x5.h can me moved in
>>> include/dt-bindings/ and used in at91sam9x5.dtsi
>> This was requested by Jean-Christophe too.
>> I'll add these macro files and make use of it in next version.
>>
>> BTW where should I put these macro files
>> (include/dt-bindings/at91/'soc-name'/peripherals.h) ?
> That sounds correct I suppose.
Ok, I will use this path pattern.
>> Should I use macros for address fied of clocks or just for id property (or
>> drop the address) ?
>>
>> ssc_clk at AT91SAM9X5_ID_SSC {
>>          id = <AT91SAM9X5_ID_SSC>;
>> };
>>
>> or
>>
>> ssc_clk at 28 {
>>          id = <AT91SAM9X5_ID_SSC>;
>> };
>>
>> or
>>
>> ssc_clk {
>>          id = <AT91SAM9X5_ID_SSC>;
>> };
> I would drop the address, since the names are always different (for
> instance, dma0_clk and dma1_clk are used).
Ok, I'll drop the address.
> And the define should also be used here:
> ssc0: ssc at f0010000 { [...]
> clocks = <&periph AT91SAM9X5_ID_SSC>;
> [...]
> }
Yes of course, and it should be used for interrupt ids too (but this 
will not be part of this series :)).

Thanks for your review.

Best Regards,

Boris
