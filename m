From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Aug 2015 13:41:43 +0530
Subject: [PATCH] thermal: cpu_cooling: fix lockdep problems in cpu_cooling
In-Reply-To: <E1ZPQfV-0005nb-DN@rmk-PC.arm.linux.org.uk>
References: <20150812073530.GA16445@linux>
 <E1ZPQfV-0005nb-DN@rmk-PC.arm.linux.org.uk>
Message-ID: <20150812081142.GB16445@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-08-15, 08:41, Russell King wrote:
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>  /**
> @@ -221,7 +224,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  	switch (event) {
>  
>  	case CPUFREQ_ADJUST:
> -		mutex_lock(&cooling_cpufreq_lock);
> +		mutex_lock(&cooling_list_lock);

There is one more place where the list's locking needs update:
cpufreq_cooling_get_level().

>  		list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
>  			if (!cpumask_test_cpu(policy->cpu,
>  					      &cpufreq_dev->allowed_cpus))
> @@ -233,7 +236,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  				cpufreq_verify_within_limits(policy, 0,
>  							     max_freq);
>  		}
> -		mutex_unlock(&cooling_cpufreq_lock);
> +		mutex_unlock(&cooling_list_lock);
>  		break;
>  	default:
>  		return NOTIFY_DONE;
> @@ -865,12 +868,15 @@ __cpufreq_cooling_register(struct device_node *np,
>  	cpufreq_dev->cool_dev = cool_dev;
>  
>  	mutex_lock(&cooling_cpufreq_lock);
> +	mutex_lock(&cooling_list_lock);

Why is the list lock taken from within the existing lock here? and ...

> +	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> +	mutex_unlock(&cooling_list_lock);
>  
>  	/* Register the notifier for first cpufreq cooling device */
> -	if (list_empty(&cpufreq_dev_list))
> +	if (cpufreq_dev_count == 0)
>  		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
>  					  CPUFREQ_POLICY_NOTIFIER);
> -	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> +	cpufreq_dev_count++;

Maybe:
        if (!cpufreq_dev_count++)
                cpufreq_register_notifier();

>  
>  	mutex_unlock(&cooling_cpufreq_lock);
>  
> @@ -1014,14 +1020,18 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  
>  	cpufreq_dev = cdev->devdata;
>  	mutex_lock(&cooling_cpufreq_lock);
> -	list_del(&cpufreq_dev->node);
> +	cpufreq_dev_count--;
>  
>  	/* Unregister the notifier for the last cpufreq cooling device */
> -	if (list_empty(&cpufreq_dev_list))
> +	if (cpufreq_dev_count == 0)

Maybe:
        if (!--cpufreq_dev_count)
                cpufreq_register_notifier();

>  		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
>  					    CPUFREQ_POLICY_NOTIFIER);
>  	mutex_unlock(&cooling_cpufreq_lock);
>  
> +	mutex_lock(&cooling_list_lock);

... The same list lock is not taken from within the earlier critical
section?

> +	list_del(&cpufreq_dev->node);
> +	mutex_unlock(&cooling_list_lock);
> +
>  	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
>  	release_idr(&cpufreq_idr, cpufreq_dev->id);
>  	kfree(cpufreq_dev->time_in_idle_timestamp);
> -- 
> 2.1.0

-- 
viresh
