From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 31 Jan 2013 15:45:19 +0100
Subject: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
In-Reply-To: <CAOh2x==GeK4qM=kjy-tzhbEh4L9AmRXoG_0tUzov1SK+uRFxcw@mail.gmail.com>
References: <1887364.fvxYYNb7Mm@amdc1227>
 <CAOh2x==GeK4qM=kjy-tzhbEh4L9AmRXoG_0tUzov1SK+uRFxcw@mail.gmail.com>
Message-ID: <1520677.WES295RohH@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Thursday 31 of January 2013 09:50:37 Viresh Kumar wrote:
> On Tue, Nov 13, 2012 at 2:56 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Exynos SoCs all cores share the same frequency setting, so changing
> > frequency of one core will affect rest of cores.
> > 
> > This patch modifies the exynos-cpufreq driver to inform cpufreq core
> > about this behavior and broadcast frequency change notifications for
> > all cores.
> > 
> >         /* When the new frequency is lower than current frequency */
> >         if ((freqs.new < freqs.old) ||
> > 
> > @@ -235,6 +237,7 @@ static int exynos_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)> 
> >                 cpumask_copy(policy->related_cpus, cpu_possible_mask);
> >                 cpumask_copy(policy->cpus, cpu_online_mask);
> >         
> >         } else {
> > 
> > +               policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> > 
> >                 cpumask_setall(policy->cpus);
> 
> I couldn't understand the use of this change. Can you please explain ?

All cores on Exynos SoCs share the same clock source, which means that 
they all always run at the same frequency. So setting frequency on one 
core sets the frequency on all cores and so it doesn't matter on which 
core the frequency setting operation is done.

As you can see in include/linux/cpufreq.h:

#define CPUFREQ_SHARED_TYPE_ANY  (3) /* Freq can be set from any dependent 
CPU*/

which basically tells (together with rest of the patch) the cpufreq 
subsystem about what I wrote earlier.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
