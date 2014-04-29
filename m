From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 29 Apr 2014 18:05:11 +0100
Subject: [PATCH v4 08/14] ARM: hisi: add hip04 SoC support
In-Reply-To: <1398668032-8335-9-git-send-email-haojian.zhuang@linaro.org>
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140429170511.GD3582@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 02:53:46PM +0800, Haojian Zhuang wrote:
> Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
> Cortex A15 Core. Since multiple clusters is used in HiP04 SoC, it could
> be based on MCPM.
> 
> And HiP04 supports LPAE to support large memory.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig               |   2 +-
>  arch/arm/mach-hisi/Kconfig     |  10 +-
>  arch/arm/mach-hisi/Makefile    |   1 +
>  arch/arm/mach-hisi/core.h      |   2 +
>  arch/arm/mach-hisi/hisilicon.c |  12 ++
>  arch/arm/mach-hisi/platmcpm.c  | 318 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 343 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-hisi/platmcpm.c

[...]

> diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
> index 741faf3..6489e57 100644
> --- a/arch/arm/mach-hisi/hisilicon.c
> +++ b/arch/arm/mach-hisi/hisilicon.c

[...]

> @@ -0,0 +1,318 @@

[...]

> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned long data, mask;
> +
> +	if (!relocation || !sysctrl)
> +		return -ENODEV;
> +	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
> +		return -EINVAL;
> +
> +	spin_lock_irq(&boot_lock);
> +	writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
> +	writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
> +	writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
> +	writel_relaxed(0, relocation + 12);
> +
> +	if (hip04_cluster_down(cluster)) {

Do you intend to add more functionality to this backend later?

The key facility that MCPM provides is in helping to manage
per-cluster resources in the presence of interrupt-driven
wakeups.

If you have to explicity reset L2 before the first CPU can
power up, this restricts the possibility of interrupt-driven
wakeup of a cluster, unless you leave L2 powered up so that
there is no need to reset it.

> +		data = CLUSTER_L2_RESET_BIT | CLUSTER_DEBUG_RESET_BIT;
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));

Can this reset operation race with v7_exit_coherency_flush() in
hip04_mcpm_power_down()?

The _power_down() method must probably release boot_lock before calling
v7_exit_coherency_flush(), because spinlocks may stop working properly
as result of disabling the cache -- whether they still work depends on
the CPU and the platform, but it is probably best not to rely on it
unless you are sure it is safe for your platform.

However, this currently leaves the L2 cache unprotected from racing with
_power_up().

Currently MCPM assumes that all cluster setup is done by the powering-up
CPU itself.  For hardware platforms where this isn't possible, there is
a limit on how deep clusters can be powered down for CPUidle which will
solve the problem for us.  But for hotplug to work safely we might need
a C interface for doing the power-up part of the coordination, currently
done by mcpm_head.S.

Cheers
---Dave

> +		do {
> +			mask = CLUSTER_L2_RESET_STATUS | \
> +			       CLUSTER_DEBUG_RESET_STATUS;
> +			data = readl_relaxed(sysctrl + \
> +					     SC_CPU_RESET_STATUS(cluster));
> +		} while (data & mask);
> +		hip04_set_snoop_filter(cluster, 1);
> +	}
> +
> +	hip04_cpu_table[cluster][cpu]++;
> +
> +	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +	       CORE_DEBUG_RESET_BIT(cpu);
> +	writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> +	spin_unlock_irq(&boot_lock);
> +	msleep(POLL_MSEC);
> +
> +	return 0;
> +}
> +
> +static void hip04_mcpm_power_down(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +	bool skip_wfi = false;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	__mcpm_cpu_going_down(cpu, cluster);
> +
> +	spin_lock(&boot_lock);
> +	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> +	hip04_cpu_table[cluster][cpu]--;
> +	if (hip04_cpu_table[cluster][cpu] == 1) {
> +		/* A power_up request went ahead of us. */
> +		skip_wfi = true;
> +	} else if (hip04_cpu_table[cluster][cpu] > 1) {
> +		pr_err("Cluster %d CPU%d is still running\n", cluster, cpu);
> +		BUG();
> +	}
> +
> +	spin_unlock(&boot_lock);
> +
> +	v7_exit_coherency_flush(louis);
> +
> +	__mcpm_cpu_down(cpu, cluster);
> +
> +	isb();
> +	dsb();
> +
> +	if (!skip_wfi)
> +		wfi();
> +}
> +
> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned int data, tries;
> +
> +	BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
> +	       cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
> +
> +	for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; tries++) {
> +		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
> +		if (!(data & CORE_WFI_STATUS(cpu))) {
> +			msleep(POLL_MSEC);
> +			continue;
> +		}
> +		data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +		       CORE_DEBUG_RESET_BIT(cpu);
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
> +		return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void hip04_mcpm_powered_up(void)
> +{
> +	if (!relocation)
> +		return;
> +	spin_lock(&boot_lock);
> +	writel_relaxed(0, relocation);
> +	writel_relaxed(0, relocation + 4);
> +	writel_relaxed(0, relocation + 8);
> +	writel_relaxed(0, relocation + 12);
> +	spin_unlock(&boot_lock);
> +}
> +
> +static const struct mcpm_platform_ops hip04_mcpm_ops = {
> +	.power_up		= hip04_mcpm_power_up,
> +	.power_down		= hip04_mcpm_power_down,
> +	.wait_for_powerdown	= hip04_mcpm_wait_for_powerdown,
> +	.powered_up		= hip04_mcpm_powered_up,
> +};
> +
> +static bool __init hip04_cpu_table_init(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	if (cluster >= HIP04_MAX_CLUSTERS ||
> +	    cpu >= HIP04_MAX_CPUS_PER_CLUSTER) {
> +		pr_err("%s: boot CPU is out of bound!\n", __func__);
> +		return false;
> +	}
> +	hip04_set_snoop_filter(cluster, 1);
> +	hip04_cpu_table[cluster][cpu] = 1;
> +	return true;
> +}
> +
> +static int __init hip04_mcpm_init(void)
> +{
> +	struct device_node *np, *np_fab;
> +	int ret = -ENODEV;
> +
> +	np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
> +	if (!np)
> +		goto err;
> +	np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
> +	if (!np_fab)
> +		goto err;
> +
> +	if (of_property_read_u32(np, "bootwrapper-phys",
> +				 &hip04_boot.bootwrapper_phys)) {
> +		pr_err("failed to get bootwrapper-phys\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "bootwrapper-size",
> +				 &hip04_boot.bootwrapper_size)) {
> +		pr_err("failed to get bootwrapper-size\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "bootwrapper-magic",
> +				 &hip04_boot.bootwrapper_magic)) {
> +		pr_err("failed to get bootwrapper-magic\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "relocation-entry",
> +				 &hip04_boot.relocation_entry)) {
> +		pr_err("failed to get relocation-entry\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "relocation-size",
> +				 &hip04_boot.relocation_size)) {
> +		pr_err("failed to get relocation-size\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	relocation = ioremap(hip04_boot.relocation_entry,
> +			     hip04_boot.relocation_size);
> +	if (!relocation) {
> +		pr_err("failed to map relocation space\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	sysctrl = of_iomap(np, 0);
> +	if (!sysctrl) {
> +		pr_err("failed to get sysctrl base\n");
> +		ret = -ENOMEM;
> +		goto err_sysctrl;
> +	}
> +	fabric = of_iomap(np_fab, 0);
> +	if (!fabric) {
> +		pr_err("failed to get fabric base\n");
> +		ret = -ENOMEM;
> +		goto err_fabric;
> +	}
> +
> +	memblock_reserve(hip04_boot.bootwrapper_phys,
> +			 hip04_boot.bootwrapper_size);
> +
> +	if (!hip04_cpu_table_init())
> +		return -EINVAL;
> +	ret = mcpm_platform_register(&hip04_mcpm_ops);
> +	if (!ret) {
> +		mcpm_sync_init(NULL);
> +		pr_info("HiP04 MCPM initialized\n");
> +	}
> +	return ret;
> +err_fabric:
> +	iounmap(sysctrl);
> +err_sysctrl:
> +	iounmap(relocation);
> +err:
> +	return ret;
> +}
> +early_initcall(hip04_mcpm_init);
> +
> +bool __init hip04_smp_init_ops(void)
> +{
> +	mcpm_smp_set_ops();
> +	return true;
> +}
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
