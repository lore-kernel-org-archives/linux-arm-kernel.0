From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Jan 2015 12:51:01 +0530
Subject: [RFC] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohpo=HkixETTSsrRPHhUtWPVgn_7w0E2jYTokAYQRT5awk8Q@mail.gmail.com>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
 <CAKohpokUXvhqt+z4EPC9k=O8ZnQOqNSGGi8w6w4shYtbvv8mTw@mail.gmail.com>
 <CAL_JsqJabcXe7-juTnJDcVdzpnFokYmt-N=bjZt5a+32Fzr_vg@mail.gmail.com>
 <CAKohpo=HkixETTSsrRPHhUtWPVgn_7w0E2jYTokAYQRT5awk8Q@mail.gmail.com>
Message-ID: <CAKohpokvkbyWnetSN793am+s4QjxiKwPO2P0QMPWk7Js-btTLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 December 2014 at 10:17, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29 December 2014 at 22:35, Rob Herring <robherring2@gmail.com> wrote:
>>> +  - frequency-kHz: Frequency in kHz
>>
>> s/kHz/khz/
>>
>>> +  - voltage-uV: voltage in micro Volts
>>
>> -microvolt is more consistent with regulator binding.
>>
>> The names are a bit redundant. perhaps opp-khz and opp-microvolt instead.
>
> All accepted.
>
>>> +Example 1: Simple case of dual-core cortex A9-single cluster, sharing
>>> clock line.
>>> +
>>> +/ {
>>> +       cpus {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +
>>> +               cpu at 0 {
>>> +                       compatible = "arm,cortex-a9";
>>> +                       reg = <0>;
>>> +                       next-level-cache = <&L2>;
>>> +                       operating-points-v2 = <&opp0>;
>>> +
>>> +                       opp0: opp0 {
>>
>> I don't really like having this under cpu0 when it applies to all
>> cpus. I would move it out of /cpus.
>
> That's how I had it initially, but then Arnd didn't like it much.
>
>>> +                               compatible = "linux,cpu-dvfs";
>>
>> This should not be linux specific. Probably not cpu specific either.
>
> This was just an example of one of the bindings and there will be others
> as well.
>
> 'linux' here doesn't mean linux specific, but just that its first used by
> Linux. That's what my understanding is atleast.
>
>>> +                               clocks = <&clk-controller 0>;
>>> +                               clock-names = "cpu";
>>
>> clocks are an input to the cpu, not really an opp. You could have a an
>> OPP which uses a different parent clock, but that is most likely a
>> switch within the clock controller rather than 2 clock inputs to the
>> cpu.
>>
>> I think the clock binding for cpus should stand on its own independent of OPPs.
>>
>>> +                               opp-supply = <&cpu-supply0>;
>>
>> Same comment as clocks applies here.
>
> Both will be kept in the cpu node where they were initially.
>
>>> +                               voltage-tolerance = <2>; /* percentage */
>>> +                               clock-latency = <300000>;
>>
>> These could be per entry. I'm not sure it is worth the savings to not
>> just always specify them per entry.
>
> Done.
>
>> We should append units (-us) to clock-latency unless there is a good
>> reason to maintain compatibility.
>
> So you meant something like this:
>
> clock-latency-us = <300000>;
>
> right?
>
>>> +                               opp-list = <&opplist0>;
>>
>> With the above changes, having this list is unnecessary.
>
> It might be for the use case I mentioned earlier about something
> like Krait.
>
>> So, what I envision is like this:
>>
>> /cpus {
>>   cpu at 0 {
>>     clocks = <...>;
>>     cpu-supply = <...>;
>>     operating-point-v2 = <&cpu0-opp>;
>>    };
>>   cpu at 1 {
>>     clocks = <...>;
>>     cpu-supply = <...>;
>>     operating-point-v2 = <&cpu1-opp>;
>>    };
>> };
>
> Looks fine..
>
>> cpu0-opp : opp0 {
>>   compatible = "operating-point-table";
>>   entry0 {
>>     opp-khz = <500000>;
>>     opp-microvolt = <900000>;
>>   };
>>   entry1 {
>>     opp-khz = <1000000>;
>>     opp-microvolt = <1000000>;
>>     turbo-mode;
>>   };
>> };
>> cpu1-opp : opp1 {
>>   compatible = "operating-point-table";
>> ...
>> };
>
> What about something like Krait which wants to use exactly same
> bindings for all CPUs but want to specify they are controlled separately.
>
> So I had it like:
>
> cpu0-opp : opp0 {
>   compatible = "operating-point-table";
>   opp-list = <&opplist0>;
>
>   opplist0: opp-list0 {
>           entry0 {
>             opp-khz = <500000>;
>             opp-microvolt = <900000>;
>           };
>           entry1 {
>             opp-khz = <1000000>;
>             opp-microvolt = <1000000>;
>             turbo-mode;
>           };
>   };
> };
>
> cpu1-opp : opp1 {
>   compatible = "operating-point-table";
>   opp-list = <&opplist0>;
> };

Gentle reminder, so that we can close this long standing issue soon..
