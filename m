From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 22 Nov 2012 00:41:21 +0100
Subject: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
In-Reply-To: <3562672.u4N3XIHFEC@flatron>
References: <1887364.fvxYYNb7Mm@amdc1227> <4440154.l7bQzsqNex@vostro.rjw.lan>
 <3562672.u4N3XIHFEC@flatron>
Message-ID: <1516506.6Tpvy1mpz1@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 21, 2012 10:23:02 PM Tomasz Figa wrote:
> Hi Rafael,
> 
> On Wednesday 21 of November 2012 21:47:42 Rafael J. Wysocki wrote:
> > On Wednesday, November 21, 2012 02:52:26 PM Tomasz Figa wrote:
> > > On Tuesday 13 of November 2012 10:26:12 Tomasz Figa wrote:
> > > > On Exynos SoCs all cores share the same frequency setting, so
> > > > changing
> > > > frequency of one core will affect rest of cores.
> > > > 
> > > > This patch modifies the exynos-cpufreq driver to inform cpufreq core
> > > > about this behavior and broadcast frequency change notifications for
> > > > all cores.
> > > > 
> > > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > > ---
> > > > 
> > > >  drivers/cpufreq/exynos-cpufreq.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/exynos-cpufreq.c
> > > > b/drivers/cpufreq/exynos-cpufreq.c index af2d81e..c0d54a8 100644
> > > > --- a/drivers/cpufreq/exynos-cpufreq.c
> > > > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > > > @@ -100,7 +100,8 @@ static int exynos_target(struct cpufreq_policy
> > > > *policy, }
> > > > 
> > > >  	arm_volt = volt_table[index];
> > > > 
> > > > -	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > > > +	for_each_cpu(freqs.cpu, policy->cpus)
> > > > +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > > > 
> > > >  	/* When the new frequency is higher than current frequency */
> > > >  	if ((freqs.new > freqs.old) && !safe_arm_volt) {
> > > > 
> > > > @@ -115,7 +116,8 @@ static int exynos_target(struct cpufreq_policy
> > > > *policy, if (freqs.new != freqs.old)
> > > > 
> > > >  		exynos_info->set_freq(old_index, index);
> > > > 
> > > > -	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > > > +	for_each_cpu(freqs.cpu, policy->cpus)
> > > > +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > > > 
> > > >  	/* When the new frequency is lower than current frequency */
> > > >  	if ((freqs.new < freqs.old) ||
> > > > 
> > > > @@ -235,6 +237,7 @@ static int exynos_cpufreq_cpu_init(struct
> > > > cpufreq_policy *policy) cpumask_copy(policy->related_cpus,
> > > > cpu_possible_mask);
> > > > 
> > > >  		cpumask_copy(policy->cpus, cpu_online_mask);
> > > >  	
> > > >  	} else {
> > > > 
> > > > +		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> > > > 
> > > >  		cpumask_setall(policy->cpus);
> > > >  	
> > > >  	}
> > > 
> > > Ping.
> > 
> > Am I supposed to handle this?
> 
> I guess. Would be really nice if you could apply this patch for 3.8.

OK

Applied to linux-pm.git/linux-next as v3.8 material.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
