From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 18 Dec 2011 20:34:17 +0800
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <1771359.4jv0xX1vFp@wuerfel>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <4EEB5683.7000409@gmail.com> <20111217080001.GC2010@richard-laptop>
 <1771359.4jv0xX1vFp@wuerfel>
Message-ID: <20111218123414.GA2741@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 10:29:29AM +0100, Arnd Bergmann wrote:
> On Saturday 17 December 2011 16:00:03 Richard Zhao wrote:
> > On Fri, Dec 16, 2011 at 08:32:35AM -0600, Rob Herring wrote:
> > > On 12/16/2011 04:30 AM, Richard Zhao wrote:
> > > > It support single core and multi-core ARM SoCs. But it assume
> > > > all cores share the same frequency and voltage.
> > > > 
> > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > ---
> > > >  drivers/cpufreq/Kconfig.arm   |    8 ++
> > > >  drivers/cpufreq/Makefile      |    1 +
> > > >  drivers/cpufreq/arm-cpufreq.c |  269 +++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 278 insertions(+), 0 deletions(-)
> > > >  create mode 100644 drivers/cpufreq/arm-cpufreq.c
> > > > 
> > > 
> > > What makes this specific to ARM and not a generic DT + clk api +
> > > regulator api driver?
> >
> > smp loops_per_jiffy update needs arm header <asm/cpu.h>.
> 
> I would suggest to instead change the definition of adjust_jiffies in the
> core so it can be overridden by the architecture, like this
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 987a165..174584d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -189,6 +189,7 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
>   * systems as each CPU might be scaled differently. So, use the arch
>   * per-CPU loops_per_jiffy value wherever possible.
>   */
> +#ifndef adjust_jiffies
>  #ifndef CONFIG_SMP
>  static unsigned long l_p_j_ref;
>  static unsigned int  l_p_j_ref_freq;
> @@ -218,7 +219,8 @@ static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
>  {
>         return;
>  }
> -#endif
> +#endif /* CONFIG_SMP */
> +#endif /* adjust_jiffies */
>  
>  
>  /**
> 
> 
> Then ARM (and any others that want the driver) can provide their own
> implementation and set 
> 
> #define adjust_jiffies(val, ci) adjust_jiffies((val), (ci))
> 
> to let the core use that instead of the generic UP version.
> 
> 
> While we're there, we should probably try to fix drivers that use loops_per_jiffy,
> because that is not what they think it is on SMP.
Or let different arch register its different CPUFREQ_TRANSITION_NOTIFIER ?

Thanks
Richard
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
