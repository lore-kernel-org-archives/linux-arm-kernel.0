From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Jul 2015 18:44:28 +0200
Subject: [PATCH 10/10] cpufreq-dt: Add support for operating-points-v2
 bindings
In-Reply-To: <3095426.xc9msIINgb@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
 <3095426.xc9msIINgb@amdc1976>
Message-ID: <4945455.PmBrA0DySW@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 09, 2015 06:13:54 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, June 15, 2015 05:27:36 PM Viresh Kumar wrote:
> > Support for parsing operating-points-v2 bindings is in place now, lets
> > modify cpufreq-dt driver to use them.
> 
> I believe that following patches:
> 
> * [PATCH v2 1/7] opp: add dev_pm_opp_get_turbo_mode_setting() helper
>   (http://lkml.org/lkml/2015/7/9/420)
> 
> * [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
>   (http://lkml.org/lkml/2015/7/9/421)
> 
> should be integrated into this patch series before patch #10 (the current
> one) can be applied.
> 
> [ Please see http://lkml.org/lkml/2015/7/9/419 for more details. ]

On the 2nd thought here is the issue description, so people don't
have to search for it:

With the current code the turbo-mode opp-s are not distinguished in
any way in the cpufreq subsystem and once somebody defines them in
their DTS file they are treated as normal modes. I.e. if you define
opp-s using opp-v2 bindings in your DTS file (for use by cpufreq-dt
driver) and some are marked as turbo modes then the freq_table (build
by cpufreq core) will contain turbo mode frequencies and cpufreq-dt
driver will use them as normal frequencies.  This is certainly not
a desired behavior.

To fix it I added opp core helper to check whether opp is a turbo
mode and during build of freq_table turbo mode frequencies are
marked with special flag (CPUFREQ_BOOST_FREQ).  Such frequencies
are ignored by cpufreq core unless 'boost' mode is enabled.
'boost' mode support needs to be explicitly supported & enabled in
a specific cpufreq driver.  For the moment it is only available for
Exynos4x12 cpufreq driver but my patchset (converting Exynos4x12
platforms to use cpufreq-dt driver) makes it available for use in
cpufreq-dt (to be enabled from your platform support when needed).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
