From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Dec 2012 11:40:38 -0700
Subject: [PATCH 4/5] ARM: tegra20: cpuidle: add powered-down state for CPU0
In-Reply-To: <1354503607-13707-5-git-send-email-josephl@nvidia.com>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-5-git-send-email-josephl@nvidia.com>
Message-ID: <50BCF226.1080501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2012 08:00 PM, Joseph Lo wrote:
> The powered-down state of Tegra20 requires power gating both CPU cores.
> When the secondary CPU requests to enter powered-down state, it saves
> its own contexts and then enters WFI for waiting CPU0 in the same state.
> When the CPU0 requests powered-down state, it attempts to put the secondary
> CPU into reset to prevent it from waking up. Then power down both CPUs
> together and power off the cpu rail.
> 
> Be aware of that, you may see the legacy power state "LP2" in the code
> which is exactly the same meaning of "CPU power down".

> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c

> +static int tegra20_reset_sleeping_cpu(int cpu)
> +{
> +	int ret = 0;
> +
> +	BUG_ON(cpu == 0);
> +	BUG_ON(cpu == smp_processor_id());

Will this code ever be used on anything other than Tegra20? I assume not
since it's in a Tegra20-specific file. Given that, it seems much of the
code could be made a lot simpler, e.g. by removing the "cpu" parameter
here, which would avoid requiring those BUG()s. You'd probably want to
rename the function e.g. tegra20_reset_cpu_1_sleeping().

> +static int tegra20_reset_other_cpus(int cpu)
> +{
> +	int i;
> +	int ret = 0;
> +
> +	BUG_ON(cpu != 0);
> +
> +	for_each_online_cpu(i) {
> +		if (i != cpu) {
> +			if (tegra20_reset_sleeping_cpu(i)) {
> +				ret = -EBUSY;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (ret) {
> +		for_each_online_cpu(i) {
> +			if (i != cpu)
> +				tegra20_wake_reset_cpu(i);
> +		}
> +		return ret;
> +	}
> +
> +	return 0;
> +}

Equally, couldn't that simply be:

static int tegra20_reset_cpu_1(void)
{
	if (!cpu_is_online() || !tegra20_reset_cpu1_sleeping())
		return 0;

	tegra20_wake_reset_cpu_1();
	return -EBUSY;
}

> +static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
> +					   struct cpuidle_driver *drv,
> +					   int index)

> +	for_each_online_cpu(i) {
> +		if (i != dev->cpu)
> +			tegra20_wake_reset_cpu(i);
> +	}

Similarly there, we know CPU 0 is executing the code and the only other
CPU is CPU 1, so:

if (cpu_is_online(1))
	tegra20_wake_reset_cpu(1);

? Admittedly the savings aren't so clear there, since there's less code
to begin with, but it's still more obvious that way that there are fewer
cases the code will ever need to cover.

> diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
> diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S

Similar comments about C-vs-assembly here as before, for at least some
of the functions.

> +/*
> + * tegra_cpu_pllp
> + *
> + * In LP2 the normal cpu clock pllx will be turned off. Switch the CPU to pllp
> + */
> +ENTRY(tegra_cpu_pllp)

There's no verb in that function name. tegra_switch_cpu_to_pllp() might
be a better name.
