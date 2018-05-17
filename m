From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Thu, 17 May 2018 10:50:34 +0300
Subject: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org>
 <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
 <CAHLCerOYq4q2GE+m3MQAbMfxM4azPr95XiLKVtoPVG1Kv2Db=A@mail.gmail.com>
 <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
Message-ID: <017601d3edb3$c0d96d40$428c47c0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Wednesday, May 16, 2018 17:12
> To: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Ilia Lin <ilialin@codeaurora.org>; Michael Turquette
> <mturquette@baylibre.com>; sboyd at kernel.org; Rob Herring
> <robh@kernel.org>; Mark Rutland <mark.rutland@arm.com>; nm at ti.com;
> lgirdwood at gmail.com; broonie at kernel.org; Andy Gross
> <andy.gross@linaro.org>; David Brown <david.brown@linaro.org>;
> catalin.marinas at arm.com; will.deacon at arm.com; Rafael J. Wysocki
> <rjw@rjwysocki.net>; linux-clk at vger.kernel.org;
> devicetree at vger.kernel.org; LKML <linux-kernel@vger.kernel.org>; Linux
> PM list <linux-pm@vger.kernel.org>; linux-arm-msm at vger.kernel.org; linux-
> soc at vger.kernel.org; lakml <linux-arm-kernel@lists.infradead.org>;
> Rajendra Nayak <rnayak@codeaurora.org>; nicolas.dechesne at linaro.org;
> celster at codeaurora.org; tfinkel at codeaurora.org
> Subject: Re: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
> 
> On 16-05-18, 16:12, Amit Kucheria wrote:
> > > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > > +
> dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > > +       if (0 > ret)
> >
> > Any particular reason to prefer this over (ret < 0) that is generally
> > used? I've seen it used to avoid the == vs. = typos, but not for other
> > comparisons.
> >
> > Suggest sticking to what is commonly used i.e. ret < 0.
> >
> > > +               goto free_opp;
> > > +
> > > +       cpu_dev = get_cpu_device(GOLD_LEAD);
> >
> > Error check cpu_dev here?
> >
> > > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > > +
> dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > > +       if (0 > ret)
> > > +               goto free_opp;
> 
> The goto here is wrong

If we are here, then the first dev_pm_opp_set_supported_hw() succeeded. And
should be deallocated before exit with error.

> 
> > > +
> > > +
> > > +       ret =
> PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt",
> > > +                                                             -1,
> > > + NULL, 0));
> > > +
> > > +       if (0 == ret)
> > > +               return 0;
> > > +
> > > +free_opp:
> > > +       dev_pm_opp_put_supported_hw(opp_temp);
> >
> > This is not needed because dev_pm_opp_set_supported_hw will free
> > memory in case of failure. This call in only needed in case of a
> > successful get.
> 
> But this is still required for the case where platform device registration
fails.
> 
> --
> viresh
