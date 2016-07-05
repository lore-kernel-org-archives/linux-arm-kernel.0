From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 Jul 2016 15:56:31 +0100
Subject: [PATCH v8] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <1467624020-29240-1-git-send-email-suzuki.poulose@arm.com>
References: <1467624020-29240-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160705145631.GB28482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 10:20:20AM +0100, Suzuki K Poulose wrote:
> From: Steve Capper <steve.capper@linaro.org>
> 
> It can be useful for JIT software to be aware of MIDR_EL1 and
> REVIDR_EL1 to ascertain the presence of any core errata that could
> affect code generation.
> 
> This patch exposes these registers through sysfs:
> 
> /sys/devices/system/cpu/cpu$ID/regs/identification/midr_el1
> /sys/devices/system/cpu/cpu$ID/regs/identification/revidr_el1
> 
> where $ID is the cpu number. For big.LITTLE systems, one can have a
> mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
> to be enumerated.
> 
> If the kernel does not have valid information to populate these entries
> with, an empty string is returned to userspace.

[...]

> +static int cpuid_add_regs(int cpu)
> +{
> +	int rc;
> +	struct device *dev;
> +	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> +
> +	dev = get_cpu_device(cpu);
> +	if (dev) {
> +		rc = kobject_add(&info->kobj, &dev->kobj, "regs");
> +		if (!rc)
> +			rc = sysfs_create_group(&info->kobj, &cpuregs_attr_group);

If this call fails...

> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	return rc;
> +}
> +
> +static int cpuid_remove_regs(int cpu)
> +{
> +	int rc = 0;
> +	struct device *dev;
> +	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> +
> +	dev = get_cpu_device(cpu);
> +	if (dev) {
> +		sysfs_remove_group(&info->kobj, &cpuregs_attr_group);

... then we still call sysfs_remove_group on the CPU_DEAD path. I think
that just results in a WARN, but it would be good to double-check this
(perhaps by forcing the failure path).

Will
