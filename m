From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 May 2018 19:41:32 +0530
Subject: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <CAHLCerOYq4q2GE+m3MQAbMfxM4azPr95XiLKVtoPVG1Kv2Db=A@mail.gmail.com>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org>
 <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
 <CAHLCerOYq4q2GE+m3MQAbMfxM4azPr95XiLKVtoPVG1Kv2Db=A@mail.gmail.com>
Message-ID: <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-05-18, 16:12, Amit Kucheria wrote:
> > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > +                             dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > +       if (0 > ret)
> 
> Any particular reason to prefer this over (ret < 0) that is generally
> used? I've seen it used to avoid the == vs. = typos, but not for other
> comparisons.
> 
> Suggest sticking to what is commonly used i.e. ret < 0.
> 
> > +               goto free_opp;
> > +
> > +       cpu_dev = get_cpu_device(GOLD_LEAD);
> 
> Error check cpu_dev here?
> 
> > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > +                             dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > +       if (0 > ret)
> > +               goto free_opp;

The goto here is wrong

> > +
> > +
> > +       ret = PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt",
> > +                                                             -1, NULL, 0));
> > +
> > +       if (0 == ret)
> > +               return 0;
> > +
> > +free_opp:
> > +       dev_pm_opp_put_supported_hw(opp_temp);
> 
> This is not needed because dev_pm_opp_set_supported_hw will free
> memory in case of failure. This call in only needed in case of a
> successful get.

But this is still required for the case where platform device
registration fails.

-- 
viresh
