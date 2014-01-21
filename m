From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue, 21 Jan 2014 13:22:56 +0530
Subject: [PATCH v2 5/7] clk: exynos: use cpu-clock provider type to
 represent arm clock
In-Reply-To: <20140120084721.7f0050ea@amdc2363>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <1390047057-2239-6-git-send-email-thomas.ab@samsung.com>
 <20140120084721.7f0050ea@amdc2363>
Message-ID: <CAJuA9ajQWStgtFHDshM8PgRwizndzyTuRqvBNwh6GT4m-Exj6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 1:17 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Thomas,
>
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> With the addition of the new Samsung specific cpu-clock type, the
>> arm clock can be represented as a cpu-clock type and the independent
>> clock blocks that made up the arm clock can be removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  .../devicetree/bindings/clock/exynos5250-clock.txt |    1 +
>>  drivers/clk/samsung/clk-exynos4.c                  |   11 +++++------
>>  drivers/clk/samsung/clk-exynos5250.c               |    8 ++++----
>>  include/dt-bindings/clock/exynos5250.h             |    1 +
>>  4 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>> b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt index
>> 99eae9c..acf867a 100644 ---
>> a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt +++
>> b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt @@
>> -38,6 +38,7 @@ clock which they consume. ----------------------------
>>    fin_pll            1
>> +  armclk             12
>>
>>    [Clock Gate for Special Clocks]
>>
>> diff --git a/drivers/clk/samsung/clk-exynos4.c
>> b/drivers/clk/samsung/clk-exynos4.c index 010f071..efcf4a3 100644
>> --- a/drivers/clk/samsung/clk-exynos4.c
>> +++ b/drivers/clk/samsung/clk-exynos4.c
>> @@ -437,8 +437,6 @@ static struct samsung_mux_clock
>> exynos4x12_mux_clks[] __initdata = {
>>  /* list of divider clocks supported in all exynos4 soc's */
>>  static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>> -     DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
>> -     DIV(0, "div_core2", "div_core", DIV_CPU0, 28, 3),
>>       DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
>>       DIV(0, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
>>       DIV(0, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
>> @@ -484,8 +482,8 @@ static struct samsung_div_clock
>> exynos4_div_clks[] __initdata = { DIV(0, "div_spi_pre2", "div_spi2",
>> DIV_PERIL2, 8, 8), DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0,
>> 4), DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
>> -     DIV(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
>> -     DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24,
>> 3),
>> +     DIV_F(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24,
>> 3,
>> +                     CLK_GET_RATE_NOCACHE, 0),
>>       DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
>>                       CLK_SET_RATE_PARENT, 0),
>>       DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
>> @@ -870,7 +868,6 @@ static struct samsung_gate_clock
>> exynos4x12_gate_clks[] __initdata = {
>>  static struct samsung_clock_alias exynos4_aliases[] __initdata = {
>>       ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
>> -     ALIAS(CLK_ARM_CLK, NULL, "armclk"),
>>       ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
>>  };
>>
>> @@ -1125,12 +1122,14 @@ static void __init exynos4_clk_init(struct
>> device_node *np, samsung_clk_register_alias(exynos4_aliases,
>>                       ARRAY_SIZE(exynos4_aliases));
>>
>> +     samsung_register_arm_clock(np, CLK_ARM_CLK, "mout_apll",
>> reg_base); +
>
> I've got some doubts about allowing only the "mout_apll" clock to be the
> only parent for armclk Samsung clock.
>
> For the Exynos4412 it is also valid to have SCLK_MPLL_USER_C [*] as a
> parent for this clock.
>
> The problem is that you are reparenting the armclk to [*] with the
> register modification - no CCF involved.

The MUX_CORE mux is part of the larger cpu clock type and not
registered as a separate mux clock with CCF. So I would like to know
if there are any potential issues you see if this mux clock is
internally managed within the set_rate of the larger cpu clock type.

>
> I just would like to know if this is yours design decision or
> something, that we have overlooked in the v1 of this patch series.

I did overlook this one. This will be fixed in the next version by
ensuring that the dividers for SCLK_HPM clock will be updated only if
mout_apll is the parent of the MUX_HPM clock mux.

Thanks,
Thomas.

>
>>       pr_info("%s clocks: sclk_apll = %ld, sclk_mpll = %ld\n"
>>               "\tsclk_epll = %ld, sclk_vpll = %ld, arm_clk =
>> %ld\n", exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>>               _get_rate("sclk_apll"),
>> _get_rate("sclk_mpll"), _get_rate("sclk_epll"),
>> _get_rate("sclk_vpll"),
>> -             _get_rate("arm_clk"));
>> +             _get_rate("armclk"));
>>  }
>>
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5250.c
>> b/drivers/clk/samsung/clk-exynos5250.c index ff4beeb..487be36 100644
>> --- a/drivers/clk/samsung/clk-exynos5250.c
>> +++ b/drivers/clk/samsung/clk-exynos5250.c
>> @@ -298,9 +298,8 @@ static struct samsung_div_clock
>> exynos5250_div_clks[] __initdata = { /*
>>        * CMU_CPU
>>        */
>> -     DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
>> -     DIV(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
>> -     DIV_A(0, "div_arm2", "div_arm", DIV_CPU0, 28, 3, "armclk"),
>> +     DIV_F(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3,
>> +                     CLK_GET_RATE_NOCACHE, 0),
>>
>>       /*
>>        * CMU_TOP
>> @@ -684,8 +683,9 @@ static void __init exynos5250_clk_init(struct
>> device_node *np) ARRAY_SIZE(exynos5250_div_clks));
>>       samsung_clk_register_gate(exynos5250_gate_clks,
>>                       ARRAY_SIZE(exynos5250_gate_clks));
>> +     samsung_register_arm_clock(np, CLK_ARM_CLK, "mout_apll",
>> reg_base);
>>       pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
>> -                     _get_rate("div_arm2"));
>> +                     _get_rate("armclk"));
>>  }
>>  CLK_OF_DECLARE(exynos5250_clk, "samsung,exynos5250-clock",
>> exynos5250_clk_init); diff --git
>> a/include/dt-bindings/clock/exynos5250.h
>> b/include/dt-bindings/clock/exynos5250.h index 922f2dc..59a10fb
>> 100644 --- a/include/dt-bindings/clock/exynos5250.h +++
>> b/include/dt-bindings/clock/exynos5250.h @@ -21,6 +21,7 @@
>>  #define CLK_FOUT_CPLL                6
>>  #define CLK_FOUT_EPLL                7
>>  #define CLK_FOUT_VPLL                8
>> +#define CLK_ARM_CLK          12
>>
>>  /* gate for special clocks (sclk) */
>>  #define CLK_SCLK_CAM_BAYER   128
>
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
