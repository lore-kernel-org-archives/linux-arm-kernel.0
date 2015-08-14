From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 13 Aug 2015 21:50:11 -0700
Subject: [PATCH] thermal: cpu_cooling: fix lockdep problems in cpu_cooling
In-Reply-To: <E1ZPQfV-0005nb-DN@rmk-PC.arm.linux.org.uk>
References: <20150812073530.GA16445@linux>
 <E1ZPQfV-0005nb-DN@rmk-PC.arm.linux.org.uk>
Message-ID: <20150814045009.GB10354@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Aug 12, 2015 at 08:41:49AM +0100, Russell King wrote:

<cut>

> 
> For some reason, despite Rafael saying that this should go in, despite it
> having been reviewed, Eduardo appears to be ignoring basic fixes to code
> under his control.  Having waited more than a reasonable amount of time,
> it is now time to take some action against this blockage.  Hence, I'm
> putting this into linux-next in the hope that it'll conflict and elicit
> a response for this important bug fix.

Sorry if I let this one to fall into the cracks for this long.

I am looking at this now and queuing as soon as possible.

Thanks for pushing this fix.

BR,

Eduardo

> 
> Relevant message IDs:
> 20141214213655.GA11285 at n2100.arm.linux.org.uk
> 7573578.UE8ufgjWuX at vostro.rjw.lan
> 20141215230922.GL11285 at n2100.arm.linux.org.uk
> CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A at mail.gmail.com
> 20150518185645.GA28053 at n2100.arm.linux.org.uk
> 2574268.XBqpdL2VLI at vostro.rjw.lan
> ---
>  drivers/thermal/cpu_cooling.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 6509c61b9648..d1fd02eec58d 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -107,6 +107,9 @@ struct cpufreq_cooling_device {
>  static DEFINE_IDR(cpufreq_idr);
>  static DEFINE_MUTEX(cooling_cpufreq_lock);
>  
> +static unsigned int cpufreq_dev_count;
> +
> +static DEFINE_MUTEX(cooling_list_lock);
>  static LIST_HEAD(cpufreq_dev_list);
>  
>  /**
> @@ -221,7 +224,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  	switch (event) {
>  
>  	case CPUFREQ_ADJUST:
> -		mutex_lock(&cooling_cpufreq_lock);
> +		mutex_lock(&cooling_list_lock);
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
>  		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
>  					    CPUFREQ_POLICY_NOTIFIER);
>  	mutex_unlock(&cooling_cpufreq_lock);
>  
> +	mutex_lock(&cooling_list_lock);
> +	list_del(&cpufreq_dev->node);
> +	mutex_unlock(&cooling_list_lock);
> +
>  	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
>  	release_idr(&cpufreq_idr, cpufreq_dev->id);
>  	kfree(cpufreq_dev->time_in_idle_timestamp);
> -- 
> 2.1.0
> 
