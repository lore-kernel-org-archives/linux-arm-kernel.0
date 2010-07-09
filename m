From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 9 Jul 2010 16:02:16 +0800
Subject: [PATCH 1/5] cpufreq-pxa3xx: use HSIO 312MHz on the pxa310
In-Reply-To: <201007081904.01464.pieterg@gmx.com>
References: <201007081904.01464.pieterg@gmx.com>
Message-ID: <AANLkTikbSZ47S4xmswCzj7O665t915EMLVYcbZLR4FUS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 9, 2010 at 1:04 AM, pieterg <pieterg@gmx.com> wrote:
>
> Signed-off-by: pieter <p.grimmerink@inepro.com>
> ---
> ?arch/arm/mach-pxa/cpufreq-pxa3xx.c | ? 13 ++++++++++++-
> ?1 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
> b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
> index 27fa329..8cc10c3 100644
> --- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
> +++ b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
> @@ -76,6 +76,14 @@ static struct pxa3xx_freq_info pxa300_freqs[] = {
> ? ? ? ?OP(624, 24, 2, 208, 260, 208, 312, 3, 1375, 1400), /* 624MHz */
> ?};
>
> +static struct pxa3xx_freq_info pxa310_freqs[] = {
> + ? ? ? /* ?CPU XL XN ?HSS DMEM SMEM SRAM DFI VCC_CORE VCC_SRAM */
> + ? ? ? OP(104, ?8, 1, 104, 260, ?78, 104, 3, 1000, 1100), /* 104MHz */
> + ? ? ? OP(208, 16, 1, 104, 260, 104, 156, 2, 1000, 1100), /* 208MHz */
> + ? ? ? OP(416, 16, 2, 156, 260, 104, 208, 2, 1100, 1200), /* 416MHz */
> + ? ? ? OP(624, 24, 2, 312, 260, 208, 312, 3, 1375, 1400), /* 624MHz */

What's wrong with 208MHz HSS on PXA310?

> +};
> +
> ?static struct pxa3xx_freq_info pxa320_freqs[] = {
> ? ? ? ?/* ?CPU XL XN ?HSS DMEM SMEM SRAM DFI VCC_CORE VCC_SRAM */
> ? ? ? ?OP(104, ?8, 1, 104, 260, ?78, 104, 3, 1000, 1100), /* 104MHz */
> @@ -214,9 +222,12 @@ static __init int pxa3xx_cpufreq_init(struct
> cpufreq_policy *policy)
> ? ? ? ?policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
> ? ? ? ?policy->cur = policy->min = policy->max = get_clk_frequency_khz(0);
>
> - ? ? ? if (cpu_is_pxa300() || cpu_is_pxa310())
> + ? ? ? if (cpu_is_pxa300())
> ? ? ? ? ? ? ? ?ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa300_freqs));
>
> + ? ? ? if (cpu_is_pxa310())
> + ? ? ? ? ? ? ? ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa310_freqs));
> +
> ? ? ? ?if (cpu_is_pxa320())
> ? ? ? ? ? ? ? ?ret = setup_freqs_table(policy, ARRAY_AND_SIZE(pxa320_freqs));
>
> --
> 1.6.5.rc1.44.ga1675
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
