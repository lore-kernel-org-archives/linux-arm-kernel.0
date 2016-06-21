From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 21 Jun 2016 12:12:36 +0100
Subject: [PATCH v6] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
Message-ID: <1466507556-9027-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@linaro.org>

It can be useful for JIT software to be aware of MIDR_EL1 and
REVIDR_EL1 to ascertain the presence of any core errata that could
affect code generation.

This patch exposes these registers through sysfs:

/sys/devices/system/cpu/cpu$ID/identification/midr
/sys/devices/system/cpu/cpu$ID/identification/revidr

where $ID is the cpu number. For big.LITTLE systems, one can have a
mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
to be enumerated.

If the kernel does not have valid information to populate these entries
with, an empty string is returned to userspace.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steve Capper <steve.capper@linaro.org>
[ ABI documentation updates, hotplug notifiers ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V5:
  - Add hotplug notifier to {add/remove} the attributes when the CPU is brought
    {online/offline}.
  - Replace cpu_hotplug_{disable,enable} => cpu_notifier_register_{begin/done}
  - Remove redundant check for cpu present, as the sysfs infrastructure does
    check already returning -ENODEV, if the CPU goes offline between open() and
    read().
Changes since V4:
  - Update comment as suggested by Mark Rutland
Changes since V3:
  - Disable cpu hotplug while we initialise
  - Added a comment to explain why expose 64bit value
  - Update Document/ABI/testing/sysfs-devices-system-cpu
Changes since V2:
  - Fix errno for failures (Spotted-by: Russell King)
  - Roll back, if we encounter a missing cpu device
  - Return error for access to registers of CPUs not present.
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  13 +++
 arch/arm64/include/asm/cpu.h                       |   1 +
 arch/arm64/kernel/cpuinfo.c                        | 106 +++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1650133..8c4607d 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -340,3 +340,16 @@ Description:	POWERNV CPUFreq driver's frequency throttle stats directory and
 		'policyX/throttle_stats' directory and all the attributes are same as
 		the /sys/devices/system/cpu/cpuX/cpufreq/throttle_stats directory and
 		attributes which give the frequency throttle information of the chip.
+
+What:		/sys/devices/system/cpu/cpuX/identification/
+		/sys/devices/system/cpu/cpuX/identification/midr
+		/sys/devices/system/cpu/cpuX/identification/revidr
+Date:		June 2016
+Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
+		Linux Kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	ARM64 CPU identification registers
+		'identification' directory exposes the CPU ID registers for
+		 identifying model and revision of the CPU.
+		- midr : This file gives contents of Main ID Register (MIDR_EL1).
+		- revidr : This file gives contents of the Revision ID register
+		 (REVIDR_EL1).
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 13a6103..116a382 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -29,6 +29,7 @@ struct cpuinfo_arm64 {
 	u32		reg_cntfrq;
 	u32		reg_dczid;
 	u32		reg_midr;
+	u32		reg_revidr;
 
 	u64		reg_id_aa64dfr0;
 	u64		reg_id_aa64dfr1;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index c173d32..44ec263 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -212,6 +212,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_ctr = read_cpuid_cachetype();
 	info->reg_dczid = read_cpuid(DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
+	info->reg_revidr = read_cpuid(REVIDR_EL1);
 
 	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
 	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
@@ -264,3 +265,108 @@ void __init cpuinfo_store_boot_cpu(void)
 	boot_cpu_data = *info;
 	init_cpu_features(&boot_cpu_data);
 }
+
+/*
+ * The ARM ARM uses the phrase "32-bit register" to describe a register
+ * whose upper 32 bits are RES0 (per C5.1.1, ARM DDI 0487A.i), however
+ * no statement is made as to whether the upper 32 bits will or will not
+ * be made use of in future, and between ARM DDI 0487A.c and ARM DDI
+ * 0487A.d CLIDR_EL1 was expanded from 32-bit to 64-bit.
+ *
+ * Thus, while both MIDR_EL1 and REVIDR_EL1 are described as 32-bit
+ * registers, we expose them both as 64 bit values to cater for possible
+ * future expansion without an ABI break.
+ */
+#define CPUINFO_ATTR_RO(_name)							\
+	static ssize_t show_##_name(struct device *dev,				\
+			struct device_attribute *attr, char *buf)		\
+	{									\
+		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, dev->id);	\
+										\
+		if (info->reg_midr)						\
+			return sprintf(buf, "0x%016x\n", info->reg_##_name);	\
+		else								\
+			return 0;						\
+	}									\
+	static DEVICE_ATTR(_name, 0444, show_##_name, NULL)
+
+CPUINFO_ATTR_RO(midr);
+CPUINFO_ATTR_RO(revidr);
+
+static struct attribute *cpuregs_attrs[] = {
+	&dev_attr_midr.attr,
+	&dev_attr_revidr.attr,
+	NULL
+};
+
+static struct attribute_group cpuregs_attr_group = {
+	.attrs = cpuregs_attrs,
+	.name = "identification"
+};
+
+static int cpuid_callback(struct notifier_block *nb,
+			 unsigned long action, void *hcpu)
+{
+	int rc = 0;
+	unsigned long cpu = (unsigned long)hcpu;
+	struct device *dev = get_cpu_device(cpu);
+
+	if (dev) {
+		switch (action & ~CPU_TASKS_FROZEN) {
+		case CPU_ONLINE:
+			rc = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
+			break;
+		case CPU_DEAD:
+			sysfs_remove_group(&dev->kobj, &cpuregs_attr_group);
+			break;
+		}
+	} else {
+		rc = -ENODEV;
+	}
+
+	return notifier_from_errno(rc);
+}
+
+static int __init cpuinfo_regs_init(void)
+{
+	int cpu, finalcpu, ret;
+	struct device *dev;
+
+	cpu_notifier_register_begin();
+
+	for_each_online_cpu(cpu) {
+		dev = get_cpu_device(cpu);
+
+		if (dev)
+			ret = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
+		else
+			ret = -ENODEV;
+		if (ret)
+			break;
+	}
+
+	if (!ret) {
+		__hotcpu_notifier(cpuid_callback, 0);
+		goto out;
+	}
+
+	/*
+	 * We were unable to put down sysfs groups for all the CPUs, revert
+	 * all the groups we have placed down s.t. none are visible.
+	 * Otherwise we could give a misleading picture of what's present.
+	 */
+	finalcpu = cpu;
+	for_each_online_cpu(cpu) {
+		if (cpu == finalcpu)
+			break;
+		dev = get_cpu_device(cpu);
+		if (dev)
+			sysfs_remove_group(&dev->kobj, &cpuregs_attr_group);
+	}
+
+out:
+	cpu_notifier_register_done();
+	return ret;
+}
+
+device_initcall(cpuinfo_regs_init);
-- 
1.9.1
