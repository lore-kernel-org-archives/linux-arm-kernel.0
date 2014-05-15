From: ta.omasab@gmail.com (Thomas Abraham)
Date: Thu, 15 May 2014 13:18:24 +0530
Subject: [PATCH v4 5/8] clk: exynos: use cpu-clock provider type to
 represent arm clock.
In-Reply-To: <20140514213729.19795.77753@quantum>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-6-git-send-email-thomas.ab@samsung.com>
 <20140514213729.19795.77753@quantum>
Message-ID: <CAJuA9aiq6zzsdwDhGBUdnFDvtX65V1K_L4KgXpFpWvua18bfBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 3:07 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Thomas Abraham (2014-05-13 18:11:13)
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> With the addition of the new Samsung specific cpu-clock type, the
>> arm clock can be represented as a cpu-clock type and the independent
>> clock blocks that made up the arm clock can be removed.
>
> <rant>
>
> I am not a fan of this type of "clock hiding". Certainly the design of
> the CCF allows for a clock provider to obfuscate it's internals; there
> was never a requirement that every clock node be exposed to Linux as a
> struct clk. A truly obfuscated system could only expose leaf clocks that
> are consumed by Linux device drivers, and never expose any of the
> intermediary clocks in between the input clock signal (if it exists) and
> the leaf nodes.
>
> However I feel that this patch is more of a workaround to the fact that
> the clock framework today does not make DVFS transitions (or
> coordinated, multi-clock rate change transitions) easy to control. The
> generic "walk up the tree" algorithm might give you the right rate, but
> perhaps using a non-validated combination of PLL frequency and
> adjustable-rate dividers, or a combination that his higher jitter or is
> more likely to unlock at higher temperatures, etc.
>
> Back in the pre-CCF days lots of folks implemented this with "virtual"
> clock nodes that simply called "clk_set_rate" or whatever on the
> affected clocks, or even worse just banged a bunch of registers.
>
> The cbus clock series for Tegra is also looks a little like this.
>
> </rant>
>
> Thomas,
>
> Would a coordinated clock rate change method solve this problem for you
> in place of the cpu-clock provider type? A poorly conceived call graph
> for this might look something like:
>
> clk_set_rate(div_arm2, 1000000);
> -> if (div_arm2->coordinated == true)
>         clk_coordinate_rates(div_arm2, 1000000);
>         -> clk->ops->coordinate(div_arm2->hw, 1000000);
>            -> vendor_supplied_magic()
>
> The vendor_supplied_magic() would be a callback that essentially calls
> clk_set_rate() on all of the affected (coordinated) clocks. In your case
> that looks like mout_core, div_core, div_core2, arm_clk and sclk_apll
> for Exynos4.
>
> The trick is that calling clk_set_rate() from any driver would initiate
> this coordinated rate change, and then the exynos clock driver would set
> up the coordinated clocks itself. No new API is introduced to drivers
> (since it still uses clk_set_rate) and now a new clock provider doesn't
> have to be invented every time we have a couple of clocks involved in a
> DVFS transition.
>
> Does this sound right to you or have I horribly misinterpreted the point
> of these clock patches?

Mike,

Thanks for your comments. If I have understood the coordinated clock
as described above, I believe this patch series also attempts to do
almost the same thing. The advantage of using coordinated clock over
the approach in this series is that each platform need not define a
new clock type.

In this patch series, for all exynos SoC's, a new cpu clock type was
introduced which is reusable for multi-cluster exynos SoCs as well.
The new clock type is part of the clock driver and all drivers can use
standard clock API to access this clock type instance.

So probably, all the logic for the new cpu_clk clock type introduced
in this patch would go into the vendor_supplied_magic() callback. So
it sounds like the coordinated clock approach would be helpful. Is
this something that you are already working on?

Thanks,
Thomas.

>
> Thanks,
> Mike
>
>>
>> Cc: Tomasz Figa <t.figa@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos4.c      |   25 +++++++++----------------
>>  drivers/clk/samsung/clk-exynos5250.c   |   12 ++++++------
>>  include/dt-bindings/clock/exynos5250.h |    1 +
>>  3 files changed, 16 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
>> index b4f9672..7e3bb16c 100644
>> --- a/drivers/clk/samsung/clk-exynos4.c
>> +++ b/drivers/clk/samsung/clk-exynos4.c
>> @@ -471,7 +471,6 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
>>         MUX(0, "mout_fimd1", group1_p4210, E4210_SRC_LCD1, 0, 4),
>>         MUX(0, "mout_mipi1", group1_p4210, E4210_SRC_LCD1, 12, 4),
>>         MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1),
>> -       MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
>>         MUX(CLK_SCLK_VPLL, "sclk_vpll", sclk_vpll_p4210, SRC_TOP0, 8, 1),
>>         MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
>>         MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
>> @@ -530,7 +529,6 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
>>         MUX(0, "mout_jpeg", mout_jpeg_p, E4X12_SRC_CAM1, 8, 1),
>>         MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_DMC, 12, 1),
>>         MUX(CLK_SCLK_VPLL, "sclk_vpll", mout_vpll_p, SRC_TOP0, 8, 1),
>> -       MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
>>         MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
>>         MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
>>         MUX(CLK_MOUT_FIMC2, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
>> @@ -572,8 +570,6 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
>>
>>  /* list of divider clocks supported in all exynos4 soc's */
>>  static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>> -       DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
>> -       DIV(0, "div_core2", "div_core", DIV_CPU0, 28, 3),
>>         DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
>>         DIV(0, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
>>         DIV(0, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
>> @@ -619,8 +615,8 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>>         DIV(0, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
>>         DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
>>         DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
>> -       DIV(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
>> -       DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
>> +       DIV_F(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3,
>> +                       CLK_GET_RATE_NOCACHE, 0),
>>         DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
>>                         CLK_SET_RATE_PARENT, 0),
>>         DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
>> @@ -1003,12 +999,6 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
>>                 0),
>>  };
>>
>> -static struct samsung_clock_alias exynos4_aliases[] __initdata = {
>> -       ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
>> -       ALIAS(CLK_ARM_CLK, NULL, "armclk"),
>> -       ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
>> -};
>> -
>>  static struct samsung_clock_alias exynos4210_aliases[] __initdata = {
>>         ALIAS(CLK_SCLK_MPLL, NULL, "mout_mpll"),
>>  };
>> @@ -1241,6 +1231,9 @@ static void __init exynos4_clk_init(struct device_node *np,
>>                         ARRAY_SIZE(exynos4210_gate_clks));
>>                 samsung_clk_register_alias(exynos4210_aliases,
>>                         ARRAY_SIZE(exynos4210_aliases));
>> +               exynos_register_arm_clock(CLK_ARM_CLK, mout_core_p4210,
>> +                       ARRAY_SIZE(mout_core_p4210), reg_base, np, NULL,
>> +                       &samsung_clk_lock);
>>         } else {
>>                 samsung_clk_register_mux(exynos4x12_mux_clks,
>>                         ARRAY_SIZE(exynos4x12_mux_clks));
>> @@ -1250,11 +1243,11 @@ static void __init exynos4_clk_init(struct device_node *np,
>>                         ARRAY_SIZE(exynos4x12_gate_clks));
>>                 samsung_clk_register_alias(exynos4x12_aliases,
>>                         ARRAY_SIZE(exynos4x12_aliases));
>> +               exynos_register_arm_clock(CLK_ARM_CLK, mout_core_p4x12,
>> +                       ARRAY_SIZE(mout_core_p4x12), reg_base, np, NULL,
>> +                       &samsung_clk_lock);
>>         }
>>
>> -       samsung_clk_register_alias(exynos4_aliases,
>> -                       ARRAY_SIZE(exynos4_aliases));
>> -
>>         exynos4_clk_sleep_init();
>>
>>         pr_info("%s clocks: sclk_apll = %ld, sclk_mpll = %ld\n"
>> @@ -1262,7 +1255,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>>                 exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>>                 _get_rate("sclk_apll"), _get_rate("sclk_mpll"),
>>                 _get_rate("sclk_epll"), _get_rate("sclk_vpll"),
>> -               _get_rate("arm_clk"));
>> +               _get_rate("armclk"));
>>  }
>>
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
>> index e7ee442..3fe1ca0 100644
>> --- a/drivers/clk/samsung/clk-exynos5250.c
>> +++ b/drivers/clk/samsung/clk-exynos5250.c
>> @@ -260,8 +260,6 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
>>          */
>>         MUX_FA(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
>>                                         CLK_SET_RATE_PARENT, 0, "mout_apll"),
>> -       MUX_A(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
>> -
>>         /*
>>          * CMU_CORE
>>          */
>> @@ -339,9 +337,8 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
>>         /*
>>          * CMU_CPU
>>          */
>> -       DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
>> -       DIV(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
>> -       DIV_A(0, "div_arm2", "div_arm", DIV_CPU0, 28, 3, "armclk"),
>> +       DIV_F(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3,
>> +                       CLK_GET_RATE_NOCACHE, 0),
>>
>>         /*
>>          * CMU_TOP
>> @@ -721,10 +718,13 @@ static void __init exynos5250_clk_init(struct device_node *np)
>>                         ARRAY_SIZE(exynos5250_div_clks));
>>         samsung_clk_register_gate(exynos5250_gate_clks,
>>                         ARRAY_SIZE(exynos5250_gate_clks));
>> +       exynos_register_arm_clock(CLK_ARM_CLK, mout_cpu_p,
>> +                       ARRAY_SIZE(mout_cpu_p), reg_base, np, NULL,
>> +                       &samsung_clk_lock);
>>
>>         exynos5250_clk_sleep_init();
>>
>>         pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
>> -                       _get_rate("div_arm2"));
>> +                       _get_rate("armclk"));
>>  }
>>  CLK_OF_DECLARE(exynos5250_clk, "samsung,exynos5250-clock", exynos5250_clk_init);
>> diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
>> index 922f2dc..59a10fb 100644
>> --- a/include/dt-bindings/clock/exynos5250.h
>> +++ b/include/dt-bindings/clock/exynos5250.h
>> @@ -21,6 +21,7 @@
>>  #define CLK_FOUT_CPLL          6
>>  #define CLK_FOUT_EPLL          7
>>  #define CLK_FOUT_VPLL          8
>> +#define CLK_ARM_CLK            12
>>
>>  /* gate for special clocks (sclk) */
>>  #define CLK_SCLK_CAM_BAYER     128
>> --
>> 1.7.4.4
>>
