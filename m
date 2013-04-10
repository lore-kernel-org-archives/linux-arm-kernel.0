From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 10 Apr 2013 20:02:31 +0200
Subject: [PATCH 05/18] cpuidle: make a single register function for all
In-Reply-To: <20130410170457.GL13524@lunn.ch>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
 <20130410170457.GL13524@lunn.ch>
Message-ID: <5165A937.70705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 07:04 PM, Andrew Lunn wrote:
>> +int cpuidle_register(struct cpuidle_driver *drv,
>> +		     const struct cpumask *const coupled_cpus)
>> +{
>> +	int ret, cpu;
>> +	struct cpuidle_device *device;
>> +
>> +	ret = cpuidle_register_driver(drv);
>> +	if (ret) {
>> +		printk(KERN_ERR "failed to register cpuidle driver\n");
>> +		return ret;
>> +	}
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		device = &per_cpu(cpuidle_dev, cpu);
>> +		device->cpu = cpu;
>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>> +		device->coupled_cpus = *coupled_cpus;
>> +#endif
> 
> At least the kirkwood and the calxeda driver set 
> 
>    device->state_count
> 
> which you don't appear to do. cpuidle_add_state_sysfs() and
> cpuidle_remove_state_sysfs() use this. Is it now being set somewhere
> else?

Yes, in cpuidle_enable_device called from cpuidle_register_device:


int cpuidle_enable_device(struct cpuidle_device *dev)
{
	...

        if (!dev->state_count)
                dev->state_count = drv->state_count;

	...
}

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
