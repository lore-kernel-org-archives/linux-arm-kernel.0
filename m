From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 May 2017 10:46:11 -0600
Subject: [patch V3 11/32] hwtracing/coresight-etm3x: Use
 cpuhp_setup_state_nocalls_cpuslocked()
In-Reply-To: <20170524081547.889092478@linutronix.de>
References: <20170524081511.203800767@linutronix.de>
 <20170524081547.889092478@linutronix.de>
Message-ID: <20170525164611.GA31052@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 10:15:22AM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> etm_probe() holds get_online_cpus() while invoking
> cpuhp_setup_state_nocalls().
> 
> cpuhp_setup_state_nocalls() invokes get_online_cpus() as well. This is
> correct, but prevents the conversion of the hotplug locking to a percpu
> rwsem.
> 
> Use cpuhp_setup_state_nocalls_cpuslocked() to avoid the nested
> call. Convert *_online_cpus() to the new interfaces while at it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -587,7 +587,7 @@ static void etm_disable_sysfs(struct cor
>  	 * after cpu online mask indicates the cpu is offline but before the
>  	 * DYING hotplug callback is serviced by the ETM driver.
>  	 */
> -	get_online_cpus();
> +	cpus_read_lock();
>  	spin_lock(&drvdata->spinlock);
>  
>  	/*
> @@ -597,7 +597,7 @@ static void etm_disable_sysfs(struct cor
>  	smp_call_function_single(drvdata->cpu, etm_disable_hw, drvdata, 1);
>  
>  	spin_unlock(&drvdata->spinlock);
> -	put_online_cpus();
> +	cpus_read_unlock();
>  
>  	dev_info(drvdata->dev, "ETM tracing disabled\n");
>  }
> @@ -795,7 +795,7 @@ static int etm_probe(struct amba_device
>  
>  	drvdata->cpu = pdata ? pdata->cpu : 0;
>  
> -	get_online_cpus();
> +	cpus_read_lock();
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
>  	if (smp_call_function_single(drvdata->cpu,
> @@ -803,17 +803,17 @@ static int etm_probe(struct amba_device
>  		dev_err(dev, "ETM arch init failed\n");
>  
>  	if (!etm_count++) {
> -		cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING,
> -					  "arm/coresight:starting",
> -					  etm_starting_cpu, etm_dying_cpu);
> -		ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> -						"arm/coresight:online",
> -						etm_online_cpu, NULL);
> +		cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING,
> +						     "arm/coresight:starting",
> +						     etm_starting_cpu, etm_dying_cpu);
> +		ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
> +							   "arm/coresight:online",
> +							   etm_online_cpu, NULL);
>  		if (ret < 0)
>  			goto err_arch_supported;
>  		hp_online = ret;
>  	}
> -	put_online_cpus();
> +	cpus_read_unlock();
>  
>  	if (etm_arch_supported(drvdata->arch) == false) {
>  		ret = -EINVAL;
> 
> 
