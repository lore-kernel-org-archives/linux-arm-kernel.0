From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 12 Jan 2014 02:47:20 +0100
Subject: [PATCH 2/6] clk: samsung: add infrastructure to register CPU
 clocks
In-Reply-To: <CAJuA9aiYKb42frkE=2qDzh4Jo_mnFVm3wABJQ-3vn4Uek_AMBQ@mail.gmail.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>	<1389283165-17708-3-git-send-email-thomas.ab@samsung.com>	<20140110130407.3390213d@amdc2363>	<CAJuA9ah7Owfo7yrZqN+iU6KYEkeoncL4AZ8rEKddNXAu6tC4aQ@mail.gmail.com>	<20140110142546.1e8583d6@amdc2363>
 <CAJuA9aiYKb42frkE=2qDzh4Jo_mnFVm3wABJQ-3vn4Uek_AMBQ@mail.gmail.com>
Message-ID: <52D1F428.4090701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Lukasz,

Let me put my two cents in.

On 11.01.2014 05:43, Thomas Abraham wrote:
> On Fri, Jan 10, 2014 at 6:55 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> Hi Thomas,
>>
>>> Hi Lukasz,
>>>
>>> On Fri, Jan 10, 2014 at 5:34 PM, Lukasz Majewski
>>> <l.majewski@samsung.com> wrote:
[snip]
>>>>> +/* helper function to register a core clock */
>>>>> +void __init samsung_coreclk_register(const char *name, const char
>>>>> **parents,
>>>>> +                     unsigned int num_parents, const char *pllclk,
>>>>> +                     const struct clk_ops *clk_ops, unsigned int
>>>>> lookup_id,
>>>>> +                     const struct samsung_core_clock_freq_table
>>>>> *freq_tbl) +{
>>>>> +     struct samsung_core_clock *coreclk;
>>>>> +     struct clk_init_data init;
>>>>> +     struct clk *clk;
>>>>> +
>>>>> +     coreclk = kzalloc(sizeof(*coreclk), GFP_KERNEL);
>>>>> +     if (!coreclk) {
>>>>> +             pr_err("%s: could not allocate memory for coreclk
>>>>> %s\n",
>>>>> +                                     __func__, name);
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     init.name = name;
>>>>> +     init.flags = CLK_GET_RATE_NOCACHE;
>>>>> +     init.parent_names = parents;
>>>>> +     init.num_parents = num_parents;
>>>>> +     init.ops = clk_ops;
>>>>> +
>>>>> +     coreclk->hw.init = &init;
>>>>> +     coreclk->ctrl_base = reg_base;
>>>>> +     coreclk->fout_pll = __clk_lookup(pllclk);
>>>>> +     coreclk->freq_table = freq_tbl;
>>>>> +
>>>>> +     clk = clk_register(NULL, &coreclk->hw);
>>>>> +     if (IS_ERR(clk)) {
>>>>> +             pr_err("%s: could not register coreclk %s\n",
>>>>> __func__,     name);
>>>>> +             kfree(coreclk);
>>>>> +             return;
>>>>> +     }
>>>>> +     samsung_clk_add_lookup(clk, lookup_id);
>>>>> +}
>>>>
>>>> I think, that those definitions for samsung_core_clock shall be
>>>> moved to a separate file (maybe clk-exynos-cpu.c)?
>>>
>>> The additions were not really much and the samsung/clk.c file is used
>>> to hold all the common code for Samsung SoCs. So the additions were
>>> put into this existing file itself.

Still, separation between clock drivers and clock providers would be 
nice. clk-exynos4.c and friends doesn't implement any clock handling 
logic, they just define the tree of available clocks. I agree with 
Lukasz that separate file would be better place for such code, just as 
it was done with PLL drivers.

In addition this would allow you to make the generic core clock helpers 
static, as they could be moved to the same file where all the core clock 
driver variants are implemented.

>>>
>>>>
>>>> Moreover, maybe you can choose a shorter name?
>>>
>>> Ok, I will try to find a shorter name for in the next version.

I'm not sure how the name (or which name) could be shorter here, without 
impairing readability. Lukasz, can you elaborate?

>>>
>>>>
>>>>> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
>>>>> index 31b4174..0e43023 100644
>>>>> --- a/drivers/clk/samsung/clk.h
>>>>> +++ b/drivers/clk/samsung/clk.h
>>>>> @@ -312,6 +312,37 @@ struct samsung_pll_clock {
>>>>>        __PLL(_typ, _id, NULL, _name, _pname,
>>>>> CLK_GET_RATE_NOCACHE, \ _lock, _con, _rtable, _alias)
>>>>>
>>>>> +/**
>>>>> + * struct samsung_core_clock_freq_table: table of frequency
>>>>> supported by
>>>>> + * a core clock and associated data if any.
>>>>> + * @freq: points to a table of supported frequencies (in KHz)
>>>>> + * @freq_count: number of entries in the frequency table
>>>>> + * @data: core clock specific data, if any
>>>>> + */
>>>>> +struct samsung_core_clock_freq_table {
>>>>> +     const unsigned long     *freq;       /* in KHz */
>>>>> +     unsigned long           freq_count;
>>>>> +     const void              *data;
>>>>> +};
>>>>
>>>> This is another instance of a structure, which holds the frequency
>>>> for the system (like struct cpufreq_frequency_table).
>>>>
>>>> Unfortunately, since the clk subsystem starts very early, the
>>>> cpufreq_frequency_table is not yet parsed from "operating-points"
>>>> attribute.
>>>>
>>>> Maybe we can defer the clock registration?
>>>
>>> The core clock is not limited to support only those frequencies which
>>> the CPU operating point specifies. The core clock type can be used
>>> independent of the cpufreq driver and hence has its own set of
>>> supported frequencies. The cpufreq driver, depending the operating
>>> points allowed, can request the core clock to setup the requested
>>> clock speed.
>>
>> The above would be true if it could have been possible to use this
>> clock without cpufreq.
>>
>> Since, justification of this whole change is the clean up of cpufreq for
>> Exynos, I assume that it will be only used with cpufreq. Is there any
>> use case to use this clock without cpufreq?
>>
>> For this reason Exynos SoCs can only change frequency to the one, which
>> is defined at cpufreq_frequency_table.
>>
>> And since the cpufreq_frequency_table is dynamically build from
>> operating-points attribute, then in my opinion we shall refer to only
>> one place for frequency.
>>
>> Similar approach - of reusing cpufreq_frequency_table is used at
>> thermal core driver.
>
> One of the reasons for keeping the supported frequencies independent
> of the cpufreq table was ensure that platforms are free to use only a
> subset of the supported clock speed due to certain performance/power
> requirements particular to that platform Two or more platforms based
> on the same SoC can have different power/performance requirements. The
> case of thermal is different, it can only request for the CPU to be
> clocked at speeds supported by the cpufreq driver.
>
> Also, the core clock type is not limited to be used only by the
> cpufreq driver. It should be possible to use a platform without the
> cpufreq driver but still have the flexibility to change the cpu clock
> speed.
>

I don't think the core clock is going to be used (in reconfigurable way) 
with anything else than cpufreq. I agree with Thomas, though, that clock 
drivers should not have any dependencies on other subsystems. Separation 
is always good.

However, Lukasz has a valid point. Your patch is adding third place 
where list of CPU frequencies is defined. We really shouldn't have 
allowed this to be scattered into two pieces with common clock framework 
implementation, not even saying about three. This is data redundancy 
that is not only error prone, but also a maintenance issue, because 
whenever one wants to change the set of supported frequencies, they must 
modify all two (or three) locations.

My stance on this is that we should get rid of this redundancy and I 
won't Ack any patch that makes us further from this goal, unless you can 
convince me that there is no other option.

As for how I see solution for this, I believe that possible APLL 
settings, core clock settings and cpufreq operating points are all 
board-specific or at least SoC revision-specific. Moreover, they are all 
closely related to themselves:

  - the list of available cpufreq operating points depends on available 
APLL and core clock configurations,

  - each APLL setting has its own, specific, set of configurations of 
core dividers.

This makes me almost sure that what we want is a single place where all 
(or at least all clock-related) data are specified and this is probably 
device tree, since those can be board-specific or at least SoC revision 
specific.

>>
>>>
>>>>
>>>>> +
>>>>> +/**
>>>>> + * struct samsung_core_clock: information about clock supplied to
>>>>> a CPU core.
>>>>> + * @hw: handle between ccf and core clock.
>>>>> + * @ctrl_base: base address of the clock controller.
>>>>> + * @fout_pll: clock handle representing the clock output of the
>>>>> associated PLL.
>>>>> + */
>>>>> +struct samsung_core_clock {
>>>>> +     struct clk_hw           hw;
>>>>> +     void __iomem            *ctrl_base;
>>>>> +     struct clk              *fout_pll;
>>>>> +     const struct samsung_core_clock_freq_table *freq_table;
>>>>> +};
>>>>> +
>>>>> +extern unsigned long samsung_core_clock_recalc_rate(struct clk_hw
>>>>> *hw,
>>>>> +                             unsigned long parent_rate);
>>>>> +extern long samsung_core_clk_round_rate(struct clk_hw *hw,
>>>>> +                     unsigned long drate, unsigned long *prate);
>>>>
>>>> IMHO, those methods shall be defined as static in a separate file.
>>>
>>> These two functions are generic enough to be reused for core clock
>>> implementations on multiple exynos platforms.
>>
>> I thought that you are going to implement this clock in a generic way,
>> so by using the DT we could use it for Exynos4210/4x12 and 5250.
>>
>>> Only the set_rate
>>> callback is the one that will be specific to SoC and core clock. The
>>> SoC specific implementation can reuse these two callback funcitons
>>> when registering the core clock type. That is the reason these are not
>>> static functions. The 3/6 patch of this series includes the usage of
>>> these functions.
>>
>> In my opinion we shall not duplicate per SoC constructs like for
>> example:
>>
>> static struct apll_freq apll_freq_4412[]
>> static struct apll_freq apll_freq_4212[]
>> static struct apll_freq apll_freq_4210[]
>>
>> which would be used at different ->set_rate() callbacks.
>>
>> I think that the best solution would be to use one ->set_rate() with
>> data parsed from DT.
>
> Yes, I agree with you. The ->set_rate() callback code is not going to
> be repeated if the code can be reused for other Exynos SoCs.
>
> And about the values of the registers for set_rate coming in from DT,
> these are SoC specific values and are not different for two or more
> platforms using the same SoC. So why put this into DT? The same was
> the argument about populating all the clocks from DT. Clock blocks are
> not going to change from one platform to another platform which use
> the same SoC. They are SoC specific and not platform specific and
> hence there is little use in putting them into DT.

Those values aren't really such generic as one might think. There exist 
different SoC revisions on which different settings can be used. 
Moreover, I've already seen different sets of settings even for the same 
board in different sources of vendor kernel. This might mean that those 
values are in fact more of configuration, than static values selected 
for given hardware.

Best regards,
Tomasz
