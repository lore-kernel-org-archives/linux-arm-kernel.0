From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 13 Jun 2014 17:06:37 +0200
Subject: [PATCH RFC v5 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <537EECC7.2030605@ti.com>
References: <1397042790-10636-1-git-send-email-s.nawrocki@samsung.com>
 <1397042790-10636-3-git-send-email-s.nawrocki@samsung.com>
 <CAL_JsqKDJ_yFxFYnrTtmzMPoxO2rmypiujybwbhUh35y1LS-Mw@mail.gmail.com>
 <5347DF4D.5000005@samsung.com> <20140523013406.9521.82891@quantum>
 <537EECC7.2030605@ti.com>
Message-ID: <539B137D.4060408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/14 08:37, Tero Kristo wrote:
> On 05/23/2014 04:34 AM, Mike Turquette wrote:
[...]
>> It looks like this idea was dropped for v6. Can we revisit it? Take a
>> look at Tero's example implementation for OMAP using this binding:
>>
>> http://www.spinics.net/lists/linux-omap/msg104705.html
>>
>> There is a bogus "default-clocks" node made solely for storing this info
>> within the OMAP PRCM clock provider node. This is basically faking a
>> clock consumer. I think with the proposed solution above Tero could have
>> avoided that node entirely and done the following:
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 649b5cd..e3ff1a7 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -145,6 +145,11 @@
>>   			cm2_clocks: clocks {
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>> +
>> +				assigned-clocks = <&abe_dpll_refclk_mux_ck>,
>> +					<&dpll_usb_ck>, <&dpll_abe_ck>;
>> +				assigned-clock-parents = <&sys_32k_ck>;
>> +				assigned-clock-rates = <0>, <960000000>, <98304000>;
>>   			};
>>
>>   			cm2_clockdomains: clockdomains {
>>
>>
>> Tero, what do you think?
> 
> Yeah, if we can avoid having a dummy node someplace, it is always 
> better. Only issue might be the initialization order, this was the 
> reason I created the dummy node if I recall right. But I guess we can 
> just scan the clock provider nodes second time at a later phase of boot 
> (or just store the default info for later use.)

One issue I'm a bit concerned about with an initcall-like approach is
it may not work well for clock providers in kernel modules which can be
loaded at any time.  So doing the configuration upon the clock provider
registration might have worked better.  Then we could disallow (defer)
a clock provider registration if any of its dependencies (as specified
through assigned-clock* properties) are not satisfied.  Do you think
that could work ?

--
Thanks,
Sylwester
