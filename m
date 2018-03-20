From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Tue, 20 Mar 2018 15:53:08 +0200
Subject: [PATCH v3 07/10] clk: qcom: clk-cpu-8996: Prepare PLLs on probe
In-Reply-To: <152147821849.242365.7709382599118820578@swboyd.mtv.corp.google.com>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-8-git-send-email-ilialin@codeaurora.org>
 <152147821849.242365.7709382599118820578@swboyd.mtv.corp.google.com>
Message-ID: <013c01d3c052$ca49ecd0$5eddc670$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Stephen Boyd <sboyd@kernel.org>
> Sent: Monday, March 19, 2018 18:50
> To: Ilia Lin <ilialin@codeaurora.org>; linux-arm-kernel at lists.infradead.org;
> linux-arm-msm at vger.kernel.org; linux-clk at vger.kernel.org;
> sboyd at codeaurora.org
> Cc: mark.rutland at arm.com; devicetree at vger.kernel.org;
> rnayak at codeaurora.org; robh at kernel.org; will.deacon at arm.com;
> amit.kucheria at linaro.org; tfinkel at codeaurora.org; ilialin at codeaurora.org;
> nicolas.dechesne at linaro.org; celster at codeaurora.org
> Subject: Re: [PATCH v3 07/10] clk: qcom: clk-cpu-8996: Prepare PLLs on probe
> 
> Quoting Ilia Lin (2018-02-14 05:59:49)
> > The PLLs must be prepared enabled during the probe to be accessible by
> > the OPPs. Otherwise an OPP may switch to non-enabled clock.
> 
> Sounds like an OPP problem.

And again, it could be solved by a platform specific cpufreq driver. Worth it?

> 
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > ---
> >  drivers/clk/qcom/clk-cpu-8996.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/clk-cpu-8996.c
> > b/drivers/clk/qcom/clk-cpu-8996.c index 854f327..b0a3b73 100644
> > --- a/drivers/clk/qcom/clk-cpu-8996.c
> > +++ b/drivers/clk/qcom/clk-cpu-8996.c
> > @@ -15,7 +15,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > -
> > +#include <linux/clk-provider.h>
> 
> Please leave a newline between linux/* and local includes.

Will be changed in the next spin.

> 
> >  #include "clk-alpha-pll.h"
> >
> >  #define VCO(a, b, c) { \
> > @@ -376,6 +376,18 @@ struct clk_hw_clks {
> >         clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
> >         clk_alpha_pll_configure(&pwrcl_alt_pll, regmap,
> > &altpll_config);
> >
> > +       /* Enable all PLLs and alt PLLs */
> > +       clk_prepare_enable(pwrcl_alt_pll.clkr.hw.clk);
> > +       clk_prepare_enable(perfcl_alt_pll.clkr.hw.clk);
> > +       clk_prepare_enable(pwrcl_pll.clkr.hw.clk);
> > +       clk_prepare_enable(perfcl_pll.clkr.hw.clk);
> 
> And this can't be done by the cpufreq-dt driver?

Are you suggesting changing the cpufreq-dt as well?

> 
> > +
> > +       /* Set initial boot frequencies for power/perf PLLs */
> > +       clk_set_rate(pwrcl_alt_pll.clkr.hw.clk, 652800000);
> > +       clk_set_rate(perfcl_alt_pll.clkr.hw.clk, 652800000);
> > +       clk_set_rate(pwrcl_pll.clkr.hw.clk, 652800000);
> > +       clk_set_rate(perfcl_pll.clkr.hw.clk, 652800000);
> 
> We have assigned rates in DT for this.

I assumed that the clock driver can live without the OPP table and any cpufreq driver. Or do you mean adding this as parameters for the kryocc DT node?

> 
> > +
> >         ret = clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux.nb);
> >         if (ret)
> >                 return ret;
