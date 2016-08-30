From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 30 Aug 2016 17:28:53 +0100
Subject: [PATCH v6 2/8] arm: parse cpu capacity-dmips-mhz from DT
In-Reply-To: <CAKfTPtBy7LGCW2T4AGoqL5L_1AHtW6KxHigxFVFVc_EU4oUO0g@mail.gmail.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-3-git-send-email-juri.lelli@arm.com>
 <CAKfTPtBy7LGCW2T4AGoqL5L_1AHtW6KxHigxFVFVc_EU4oUO0g@mail.gmail.com>
Message-ID: <20160830162853.GF9337@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On 16/08/16 10:20, Vincent Guittot wrote:
> Hi Juri,
> 
> 
> On 19 July 2016 at 14:40, Juri Lelli <juri.lelli@arm.com> wrote:

[...]

> > +static int
> > +init_cpu_capacity_callback(struct notifier_block *nb,
> > +                          unsigned long val,
> > +                          void *data)
> > +{
> > +       struct cpufreq_policy *policy = data;
> > +       int cpu;
> > +
> > +       if (cap_parsing_failed || cap_parsing_done)
> > +               return 0;
> > +
> > +       switch (val) {
> > +       case CPUFREQ_NOTIFY:
> > +               pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
> > +                               cpumask_pr_args(policy->related_cpus),
> > +                               cpumask_pr_args(cpus_to_visit));
> > +               cpumask_andnot(cpus_to_visit,
> > +                              cpus_to_visit,
> > +                              policy->related_cpus);
> > +               for_each_cpu(cpu, policy->related_cpus) {
> > +                       raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
> > +                                           policy->max / 1000UL;
> 
> Should it be policy->cpuinfo.max_freq instead of policy->max ?
> 

Right. I'll fix the arm64 bits as well.

> > +                       capacity_scale = max(raw_capacity[cpu], capacity_scale);
> > +               }
> > +               if (cpumask_empty(cpus_to_visit)) {
> > +                       normalize_cpu_capacity();
> > +                       kfree(raw_capacity);
> > +                       pr_debug("cpu_capacity: parsing done\n");
> > +                       cap_parsing_done = true;
> 
> ok so you do that once with the 1st governor that will be registered
> for the CPU. Can't you unregister the notifier then ?
> 

I tried, but the only place I could find to unregister it is from the
callback itself; and it is not possible to do so AFAIK. Suggestions?

Thanks for the review.

Best,

- Juri
