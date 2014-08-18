From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:21:53 +0100
Subject: [PATCH v7 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <1407945127-27554-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-7-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140818142153.GH20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 04:52:05PM +0100, Lorenzo Pieralisi wrote:
> +static int __init arm64_idle_init(void)
> +{
> +	int i, ret;
> +	struct cpuidle_driver *drv = &arm64_idle_driver;
> +
> +	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> +	if (!drv->cpumask)
> +		return -ENOMEM;
> +
> +	cpumask_copy(drv->cpumask, cpu_possible_mask);
> +	/*
> +	 * Initialize idle states data, starting at index 1.
> +	 * This driver is DT only, if no DT idle states are detected (ret == 0)
> +	 * let the driver initialization fail accordingly since there is no
> +	 * reason to initialize the idle driver if only wfi is supported.
> +	 */
> +	ret = dt_init_idle_driver(drv, 1);
> +	if (ret <= 0)
> +		goto free_mem;
> +	/*
> +	 * Call arch CPU operations in order to initialize
> +	 * idle states suspend back-end specific data
> +	 */
> +	for_each_cpu(i, drv->cpumask) {
> +		ret = cpu_init_idle(i);
> +		if (ret)
> +			goto free_mem;
> +	}
> +
> +	for (i = 1; i < drv->state_count; i++)
> +		drv->states[i].enter = arm_enter_idle_state;

BTW, I've seen this pattern a few times already. Do you think it would
be useful to change the dt_init_idle_driver() API to take a function
pointer as argument and populate it there? The only drawback would be if
we want different functions based on the states that have been
populated (not sure whether we'll need the flexibility in the future).
Either way, my ack on this patch stands.

-- 
Catalin
