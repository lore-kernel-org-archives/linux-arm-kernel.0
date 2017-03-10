From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 10 Mar 2017 23:38:50 +0100
Subject: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
In-Reply-To: <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
References: <20170310150218.GW21222@n2100.armlinux.org.uk>
 <CAJZ5v0jGRH_hwvvm9OLsaYgbghqWKOke9PyGNnkvP_ZiMqAxSw@mail.gmail.com>
 <BY2PR21MB00362E60448FD2E00C120FFCCB200@BY2PR21MB0036.namprd21.prod.outlook.com>
 <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
Message-ID: <CAJZ5v0gWA7fYRMSdpsRA8n8_9A4jBAKCZYHJRBB9dKFMKa09ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 7:33 PM, Matthew Wilcox <mawilcox@microsoft.com> wrote:
> (compile tested only ... obviously)
>
> From cd5401d81633d5e48e39d67d4e65156e6759537e Mon Sep 17 00:00:00 2001
> From: Matthew Wilcox <mawilcox@microsoft.com>
> Date: Fri, 10 Mar 2017 13:22:53 -0500
> Subject: [PATCH] thermal: Fix potential deadlock in cpu_cooling
>
> I expanded the scope of cooling_list_lock a little too far; it was
> not just covering cpufreq_dev_count, it was also covering the calls
> to cpufreq_register_notifier() and cpufreq_unregister_notifier().
> Since cooling_list_lock is also used within cpufreq_thermal_notifier(),
> lockdep reports a potential deadlock.  I don't think that's actually
> possible, but it's easy enough to make it impossible by testing the
> condition under cooling_list_lock and dropping the lock before calling
> cpufreq_register_notifier().
>
> As a bonus, I noticed that cpufreq_dev_count is only used for the purpose
> of knowing whether this is the first or last cooling device registered,
> and we know that anyway because we know whether the list transitioned
> between empty and not-empty.  So we can delete that variable too.
>
> Fixes: ae606089621ef0349402cfcbeca33a82abbd0fd0
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Looks good to me.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/thermal/cpu_cooling.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 91048eeca28b..11b5ea685518 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -107,8 +107,6 @@ struct cpufreq_cooling_device {
>  };
>  static DEFINE_IDA(cpufreq_ida);
>
> -static unsigned int cpufreq_dev_count;
> -
>  static DEFINE_MUTEX(cooling_list_lock);
>  static LIST_HEAD(cpufreq_dev_list);
>
> @@ -771,6 +769,7 @@ __cpufreq_cooling_register(struct device_node *np,
>         unsigned int freq, i, num_cpus;
>         int ret;
>         struct thermal_cooling_device_ops *cooling_ops;
> +       bool first;
>
>         if (!alloc_cpumask_var(&temp_mask, GFP_KERNEL))
>                 return ERR_PTR(-ENOMEM);
> @@ -874,13 +873,14 @@ __cpufreq_cooling_register(struct device_node *np,
>         cpufreq_dev->cool_dev = cool_dev;
>
>         mutex_lock(&cooling_list_lock);
> +       /* Register the notifier for first cpufreq cooling device */
> +       first = list_empty(&cpufreq_dev_list);
>         list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> +       mutex_unlock(&cooling_list_lock);
>
> -       /* Register the notifier for first cpufreq cooling device */
> -       if (!cpufreq_dev_count++)
> +       if (first)
>                 cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
>                                           CPUFREQ_POLICY_NOTIFIER);
> -       mutex_unlock(&cooling_list_lock);
>
>         goto put_policy;
>
> @@ -1021,6 +1021,7 @@ EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
>  void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  {
>         struct cpufreq_cooling_device *cpufreq_dev;
> +       bool last;
>
>         if (!cdev)
>                 return;
> @@ -1028,14 +1029,15 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>         cpufreq_dev = cdev->devdata;
>
>         mutex_lock(&cooling_list_lock);
> +       list_del(&cpufreq_dev->node);
>         /* Unregister the notifier for the last cpufreq cooling device */
> -       if (!--cpufreq_dev_count)
> +       last = list_empty(&cpufreq_dev_list);
> +       mutex_unlock(&cooling_list_lock);
> +
> +       if (last)
>                 cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
>                                             CPUFREQ_POLICY_NOTIFIER);
>
> -       list_del(&cpufreq_dev->node);
> -       mutex_unlock(&cooling_list_lock);
> -
>         thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
>         ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
>         kfree(cpufreq_dev->dyn_power_table);
> --
> 2.11.0
