From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 13 Jun 2014 16:30:40 +0200
Subject: [PATCH RFC v5 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <20140523013406.9521.82891@quantum>
References: <1397042790-10636-1-git-send-email-s.nawrocki@samsung.com>
 <1397042790-10636-3-git-send-email-s.nawrocki@samsung.com>
 <CAL_JsqKDJ_yFxFYnrTtmzMPoxO2rmypiujybwbhUh35y1LS-Mw@mail.gmail.com>
 <5347DF4D.5000005@samsung.com> <20140523013406.9521.82891@quantum>
Message-ID: <539B0B10.5000005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/14 03:34, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2014-04-11 05:25:49)
>>>> +==Assigned clock parents and rates==
>>>> +
>>>> +Some platforms require static initial configuration of parts of the clocks
>>>> +controller. Such a configuration can be specified in a clock consumer node
>>>> +through clock-parents and clock-rates DT properties. The former should
>>>> +contain a list of parent clocks in form of phandle and clock specifier pairs,
>>>> +the latter the list of assigned clock frequency values (one cell each).
>>>> +To skip setting parent or rate of a clock its corresponding entry should be
>>>> +set to 0, or can be omitted if it is not followed by any non-zero entry.
>>>> +
>>>> +    uart at a000 {
>>>> +        compatible = "fsl,imx-uart";
>>>> +        reg = <0xa000 0x1000>;
>>>> +        ...
>>>> +        clocks = <&clkcon 0>, <&clkcon 3>;
>>>> +        clock-names = "baud", "mux";
>>>> +
>>>> +        clock-parents = <0>, <&pll 1>;
>>>> +        clock-rates = <460800>;
>>>
>>> Is this the input frequency or serial baud rate? Looks like a baud
>>> rate, but the clock framework needs input (to the uart) frequency. I
>>> would say this should be clock-frequency and specify the max baud rate
>>> as is being done with i2c bindings. The uart driver should know how to
>>> convert between input clock freq and baud rate.
>>
>> This UART example is not quite representative for the issues I have been
>> trying to address with this patch set. There is a need to set (an initial)
>> input clock frequency. E.g. in case of multimedia devices there may be
>> a need to set clock parent and frequency of an input clock to multiple IP
>> blocks, so they are clocked synchronously and data is carried properly
>> across a whole processing chain. Thus there may not be even clock output
>> in an IP block, but still input clock needs to be set. IIUC there is
>> similar issue with audio, where it is difficult to calculate the clock
>> frequencies/determine parent clocks in individual drivers algorithmically.
>>
>>>> +    };
>>>> +
>>>> +In this example the pll is set as parent of "mux" clock and frequency 
>>>> of "baud"
>>>> +clock is specified as 460800 Hz.
>>>
>>> I don't really like clock-parents. The parent information is part of
>>> the clock source, not the consumer.
>>
>> I'm not sure we must always consider the parent information as property
>> of a clock source. If for example we expose a structure like below as
>> single clock object, supporting clock gating, parent and frequency
>> setting the parent setting is still accessible from within a device
>> driver.
> 
> The design of the ccf implementation certainly allows one to hide
> individually addressable/configurable clock nodes within a single struct
> clk. But should we? I have always maintained that a clock driver should
> enumerate clocks in the same way that the data sheet or technical
> reference manual states. I did make a recent exception[1], but that is
> going to be rolled back after the coordinated clock rate changes land in
> mainline.
> 
>> And clock parent selection may depend on a system configuration
>> not immediately obvious from within a single device driver perspective.
>>
>>                          MUX
>>                        ,-------.     DIVIDER      GATE
>> common clk source 1 -->|--.    |   ,--------.   ,--------.
>>                        |   \   |   |        |   |        |
>> common clk source 2 -->|-   '--|-->|        |-->|        |--> consumer
>>        ...             |       |   |        |   |        |
>> common clk source N -->|-      |   '--------'   '--------'
>>                        '-------'
>>
>>> We've somewhat decided against having every single clock defined in DT
>>> and rather only describe a clock controller with leaf clocks to
>>> devices. That is not a hard rule, but for complex clock trees that is
>>> the norm. Doing something like this will require all levels of the
>>> clock tree to be described. You may have multiple layers of parents
>>> that have to be configured correctly. How are you configuring the rest
>>> of the tree?
>>
>> I believe even clock controllers where clocks are represented as flat
>> array often describe the clock tree entirely by parenthood, the tree
>> structure is just not obvious from the DT binding.
>> In addition, there seems to be appearing more and more clock controller
>> DT bindings describing their clocks individually.
> 
> I've been discouraging these per-clock node bindings in favor of the
> per-controller node style.
> 
>>
>>>> +Configuring a clock's parent and rate through the device node that uses
>>>> +the clock can be done only for clocks that have a single user. Specifying
>>>> +conflicting parent or rate configuration in multiple consumer nodes for
>>>> +a shared clock is forbidden.
>>>> +
>>>> +Configuration of common clocks, which affect multiple consumer devices
>>>> +can be specified in a dedicated 'assigned-clocks' subnode of a clock
>>>> +provider node, e.g.:
>>>
>>> This seems like a work-around due to having clock-parents in the
>>> consumer node. If (I'm not convinced we should) we have a binding for
>>> parent config, it needs to be a single binding that works for both
>>> cases.
>>
>> When this issue was first raised during an ARM kernel summit it was
>> proposed to add 'assigned' prefix to DT properties for such bindings.
>>
> 
> Yes, I like the "assigned-" prefix.
> 
>> How about separate properties for the default clock configuration,
>> e.g. assigned-clocks/assigned-clock-parents/assigned-clock-rates ?
>> So a clock provider would look like:
>>
>>     clkcon {
>>         ...
>>         #clock-cells = <1>;
>>
>>         assigned-clocks = <&clkcon 16>, <&clkcon 17>;
>>         assigned-clock-parents = <0>, <&clkcon 1>;
>>         assigned-clock-rates = <200000>;
>>     };
>>
>> And a consumer device node:
>>
>>     uart at a000 {
>>         compatible = "fsl,imx-uart";
>>         reg = <0xa000 0x1000>;
>>         ...
>>         clocks = <&clkcon 0>;
>>         clock-names = "baud";
>>
>>         assigned-clocks = <&clkcon 3>, <&clkcon 0>;
>>         assigned-clock-parents = <&pll 1>;
>>         assigned-clock-rates = <0>, <460800>;
>> };
> 
> It looks like this idea was dropped for v6. Can we revisit it? Take a

Yeah, we discussed this internally and some ones where not too excited
about such new properties, so I tried implementation of the bindings which
Grant initially suggested.
Having separate properties like these has an advantage though that the
clocks configuration specification is separated and not mixed with
regular clock properties describing solely the clock connections.

> look at Tero's example implementation for OMAP using this binding:
> 
> http://www.spinics.net/lists/linux-omap/msg104705.html
> 
> There is a bogus "default-clocks" node made solely for storing this info
> within the OMAP PRCM clock provider node. This is basically faking a
> clock consumer. I think with the proposed solution above Tero could have
> avoided that node entirely and done the following:

OK, I'm going to prepare new version of this series with the altered
DT binding.

> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 649b5cd..e3ff1a7 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -145,6 +145,11 @@
>  			cm2_clocks: clocks {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +
> +				assigned-clocks = <&abe_dpll_refclk_mux_ck>,
> +					<&dpll_usb_ck>, <&dpll_abe_ck>;
> +				assigned-clock-parents = <&sys_32k_ck>;
> +				assigned-clock-rates = <0>, <960000000>, <98304000>;
>  			};
>  
>  			cm2_clockdomains: clockdomains {
> 
> 
> Tero, what do you think?
> 
> Regards,
> Mike
> 
> [1] http://www.spinics.net/lists/cpufreq/msg10071.html

--
Regards,
Sylwester
