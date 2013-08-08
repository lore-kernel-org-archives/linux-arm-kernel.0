From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 08 Aug 2013 18:00:24 +0200
Subject: [PATCH v3 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
In-Reply-To: <1375875813-13358-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1375875813-13358-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5203C098.9000701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 01:43 PM, Lorenzo Pieralisi wrote:
> The big.LITTLE architecture is composed of two clusters of cpus. One cluster
> contains less powerful but more energy efficient processors and the other
> cluster groups the powerful but energy-intensive cpus.
> 
> The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters in
> a big.LITTLE configuration) connected through a CCI interconnect that manages
> coherency of their respective L2 caches and intercluster distributed
> virtual memory messages (DVM).
> 
> TC2 testchip integrates a power controller that manages cores resets, wake-up
> IRQs and cluster low-power states. Power states are managed at cluster
> level, which means that voltage is removed from a cluster iff all cores
> in a cluster are in a wfi state. Single cores can enter a reset state
> which is identical to wfi in terms of power consumption but simplifies the
> way cluster states are entered.
> 
> This patch provides a multiple driver CPU idle implementation for TC2
> which paves the way for a generic big.LITTLE idle driver for all
> upcoming big.LITTLE based systems on chip.
> 
> The driver relies on the MCPM infrastructure to coordinate and manage
> core power states; in particular MCPM allows to suspend specific cores
> and hides the CPUs coordination required to shut-down clusters of CPUs.
> 
> Power down sequences for the respective clusters are implemented in the
> MCPM TC2 backend, with all code needed to clean caches and exit coherency.
> 
> The multiple driver CPU idle infrastructure allows to define different
> C-states for big and little cores, determined at boot by checking the
> part id of the possible CPUs and initializing the respective logical
> masks in the big and little drivers.
> 
> Current big.little systems are composed of A7 and A15 clusters, as
> implemented in TC2, but in the future that may change and the driver
> will have evolve to retrieve what is a 'big' cpu and what is a 'little'
> cpu in order to build the correct topology.
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---

A nit below :/

[ ... ]

> +
> +static struct cpuidle_driver bl_idle_big_driver = {
> +	.name = "big_idle",
> +	.owner = THIS_MODULE,
> +	.states[0] = ARM_CPUIDLE_WFI_STATE,
> +	.states[1] = {
> +		.enter			= bl_enter_powerdown,
> +
> +		.exit_latency		= 500,

Extra line between enter and exit_latency.

> +		.target_residency	= 2000,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID |
> +					  CPUIDLE_FLAG_TIMER_STOP,
> +		.name			= "C1",
> +		.desc			= "ARM big-cluster power down",
> +	},
> +	.state_count = 2,
> +};

Thanks
  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
