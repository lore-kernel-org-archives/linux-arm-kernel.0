From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 12 Jan 2014 13:58:28 +0100
Subject: [PATCH 3/6] clk: samsung: register cpu clock provider for
 exynos4210 SoC
In-Reply-To: <20140112134152.58d393f0@jawa>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>	<1389283165-17708-4-git-send-email-thomas.ab@samsung.com>	<20140110130424.6aa78438@amdc2363>	<CAJuA9aidWvkPPXFfOysqQCQ4d7q_y51zbYxHCK9d-E8+ojfN_w@mail.gmail.com>	<20140110151812.5104cc92@amdc2363>	<CAJuA9aj3ca9VNsQ9cadVH8pUpyYeaht3DufT3DW4jXuEN5BudA@mail.gmail.com>	<52D1FB94.1030006@gmail.com>	<20140112092330.4baa2c77@jawa>	<52D2851B.50200@gmail.com>
 <20140112134152.58d393f0@jawa>
Message-ID: <52D29174.7010604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12.01.2014 13:41, Lukasz Majewski wrote:
> On Sun, 12 Jan 2014 13:05:47 +0100
> Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
>> On 12.01.2014 09:23, Lukasz Majewski wrote:
>>> Dear All,
>>>
>>>> On 11.01.2014 06:25, Thomas Abraham wrote:
>>>>> On Fri, Jan 10, 2014 at 7:48 PM, Lukasz Majewski
>>>>> <l.majewski@samsung.com> wrote:
>>>>>>> On Fri, Jan 10, 2014 at 5:34 PM, Lukasz Majewski
>>>>>>> <l.majewski@samsung.com> wrote:
>> [snip]
>>>>>>>>> +
>>>>>>>>> +static const struct samsung_core_clock_freq_table
>>>>>>>>> exyno4210_armclk_table = {
>>>>>>>>> +     .freq           = exynos4210_armclk_freqs,
>>>>>>>>> +     .freq_count     = ARRAY_SIZE(exynos4210_armclk_freqs),
>>>>>>>>> +     .data           = (void *)exynos4210_armclk_data,
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static int exynos4210_armclk_set_rate(struct clk_hw *hw,
>>>>>>>>> unsigned long drate,
>>>>>>>>> +                                     unsigned long prate)
>>>>>>>>> +{
>>>>>>>>> +     struct samsung_core_clock *armclk;
>>>>>>>>> +     const struct samsung_core_clock_freq_table *freq_tbl;
>>>>>>>>> +     unsigned long *freq_data;
>>>>>>>>> +     unsigned long mux_reg, idx;
>>>>>>>>> +     void __iomem *base;
>>>>>>>>> +
>>>>>>>>> +     if (drate == prate)
>>>>>>>>> +             return 0;
>>>>>>>>> +
>>>>>>>>> +     armclk = container_of(hw, struct samsung_core_clock,
>>>>>>>>> hw);
>>>>>>>>> +     freq_tbl = armclk->freq_table;
>>>>>>>>> +     freq_data = (unsigned long *)freq_tbl->data;
>>>>>>>>> +     base = armclk->ctrl_base;
>>>>>>>>> +
>>>>>>>>> +     for (idx = 0; idx < freq_tbl->freq_count; idx++,
>>>>>>>>> freq_data += 2)
>>>>>>>>> +             if ((freq_tbl->freq[idx] * 1000) == drate)
>>>>>>>>> +                     break;
>>>>>>>>> +
>>>>>>>>> +     if (!armclk->fout_pll)
>>>>>>>>> +             armclk->fout_pll = __clk_lookup("fout_apll");\
>>>>>>>>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^[*]
>>>>>>>>
>>>>>>>> I'm a bit confused here for two reasons. Please correct me if
>>>>>>>> I'm wrong.
>>>>>>>>
>>>>>>>> 1. You go into this ->set_rate() because of calling
>>>>>>>> clk_set_rate at "arm_clk" clock (numbered as 12 at
>>>>>>>> clk-exynos4.c) at cpufreq-cpu0.c
>>>>>>>>
>>>>>>>> In a Exynos4210 we have:
>>>>>>>> XXTI-> APLL -> fout_apll -> mout_apll -> mout_core -> div_core
>>>>>>>> -> div_core2 -> arm_clk
>>>>>>>>
>>>>>>>> In the code you call directly the fout_apll which changes
>>>>>>>> frequency. Then the change shall be propagated to all
>>>>>>>> registered clocks.
>>>>>>>> I think, that DIV and DIV1 shall be reduced before PLL change
>>>>>>>> [*], to reflect the changes at CCF.
>>>>>>>
>>>>>>> The core clock implementation encapsulates multiple clock blocks
>>>>>>> (such as dividers and muxes) which are in between the output of
>>>>>>> the APLL and the point that actually is the cpu domain clock
>>>>>>> output.
>>>>>>
>>>>>> No problem with that. I mostly agree...
>>>>>>
>>>>>>> When a clock
>>>>>>> frequency change has to be made, all these clock blocks
>>>>>>> encapsulated within the core clock are programmed by
>>>>>>> pre-determined values.
>>>>>>
>>>>>> And what about the situation with already defined clocks (like
>>>>>> "div_core" and "div_core2"). Those will not be updated when you
>>>>>> first call clk_set_rate() and change by hand DIV and DIV1.
>>>>>>
>>>>>> What if you would like to have the PCLK_DBG clock used in the
>>>>>> future? You would add it to CCF and the change will not
>>>>>> propagate.
>>>>>
>>>>> I did intend to remove individual clock blocks which are now
>>>>> encapsulated within the core clock type from the clock driver
>>>>> file. I missed doing that in this patch series.
>>>>
>>>> Yes, they should be removed, since they are encapsulated inside the
>>>> core clock now.
>>>
>>> This was not my point here.
>>>
>>> You are creating an opaque clock for cpu (like
>>> "samsung_clock_cpu" [*]) , which encapsulates many other clocks
>>> (mostly DIVs and MUXes to be more precise).
>>>
>>> I don't think, that those clocks shall be removed from CCF.
>>>
>>> I do believe, that they shall be passed as the argument to [*] and
>>> recalculated.
>>>
>>> Why the advent of [*] clock forbids me from creating and using
>>> clocks based on "div_core", "div_core2" and PCLK_DBG?
>>>
>>> What if I would like to see output of those particular clocks
>>> at /sys/kernel/debug/ or use them at a custom driver?
>>
>> Having those clocks defined as separate entities in CCF would make
>> them accessible outside the core clock, including changing their
>> configuration, but they should be only changed on APLL change and
>> atomically. By registering them as standard CCF clocks you are
>> providing an interface to something that is not allowed.
>>
>> If there was a _real_ need to have them defined as separate clocks,
>> you would have to implement a separate clock type that would only
>> allow retrieving the rate from it. Maybe a read-only flag for the
>> divider clock could do, as mux clock already has such.
>
> To not create unrealistic use cases, we can export those clocks as read
> only (to allow them to be visible at /sys/kernel/debug).

What functionality would that provide?

>
> Also we can design the code with future write extension in back of our
> heads.

As I already explained above, you _must_ _not_ reconfigure the clocks 
beyond div_core2 separately, because they are supposed to be set atomically.

In case of mout_core, div_core and div_core2 they probably can be 
reconfigured in a non-atomic fashion, but this is still a bad idea, 
because this invalidates the settings done to those internal dividers. 
Remember that whenever you change the input frequency of core block you 
need to reconfigure the internal dividers properly.

Of course there is a number of complex solutions involving adding some 
synchronization code, clock notifications and so on to keep those clocks 
at CCF and still meet the requirements for core block clocks (not even 
saying that you could even extend CCF to provide support for changing 
clocks atomically), but would this complexity be justified without any 
_real_ need?

>>>>>>>>
[snip]
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +     if (drate < prate) {
>>>>>>>>> +             mux_reg = readl(base + SRC_CPU);
>>>>>>>>> +             writel(mux_reg | (1 << 16), base + SRC_CPU);
>>>>>>>>> +             while (((readl(base + STAT_CPU) >> 16) & 0x7) !=
>>>>>>>>> 2)
>>>>>>>>> +                     ;
>>>>>>>>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [**]
>>>>>>>>
>>>>>>>> 2. I think, the above shall be done in a following way:
>>>>>>>>
>>>>>>>>            clk_set_parent(mout_core, mout_mpll);
>>>>>>>>            clk_set_rate(armclk->fout_pll, drate);
>>>>>>>>            clk_set_parent(mout_core, mout_apll);
>>>>>>>>
>>>>>>>> The direct write to registers [**] doesn't look compliant to
>>>>>>>> CCF.
>>>>>>>>
>>>>>>>
>>>>>>> As mentioned above, the clock block encapsulates these clock
>>>>>>> blocks into a single clock and only this single encapsulated
>>>>>>> clock is registered with CCF. The internal implementation of how
>>>>>>> the different clock blocks are managed within this clock is
>>>>>>> independent of the CCF.
>>>>>>
>>>>>> I agree, that the CPU_DIV and CPU_DIV1 shall be changed
>>>>>> atomically (without CCF).
>>>>>>
>>>>>> But on the situation [**] the MUX can be changed by
>>>>>> clk_set_parent() as it is now done at exynosXXXX-cpufreq.c code.
>>>>>
>>>>> The mux is also encapsulated into a larger clock type and this new
>>>>> clock type know how the mux has to be configured.
>>>>
>>>> IMHO it's fine to encapsulate the mux as well. There are no users
>>>> of it other than the core clock.
>>>
>>> In spite of the above comment, it looks far more better to change
>>> clocks with CCF API (like clk_set_parent), not by writing directly
>>> to registers.
>>
>> This also depends on whether other entities should be able to
>> reconfigure the mux in question. If it needs to be switched only when
>> the APLL is reconfigured by core clock, then I don't think there is a
>> need to provide access to it outside.
>
> The mout_apll and mout_mpll are important clocks for the platform. For
> this reason I'd prefer them to be exported and up to date.

I haven't said anything about mout_apll and mout_mpll. They have 
multiple users other than the core block and they should be left intact. 
We are talking here about mout_core which is only used to select the 
input of core block.

Best regards,
Tomasz
