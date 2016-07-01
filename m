From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jul 2016 14:01:36 +0100
Subject: [PATCH v7] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <1467308204-23669-1-git-send-email-suzuki.poulose@arm.com>
References: <1467308204-23669-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160701130135.GB14018@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 06:36:44PM +0100, Suzuki K. Poulose wrote:
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
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> [ ABI documentation updates, hotplug notifiers, kobject changes ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V6:
>   - Introduce regs/identification hierarchy(using kobject for the added level)
>   - Use the register names as in ARM ARM (i.e, midr => midr_el1)
> Changes since V5:
>   - Add hotplug notifier to {add/remove} the attributes when the CPU is brought
>     {online/offline}.
>   - Replace cpu_hotplug_{disable,enable} => cpu_notifier_register_{begin/done}
>   - Remove redundant check for cpu present, as the sysfs infrastructure does
>     check already returning -ENODEV, if the CPU goes offline between open() and
>     read().
> Changes since V4:
>   - Update comment as suggested by Mark Rutland
> Changes since V3:
>   - Disable cpu hotplug while we initialise
>   - Added a comment to explain why expose 64bit value
>   - Update Document/ABI/testing/sysfs-devices-system-cpu
> Changes since V2:
>   - Fix errno for failures (Spotted-by: Russell King)
>   - Roll back, if we encounter a missing cpu device
>   - Return error for access to registers of CPUs not present.
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |  14 +++
>  arch/arm64/include/asm/cpu.h                       |   2 +
>  arch/arm64/kernel/cpuinfo.c                        | 137 +++++++++++++++++++++
>  3 files changed, 153 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 1650133..31dee60 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -340,3 +340,17 @@ Description:	POWERNV CPUFreq driver's frequency throttle stats directory and
>  		'policyX/throttle_stats' directory and all the attributes are same as
>  		the /sys/devices/system/cpu/cpuX/cpufreq/throttle_stats directory and
>  		attributes which give the frequency throttle information of the chip.
> +
> +What:		/sys/devices/system/cpu/cpuX/regs/
> +		/sys/devices/system/cpu/cpuX/regs/identification/
> +		/sys/devices/system/cpu/cpuX/regs/identification/midr_el1
> +		/sys/devices/system/cpu/cpuX/regs/identification/revidr_el1
> +Date:		June 2016
> +Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
> +		Linux Kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	ARM64 CPU identification registers

s/ARM64/AArch64/.

> +		'identification' directory exposes the CPU ID registers for
> +		 identifying model and revision of the CPU.
> +		- midr_el1 : This file gives contents of Main ID Register (MIDR_EL1).
> +		- revidr_el1 : This file gives contents of the Revision ID register
> +		 (REVIDR_EL1).
[...]
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -183,6 +183,140 @@ const struct seq_operations cpuinfo_op = {
>  	.show	= c_show
>  };
>  
> +
> +static struct kobj_type cpuregs_kobj_type = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +/*
> + * The ARM ARM uses the phrase "32-bit register" to describe a register
> + * whose upper 32 bits are RES0 (per C5.1.1, ARM DDI 0487A.i), however
> + * no statement is made as to whether the upper 32 bits will or will not
> + * be made use of in future, and between ARM DDI 0487A.c and ARM DDI
> + * 0487A.d CLIDR_EL1 was expanded from 32-bit to 64-bit.
> + *
> + * Thus, while both MIDR_EL1 and REVIDR_EL1 are described as 32-bit
> + * registers, we expose them both as 64 bit values to cater for possible
> + * future expansion without an ABI break.
> + */
> +#define kobj_to_cpuinfo(kobj)	container_of(kobj, struct cpuinfo_arm64, kobj)
> +#define CPUREGS_ATTR_RO(_name, _field)						\
> +	static ssize_t _name##_show(struct kobject *kobj,			\
> +			struct kobj_attribute *attr, char *buf)			\
> +	{									\
> +		struct cpuinfo_arm64 *info = kobj_to_cpuinfo(kobj);		\
> +										\
> +		if (info->reg_midr)						\
> +			return sprintf(buf, "0x%016x\n", info->reg_##_field);	\
> +		else								\
> +			return 0;						\
> +	}									\
> +	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
> +
> +CPUREGS_ATTR_RO(midr_el1, midr);
> +CPUREGS_ATTR_RO(revidr_el1, revidr);
> +
> +static struct attribute *cpuregs_id_attrs[] = {
> +	&cpuregs_attr_midr_el1.attr,
> +	&cpuregs_attr_revidr_el1.attr,
> +	NULL
> +};
> +
> +static struct attribute_group cpuregs_attr_group = {
> +	.attrs = cpuregs_id_attrs,
> +	.name = "identification"
> +};
> +
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
> +		kobject_del(&info->kobj);
> +	} else {
> +		rc = -ENODEV;
> +	}
> +
> +	return rc;
> +}
> +
> +static int cpuid_callback(struct notifier_block *nb,
> +			 unsigned long action, void *hcpu)
> +{
> +	int rc = 0;
> +	unsigned long cpu = (unsigned long)hcpu;
> +
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +	case CPU_ONLINE:
> +		rc = cpuid_add_regs(cpu);
> +		break;
> +	case CPU_DEAD:
> +		rc = cpuid_remove_regs(cpu);
> +		break;
> +	}
> +
> +	return notifier_from_errno(rc);
> +}
> +
> +static int __init cpuinfo_regs_init(void)
> +{
> +	int cpu, finalcpu, ret;
> +
> +	cpu_notifier_register_begin();
> +
> +	for_each_possible_cpu(cpu) {
> +		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> +
> +		kobject_init(&info->kobj, &cpuregs_kobj_type);
> +		if (cpu_online(cpu)) {
> +			ret = cpuid_add_regs(cpu);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +
> +	/*
> +	 * We were unable to put down sysfs groups for all the CPUs, revert
> +	 * all the groups we have placed down s.t. none are visible.
> +	 * Otherwise we could give a misleading picture of what's present.
> +	 */
> +	if (ret) {
> +		finalcpu = cpu;
> +		for_each_online_cpu(cpu) {
> +			if (cpu == finalcpu)
> +				break;
> +			cpuid_remove_regs(cpu);
> +		}
> +	} else {
> +		__hotcpu_notifier(cpuid_callback, 0);
> +	}
> +
> +	cpu_notifier_register_done();
> +	return ret;

What is the failure scenario here and do we expect it to fail in the
middle of a for_each_possible_cpu()? You don't do any such clean-up if
this fails during CPU_ONLINE, so I think we should either ignore this
altogether or have a different clean-up function that handles the
CPU_ONLINE cases. I prefer the former.

-- 
Catalin
