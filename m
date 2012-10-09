From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Oct 2012 16:49:50 -0600
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <1349691981-31038-8-git-send-email-josephl@nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
Message-ID: <5074AA0E.2080508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 04:26 AM, Joseph Lo wrote:
> The cpuidle LP2 is a power gating idle mode. It support power gating
> vdd_cpu rail after all cpu cores in LP2. For Tegra30, the CPU0 must
> be last one to go into LP2. We need to take care and make sure whole
> secondary CPUs were in LP2 by checking CPU and power gate status.
> After that, the CPU0 can go into LP2 safely. Then power gating the
> CPU rail.

> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c

> +static bool tegra30_idle_enter_lp2_cpu_0(struct cpuidle_device *dev,
> +					 struct cpuidle_driver *drv,
> +					 int index)
> +{
> +	struct cpuidle_state *state = &drv->states[index];
> +	u32 cpu_on_time = state->exit_latency;
> +	u32 cpu_off_time = state->target_residency - state->exit_latency;
> +
> +	if (num_online_cpus() > 1 && !tegra_cpu_rail_off_ready()) {

Should that be || not &&?

Isn't the "num_online_cpus() > 1" condition effectively checked at the
call site, i.e. in tegra30_idle_lp2() below via the if (last_cpu) check?

> @@ -85,16 +108,22 @@ static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
>  				      int index)
>  {
>  	bool entered_lp2 = false;
> +	bool last_cpu;
>  
>  	local_fiq_disable();
>  
> +	last_cpu = tegra_set_cpu_in_lp2(dev->cpu);
> +	if (dev->cpu == 0) {
> +		if (last_cpu)
> +			entered_lp2 = tegra30_idle_enter_lp2_cpu_0(dev, drv,
> +								   index);
> +		else
> +			cpu_do_idle();
> +	} else {
>  		entered_lp2 = tegra30_idle_enter_lp2_cpu_n(dev, drv, index);
> +	}

Hmm. That means that if the last CPU to enter LP2 is e.g. CPU1, then
even though all CPUs are now in LP2, the complex as a whole doesn't
enter LP2. Is there a way to make the cluster as a whole enter LP2 in
this case? Isn't that what coupled cpuidle is for?

> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c

> +static void set_power_timers(unsigned long us_on, unsigned long us_off)

> +	if (tegra_pclk == NULL) {
> +		tegra_pclk = clk_get_sys(NULL, "pclk");
> +		if (IS_ERR(tegra_pclk)) {
> +			/*
> +			 * pclk not been init or not exist.
> +			 * Use sclk to take the place of it.
> +			 * The default setting was pclk=sclk.
> +			 */
> +			tegra_pclk = clk_get_sys(NULL, "sclk");
> +		}
> +	}

That's a little odd. Surely the HW has pclk or it doesn't? Why use
different clocks at different times for what is apparently the same thing?
