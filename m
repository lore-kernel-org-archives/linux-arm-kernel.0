From: ta.omasab@gmail.com (Thomas Abraham)
Date: Fri, 10 Jan 2014 17:49:25 +0530
Subject: [PATCH 2/6] clk: samsung: add infrastructure to register CPU
 clocks
In-Reply-To: <20140110130407.3390213d@amdc2363>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <1389283165-17708-3-git-send-email-thomas.ab@samsung.com>
 <20140110130407.3390213d@amdc2363>
Message-ID: <CAJuA9ah7Owfo7yrZqN+iU6KYEkeoncL4AZ8rEKddNXAu6tC4aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Fri, Jan 10, 2014 at 5:34 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Thomas,
>
>> The CPU clock provider supplies the clock to the CPU clock domain. The
>> composition and organization of the CPU clock provider could vary
>> among Exynos SoCs. A CPU clock provider can be composed of clock mux,
>> dividers and gates. This patch defines a new clock type for CPU clock
>> provider and adds infrastructure to register the CPU clock providers
>> for Samsung platforms.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  drivers/clk/samsung/clk.c |   71
>> +++++++++++++++++++++++++++++++++++++++++++++
>> drivers/clk/samsung/clk.h |   37 +++++++++++++++++++++++- 2 files
>> changed, 107 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
>> index f503f32..9ac9056 100644
>> --- a/drivers/clk/samsung/clk.c
>> +++ b/drivers/clk/samsung/clk.c
>> @@ -316,3 +316,74 @@ unsigned long _get_rate(const char *clk_name)
>>
>>       return clk_get_rate(clk);
>>  }
>> +
>> +/*
>> + * On most platform, the core clock rate is equal to the clock rate
>> of
>> + * parent pll. This is a simple helper function to support
>> recalc_rate
>> + * callback for such platforms.
>> + */
>> +unsigned long samsung_core_clock_recalc_rate(struct clk_hw *hw,
>> +                             unsigned long parent_rate)
>> +{
>> +     /*
>> +      * Assuming that the output of the parent pll is the output
>> clock
>> +      * frequency of the core clock.
>> +      */
>> +     return parent_rate;
>> +}
>> +
>> +/* This is a helper function to perform clock rounding for core
>> clocks. */ +long samsung_core_clk_round_rate(struct clk_hw *hw,
>> +                     unsigned long drate, unsigned long *prate)
>> +{
>> +     struct samsung_core_clock *core_clk;
>> +     const struct samsung_core_clock_freq_table *freq_tbl;
>> +     int i;
>> +
>> +     core_clk = container_of(hw, struct samsung_core_clock, hw);
>> +     freq_tbl = core_clk->freq_table;
>> +     drate /= 1000;
>> +
>> +     for (i = 0; i < freq_tbl->freq_count; i++) {
>> +             if (drate >= freq_tbl->freq[i])
>> +                     return freq_tbl->freq[i] * 1000;
>> +     }
>> +     return freq_tbl->freq[i - 1] * 1000;
>> +}
>> +
>> +/* helper function to register a core clock */
>> +void __init samsung_coreclk_register(const char *name, const char
>> **parents,
>> +                     unsigned int num_parents, const char *pllclk,
>> +                     const struct clk_ops *clk_ops, unsigned int
>> lookup_id,
>> +                     const struct samsung_core_clock_freq_table
>> *freq_tbl) +{
>> +     struct samsung_core_clock *coreclk;
>> +     struct clk_init_data init;
>> +     struct clk *clk;
>> +
>> +     coreclk = kzalloc(sizeof(*coreclk), GFP_KERNEL);
>> +     if (!coreclk) {
>> +             pr_err("%s: could not allocate memory for coreclk
>> %s\n",
>> +                                     __func__, name);
>> +             return;
>> +     }
>> +
>> +     init.name = name;
>> +     init.flags = CLK_GET_RATE_NOCACHE;
>> +     init.parent_names = parents;
>> +     init.num_parents = num_parents;
>> +     init.ops = clk_ops;
>> +
>> +     coreclk->hw.init = &init;
>> +     coreclk->ctrl_base = reg_base;
>> +     coreclk->fout_pll = __clk_lookup(pllclk);
>> +     coreclk->freq_table = freq_tbl;
>> +
>> +     clk = clk_register(NULL, &coreclk->hw);
>> +     if (IS_ERR(clk)) {
>> +             pr_err("%s: could not register coreclk %s\n",
>> __func__,     name);
>> +             kfree(coreclk);
>> +             return;
>> +     }
>> +     samsung_clk_add_lookup(clk, lookup_id);
>> +}
>
> I think, that those definitions for samsung_core_clock shall be moved
> to a separate file (maybe clk-exynos-cpu.c)?

The additions were not really much and the samsung/clk.c file is used
to hold all the common code for Samsung SoCs. So the additions were
put into this existing file itself.

>
> Moreover, maybe you can choose a shorter name?

Ok, I will try to find a shorter name for in the next version.

>
>> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
>> index 31b4174..0e43023 100644
>> --- a/drivers/clk/samsung/clk.h
>> +++ b/drivers/clk/samsung/clk.h
>> @@ -312,6 +312,37 @@ struct samsung_pll_clock {
>>       __PLL(_typ, _id, NULL, _name, _pname,
>> CLK_GET_RATE_NOCACHE, \ _lock, _con, _rtable, _alias)
>>
>> +/**
>> + * struct samsung_core_clock_freq_table: table of frequency
>> supported by
>> + * a core clock and associated data if any.
>> + * @freq: points to a table of supported frequencies (in KHz)
>> + * @freq_count: number of entries in the frequency table
>> + * @data: core clock specific data, if any
>> + */
>> +struct samsung_core_clock_freq_table {
>> +     const unsigned long     *freq;       /* in KHz */
>> +     unsigned long           freq_count;
>> +     const void              *data;
>> +};
>
> This is another instance of a structure, which holds the frequency for
> the system (like struct cpufreq_frequency_table).
>
> Unfortunately, since the clk subsystem starts very early, the
> cpufreq_frequency_table is not yet parsed from "operating-points"
> attribute.
>
> Maybe we can defer the clock registration?

The core clock is not limited to support only those frequencies which
the CPU operating point specifies. The core clock type can be used
independent of the cpufreq driver and hence has its own set of
supported frequencies. The cpufreq driver, depending the operating
points allowed, can request the core clock to setup the requested
clock speed.

>
>> +
>> +/**
>> + * struct samsung_core_clock: information about clock supplied to a
>> CPU core.
>> + * @hw: handle between ccf and core clock.
>> + * @ctrl_base: base address of the clock controller.
>> + * @fout_pll: clock handle representing the clock output of the
>> associated PLL.
>> + */
>> +struct samsung_core_clock {
>> +     struct clk_hw           hw;
>> +     void __iomem            *ctrl_base;
>> +     struct clk              *fout_pll;
>> +     const struct samsung_core_clock_freq_table *freq_table;
>> +};
>> +
>> +extern unsigned long samsung_core_clock_recalc_rate(struct clk_hw
>> *hw,
>> +                             unsigned long parent_rate);
>> +extern long samsung_core_clk_round_rate(struct clk_hw *hw,
>> +                     unsigned long drate, unsigned long *prate);
>
> IMHO, those methods shall be defined as static in a separate file.

These two functions are generic enough to be reused for core clock
implementations on multiple exynos platforms. Only the set_rate
callback is the one that will be specific to SoC and core clock. The
SoC specific implementation can reuse these two callback funcitons
when registering the core clock type. That is the reason these are not
static functions. The 3/6 patch of this series includes the usage of
these functions.

Thanks,
Thomas.

>
>> +
>>  extern void __init samsung_clk_init(struct device_node *np, void
>> __iomem *base, unsigned long nr_clks, unsigned long *rdump,
>>               unsigned long nr_rdump, unsigned long *soc_rdump,
>> @@ -337,7 +368,11 @@ extern void __init samsung_clk_register_gate(
>>               struct samsung_gate_clock *clk_list, unsigned int
>> nr_clk); extern void __init samsung_clk_register_pll(struct
>> samsung_pll_clock *pll_list, unsigned int nr_clk, void __iomem *base);
>> -
>> +extern void __init samsung_coreclk_register(const char *coreclk,
>> +             const char **parents, unsigned int num_parents,
>> +             const char *pllclk, const struct clk_ops *clk_ops,
>> +             unsigned int lookup_id,
>> +             const struct samsung_core_clock_freq_table
>> *freq_tbl); extern unsigned long _get_rate(const char *clk_name);
>>
>>  #endif /* __SAMSUNG_CLK_H */
>
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
