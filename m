From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 21 Sep 2017 02:17:10 +0000
Subject: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
In-Reply-To: <20170920203033.GD3001@ubuntu>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
 <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
 <20170919225840.GI30848@ubuntu> <20170920070343.GA32187@b29396-OptiPlex-7040>
 <20170920203033.GD3001@ubuntu>
Message-ID: <AM3PR04MB3063900BE634FABE8668F3380660@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar at linaro.org]
> Sent: Thursday, September 21, 2017 4:31 AM
> To: Dong Aisheng
> Cc: A.s. Dong; linux-pm at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; sboyd at codeaurora.org;
> vireshk at kernel.org; nm at ti.com; rjw at rjwysocki.net; shawnguo at kernel.org;
> Anson Huang; Jacky Bai
> Subject: Re: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
> 
> On 20-09-17, 15:03, Dong Aisheng wrote:
> > I've been thinking of that before.
> > Actually IMX already does some similar thing for MX5 (no for MX6).
> > See: clk_cpu_set_rate() in drivers/clk/imx/clk-cpu.c.
> >
> > After some diggings, it seems MX7ULP is a bit more complicated than
> > before mainly due to two reasons:
> > 1) It requires to switch to different CPU mode accordingly when
> > setting clocks rate. That means we need handle this in clock driver as
> > well which looks not quite suitable although we could do if really want.
> >
> > 2) It uses different clocks for different CPU mode (RUN 416M or HSRUN
> > 528M), and those clocks have some dependency.
> > e.g. when setting HSRUN clock, we need change RUN clock parent to make
> > sure the SPLL_PFD is got disabled before changing rate, as both CPU
> > mode using the same parent SPLL_PFD clock. Doing this in clock driver
> > also make things a bit more complicated.
> >
> > The whole follow would be something like below:
> > static int imx7ulp_set_clk(struct device *dev, struct clk *clk,
> >                            unsigned long old_freq, unsigned long
> > new_freq) {
> >         u32 val;
> >
> >         /*
> >          * Before changing the ARM core PLL, change the ARM clock soure
> >          * to FIRC first.
> >          */
> >         if (new_freq >= HSRUN_FREQ) {
> >                 clk_set_parent(clks[RUN_SCS_SEL].clk, clks[FIRC].clk);
> >
> >                 /* switch to HSRUN mode */
> >                 val = readl_relaxed(smc_base + SMC_PMCTRL);
> >                 val |= (0x3 << 8);
> >                 writel_relaxed(val, smc_base + SMC_PMCTRL);
> >
> >                 /* change the clock rate in HSRUN */
> >                 clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
> >                 clk_set_parent(clks[HSRUN_SCS_SEL].clk,
> clks[SPLL_SEL].clk);
> >         } else {
> >                 /* change the HSRUN clock to firc */
> >                 clk_set_parent(clks[HSRUN_SCS_SEL].clk,
> > clks[FIRC].clk);
> >
> >                 /* switch to RUN mode */
> >                 val = readl_relaxed(smc_base + SMC_PMCTRL);
> >                 val &= ~(0x3 << 8);
> >                 writel_relaxed(val, smc_base + SMC_PMCTRL);
> >
> >                 clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
> >                 clk_set_parent(clks[RUN_SCS_SEL].clk,
> clks[SPLL_SEL].clk);
> >         }
> >
> >         return 0;
> > }
> 
> Right and we have the same thing in the cpufreq driver now. It will stay
> at some place and we need to find the best one, keeping in mind that we
> may or may not want to solve this problem in a generic way.
> 
> > That's why i thought if we can make OPP core provide a way to handle
> > such complicated things in platform specific cpufreq driver.
> >
> > How would you suggest for this issue?
> 
> I wouldn't add an API into the OPP framework if I were you. There is just
> too much code to add to the core to handle such platform specific stuff,
> which you are anyway going to keep somewhere as it is. IMHO, keeping that
> in the clock driver is a better thing to do than this.
> 

Okay, I will give a try in CLK driver.
Thanks for the suggestion.

Regards
Dong Aisheng

> --
> viresh
