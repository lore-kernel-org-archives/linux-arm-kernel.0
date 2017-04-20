From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 20 Apr 2017 09:32:11 -0600
Subject: [patch V2 08/24] hwtracing/coresight-etm3x: Use
 cpuhp_setup_state_nocalls_cpuslocked()
In-Reply-To: <20170418170553.026838125@linutronix.de>
References: <20170418170442.665445272@linutronix.de>
 <20170418170553.026838125@linutronix.de>
Message-ID: <20170420153211.GA11868@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 07:04:50PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> etm_probe() holds get_online_cpus() while invoking
> cpuhp_setup_state_nocalls().
> 
> cpuhp_setup_state_nocalls() invokes get_online_cpus() as well. This is
> correct, but prevents the conversion of the hotplug locking to a percpu
> rwsem.
> 
> Use cpuhp_setup_state_nocalls_cpuslocked() to avoid the nested call.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> 
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -803,12 +803,12 @@ static int etm_probe(struct amba_device
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

Checkpatch complains about lines being over 80 characters long.  It is better to
keep the above or do as follow and make checkpatch happy?

                cpuhp_setup_state_nocalls_cpuslocked(
                                        PUHP_AP_ARM_CORESIGHT_STARTING,
                                        "arm/coresight:starting",
                                        etm_starting_cpu, etm_dying_cpu);
                ret = cpuhp_setup_state_nocalls_cpuslocked(
                                        CPUHP_AP_ONLINE_DYN,
                                        "arm/coresight:online",
                                        etm_online_cpu, NULL);

Same for coresight-etm4x.c

Thanks,
Mathieu
