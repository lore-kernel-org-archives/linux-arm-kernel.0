From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Jul 2014 06:12:50 -0400 (EDT)
Subject: [PATCH v11 04/12] ARM: hisi: enable MCPM implementation
In-Reply-To: <1405330453-15104-1-git-send-email-haojian.zhuang@linaro.org>
References: <1405330453-15104-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <alpine.LFD.2.11.1407140553300.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jul 2014, Haojian Zhuang wrote:

> +static bool hip04_init_cluster0_snoop(void)
> +{
> +	unsigned long data;
> +
> +	if (!fabric) {
> +		pr_err("failed to find fabric base\n");
> +		return false;
> +	}
> +	data = readl_relaxed(fabric + FAB_SF_MODE);
> +	data |= 1;
> +	writel_relaxed(data, fabric + FAB_SF_MODE);
> +	while (1) {
> +		if (data == readl_relaxed(fabric + FAB_SF_MODE))
> +			break;
> +	}
> +	return true;
> +}

In fact you probably should make this into something like:

static bool hip04_set_cluster_snoop(int cluster, bool active)

Eventually you'll want to turn snoops off when a cluster is completely 
idle.  And this can be used to init snoops on cluster 0 during boot as 
well.

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
> +
> +	if (hip04_cpu_table[cluster][cpu]) {
> +		hip04_cpu_table[cluster][cpu]++;
> +		spin_unlock_irq(&boot_lock);
> +		return 0;
> +	}
> +
> +	writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
> +	writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
> +	writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
> +	writel_relaxed(0, relocation + 12);
> +
> +	if (hip04_cluster_down(cluster)) {
> +		data = CLUSTER_DEBUG_RESET_BIT;
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> +		do {
> +			mask = CLUSTER_DEBUG_RESET_STATUS;
> +			data = readl_relaxed(sysctrl + \
> +					     SC_CPU_RESET_STATUS(cluster));
> +		} while (data & mask);
> +	}
> +
> +	hip04_cpu_table[cluster][cpu]++;
> +
> +	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +	       CORE_DEBUG_RESET_BIT(cpu);
> +	writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> +	spin_unlock_irq(&boot_lock);
> +	msleep(POLL_MSEC);

Now that the booting CPU takes cares of snoops for itself, is this delay 
still required?

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
> +		pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
> +		BUG();
> +	}
> +
> +	v7_exit_coherency_flush(louis);
> +
> +	__mcpm_cpu_down(cpu, cluster);
> +	spin_unlock(&boot_lock);

You can't touch spinlocks after v7_exit_coherency_flush().  That has to 
come before it.

> +	if (!skip_reset) {
> +		data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +		       CORE_DEBUG_RESET_BIT(cpu);
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
> +	}

And the race is still there.  If right before skip_reset is tested the 
code in power_up() is executed, the CPU will then be shut down here 
although it is expected to remain alive.

You are certain no code is ever executed after SC_CPU_RESET_REQ is 
written to? You don't need to execute wfi() for the reset to be 
effective?  If so this write will have to be performed by another CPU 
via a work queue or something unless there is simply no other CPU 
running in the system.


Nicolas
