From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 12 Aug 2014 11:52:49 -0400 (EDT)
Subject: [PATCH v18 2/8] ARM: hisi: enable MCPM implementation
In-Reply-To: <1407828408-21431-1-git-send-email-haojian.zhuang@linaro.org>
References: <1407828408-21431-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <alpine.LFD.2.11.1408121129440.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Aug 2014, Haojian Zhuang wrote:

> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned long data, mask;
> +	void __iomem *sys_dreq, *sys_status;
> +
> +	if (!sysctrl)
> +		return -ENODEV;
> +	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
> +		return -EINVAL;
> +
> +	spin_lock_irq(&boot_lock);
> +
> +	if (hip04_cpu_table[cluster][cpu])
> +		goto out;
> +
> +	sys_dreq = sysctrl + SC_CPU_RESET_DREQ(cluster);
> +	sys_status = sysctrl + SC_CPU_RESET_STATUS(cluster);
> +	if (hip04_cluster_is_down(cluster)) {
> +		data = CLUSTER_DEBUG_RESET_BIT;
> +		writel_relaxed(data, sys_dreq);
> +		do {
> +			cpu_relax();
> +			mask = CLUSTER_DEBUG_RESET_STATUS;
> +			data = readl_relaxed(sys_status);
> +		} while (data & mask);
> +	}
> +
> +	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +	       CORE_DEBUG_RESET_BIT(cpu);
> +	writel_relaxed(data, sys_dreq);
> +	do {
> +		cpu_relax();
> +	} while (data == readl_relaxed(sys_status));
> +	udelay(20);

You really need this even if the snoops aren't disabled in 
hip04_mcpm_power_down() ?

> +out:
> +	hip04_cpu_table[cluster][cpu]++;
> +	spin_unlock_irq(&boot_lock);
> +
> +	return 0;
> +}
> +
> +static void hip04_mcpm_power_down(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +	bool skip_wfi = false, last_man = false;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	__mcpm_cpu_going_down(cpu, cluster);
> +
> +	spin_lock_irq(&boot_lock);
> +	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> +	hip04_cpu_table[cluster][cpu]--;
> +	if (hip04_cpu_table[cluster][cpu] == 1) {
> +		/* A power_up request went ahead of us. */
> +		skip_wfi = true;
> +	} else if (hip04_cpu_table[cluster][cpu] > 1) {
> +		pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
> +		BUG();
> +	}
> +
> +	last_man = hip04_cluster_is_down(cluster);
> +	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
> +		spin_unlock(&boot_lock);
> +		v7_exit_coherency_flush(all);
> +		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
> +	} else {
> +		spin_unlock(&boot_lock);
> +		v7_exit_coherency_flush(louis);
> +	}
> +
> +	__mcpm_cpu_down(cpu, cluster);
> +
> +	if (!skip_wfi)
> +		wfi();
> +}
> +
> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned int data, tries, count;
> +
> +	BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
> +	       cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
> +
> +	count = TIMEOUT_MSEC / POLL_MSEC;

This count value doesn't make much sense anymore, does it?  Nothing 
relates to POLL_MSEC afterwards.

> +	spin_lock_irq(&boot_lock);
> +	/*
> +	 * Target core should enter WFI first.
> +	 * Then cluster could be disabled in snoop filter.
> +	 * At last, target core could be reset.
> +	 */

You should verify that the CPU usage count is still 0 here as I 
suggested.

> +	for (tries = 0; tries < count; tries++) {
> +		cpu_relax();

There is probably no point calling cpu_relax() if it is followed by 
udelay().

> +		udelay(50);
> +		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
> +		if (!hip04_cpu_table[cluster][cpu] || \
> +		    (data & CORE_WFI_STATUS(cpu))) {
> +			break;
> +		}
> +	}
> +	if (tries >= count)
> +		goto err;
> +	if (hip04_cluster_is_down(cluster))
> +		hip04_set_snoop_filter(cluster, 0);
> +	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +	       CORE_DEBUG_RESET_BIT(cpu);
> +	writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));
> +	for (tries = 0; tries < count; tries++) {
> +		cpu_relax();
> +		udelay(50);
> +		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
> +		if (!hip04_cpu_table[cluster][cpu] || \
> +		    (data & CORE_RESET_STATUS(cpu))) {
> +			break;
> +		}
> +	}
> +	if (tries >= count)
> +		goto err;
> +	spin_unlock_irq(&boot_lock);
> +	return 0;
> +err:
> +	spin_unlock_irq(&boot_lock);
> +	return -EBUSY;
> +}

I don't really like the way things are done in general.  And we're 
apparently going in circle over this. This is almost like if MCPM was of 
no benefit to you given all the things which look "wrong".  But given 
that no usable documentation is available, preventing me and others from 
suggesting better ways, then this platform is going to be limited to 
suboptimal CPU hotplug support.  So if you fix the minor issues I've 
noted above then I'll provide my reluctant ACK for this patch if nothing 
else can be helped.


Nicolas
