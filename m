From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 31 Mar 2014 13:40:26 +0200
Subject: [PATCH RFC v3 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <5456863.skuFAcRA98@avalon>
References: <1395922579-28547-1-git-send-email-s.nawrocki@samsung.com>
 <46532903.ghnH4Us8Zz@avalon> <53343D9C.6040605@samsung.com>
 <5456863.skuFAcRA98@avalon>
Message-ID: <5339542A.50502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 28/03/14 17:49, Laurent Pinchart wrote:
> On Thursday 27 March 2014 16:02:52 Sylwester Nawrocki wrote:
>> > On 27/03/14 15:08, Laurent Pinchart wrote:
>>> > > On Thursday 27 March 2014 14:57:56 Sylwester Nawrocki wrote:
>>>> > >> On 27/03/14 14:24, Laurent Pinchart wrote:
>>>>> > >>> On Thursday 27 March 2014 13:16:19 Sylwester Nawrocki wrote:
>>>>>> > >>>> This function adds a helper function to configure clock parents and
>>>>>> > >>>> rates as specified in clock-parents, clock-rates DT properties for a
>>>>>> > >>>> consumer device and a call to it before driver is bound to a device.
>>>>>> > >>>> 
>>>>>> > >>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>>>> > >>>> ---
>>>> > >> 
>>>> > >> [...]
>>>> > >> 
>>>>>> > >>>>  .../devicetree/bindings/clock/clock-bindings.txt   |   26 ++++++
>>>>>> > >>>>  drivers/base/dd.c                                  |    7 ++
>>>>>> > >>>>  drivers/clk/Makefile                               |    1 +
>>>>>> > >>>>  drivers/clk/clk-conf.c                             |   87 ++++++++++++
>>>>>> > >>>>  drivers/clk/clk.c                                  |   10 ++-
>>>>>> > >>>>  include/linux/clk/clk-conf.h                       |   19 +++++
>>>>>> > >>>>  6 files changed, 149 insertions(+), 1 deletion(-)
>>>>>> > >>>>  create mode 100644 drivers/clk/clk-conf.c
>>>>>> > >>>>  create mode 100644 include/linux/clk/clk-conf.h
>>>>>> > >>>> 
>>>>>> > >>>> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>>> > >>>> b/Documentation/devicetree/bindings/clock/clock-bindings.txt index
>>>>>> > >>>> 7c52c29..b452f80 100644
>>>>>> > >>>> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>>> > >>>> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>>> > >>>> @@ -115,3 +115,29 @@ clock signal, and a UART.
>>>>>> > >>>>    ("pll" and "pll-switched").
>>>>>> > >>>>  
>>>>>> > >>>>  * The UART has its baud clock connected the external oscillator and
>>>>>> > >>>>    its register clock connected to the PLL clock (the "pll-switched"
>>>>>> > >>>>    signal)
>>>>>> > >>>> 
>>>>>> > >>>> +
>>>>>> > >>>> +==Assigned clock parents and rates==
>>>>>> > >>>> +
>>>>>> > >>>> +Some platforms require static initial configuration of parts of the
>>>>>> > >>>> clocks
>>>>>> > >>>> +controller. Such a configuration can be specified in a clock consumer
>>>>>> > >>>> node
>>>>>> > >>>> +through clock-parents and clock-rates DT properties. The former should
>>>>>> > >>>> contain
>>>>>> > >>>> +a list of parent clocks in form of phandle and clock specifier pairs,
>>>>>> > >>>> the
>>>>>> > >>>> +latter the list of assigned clock frequency values (one cell each).
>>>>>> > >>>> +
>>>>>> > >>>> +    uart at a000 {
>>>>>> > >>>> +        compatible = "fsl,imx-uart";
>>>>>> > >>>> +        reg = <0xa000 0x1000>;
>>>>>> > >>>> +        ...
>>>>>> > >>>> +        clocks = <&clkcon 0>, <&clkcon 3>;
>>>>>> > >>>> +        clock-names = "baud", "mux";
>>>>>> > >>>> +
>>>>>> > >>>> +        clock-parents = <0>, <&pll 1>;
>>>>>> > >>>> +        clock-rates = <460800>;
>>>>>> > >>>> +    };
>>>>>> > >>>> +
>>>>>> > >>>> +In this example the pll is set as parent of "mux" clock and frequency
>>>>>> > >>>> of "baud"
>>>>>> > >>>> +clock is specified as 460800 Hz.
>>>>> > >>> 
>>>>> > >>> I'm curious, what should happen when two devices have conflicting
>>>>> > >>> requirements ? If a different device required the <&clkcon 3> parent to
>>>>> > >>> be set to <&pll 2> for instance, who should win ? Shouldn't a warning be
>>>>> > >>> printed ?
>>>> > >> 
>>>> > >> In general, the assumption is that the <&clkcon 3> clock would be used
>>>> > >> only by the uart at a000 device.
>>> > > 
>>> > > OK. Removing the problem is a simple way to fix it :-) What about stating
>>> > > this explicitly in the documentation then ? Maybe by prefixing your
>>> > > proposed explanation below with something like
>>> > > 
>>> > > "Configuring a clock parent and rate through the device node that uses the
>>> > > clock is only supported for clocks that have a single user."
>> > 
>> > Looks good, we could add it. Or perhaps something like:
>> > 
>> > "Configuring a clock parent and rate through the device node that uses the
>> >  clock should be only done for clocks that have a single user. If a clock
>> >  is shared and conflicting parent or rate configuration is specified in
>> >  multiple consumer nodes a resulting configuration is undefined." ?
>> > 
>> > Not sure if it is acceptable to inject such an unpredictability to the
>> > kernel from DT though. Might be more reasonable to go with a clarification
>> > as you proposed.
>
> I would go further and forbid it.
> 
> "Configuring a clock parent and rate through the device node that uses the
> clock can be done only for clocks that have a single user. Specifying 
> conflicting parent or rate configuration in multiple consumer nodes for a 
> shared clock is forbidden."

Sounds good to me, I'll add it in next version of the patch. Thanks.

--
Regards,
Sylwester
