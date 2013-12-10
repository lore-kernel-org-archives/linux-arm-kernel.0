From: arunkk.samsung@gmail.com (Arun Kumar K)
Date: Tue, 10 Dec 2013 10:10:06 +0530
Subject: [PATCH 3/3] cpufreq: exynos: Add exynos5420 cpufreq driver
In-Reply-To: <20131209092324.1f8b6502@amdc2363>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
 <1386323284-15646-4-git-send-email-arun.kk@samsung.com>
 <20131209092324.1f8b6502@amdc2363>
Message-ID: <CALt3h7-25_mW5SnnTbZWjoF0pOZxsU5Gg6FqOdoz1MgdH7gm5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

Thank you for the review.


On Mon, Dec 9, 2013 at 1:53 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Arun,
>
>> From: "Arjun.K.V" <arjun.kv@samsung.com>
>>
>> The patch adds cpufreq driver for exynos5420.
>>
>> Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm          |   11 ++
>>  drivers/cpufreq/Makefile             |    1 +
>>  drivers/cpufreq/exynos-cpufreq.c     |    2 +
>>  drivers/cpufreq/exynos-cpufreq.h     |    8 +
>>  drivers/cpufreq/exynos5420-cpufreq.c |  346
>> ++++++++++++++++++++++++++++++++++ 5 files changed, 368 insertions(+)
>>  create mode 100644 drivers/cpufreq/exynos5420-cpufreq.c
>
> I think that we shall cleanup "a bit" the cpufreq code for exynos.
> Now we have [*]:
> - exynos4x12-cpufreq.c
> - exynos4210-cpufreq.c
> - exynos5250-cpufreq.c
>
> and you want to add exynos5420-cpufreq.c
>
> Those files are pretty similar, so are a very good candidates for
> cleanup.
>

Yes thats right. There is a lot of common code now in these files.

> All supported processors (up to exynos5250) allows for frequency
> setting on all cores in the SoC.
>
> Those files [*] can be easily replaced by cpu0-cpufreq.c generic code.
> Also we can provide frequency, voltage table and ASV if needed via
> device tree.
>
> I did some preliminary work on this for Exynos4412. My plan is to
> continue when things with BOOST "calm down" :-).
>

Ok I will wait for your patches then :)

[snip]

>> +static unsigned int exynos5420_volt_table[CPUFREQ_NUM_LEVELS];
>> +static struct cpufreq_frequency_table exynos5420_freq_table[] = {
>> +     {L0,  2000 * 1000},
>> +     {L1,  1900 * 1000},
>> +     {L2,  1800 * 1000},
>> +     {L3,  1700 * 1000},
>> +     {L4,  1600 * 1000},
>> +     {L5,  1500 * 1000},
>> +     {L6,  1400 * 1000},
>> +     {L7,  1300 * 1000},
>> +     {L8,  1200 * 1000},
>> +     {L9,  1100 * 1000},
>> +     {L10, 1000 * 1000},
>> +     {L11,  900 * 1000},
>> +     {L12,  800 * 1000},
>> +     {L13,  700 * 1000},
>> +     {L14,  600 * 1000},
>> +     {L15,  500 * 1000},
>> +     {L16,  400 * 1000},
>> +     {L17,  300 * 1000},
>> +     {L18,  200 * 1000},
>> +     {0, CPUFREQ_TABLE_END},
>> +};
>
> This shall be provided via device tree.
>

Ok.

>> +
>> +static struct cpufreq_clkdiv
>> exynos5420_clkdiv_table[CPUFREQ_NUM_LEVELS]; +
>> +static unsigned int clkdiv_cpu0_5420[CPUFREQ_NUM_LEVELS][7] = {
>> +     /*
>> +      *  Clock divider values for {CPUD, ATB, PCLK_DBG, APLL,
>> ARM2}
>> +      */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L0: 2.0GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L1: 1.9GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L2: 1.8GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L3: 1.7GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L4: 1.6GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L5: 1.5GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L6: 1.4GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L7: 1.3GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L8: 1.2GHz */
>> +     { 2, 7, 7, 3, 0 }, /* ARM L9: 1.1GHz */
>> +     { 2, 6, 6, 3, 0 }, /* ARM L10: 1GHz */
>> +     { 2, 6, 6, 3, 0 }, /* ARM L11: 900MHz */
>> +     { 2, 5, 5, 3, 0 }, /* ARM L12: 800MHz */
>> +     { 2, 5, 5, 3, 0 }, /* ARM L13: 700MHz */
>> +     { 2, 4, 4, 3, 0 }, /* ARM L14: 600MHz */
>> +     { 2, 3, 3, 3, 0 }, /* ARM L15: 500MHz */
>> +     { 2, 3, 3, 3, 0 }, /* ARM L16: 400MHz */
>> +     { 2, 3, 3, 3, 0 }, /* ARM L17: 300MHz */
>> +     { 2, 3, 3, 3, 0 }, /* ARM L18: 200MHz */
>> +};
>
> This table is not needed (as similar ones in this patch), since the
> Common Clock Framework (and more specific the PLL code for Exynos)
> shall handle this.
>

Actually these values are not for PLL, but for the dividers.
If you see below, the PLL rate setting is done through clk_set_rate() going
via CCF. But I found an issue if the divider values are set via
clk_set_rate API.
What I found is, the system goes into freeze if all the divider values are not
set in one shot. So we cannot call multiple clk_set_rate()'s on each divider.
Thats why I continued with non-CCF way of setting the divider.
Are you taking care of this requirement in your restructuring?

>> +
>> +unsigned int clkdiv_cpu1_5420[CPUFREQ_NUM_LEVELS][2] = {
>> +     /* Clock divider values for { copy, HPM } */
>> +     { 7, 7 }, /* ARM L0: 2.0GHz */
>> +     { 7, 7 }, /* ARM L1: 1.9GHz */
>> +     { 7, 7 }, /* ARM L2: 1.8GHz */
>> +     { 7, 7 }, /* ARM L3: 1.7GHz */
>> +     { 7, 7 }, /* ARM L4: 1.6GHz */
>> +     { 7, 7 }, /* ARM L5: 1.5GHz */
>> +     { 7, 7 }, /* ARM L6: 1.4GHz */
>> +     { 7, 7 }, /* ARM L7: 1.3GHz */
>> +     { 7, 7 }, /* ARM L8: 1.2GHz */
>> +     { 7, 7 }, /* ARM L9: 1.1GHz */
>> +     { 7, 7 }, /* ARM L10: 1GHz */
>> +     { 7, 7 }, /* ARM L11: 900MHz */
>> +     { 7, 7 }, /* ARM L12: 800MHz */
>> +     { 7, 7 }, /* ARM L13: 700MHz */
>> +     { 7, 7 }, /* ARM L14: 600MHz */
>> +     { 7, 7 }, /* ARM L15: 500MHz */
>> +     { 7, 7 }, /* ARM L16: 400MHz */
>> +     { 7, 7 }, /* ARM L17: 300MHz */
>> +     { 7, 7 }, /* ARM L18: 200MHz */
>> +};
>> +
>> +/*
>> + * Default ASV table
>> + */
>> +static const unsigned int asv_voltage_5420[CPUFREQ_NUM_LEVELS] = {
>> +     1300000,        /* L0  2000 */
>> +     1300000,        /* L1  1900 */
>> +     1200000,        /* L2  1800 */
>> +     1200000,        /* L3  1700 */
>> +     1200000,        /* L4  1600 */
>> +     1175000,        /* L5  1500 */
>> +     1150000,        /* L6  1400 */
>> +     1125000,        /* L7  1300 */
>> +     1100000,        /* L8  1200 */
>> +     1075000,        /* L9  1100 */
>> +     1050000,        /* L10 1000 */
>> +     1000000,        /* L11  900 */
>> +      950000,        /* L12  800 */
>> +      925000,        /* L13  700 */
>> +      900000,        /* L14  600 */
>> +      900000,        /* L15  500 */
>> +      900000,        /* L16  400 */
>> +      900000,        /* L17  300 */
>> +      900000,        /* L18  200 */
>> +};
>> +
>
> If I remember correctly, some code for ASV generic framework has
> been posted recently (by Sachin):
>
> http://article.gmane.org/gmane.linux.power-management.general/40453/match=asv+framework
>

Yes that will be incorporated with ASV support enabled. Even without
ASV enabled, a default
table can be provided with safe operating voltages. If ASV is enabled,
these values wont be used.

>> +static void exynos5420_set_clkdiv(unsigned int div_index)
>> +{
>> +     unsigned int tmp;
>> +
>> +     /* Change Divider - CPU0 for CMU_CPU */
>> +     tmp = exynos5420_clkdiv_table[div_index].clkdiv;
>> +     __raw_writel(tmp, EXYNOS5_CLKDIV_CPU0);
>> +
>> +     do {
>> +             cpu_relax();
>> +             tmp = __raw_readl(EXYNOS5_CLKDIV_STATCPU0);
>> +     } while (tmp & EXYNOS5_CLKDIV_STATCPU0_MASK);
>> +     pr_debug("DIV_CPU0[0x%x]\n",
>> __raw_readl(EXYNOS5_CLKDIV_CPU0)); +
>> +     /* Change Divider - CPU1 for CMU_CPU */
>> +     tmp = exynos5420_clkdiv_table[div_index].clkdiv1;
>> +     __raw_writel(tmp, EXYNOS5_CLKDIV_CPU1);
>> +
>> +     do {
>> +             cpu_relax();
>> +             tmp = __raw_readl(EXYNOS5_CLKDIV_STATCPU1);
>> +     } while (tmp & EXYNOS5_CLKDIV_STATCPU1_MASK);
>> +     pr_debug("DIV_CPU1[0x%x]\n",
>> __raw_readl(EXYNOS5_CLKDIV_CPU1)); +}
>> +
>
> Operations on raw registers - behind the Common Clock Framework is
> asking for a trouble. I had a similar issues. Please refer to
> appropriate Exynos4412/4210 patches.
>
> http://article.gmane.org/gmane.linux.kernel/1575500/match=cpufreq
>

As mentioned earlier, I couldnt avoid doing it for divider values setting.

Regards
Arun
