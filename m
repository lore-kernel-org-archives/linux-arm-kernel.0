From: ta.omasab@gmail.com (Thomas Abraham)
Date: Sat, 11 Jan 2014 10:55:13 +0530
Subject: [PATCH 3/6] clk: samsung: register cpu clock provider for
 exynos4210 SoC
In-Reply-To: <20140110151812.5104cc92@amdc2363>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <1389283165-17708-4-git-send-email-thomas.ab@samsung.com>
 <20140110130424.6aa78438@amdc2363>
 <CAJuA9aidWvkPPXFfOysqQCQ4d7q_y51zbYxHCK9d-E8+ojfN_w@mail.gmail.com>
 <20140110151812.5104cc92@amdc2363>
Message-ID: <CAJuA9aj3ca9VNsQ9cadVH8pUpyYeaht3DufT3DW4jXuEN5BudA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 7:48 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Thomas,
>
>> Hi Lukasz,
>>
>> On Fri, Jan 10, 2014 at 5:34 PM, Lukasz Majewski
>> <l.majewski@samsung.com> wrote:
>> > Hi Thomas,
>> >
>> >> Add a new clock provider for ARM clock domain. This clock provider
>> >> is composed of multiple components which include mux_core,
>> >> div_core, div_core2, div_corem0, div_corem1, div_periph, div_atb,
>> >> div_pclk_dbg, div_copy and div_hpm. This composition of mutiple
>> >> components into a single clock provider helps with faster
>> >> completion of CPU clock speed switching during DVFS operations.
>> >>
>> >> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> >> ---
>> >>  drivers/clk/samsung/clk-exynos4.c |   96
>> >> ++++++++++++++++++++++++++++++++++++- 1 files changed, 95
>> >> insertions(+), 1 deletions(-)
>> >>
>> >> diff --git a/drivers/clk/samsung/clk-exynos4.c
>> >> b/drivers/clk/samsung/clk-exynos4.c index d967571..4bf2f93 100644
>> >> --- a/drivers/clk/samsung/clk-exynos4.c
>> >> +++ b/drivers/clk/samsung/clk-exynos4.c
>> >> @@ -108,8 +108,11 @@
>> >>  #define APLL_CON0            0x14100
>> >>  #define E4210_MPLL_CON0              0x14108
>> >>  #define SRC_CPU                      0x14200
>> >> +#define STAT_CPU             0x14400
>> >>  #define DIV_CPU0             0x14500
>> >>  #define DIV_CPU1             0x14504
>> >> +#define DIV_STAT_CPU0                0x14600
>> >> +#define DIV_STAT_CPU1                0x14604
>> >>  #define GATE_SCLK_CPU                0x14800
>> >>  #define GATE_IP_CPU          0x14900
>> >>  #define E4X12_DIV_ISP0               0x18300
>> >> @@ -289,7 +292,7 @@ static unsigned long exynos4_clk_regs[]
>> >> __initdata = { };
>> >>
>> >>  /* list of all parent clock list */
>> >> -PNAME(mout_apll_p)   = { "fin_pll", "fout_apll", };
>> >> +PNAME(mout_apll_p)   = { "fin_pll", "fout_apll1", };
>> >>  PNAME(mout_mpll_p)   = { "fin_pll", "fout_mpll", };
>> >>  PNAME(mout_epll_p)   = { "fin_pll", "fout_epll", };
>> >>  PNAME(mout_vpllsrc_p)        = { "fin_pll", "sclk_hdmi24m", };
>> >> @@ -306,6 +309,7 @@ PNAME(mout_onenand_p)  = {"aclk133",
>> >> "aclk160", }; PNAME(mout_onenand1_p) = {"mout_onenand",
>> >> "sclk_vpll", };
>> >>
>> >>  /* Exynos 4210-specific parent groups */
>> >> +PNAME(armclk_p) = { "fout_apll", };
>> >
>> > Here you only give no parent clock, but at
>> > samsung_coreclk_register() it is expected to provide list of
>> > parents.
>>
>> Here only one parent is listed, but the core clock type does not limit
>> the number of parents that can be specified. A specific implementation
>> can define and use multiple parents.
>
> I only pointed out that the definition of the:
>
> samsung_coreclk_register("armclk", armclk_p,
>                     ARRAY_SIZE(armclk_p), "fout_apll",
>                     &exynos4210_armclk_clk_ops, arm_clk,
>                     &exyno4210_armclk_table);
>
> Could only use parent, especially when you plan to change mux clock
> (apll vs. mpll) by writing directly to registers (which I think is bad).

This definition is not limited to be used only on Exynos4210. This is
a generic core clock registration helper function intended to be
reusable across multiple Samsung SoCs.

>
>>
>> >
>> >>  PNAME(sclk_vpll_p4210)       = { "mout_vpllsrc", "fout_vpll", };
>> >>  PNAME(mout_core_p4210)       = { "mout_apll", "sclk_mpll", };
>> >>  PNAME(sclk_ampll_p4210)      = { "sclk_mpll", "sclk_apll", };
>> >> @@ -1089,6 +1093,92 @@ static struct samsung_pll_clock
>> >> exynos4x12_plls[nr_plls] __initdata = { VPLL_LOCK, VPLL_CON0,
>> >> NULL), };
>> >>
>> >> +#define EXYNOS4210_DIV_CPU0(apll, pclk_dbg, atb, periph, corem1,
>> >> corem0) \
>> >> +             ((apll << 24) | (pclk_dbg << 20) | (atb << 16) | \
>> >> +             (periph << 12) | (corem1 << 8) | (corem0 << 4))
>> >> +#define EXYNOS4210_DIV_CPU1(hpm, copy)       \
>> >> +             ((hpm << 4) | (copy << 0))
>> >> +static const unsigned long exynos4210_armclk_data[][2] = {
>> >> +     { EXYNOS4210_DIV_CPU0(7, 1, 4, 3, 7, 3),
>> >> EXYNOS4210_DIV_CPU1(0, 5), },
>> >> +     { EXYNOS4210_DIV_CPU0(7, 1, 4, 3, 7, 3),
>> >> EXYNOS4210_DIV_CPU1(0, 4), },
>> >> +     { EXYNOS4210_DIV_CPU0(7, 1, 3, 3, 7, 3),
>> >> EXYNOS4210_DIV_CPU1(0, 3), },
>> >> +     { EXYNOS4210_DIV_CPU0(7, 1, 3, 3, 7, 3),
>> >> EXYNOS4210_DIV_CPU1(0, 3), },
>> >> +     { EXYNOS4210_DIV_CPU0(7, 1, 3, 3, 7, 3),
>> >> EXYNOS4210_DIV_CPU1(0, 3), },
>> >> +     { EXYNOS4210_DIV_CPU0(0, 1, 3, 1, 3, 1),
>> >> EXYNOS4210_DIV_CPU1(0, 3), }, +};
>> >> +
>> >
>> > What do you think about adding those parameters (like CPU dividers)
>> > as an attribute to /cpus/cpu at 0 node?
>>
>> Not in CPU node but may be in clock controller node since these values
>> are actually used by the clock controller.
>
> /cpus/cpu at 0 seems like a good place for them (since those DIVs are
> related to core)

DIVs belong to the clock controller, not the CPU, and are addressed
from the clock controller address space.

> .
> However, we can choose any better DT node to add it.
>
>> But since these values are
>> Exynos4210 specific and not generic enough to be reused across
>> multiple Exynos SoCs, there is little benefit in defining bindings and
>> parsing code for these values. It would be simpler enough to just
>> embed them in the code.
>
> It would be less to code, but isn't it the same ugly code, which we
> have now at exynos4xxx-cpufreq.c?
>
> With those values parsed from DT we can write generic code for the
> "arm_clk" clock. One clock implementation for cpufreq-cpu0.c (and maybe
> for arm_big_little.c) reused by Exynos4/5.

As replied in the 2/3 patch, if these values would change across
multiple platforms based on the same SoC, it makes sense to put them
into DT. Any data that is purely SoC specific and not going to change
across platforms can be embedded into the code itself.

>
>>
>> >
>> >> +static const unsigned long exynos4210_armclk_freqs[] = {
>> >> +     1200000 , 1000000, 800000, 500000, 400000, 200000,
>> >> +};
>> >
>> > Those freq's are going to be defined at /cpus/cpu at 0 at
>> > operating-points attribute (or if possible took from
>> > cpufreq_frequency table).
>>
>> These are frequencies supported by the core clock. But the cpufreq
>> table can use all or subset of the supported frequencies.
>
> I see your point, but I find this distinction here a bit superfluous.

Replied to similar comment in 2/3 patch.

>
>> The core
>> clock should be usable with the clock api independently and not tied
>> to be used only by cpufreq driver.
>
> But then still for Exynos it will use PLL's M P S coefficients which
> only corresponds to values defined at cpufreq's frequency table.

The PLL clocks are now separated out as PLL clock types in
samsung/clk-pll.c file. The P,M,S values of the PLLs are now handled
over there. So now the PLL is independent of the cpufreq driver and
can support any number of clock speeds not limited to the ones needed
by cpufreq.

>
> The set of frequencies for PLL, cpufreq and this clock is the same, so
> I think that we shall not define them in three different places.
>
> Could you give any example supporting your point of view?

A PLL is a hardware component that can be reused in multiple SoCs. A
PLL can generate and support 'x' number of clock speeds but a SoC
using that PLL might use only 'y' (a subset of 'x')  number of clock
speeds of the PLL due to certain hardware limitations. Then there are
platforms using a SoC which might use only 'z' (a subset of 'y') clock
speeds due to the power/performance requirements of the platform.

>
>>
>> >
>> >> +
>> >> +static const struct samsung_core_clock_freq_table
>> >> exyno4210_armclk_table = {
>> >> +     .freq           = exynos4210_armclk_freqs,
>> >> +     .freq_count     = ARRAY_SIZE(exynos4210_armclk_freqs),
>> >> +     .data           = (void *)exynos4210_armclk_data,
>> >> +};
>> >> +
>> >> +static int exynos4210_armclk_set_rate(struct clk_hw *hw, unsigned
>> >> long drate,
>> >> +                                     unsigned long prate)
>> >> +{
>> >> +     struct samsung_core_clock *armclk;
>> >> +     const struct samsung_core_clock_freq_table *freq_tbl;
>> >> +     unsigned long *freq_data;
>> >> +     unsigned long mux_reg, idx;
>> >> +     void __iomem *base;
>> >> +
>> >> +     if (drate == prate)
>> >> +             return 0;
>> >> +
>> >> +     armclk = container_of(hw, struct samsung_core_clock, hw);
>> >> +     freq_tbl = armclk->freq_table;
>> >> +     freq_data = (unsigned long *)freq_tbl->data;
>> >> +     base = armclk->ctrl_base;
>> >> +
>> >> +     for (idx = 0; idx < freq_tbl->freq_count; idx++, freq_data
>> >> += 2)
>> >> +             if ((freq_tbl->freq[idx] * 1000) == drate)
>> >> +                     break;
>> >> +
>> >> +     if (!armclk->fout_pll)
>> >> +             armclk->fout_pll = __clk_lookup("fout_apll");\
>> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^[*]
>> >
>> > I'm a bit confused here for two reasons. Please correct me if I'm
>> > wrong.
>> >
>> > 1. You go into this ->set_rate() because of calling clk_set_rate at
>> > "arm_clk" clock (numbered as 12 at clk-exynos4.c) at cpufreq-cpu0.c
>> >
>> > In a Exynos4210 we have:
>> > XXTI-> APLL -> fout_apll -> mout_apll -> mout_core -> div_core
>> > -> div_core2 -> arm_clk
>> >
>> > In the code you call directly the fout_apll which changes
>> > frequency. Then the change shall be propagated to all registered
>> > clocks.
>> > I think, that DIV and DIV1 shall be reduced before PLL change [*],
>> > to reflect the changes at CCF.
>>
>> The core clock implementation encapsulates multiple clock blocks (such
>> as dividers and muxes) which are in between the output of the APLL and
>> the point that actually is the cpu domain clock output.
>
> No problem with that. I mostly agree...
>
>> When a clock
>> frequency change has to be made, all these clock blocks encapsulated
>> within the core clock are programmed by pre-determined values.
>
> And what about the situation with already defined clocks (like
> "div_core" and "div_core2"). Those will not be updated when you first
> call clk_set_rate() and change by hand DIV and DIV1.
>
> What if you would like to have the PCLK_DBG clock used in the future?
> You would add it to CCF and the change will not propagate.

I did intend to remove individual clock blocks which are now
encapsulated within the core clock type from the clock driver file. I
missed doing that in this patch series.

>
>> This
>> approach allows very fast clock speed switching, instead of traversing
>> the entire CCF clock tree searching for individual clock blocks to be
>> programmed.
>
> Those are mostly DIV and MUXes. Recalculation shouldn't be time
> consuming.

I was mainly referring to the time taken to search the clock tree for
these individual clock blocks.

>
>>
>> >
>> >
>> >> +
>> >> +     if (drate < prate) {
>> >> +             mux_reg = readl(base + SRC_CPU);
>> >> +             writel(mux_reg | (1 << 16), base + SRC_CPU);
>> >> +             while (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
>> >> +                     ;
>> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [**]
>> >
>> > 2. I think, the above shall be done in a following way:
>> >
>> >         clk_set_parent(mout_core, mout_mpll);
>> >         clk_set_rate(armclk->fout_pll, drate);
>> >         clk_set_parent(mout_core, mout_apll);
>> >
>> > The direct write to registers [**] doesn't look compliant to CCF.
>> >
>>
>> As mentioned above, the clock block encapsulates these clock blocks
>> into a single clock and only this single encapsulated clock is
>> registered with CCF. The internal implementation of how the different
>> clock blocks are managed within this clock is independent of the CCF.
>
> I agree, that the CPU_DIV and CPU_DIV1 shall be changed atomically
> (without CCF).
>
> But on the situation [**] the MUX can be changed by clk_set_parent() as
> it is now done at exynosXXXX-cpufreq.c code.

The mux is also encapsulated into a larger clock type and this new
clock type know how the mux has to be configured.

>
>
>>
>> >
>> > I'd rather thought about using "mout_core" instead of "arm_clk".
>> > Then we would get access to the parent directly:
>> >
>> >         struct clk *parent = clk_get_parent(hw->clk);
>> >
>> > so we set the parents explicitly (at clk registration) and call
>> > ->recalc_rate for clocks which are lower in the tree (like
>> > "div_core", "div_core2").
>>
>> That was not the intention as mentioned above.
>
> This is just another possible solution to the problem.
>
>>
>> Thanks,
>> Thomas.
>>
>> >
>> >> +             clk_set_rate(armclk->fout_pll, drate);
>> >> +     }
>> >> +
>> >> +     writel(freq_data[0], base + DIV_CPU0);
>> >> +     while (readl(base + DIV_STAT_CPU0) != 0)
>> >> +             ;
>> >> +     writel(freq_data[1], base + DIV_CPU1);
>> >> +     while (readl(base + DIV_STAT_CPU1) != 0)
>> >> +             ;
>> >> +
>> >> +     if (drate > prate) {
>> >> +             mux_reg = readl(base + SRC_CPU);
>> >> +             writel(mux_reg | (1 << 16), base + SRC_CPU);
>> >> +             while (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
>> >> +                     ;
>> >> +
>> >> +             clk_set_rate(armclk->fout_pll, drate);
>> >> +     }
>> >> +
>> >> +     mux_reg = readl(base + SRC_CPU);
>> >> +     writel(mux_reg & ~(1 << 16), base + SRC_CPU);
>> >> +     while (((readl(base + STAT_CPU) >> 16) & 0x7) != 1)
>> >> +                     ;
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +static const struct clk_ops exynos4210_armclk_clk_ops = {
>> >> +     .recalc_rate = samsung_core_clock_recalc_rate,
>> >> +     .round_rate = samsung_core_clk_round_rate,
>> >> +     .set_rate = exynos4210_armclk_set_rate,
>> >> +};
>> >> +
>> >>  /* register exynos4 clocks */
>> >>  static void __init exynos4_clk_init(struct device_node *np,
>> >>                                   enum exynos4_soc exynos4_soc,
>> >> @@ -1164,6 +1254,10 @@ static void __init exynos4_clk_init(struct
>> >> device_node *np, ARRAY_SIZE(exynos4210_gate_clks));
>> >>               samsung_clk_register_alias(exynos4210_aliases,
>> >>                       ARRAY_SIZE(exynos4210_aliases));
>> >> +             samsung_coreclk_register("armclk", armclk_p,
>> >> +                     ARRAY_SIZE(armclk_p), "fout_apll",
>> >> +                     &exynos4210_armclk_clk_ops, arm_clk,
>> >> +                     &exyno4210_armclk_table);
>> >>       } else {
>> >>               samsung_clk_register_mux(exynos4x12_mux_clks,
>> >>                       ARRAY_SIZE(exynos4x12_mux_clks));
>> >
>> >
>> >
>> > --
>> > Best regards,
>> >
>> > Lukasz Majewski
>> >
>> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
>
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
