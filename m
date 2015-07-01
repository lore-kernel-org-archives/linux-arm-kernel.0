From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 01 Jul 2015 15:47:55 +0200
Subject: [PATCHv3] clk samsung exynos5420 add CLK_RECALC_NEW_RATES flag to
 mout_apll and mout_kpll clock.
In-Reply-To: <CANAwSgQYxkHr5fvR0Ju67mWoYuGsqc2eNt2vmVXYxbf-WmOWvg@mail.gmail.com>
References: <1431083247-3310-1-git-send-email-linux.amoon@gmail.com>
 <CANAwSgQYxkHr5fvR0Ju67mWoYuGsqc2eNt2vmVXYxbf-WmOWvg@mail.gmail.com>
Message-ID: <2343401.BLEA8Ff99T@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, July 01, 2015 11:42:19 AM Anand Moon wrote:
> Hi AlL,
> 
> 
> On 8 May 2015 at 16:37, Anand Moon <linux.amoon@gmail.com> wrote:
> > Addition of CLK_RECALC_NEW_RATES flag to support Exynos5420 cpu clk so that
> > correct divider values are re-calculated after both pre/post
> > clock notifiers had run for mout_apll clock and mout_kpll clock.
> >
> > Observation their is considerable improvement in cpufreq stats
> > after applying this patch.
> >
> > Governer : "performance"
> > $ cpupower -c 1 frequency-info
> >
> > Below is table format of the output.
> > cpufreq stats:  Frequency| Before | After  |
> > CPU 1
> >                 200 MHz  | 22.07% | 46.57% |
> >                 300 MHz  | 1.08%  | 8.18%  |
> >                 400 MHz  | 0.17%  | 1.93%  |
> >                 500 MHz  | 0.24%  | 3.51%  |
> >                 600 MHz  | 0.37%  | 2.13%  |
> >                 700 MHz  | 0.20%  | 0.88%  |
> >                 800 MHz  | 0.09%  | 1.69%  |
> >                 900 MHz  | 0.05%  | 1.02%  |
> >                 1000 MHz | 0.02%  | 2.55%  |
> >                 1.10 GHz | 0.12%  | 1.17%  |
> >                 1.20 GHz | 0.05%  | 0.88%  |
> >                 1.30 GHz | 0.07%  | 0.38%  |
> >                 1.40 GHz | 0.04%  | 0.38%  |
> >                 1.50 GHz | 0.02%  | 0.00%  |
> >                 1.60 GHz | 0.00%  | 0.15%  |
> >                 1.70 GHz | 0.00%  | 0.44%  |
> >                 1.80 GHz | 75.43% | 28.26% |
> >
> > Governer : "performance"
> > $ cpupower -c 0 frequency-info
> >
> > Below is table format of the output.
> > cpufreq stats:  Frequency| Before | After  |
> > CPU0            200 MHz  | 33.95% | 60.31% |
> >                 300 MHz  | 4.64%  | 2.13%  |
> >                 400 MHz  | 1.50%  | 0.79%  |
> >                 500 MHz  | 1.46%  | 0.49%  |
> >                 600 MHz  | 0.05%  | 0.27%  |
> >                 700 MHz  | 0.68%  | 0.21%  |
> >                 800 MHz  | 0.08%  | 0.19%  |
> >                 900 MHz  | 0.09%  | 0.12%  |
> >                 1000 MHz | 0.20%  | 0.10%  |
> >                 1.10 GHz | 0.21%  | 0.11%, |
> >                 1.20 GHz | 0.51%  | 0.28%, |
> >                 1.30 GHz | 56.64% | 35.01% |
> >
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/clk/samsung/clk-exynos5420.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> > index 462aaee..6c7458c 100644
> > --- a/drivers/clk/samsung/clk-exynos5420.c
> > +++ b/drivers/clk/samsung/clk-exynos5420.c
> > @@ -618,10 +618,10 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
> >         MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
> >
> >         MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
> > -             CLK_SET_RATE_PARENT, 0),
> > +             CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
> >         MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
> >         MUX_F(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
> > -             CLK_SET_RATE_PARENT, 0),
> > +             CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
> >         MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
> >
> >         MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
> > --
> > 1.9.1
> >
> 
> Any comments on this patch.

Thanks for catching and fixing this.

I'll integrate your fix into Exynos542x/5800 cpufreq patchset
once I get to updating it (there were comments WRT arm_big_little
cpufreq driver changes).  Please also note that it may take some
time as I still need to update Exynos4x12 patch series first
(Viresh has requested porting it over opp-v2 changes).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
