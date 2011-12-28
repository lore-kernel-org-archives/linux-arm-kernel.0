From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 28 Dec 2011 09:24:05 +0800
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111227150539.GA15132@S2101-09.ap.freescale.net>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
 <20111227150539.GA15132@S2101-09.ap.freescale.net>
Message-ID: <20111228012404.GK15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 11:05:41PM +0800, Shawn Guo wrote:
> Hi Richard,
> 
> On Tue, Dec 27, 2011 at 04:24:19PM +0800, Richard Zhao wrote:
> > The driver get cpu operation point table from device tree cpu0 node,
> > and adjusts operating points using clk and regulator APIs.
> > 
> > It support single core and multi-core ARM SoCs. But currently it assume
> > all cores share the same frequency and voltage.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> > Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  .../devicetree/bindings/cpufreq/clk-reg-cpufreq    |   21 ++
> >  drivers/cpufreq/Kconfig                            |   10 +
> >  drivers/cpufreq/Makefile                           |    2 +
> >  drivers/cpufreq/clk-reg-cpufreq.c                  |  302 ++++++++++++++++++++
> >  4 files changed, 335 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/clk-reg-cpufreq
> >  create mode 100644 drivers/cpufreq/clk-reg-cpufreq.c
> > 
> 
> [...]
> 
> > +static struct cpufreq_driver clk_reg_cpufreq_driver = {
> > +	.flags = CPUFREQ_STICKY,
> > +	.verify = clk_reg_verify_speed,
> > +	.target = clk_reg_set_target,
> > +	.get = clk_reg_get_speed,
> > +	.init = clk_reg_cpufreq_init,
> > +	.exit = clk_reg_cpufreq_exit,
> > +	.name = "clk-reg",
> > +};
> > +
> > +static u32 max_freq = UINT_MAX / 1000; /* kHz */
> > +module_param(max_freq, uint, 0);
> > +MODULE_PARM_DESC(max_freq, "max cpu frequency in unit of kHz");
> > +
> 
> Have you tried to pass this param from kernel cmdline?  What's the
> syntax if we want to pass a 800 MHz max_freq?
clk-reg-cpufreq.max_freq=800000
> 
> And I played this driver on imx6q with pm-qa [1] cpufreq test suit from
> Linaro PMWG.
> 
> ### cpufreq_01:
> ### test the cpufreq framework is available for frequency
> ### https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/QA/Scripts#cpufreq_01
> ###
> cpufreq_01.0/cpu0: checking 'scaling_available_frequencies' exists...       fail
> cpufreq_01.0/cpu1: checking 'scaling_available_frequencies' exists...       fail
> cpufreq_01.0/cpu2: checking 'scaling_available_frequencies' exists...       fail
> cpufreq_01.0/cpu3: checking 'scaling_available_frequencies' exists...       fail
hmm, scaling_available_frequencies is nice-to-have feature. I'm glad to
add it.
> 
> ### cpufreq_05:
> ### test 'ondemand' and 'conservative' trigger correctly the configuration directory
> ### https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/QA/Scripts#cpufreq_05
> ###
> cpufreq_05.0: checking 'ondemand' directory exists...                       pass
> cpufreq_05.1: checking 'conservative' directory exists...                   pass
> cpufreq_05.2: checking 'ondemand' directory is not there...                 pass
> cpufreq_05.3: checking 'conservative' directory is not there...             pass
> cpufreq_05.4: checking 'ondemand' directory exists...                       fail
> cpufreq_05.5: checking 'conservative' directory exists...                   pass
I past fail part script here:
    switch_ondemand cpu0
    switch_conservative cpu1
    check "'ondemand' directory exists" "test -d $CPU_PATH/cpufreq/ondemand"
    check "'conservative' directory exists" "test -d $CPU_PATH/cpufreq/conservative"
This driver assume all cpu cores to share the same freq and voltage. The affected
cpu is all other cpus. They also share one single governor. The test case does not
suit this driver and not for most arm multi-core cpus I guess.
> 
> The cpufreq_01 can be easily fixed with the following change.
> 
> 8<-----
> @@ -146,6 +150,11 @@ static int clk_reg_cpufreq_exit(struct cpufreq_policy *policy)
>         return 0;
>  }
> 
> +static struct freq_attr *clk_reg_cpufreq_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       NULL,
> +};
> +
>  static struct cpufreq_driver clk_reg_cpufreq_driver = {
>         .flags = CPUFREQ_STICKY,
>         .verify = clk_reg_verify_speed,
> @@ -153,10 +162,15 @@ static struct cpufreq_driver clk_reg_cpufreq_driver = {
>         .get = clk_reg_get_speed,
>         .init = clk_reg_cpufreq_init,
>         .exit = clk_reg_cpufreq_exit,
> +       .attr = clk_reg_cpufreq_attr,
>         .name = "clk-reg",
>  };
> ----->8
quite right.

Thanks
Richard
> 
> And I have not looked into the second one deeply, but maybe you
> want to :)
> 
> -- 
> Regards,
> Shawn
> 
> [1] git://git.linaro.org/people/dlezcano/pm-qa.git
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
