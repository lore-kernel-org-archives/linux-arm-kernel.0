From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 05 Feb 2014 14:15:20 +0100
Subject: [PATCH v2 7/7] cpufreq: exynos: remove all exynos specific cpufreq
 driver support
In-Reply-To: <CAJuA9aiokvq-=a-hK=nJnTkZTGF1Zc2ERXk2rpk-Xv7gUHaVpw@mail.gmail.com>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <1390047057-2239-8-git-send-email-thomas.ab@samsung.com>
 <20140120090815.39e8c21a@amdc2363>
 <CAJuA9agAQRK8NjkYU7Pr-z2AxyUoD7+NH+Y+6Ar9eCi_tbatgQ@mail.gmail.com>
 <20140205124459.61c7da0e@amdc2363>
 <CAJuA9aiokvq-=a-hK=nJnTkZTGF1Zc2ERXk2rpk-Xv7gUHaVpw@mail.gmail.com>
Message-ID: <20140205141520.6a2e8ca4@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> Hi Lukasz,
> 
> On Wed, Feb 5, 2014 at 5:14 PM, Lukasz Majewski
> <l.majewski@samsung.com> wrote:
> > Hi Thomas,
> >
> > Fist of all, thanks for your patches.
> >
> >> Hi Lukasz,
> >>
> >> On Mon, Jan 20, 2014 at 1:38 PM, Lukasz Majewski
> >> <l.majewski@samsung.com> wrote:
> >> > Hi Thomas,
> >> >
> >> >> From: Thomas Abraham <thomas.ab@samsung.com>
> >> >>
> >> >> Exynos4210, Exynos4x12 and Exynos5250 based platforms have
> >> >> switched over to use cpufreq-cpu0 driver for cpufreq
> >> >> functionality. So the Exynos specific cpufreq drivers for these
> >> >> platforms can be removed.
> >> >>
> >>
> >> <snip>
> >>
> >> >> -static unsigned int exynos4x12_volt_table[] = {
> >> >> -     1350000, 1287500, 1250000, 1187500, 1137500, 1087500,
> >> >> 1037500,
> >> >> -     1000000,  987500,  975000,  950000,  925000,  900000,
> >> >> 900000 -};
> >> >> -
> >> >> -static struct cpufreq_frequency_table exynos4x12_freq_table[]
> >> >> = {
> >> >> -     {CPUFREQ_BOOST_FREQ, 1500 * 1000},
> >> >
> >> > Here, you are removing BOOST support for Exynos4412, without any
> >> > code, which brings back this functionality in the new code.
> >> >
> >> > I'd propose adding new property to cpus node and during
> >> > operating-points parsing mark the entry at the
> >> > cpufreq_frequency_table accordingly.
> >>
> >> I tried doing this as you suggested with [1] but looks like that
> >> will not go through at this point.
> >
> > I've read your patches regarding OPP. In my opinion, despite the
> > problem with further OPP format discussion (which is ongoing and
> > probably will take some time), there is a palatable solution
> > (presented below).
> >
> >> The other alternative would be to use
> >> exynos specific cpufreq drivers only if multiplatform config is not
> >> selected or use cpufreq-cpu0 if multiplatform config is selected
> >> (but this is not something I would want to do). With this, there
> >> are issues like clock blocks encapsulated within the opaque clock
> >> type cannot be removed since exynos specific cpufreq drivers need
> >> it and hence it is not really a clean solution.
> >
> > It would be a maintenance nightmare. We cannot afford to do such
> > huge cleanup only partially. The rationale for the whole clean up
> > is to remove exynosXXXX-cpufreq.c files.
> >
> > I also share your doubts here. We shall NOT do it this way.
> >
> >>The other option is to drop the support
> >> for boost on exynos4x12 for now and reintroduce that when the OPP
> >> bindings have been finalized.
> >
> > So you want to drop the BOOST kernel functionality just because you
> > are doing clean up and this feature is problematic to provide at new
> > approach?
> >
> >> Would that be okay?
> >
> > It is NOT acceptable. Sorry, but NAK.
> >
> >> Any other
> >> suggestions will also be helpful.
> >
> > For me it would be perfectly fine to see at device tree CPU0 node
> > code proposed by Nishanth:
> >
> > operating-points = < Fa Va
> >         Fb Vb
> >         Fc Vc
> >         Fd Vd
> >         >;
> > boost-frequencies = <Fc Fd>;
> >
> > And then the cpufreq table could be properly modified by marking
> > relevant frequencies as CPUFREQ_BOOST_FREQ.
> 
> Okay, thanks. Initially it looked like adding boost frequencies into
> operating-modes would convolute it but I guess I was wrong. So I will
> add support for looking up "boost-frequencies" property in
> dev_pm_opp_init_cpufreq_table function and mark the frequencies listed
> in this binding as CPUFREQ_BOOST_FREQ.

That would be great. I'm looking forward for patches :-). 

Thanks.

> 
> Thanks,
> Thomas.
> 
> >
> >>
> >> Thanks,
> >> Thomas.
> >>
> >> >
> >> >> -     {L1, 1400 * 1000},
> >> >> -     {L2, 1300 * 1000},
> >> >> -     {L3, 1200 * 1000},
> >> >> -     {L4, 1100 * 1000},
> >> >> -     {L5, 1000 * 1000},
> >> >> -     {L6,  900 * 1000},
> >> >> -     {L7,  800 * 1000},
> >> >> -     {L8,  700 * 1000},
> >> >> -     {L9,  600 * 1000},
> >> >> -     {L10, 500 * 1000},
> >> >> -     {L11, 400 * 1000},
> >> >> -     {L12, 300 * 1000},
> >> >> -     {L13, 200 * 1000},
> >> >> -     {0, CPUFREQ_TABLE_END},
> >> >> -};
> >> >> -
> >> >> -static struct apll_freq *apll_freq_4x12;
> >> >> -
> >> >> -static struct apll_freq apll_freq_4212[] = {
> >> >> -     /*
> >> >> -      * values:
> >> >> -      * freq
> >> >> -      * clock divider for CORE, COREM0, COREM1, PERIPH, ATB,
> >> >> PCLK_DBG, APLL, CORE2
> >> >> -      * clock divider for COPY, HPM, RESERVED
> >> >> -      * PLL M, P, S
> >> >> -      */
> >> >> -     APLL_FREQ(1500, 0, 3, 7, 0, 6, 1, 2, 0, 6, 2, 0, 250, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(1400, 0, 3, 7, 0, 6, 1, 2, 0, 6, 2, 0, 175, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(1300, 0, 3, 7, 0, 5, 1, 2, 0, 5, 2, 0, 325, 6,
> >> >> 0),
> >> >> -     APLL_FREQ(1200, 0, 3, 7, 0, 5, 1, 2, 0, 5, 2, 0, 200, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(1100, 0, 3, 6, 0, 4, 1, 2, 0, 4, 2, 0, 275, 6,
> >> >> 0),
> >> >> -     APLL_FREQ(1000, 0, 2, 5, 0, 4, 1, 1, 0, 4, 2, 0, 125, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(900,  0, 2, 5, 0, 3, 1, 1, 0, 3, 2, 0, 150, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(800,  0, 2, 5, 0, 3, 1, 1, 0, 3, 2, 0, 100, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(700,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 175, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(600,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 200, 4,
> >> >> 1),
> >> >> -     APLL_FREQ(500,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 125, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(400,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 100, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(300,  0, 2, 4, 0, 2, 1, 1, 0, 3, 2, 0, 200, 4,
> >> >> 2),
> >> >> -     APLL_FREQ(200,  0, 1, 3, 0, 1, 1, 1, 0, 3, 2, 0, 100, 3,
> >> >> 2), -};
> >> >> -
> >> >> -static struct apll_freq apll_freq_4412[] = {
> >> >> -     /*
> >> >> -      * values:
> >> >> -      * freq
> >> >> -      * clock divider for CORE, COREM0, COREM1, PERIPH, ATB,
> >> >> PCLK_DBG, APLL, CORE2
> >> >> -      * clock divider for COPY, HPM, CORES
> >> >> -      * PLL M, P, S
> >> >> -      */
> >> >> -     APLL_FREQ(1500, 0, 3, 7, 0, 6, 1, 2, 0, 6, 0, 7, 250, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(1400, 0, 3, 7, 0, 6, 1, 2, 0, 6, 0, 6, 175, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(1300, 0, 3, 7, 0, 5, 1, 2, 0, 5, 0, 6, 325, 6,
> >> >> 0),
> >> >> -     APLL_FREQ(1200, 0, 3, 7, 0, 5, 1, 2, 0, 5, 0, 5, 200, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(1100, 0, 3, 6, 0, 4, 1, 2, 0, 4, 0, 5, 275, 6,
> >> >> 0),
> >> >> -     APLL_FREQ(1000, 0, 2, 5, 0, 4, 1, 1, 0, 4, 0, 4, 125, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(900,  0, 2, 5, 0, 3, 1, 1, 0, 3, 0, 4, 150, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(800,  0, 2, 5, 0, 3, 1, 1, 0, 3, 0, 3, 100, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(700,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 3, 175, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(600,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 2, 200, 4,
> >> >> 1),
> >> >> -     APLL_FREQ(500,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 2, 125, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(400,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 1, 100, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(300,  0, 2, 4, 0, 2, 1, 1, 0, 3, 0, 1, 200, 4,
> >> >> 2),
> >> >> -     APLL_FREQ(200,  0, 1, 3, 0, 1, 1, 1, 0, 3, 0, 0, 100, 3,
> >> >> 2), -};
> >> >> -
> >> >> -static void exynos4x12_set_clkdiv(unsigned int div_index)
> >> >> -{
> >> >> -     unsigned int tmp;
> >> >> -     unsigned int stat_cpu1;
> >> >> -
> >> >> -     /* Change Divider - CPU0 */
> >> >> -
> >> >> -     tmp = apll_freq_4x12[div_index].clk_div_cpu0;
> >> >> -
> >> >> -     __raw_writel(tmp, EXYNOS4_CLKDIV_CPU);
> >> >> -
> >> >> -     while (__raw_readl(EXYNOS4_CLKDIV_STATCPU) & 0x11111111)
> >> >> -             cpu_relax();
> >> >> -
> >> >> -     /* Change Divider - CPU1 */
> >> >> -     tmp = apll_freq_4x12[div_index].clk_div_cpu1;
> >> >> -
> >> >> -     __raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
> >> >> -     if (soc_is_exynos4212())
> >> >> -             stat_cpu1 = 0x11;
> >> >> -     else
> >> >> -             stat_cpu1 = 0x111;
> >> >> -
> >> >> -     while (__raw_readl(EXYNOS4_CLKDIV_STATCPU1) & stat_cpu1)
> >> >> -             cpu_relax();
> >> >> -}
> >> >> -
> >> >> -static void exynos4x12_set_apll(unsigned int index)
> >> >> -{
> >> >> -     unsigned int tmp, freq = apll_freq_4x12[index].freq;
> >> >> -
> >> >> -     /* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
> >> >> -     clk_set_parent(moutcore, mout_mpll);
> >> >> -
> >> >> -     do {
> >> >> -             cpu_relax();
> >> >> -             tmp = (__raw_readl(EXYNOS4_CLKMUX_STATCPU)
> >> >> -                     >> EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
> >> >> -             tmp &= 0x7;
> >> >> -     } while (tmp != 0x2);
> >> >> -
> >> >> -     clk_set_rate(mout_apll, freq * 1000);
> >> >> -
> >> >> -     /* MUX_CORE_SEL = APLL */
> >> >> -     clk_set_parent(moutcore, mout_apll);
> >> >> -
> >> >> -     do {
> >> >> -             cpu_relax();
> >> >> -             tmp = __raw_readl(EXYNOS4_CLKMUX_STATCPU);
> >> >> -             tmp &= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
> >> >> -     } while (tmp != (0x1 <<
> >> >> EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT)); -}
> >> >> -
> >> >> -static void exynos4x12_set_frequency(unsigned int old_index,
> >> >> -                               unsigned int new_index)
> >> >> -{
> >> >> -     if (old_index > new_index) {
> >> >> -             exynos4x12_set_clkdiv(new_index);
> >> >> -             exynos4x12_set_apll(new_index);
> >> >> -     } else if (old_index < new_index) {
> >> >> -             exynos4x12_set_apll(new_index);
> >> >> -             exynos4x12_set_clkdiv(new_index);
> >> >> -     }
> >> >> -}
> >> >> -
> >> >> -int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
> >> >> -{
> >> >> -     unsigned long rate;
> >> >> -
> >> >> -     cpu_clk = clk_get(NULL, "armclk");
> >> >> -     if (IS_ERR(cpu_clk))
> >> >> -             return PTR_ERR(cpu_clk);
> >> >> -
> >> >> -     moutcore = clk_get(NULL, "moutcore");
> >> >> -     if (IS_ERR(moutcore))
> >> >> -             goto err_moutcore;
> >> >> -
> >> >> -     mout_mpll = clk_get(NULL, "mout_mpll");
> >> >> -     if (IS_ERR(mout_mpll))
> >> >> -             goto err_mout_mpll;
> >> >> -
> >> >> -     rate = clk_get_rate(mout_mpll) / 1000;
> >> >> -
> >> >> -     mout_apll = clk_get(NULL, "mout_apll");
> >> >> -     if (IS_ERR(mout_apll))
> >> >> -             goto err_mout_apll;
> >> >> -
> >> >> -     if (soc_is_exynos4212())
> >> >> -             apll_freq_4x12 = apll_freq_4212;
> >> >> -     else
> >> >> -             apll_freq_4x12 = apll_freq_4412;
> >> >> -
> >> >> -     info->mpll_freq_khz = rate;
> >> >> -     /* 800Mhz */
> >> >> -     info->pll_safe_idx = L7;
> >> >> -     info->cpu_clk = cpu_clk;
> >> >> -     info->volt_table = exynos4x12_volt_table;
> >> >> -     info->freq_table = exynos4x12_freq_table;
> >> >> -     info->set_freq = exynos4x12_set_frequency;
> >> >> -
> >> >> -     return 0;
> >> >> -
> >> >> -err_mout_apll:
> >> >> -     clk_put(mout_mpll);
> >> >> -err_mout_mpll:
> >> >> -     clk_put(moutcore);
> >> >> -err_moutcore:
> >> >> -     clk_put(cpu_clk);
> >> >> -
> >> >> -     pr_debug("%s: failed initialization\n", __func__);
> >> >> -     return -EINVAL;
> >> >> -}
> >> >> diff --git a/drivers/cpufreq/exynos5250-cpufreq.c
> >> >> b/drivers/cpufreq/exynos5250-cpufreq.c deleted file mode 100644
> >> >> index 5f90b82..0000000
> >> >> --- a/drivers/cpufreq/exynos5250-cpufreq.c
> >> >> +++ /dev/null
> >> >> @@ -1,183 +0,0 @@
> >> >> -/*
> >> >> - * Copyright (c) 2010-20122Samsung Electronics Co., Ltd.
> >> >> - *           http://www.samsung.com
> >> >> - *
> >> >> - * EXYNOS5250 - CPU frequency scaling support
> >> >> - *
> >> >> - * This program is free software; you can redistribute it
> >> >> and/or modify
> >> >> - * it under the terms of the GNU General Public License
> >> >> version 2 as
> >> >> - * published by the Free Software Foundation.
> >> >> -*/
> >> >> -
> >> >> -#include <linux/module.h>
> >> >> -#include <linux/kernel.h>
> >> >> -#include <linux/err.h>
> >> >> -#include <linux/clk.h>
> >> >> -#include <linux/io.h>
> >> >> -#include <linux/slab.h>
> >> >> -#include <linux/cpufreq.h>
> >> >> -
> >> >> -#include <mach/map.h>
> >> >> -
> >> >> -#include "exynos-cpufreq.h"
> >> >> -
> >> >> -static struct clk *cpu_clk;
> >> >> -static struct clk *moutcore;
> >> >> -static struct clk *mout_mpll;
> >> >> -static struct clk *mout_apll;
> >> >> -
> >> >> -static unsigned int exynos5250_volt_table[] = {
> >> >> -     1300000, 1250000, 1225000, 1200000, 1150000,
> >> >> -     1125000, 1100000, 1075000, 1050000, 1025000,
> >> >> -     1012500, 1000000,  975000,  950000,  937500,
> >> >> -     925000
> >> >> -};
> >> >> -
> >> >> -static struct cpufreq_frequency_table exynos5250_freq_table[]
> >> >> = {
> >> >> -     {L0, 1700 * 1000},
> >> >> -     {L1, 1600 * 1000},
> >> >> -     {L2, 1500 * 1000},
> >> >> -     {L3, 1400 * 1000},
> >> >> -     {L4, 1300 * 1000},
> >> >> -     {L5, 1200 * 1000},
> >> >> -     {L6, 1100 * 1000},
> >> >> -     {L7, 1000 * 1000},
> >> >> -     {L8,  900 * 1000},
> >> >> -     {L9,  800 * 1000},
> >> >> -     {L10, 700 * 1000},
> >> >> -     {L11, 600 * 1000},
> >> >> -     {L12, 500 * 1000},
> >> >> -     {L13, 400 * 1000},
> >> >> -     {L14, 300 * 1000},
> >> >> -     {L15, 200 * 1000},
> >> >> -     {0, CPUFREQ_TABLE_END},
> >> >> -};
> >> >> -
> >> >> -static struct apll_freq apll_freq_5250[] = {
> >> >> -     /*
> >> >> -      * values:
> >> >> -      * freq
> >> >> -      * clock divider for ARM, CPUD, ACP, PERIPH, ATB,
> >> >> PCLK_DBG, APLL, ARM2
> >> >> -      * clock divider for COPY, HPM, RESERVED
> >> >> -      * PLL M, P, S
> >> >> -      */
> >> >> -     APLL_FREQ(1700, 0, 3, 7, 7, 7, 3, 5, 0, 0, 2, 0, 425, 6,
> >> >> 0),
> >> >> -     APLL_FREQ(1600, 0, 3, 7, 7, 7, 1, 4, 0, 0, 2, 0, 200, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(1500, 0, 2, 7, 7, 7, 1, 4, 0, 0, 2, 0, 250, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(1400, 0, 2, 7, 7, 6, 1, 4, 0, 0, 2, 0, 175, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(1300, 0, 2, 7, 7, 6, 1, 3, 0, 0, 2, 0, 325, 6,
> >> >> 0),
> >> >> -     APLL_FREQ(1200, 0, 2, 7, 7, 5, 1, 3, 0, 0, 2, 0, 200, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(1100, 0, 3, 7, 7, 5, 1, 3, 0, 0, 2, 0, 275, 6,
> >> >> 0),
> >> >> -     APLL_FREQ(1000, 0, 1, 7, 7, 4, 1, 2, 0, 0, 2, 0, 125, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(900,  0, 1, 7, 7, 4, 1, 2, 0, 0, 2, 0, 150, 4,
> >> >> 0),
> >> >> -     APLL_FREQ(800,  0, 1, 7, 7, 4, 1, 2, 0, 0, 2, 0, 100, 3,
> >> >> 0),
> >> >> -     APLL_FREQ(700,  0, 1, 7, 7, 3, 1, 1, 0, 0, 2, 0, 175, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(600,  0, 1, 7, 7, 3, 1, 1, 0, 0, 2, 0, 200, 4,
> >> >> 1),
> >> >> -     APLL_FREQ(500,  0, 1, 7, 7, 2, 1, 1, 0, 0, 2, 0, 125, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(400,  0, 1, 7, 7, 2, 1, 1, 0, 0, 2, 0, 100, 3,
> >> >> 1),
> >> >> -     APLL_FREQ(300,  0, 1, 7, 7, 1, 1, 1, 0, 0, 2, 0, 200, 4,
> >> >> 2),
> >> >> -     APLL_FREQ(200,  0, 1, 7, 7, 1, 1, 1, 0, 0, 2, 0, 100, 3,
> >> >> 2), -};
> >> >> -
> >> >> -static void set_clkdiv(unsigned int div_index)
> >> >> -{
> >> >> -     unsigned int tmp;
> >> >> -
> >> >> -     /* Change Divider - CPU0 */
> >> >> -
> >> >> -     tmp = apll_freq_5250[div_index].clk_div_cpu0;
> >> >> -
> >> >> -     __raw_writel(tmp, EXYNOS5_CLKDIV_CPU0);
> >> >> -
> >> >> -     while (__raw_readl(EXYNOS5_CLKDIV_STATCPU0) & 0x11111111)
> >> >> -             cpu_relax();
> >> >> -
> >> >> -     /* Change Divider - CPU1 */
> >> >> -     tmp = apll_freq_5250[div_index].clk_div_cpu1;
> >> >> -
> >> >> -     __raw_writel(tmp, EXYNOS5_CLKDIV_CPU1);
> >> >> -
> >> >> -     while (__raw_readl(EXYNOS5_CLKDIV_STATCPU1) & 0x11)
> >> >> -             cpu_relax();
> >> >> -}
> >> >> -
> >> >> -static void set_apll(unsigned int index)
> >> >> -{
> >> >> -     unsigned int tmp;
> >> >> -     unsigned int freq = apll_freq_5250[index].freq;
> >> >> -
> >> >> -     /* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
> >> >> -     clk_set_parent(moutcore, mout_mpll);
> >> >> -
> >> >> -     do {
> >> >> -             cpu_relax();
> >> >> -             tmp = (__raw_readl(EXYNOS5_CLKMUX_STATCPU) >> 16);
> >> >> -             tmp &= 0x7;
> >> >> -     } while (tmp != 0x2);
> >> >> -
> >> >> -     clk_set_rate(mout_apll, freq * 1000);
> >> >> -
> >> >> -     /* MUX_CORE_SEL = APLL */
> >> >> -     clk_set_parent(moutcore, mout_apll);
> >> >> -
> >> >> -     do {
> >> >> -             cpu_relax();
> >> >> -             tmp = __raw_readl(EXYNOS5_CLKMUX_STATCPU);
> >> >> -             tmp &= (0x7 << 16);
> >> >> -     } while (tmp != (0x1 << 16));
> >> >> -}
> >> >> -
> >> >> -static void exynos5250_set_frequency(unsigned int old_index,
> >> >> -                               unsigned int new_index)
> >> >> -{
> >> >> -     if (old_index > new_index) {
> >> >> -             set_clkdiv(new_index);
> >> >> -             set_apll(new_index);
> >> >> -     } else if (old_index < new_index) {
> >> >> -             set_apll(new_index);
> >> >> -             set_clkdiv(new_index);
> >> >> -     }
> >> >> -}
> >> >> -
> >> >> -int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
> >> >> -{
> >> >> -     unsigned long rate;
> >> >> -
> >> >> -     cpu_clk = clk_get(NULL, "armclk");
> >> >> -     if (IS_ERR(cpu_clk))
> >> >> -             return PTR_ERR(cpu_clk);
> >> >> -
> >> >> -     moutcore = clk_get(NULL, "mout_cpu");
> >> >> -     if (IS_ERR(moutcore))
> >> >> -             goto err_moutcore;
> >> >> -
> >> >> -     mout_mpll = clk_get(NULL, "mout_mpll");
> >> >> -     if (IS_ERR(mout_mpll))
> >> >> -             goto err_mout_mpll;
> >> >> -
> >> >> -     rate = clk_get_rate(mout_mpll) / 1000;
> >> >> -
> >> >> -     mout_apll = clk_get(NULL, "mout_apll");
> >> >> -     if (IS_ERR(mout_apll))
> >> >> -             goto err_mout_apll;
> >> >> -
> >> >> -     info->mpll_freq_khz = rate;
> >> >> -     /* 800Mhz */
> >> >> -     info->pll_safe_idx = L9;
> >> >> -     info->cpu_clk = cpu_clk;
> >> >> -     info->volt_table = exynos5250_volt_table;
> >> >> -     info->freq_table = exynos5250_freq_table;
> >> >> -     info->set_freq = exynos5250_set_frequency;
> >> >> -
> >> >> -     return 0;
> >> >> -
> >> >> -err_mout_apll:
> >> >> -     clk_put(mout_mpll);
> >> >> -err_mout_mpll:
> >> >> -     clk_put(moutcore);
> >> >> -err_moutcore:
> >> >> -     clk_put(cpu_clk);
> >> >> -
> >> >> -     pr_err("%s: failed initialization\n", __func__);
> >> >> -     return -EINVAL;
> >> >> -}
> >> >
> >> >
> >> >
> >> > --
> >> > Best regards,
> >> >
> >> > Lukasz Majewski
> >> >
> >> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe cpufreq"
> >> in the body of a message to majordomo at vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> >
> >
> > --
> > Best regards,
> >
> > Lukasz Majewski
> >
> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
