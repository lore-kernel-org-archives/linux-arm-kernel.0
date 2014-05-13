From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 13 May 2014 15:43:09 -0400 (EDT)
Subject: [PATCH v7 06/15] ARM: hisi: enable MCPM implementation
In-Reply-To: <1399981484-31628-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-7-git-send-email-haojian.zhuang@linaro.org>
 <1399981484-31628-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <alpine.LFD.2.11.1405131449270.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 May 2014, Haojian Zhuang wrote:

> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
> framework to manage power on HiP04 SoC.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Some more comments...

[...]
> +static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
> +{
> +	unsigned long data;
> +
> +	if (!fabric)
> +		return;

How could this validly be NULL?

> +	data = readl_relaxed(fabric + FAB_SF_MODE);
> +	if (on)
> +		data |= 1 << cluster;
> +	else
> +		data &= ~(1 << cluster);
> +	writel_relaxed(data, fabric + FAB_SF_MODE);
> +	while (1) {
> +		if (data == readl_relaxed(fabric + FAB_SF_MODE))
> +			break;
> +	}
> +}

The above could be easily coded in assembly for the power_up_setup 
callback thusly:

hip04_power_up_setup:

	cmp	r0, #0			@ check affinity level
	bxeq	lr			@ nothing to do at CPU level

	mrc	p15, 0, r0, c0, c0, 5	@ get MPIDR
	ubfx	r0, r0, #8, #8		@ extract cluster number

	adr	r1, .LC0
	ldmia	r1, {r2, r3}
	sub	r2, r2, r1		@ virt_addr - phys_addr
	ldr	r1, [r2, r3]		@ get fabric_phys_addr
	mov	r2, #1
	ldr	r3, [r1, #FAB_SF_MODE]	@ read "data"
	orr	r3, r3, r2, lsl r0	@ set cluster bit
	str	r3, [r1, #FAB_SF_MODE]	@ write it back

1:	ldr	r2, [r1, #FAB_SF_MODE]	@ read register content
	cmp	r2, r3			@ make sure it matches
	bne	1b			@ otherwise retry

	bx	lr

:LC0:	.word	.
	.word	fabric_phys_addr - .LC0

That should be it.

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

Shouldn't you do the above writes only when 
hip04_cpu_table[cluster][cpu] is zero?  Please see the comment in 
mcpm_cpu_power_down() about unordered calls.

> +	if (hip04_cluster_down(cluster)) {
> +		data = CLUSTER_DEBUG_RESET_BIT;
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> +		do {
> +			mask = CLUSTER_DEBUG_RESET_STATUS;
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
> +	unsigned int mpidr, cpu, cluster, data = 0;
> +	bool skip_reset = false;
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
> +		skip_reset = true;
> +	} else if (hip04_cpu_table[cluster][cpu] > 1) {
> +		pr_err("Cluster %d CPU%d is still running\n", cluster, cpu);

This message is misleading.  If execution gets here, that means 
mcpm_cpu_power_up() was called more than twice in a row for the same CPU 
which should never happen.

> +		BUG();
> +	}
> +
> +	spin_unlock(&boot_lock);
> +
> +	v7_exit_coherency_flush(louis);
> +
> +	__mcpm_cpu_down(cpu, cluster);
> +
> +	if (!skip_reset) {
> +		data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +		       CORE_DEBUG_RESET_BIT(cpu);
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));

You should not perform this outside the lock protected region as this 
could race with hip04_mcpm_power_up().  Instead, this should be done 
above when hip04_cpu_table[cluster][cpu] == 0 after being decremented.

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
> +		if (!(data & CORE_RESET_STATUS(cpu))) {
> +			msleep(POLL_MSEC);
> +			continue;
> +		}
> +		return 0;
> +	}
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
> +	if (!hip04_cpu_table_init())
> +		return -EINVAL;
> +	ret = mcpm_platform_register(&hip04_mcpm_ops);
> +	if (!ret) {
> +		mcpm_sync_init(NULL);
> +		pr_info("HiP04 MCPM initialized\n");
> +	}
> +	mcpm_smp_set_ops();
> +	return ret;
> +err_fabric:
> +	iounmap(sysctrl);
> +err_sysctrl:
> +	iounmap(relocation);
> +err:
> +	return ret;
> +}
> +early_initcall(hip04_mcpm_init);
> -- 
> 1.9.1
> 
