From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Mon, 15 Dec 2014 18:58:41 +0530
Subject: 3.18: lockdep problems in cpufreq
In-Reply-To: <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <7573578.UE8ufgjWuX@vostro.rjw.lan>
 <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
Message-ID: <002f01d0186b$2700b730$75022590$%brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar at linaro.org]
> Sent: Monday, December 15, 2014 9:27 AM
> To: Rafael J. Wysocki; yadi.brar at samsung.com
> Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org;
> linux-pm at vger.kernel.org; Eduardo Valentin
> Subject: Re: 3.18: lockdep problems in cpufreq
> 
> On 15 December 2014 at 03:53, Rafael J. Wysocki <rjw@rjwysocki.net>
> wrote:
> > On Sunday, December 14, 2014 09:36:55 PM Russell King - ARM Linux
> wrote:
> >> Here's a nice Christmas present one of my iMX6 machines gave me
> tonight.
> >> I haven't begun to look into it.
> 
> Is the culprit this one?
> 
> Fixes: 2dcd851fe4b4 ("thermal: cpu_cooling: Update always cpufreq
> policy with thermal constraints")
> 
> As this is what it changed:
> 
> @@ -316,21 +312,28 @@ static int cpufreq_thermal_notifier(struct
> notifier_block *nb,  {
>         struct cpufreq_policy *policy = data;
>         unsigned long max_freq = 0;
> +       struct cpufreq_cooling_device *cpufreq_dev;
> 
> -       if (event != CPUFREQ_ADJUST || notify_device == NOTIFY_INVALID)
> +       if (event != CPUFREQ_ADJUST)
>                 return 0;
> 
> -       if (cpumask_test_cpu(policy->cpu, &notify_device-
> >allowed_cpus))
> -               max_freq = notify_device->cpufreq_val;
> -       else
> -               return 0;
> +       mutex_lock(&cooling_cpufreq_lock);
> +       list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
> +               if (!cpumask_test_cpu(policy->cpu,
> +                                       &cpufreq_dev->allowed_cpus))
> +                       continue;
> +
> +               if (!cpufreq_dev->cpufreq_val)
> +                       cpufreq_dev->cpufreq_val = get_cpu_frequency(
> +                                       cpumask_any(&cpufreq_dev-
> >allowed_cpus),
> +                                       cpufreq_dev->cpufreq_state);
> 
> -       /* Never exceed user_policy.max */
> -       if (max_freq > policy->user_policy.max)
> -               max_freq = policy->user_policy.max;
> +               max_freq = cpufreq_dev->cpufreq_val;
> 
> -       if (policy->max != max_freq)
> -               cpufreq_verify_within_limits(policy, 0, max_freq);
> +               if (policy->max != max_freq)
> +                       cpufreq_verify_within_limits(policy, 0,
> max_freq);
> +       }
> +       mutex_unlock(&cooling_cpufreq_lock);
> 
>         return 0;
>  }
> 
> 
> >> ======================================================
> >> [ INFO: possible circular locking dependency detected ] 3.18.0+
> #1453
> >> Not tainted
> >> -------------------------------------------------------
> >> rc.local/770 is trying to acquire lock:
> >>  (cooling_cpufreq_lock){+.+.+.}, at: [<c04abfc4>]
> >> cpufreq_thermal_notifier+0x34/0xfc
> >>
> >> but task is already holding lock:
> >>  ((cpufreq_policy_notifier_list).rwsem){++++.+}, at: [<c0042f04>]
> >> __blocking_notifier_call_chain+0x34/0x68
> >>
> >> which lock already depends on the new lock.
> >
> > Well, that's for Viresh.
> 
> Maybe not as the rework I have done is queued for this merge window.
> I was afraid really after reading the "offenders" discussion on IRC :)
> 
> Cc'd Yadwinder as well who wrote this patch.

Thanks :).

Unfortunately, I didn?t get any such warning though I tested
patch enabling CONFIG_PROVE_LOCKING before posting. It seems
Russell is trying to load imx_thermal as module and parallely
Changing cpufreq governor from userspace, which was not my
test case.

Anyways, after analyzing log and code,I think problem is not
in cpufreq_thermal_notifier which was modified in patch as
stated above. Actual problem is in __cpufreq_cooling_register
which is unnecessarily calling cpufreq_register_notifier()
inside section protected by cooling_cpufreq_lock.
Because cpufreq_policy_notifier_list).rwsem is already held
by store_scaling_governor when __cpufreq_cooling_register is
trying to cpufreq_policy_notifier_list while holding cooling_cpufreq_lock. 

So I think following can fix the problem:

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ad09e51..622ea40 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -484,15 +484,15 @@ __cpufreq_cooling_register(struct device_node *np,
        cpufreq_dev->cpufreq_state = 0;
        mutex_lock(&cooling_cpufreq_lock);
 
-       /* Register the notifier for first cpufreq cooling device */
-       if (cpufreq_dev_count == 0)
-               cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
-                                         CPUFREQ_POLICY_NOTIFIER);
        cpufreq_dev_count++;
        list_add(&cpufreq_dev->node, &cpufreq_dev_list);
 
        mutex_unlock(&cooling_cpufreq_lock);
 
+       /* Register the notifier for first cpufreq cooling device */
+       if (cpufreq_dev_count == 0)
+               cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
+                                         CPUFREQ_POLICY_NOTIFIER);
        return cool_dev;
 }



Best Regards,
Yadwinder
  
