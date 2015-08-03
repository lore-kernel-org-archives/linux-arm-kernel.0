From: srinivas.pandruvada@intel.com (Pandruvada, Srinivas)
Date: Mon, 3 Aug 2015 17:12:03 +0000
Subject: [PATCH v3 5/5] cpufreq: remove no longer needed
 CPU_FREQ_BOOST_SW config option
In-Reply-To: <20150801111537.GH899@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <1438368557-2352-6-git-send-email-b.zolnierkie@samsung.com>
 <20150801111537.GH899@linux>
Message-ID: <1438621775.17718.22.camel@spandruv-DESK3.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-08-01 at 16:45 +0530, Viresh Kumar wrote:
> On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> > Remove no longer needed CPU_FREQ_BOOST_SW config option.
> > 
> > As a result scaling_boost_freqs sysfs attribute is available
> > when cpufreq-dt driver is used and boost support is enabled.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/cpufreq/Kconfig      | 4 ----
> >  drivers/cpufreq/freq_table.c | 2 --
> >  2 files changed, 6 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index bf6d596..de00a52 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -21,10 +21,6 @@ if CPU_FREQ
> >  config CPU_FREQ_GOV_COMMON
> >  	bool
> >  
> > -config CPU_FREQ_BOOST_SW
> > -	bool
> > -	depends on THERMAL
> > -
> >  config CPU_FREQ_STAT
> >  	tristate "CPU frequency translation statistics"
> >  	default y
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index a8f1daf..4c5de5b 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -293,9 +293,7 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_boost_freqs);
> >  
> >  struct freq_attr *cpufreq_generic_attr[] = {
> >  	&cpufreq_freq_attr_scaling_available_freqs,
> > -#ifdef CONFIG_CPU_FREQ_BOOST_SW
> >  	&cpufreq_freq_attr_scaling_boost_freqs,
> > -#endif
> >  	NULL,
> >  };
> >  EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
> 
> So, this will start appearing for all platforms that use cpufreq_generic_attr
> and that may not be the right thing. We may only want to show boost frequencies
> only if the driver supports it.
I agree. Although acpi-cpufreq or Intel P state driver is not using
generic_attr, but we have a plan to show boost frequencies on platforms,
where we have some control. Support of boost mode doesn't mean that we
can select the boost frequency, so in that case we will avoid showing
them.

Thanks,
Srinivas
> 
> @Rafael: What do you say?
> 
