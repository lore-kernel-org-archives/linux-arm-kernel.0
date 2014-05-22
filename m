From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 22 May 2014 14:25:50 +0200
Subject: [PATCH 3/4] clk: samsung: Add driver to control CLKOUT line on
 Exynos SoCs
In-Reply-To: <537DE714.1090407@samsung.com>
References: <1400604211-9447-1-git-send-email-t.figa@samsung.com>
 <1400604211-9447-4-git-send-email-t.figa@samsung.com>
 <537D8788.8030904@linaro.org> <537DD2C0.4060802@samsung.com>
 <CAHbNUh2gkpV-rt6S+-bUmFvYAuK_HNoXfyOStwYe29sZMJonUw@mail.gmail.com>
 <537DE714.1090407@samsung.com>
Message-ID: <537DECCE.8000301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/14 14:01, Tomasz Figa wrote:
>>>> >>> [ ... ]
>>>> >>>
>>>>> >>>> +    clkout->clk_table[0] = clk_register_composite(NULL, "clkout",
>>>>> >>>> +                            parent_names, parent_count, &clkout->mux.hw,
>>>>> >>>> +                            &clk_mux_ops, NULL, NULL, &clkout->gate.hw,
>>>>> >>>> +                            &clk_gate_ops, CLK_SET_RATE_PARENT
>>>>> >>>> +                            | CLK_SET_RATE_NO_REPARENT);
>>>> >>>
>>>> >>> Would you please remove CLK_SET_RATE_NO_REPARENT flag from here? Let me
>>>> >>> know if you have reservations against this.
>>> >>
>>> >> The problem with clock reparenting is that there are certain parent
>>> >> clocks of CLKOUT, rate of which changes at runtime, e.g. clocks derived
>>> >> from APLL or bus clocks, which can be reconfigured by cpufreq or devfreq.
>>> >>
>> > 
>> > +CC: Sylwester Nawrocki
>> > 
>> > Okay. But in cases where there is only 1 valid parent clock provided
>> > through DT (at the moment for Exynos5250/Exynos5420), would it be safe
>> > to set that clock as the parent of CLKOUT?
>
> This is not something to rely on. I have simply omitted remaining CLKOUT
> parents on Exynos 5 SoCs, as I don't have any board with them on which I
> could test this. Eventually they will be added.
> 
>> > Otherwise, this clock is
>> > not usable ATM.
>
> On many boards it is already configured properly by the bootloader.
> Although I don't see any reason why you couldn't reparent it in
> (board-specific) sound card driver right now.

This would require passing the parent's clock specifier in 'clocks'
property of the sound card device node, which I assume is not something
we're generally expected to do in mainline. Although some drivers
happen to be doing it already I think that's a bad example. It sounds
like an abuse of the current clock bindings.

--
Regards,
Sylwester
