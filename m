From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 3 Jul 2014 11:45:32 -0400 (EDT)
Subject: several messages
In-Reply-To: <1404398818-6859-1-git-send-email-a.kesavan@samsung.com>
References: <1404363737-26222-1-git-send-email-a.kesavan@samsung.com>
 <1404398818-6859-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <alpine.LFD.2.11.1407031111100.6220@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jul 2014, Abhilash Kesavan wrote:

> On Thu, Jul 3, 2014 at 6:59 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > Please, let's avoid going that route.  There is no such special handling
> > needed if the API is sufficient.  And the provided API allows you to
> > suspend a CPU or shut it down.  It shouldn't matter at that level if
> > this is due to a cluster switch or a hotplug event. Do you really need
> > something else?
> No, just one local flag for suspend should be enough for me. Will remove these.

[...]

> Changes in v5:
> 	- Removed the MCPM flags and just used a local flag to
> 	indicate that we are suspending.

[...]

> -static void exynos_power_down(void)
> +static void exynos_mcpm_power_down(u64 residency)
>  {
>  	unsigned int mpidr, cpu, cluster;
>  	bool last_man = false, skip_wfi = false;
> @@ -150,7 +153,12 @@ static void exynos_power_down(void)
>  	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>  	cpu_use_count[cpu][cluster]--;
>  	if (cpu_use_count[cpu][cluster] == 0) {
> -		exynos_cpu_power_down(cpunr);
> +		/*
> +		 * Bypass power down for CPU0 during suspend. This is being
> +		 * taken care by the SYS_PWR_CFG bit in CORE0_SYS_PWR_REG.
> +		 */
> +		if ((cpunr != 0) || (residency != S5P_CHECK_SLEEP))
> +			exynos_cpu_power_down(cpunr);
>  
>  		if (exynos_cluster_unused(cluster)) {
>  			exynos_cluster_power_down(cluster);
> @@ -209,6 +217,11 @@ static void exynos_power_down(void)
>  	/* Not dead at this point?  Let our caller cope. */
>  }
>  
> +static void exynos_power_down(void)
> +{
> +	exynos_mcpm_power_down(0);
> +}

[...]

> +static int notrace exynos_mcpm_cpu_suspend(unsigned long arg)
> +{
> +	/* MCPM works with HW CPU identifiers */
> +	unsigned int mpidr = read_cpuid_mpidr();
> +	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +
> +	__raw_writel(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
> +
> +	mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
> +
> +	/*
> +	 * Pass S5P_CHECK_SLEEP flag to the MCPM back-end to indicate that
> +	 * we are suspending the system and need to skip CPU0 power down.
> +	 */
> +	mcpm_cpu_suspend(S5P_CHECK_SLEEP);

NAK.

When I say "local flag with local meaning", I don't want you to smuggle 
that flag through a public interface either.  I find it rather inelegant 
to have the notion of special handling for CPU0 being spread around like 
that.

If CPU0 is special, then it should be dealth with in one place only, 
ideally in the MCPM backend, so the rest of the kernel doesn't have to 
care.

Again, here's what I mean:

static void exynos_mcpm_down_handler(int flags)
{
	[...]
	if ((cpunr != 0) || !(flags & SKIP_CPU_POWERDOWN_IF_CPU0))
		exynos_cpu_power_down(cpunr);
	[...]
}

static void exynos_mcpm_power_down()
{
	exynos_mcpm_down_handler(0);
}

static void exynos_mcpm_suspend(u64 residency)
{
	/*
	 * Theresidency argument is ignored for now.
	 * However, in the CPU suspend case, we bypass power down for 
	 * CPU0 as this is being taken care by the SYS_PWR_CFG bit in
	 * CORE0_SYS_PWR_REG.
	 */
	exynos_mcpm_down_handler(SKIP_CPU_POWERDOWN_IF_CPU0);
}

And SKIP_CPU_POWERDOWN_IF_CPU0 is defined in and visible to 
mcpm-exynos.c only.


Nicolas
