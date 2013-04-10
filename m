From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 10 Apr 2013 19:04:57 +0200
Subject: [PATCH 05/18] cpuidle: make a single register function for all
In-Reply-To: <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20130410170457.GL13524@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +int cpuidle_register(struct cpuidle_driver *drv,
> +		     const struct cpumask *const coupled_cpus)
> +{
> +	int ret, cpu;
> +	struct cpuidle_device *device;
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		printk(KERN_ERR "failed to register cpuidle driver\n");
> +		return ret;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		device = &per_cpu(cpuidle_dev, cpu);
> +		device->cpu = cpu;
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +		device->coupled_cpus = *coupled_cpus;
> +#endif

At least the kirkwood and the calxeda driver set 

   device->state_count

which you don't appear to do. cpuidle_add_state_sysfs() and
cpuidle_remove_state_sysfs() use this. Is it now being set somewhere
else?

Thanks
	Andrew
