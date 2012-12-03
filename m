From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Dec 2012 11:52:40 -0700
Subject: [PATCH 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <1354503607-13707-6-git-send-email-josephl@nvidia.com>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-6-git-send-email-josephl@nvidia.com>
Message-ID: <50BCF4F8.60606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2012 08:00 PM, Joseph Lo wrote:
> The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
> core to go into this mode before other core. The coupled cpuidle framework
> can help to sync the MPCore to coupled state then go into "powered-down"
> idle mode together. The driver can just assume the MPCore come into
> "powered-down" mode at the same time. No need to take care if the CPU_0
> goes into this mode along and only can put it into safe idle mode (WFI).

I wonder if it wouldn't be simpler to squash this patch into one of the
earlier patches, and just use coupled cpuidle from the very start?

> +static int __cpuinit tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
> +					      struct cpuidle_driver *drv,
> +					      int index)

> -	if (cpu == 0) {
> -		if (last_cpu)
> -			entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv,
> -								     index);
> -		else
> -			cpu_do_idle();
> -	} else {
> +	if (cpu == 0)
> +		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
> +	else
>  		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
> -	}

So I assume that coupled cpuidle only calls this function on CPU 0 once
it has guaranteed that CPU n are all in this same idle state. What does
CPU 0 do now, when it wants to enter LP2 but can't because CPU n aren't
in LP2? Do we need to explicitly provide some kind of function to
implement this waiting state, or does coupled cpuidle ensure the LP3 is
entered, or implement WFI itself, or ...?

> @@ -258,6 +256,9 @@ int __init tegra20_cpuidle_init(void)

> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +		dev->coupled_cpus = *cpu_online_mask;
> +#endif

What if that changes; I assume couple cpuidle handles that by
registering a notifier?

Is there any way that the kernel can boot with only CPU 0 "plugged in",
but later have the other CPU hotplugged in? In other words, should that
hard-code a mask (3?) that describes the HW, rather than relying on the
runtime hotplug status? (think about what happens when this idle code is
moved into drivers/cpuidle/ and built as a module, and hence could be
initialized with only 1 CPU hotplugged in).
