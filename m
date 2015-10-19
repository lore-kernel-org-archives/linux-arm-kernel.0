From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:00:47 +0100
Subject: [PATCHv4 24/24] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to
 sysfs
In-Reply-To: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
References: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445259647-21541-25-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@linaro.org>

It can be useful for JIT software to be aware of MIDR_EL1 and
REVIDR_EL1 to ascertain the presence of any core errata that could
affect codegen.

This patch exposes these registers through sysfs:

/sys/devices/system/cpu/cpu$ID/identification/midr
/sys/devices/system/cpu/cpu$ID/identification/revidr

where $ID is the cpu number. For big.LITTLE systems, one can have a
mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
to be enumerated.

If the kernel does not have valid information to populate these entries
with, an empty string is returned to userspace.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
[ Return error for access to !present CPU registers ]
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpu.h |    1 +
 arch/arm64/kernel/cpuinfo.c  |   69 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index b5e9cee..bb1b0cf 100644
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
index 52331ff..349ebf7 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -199,6 +199,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_ctr = read_cpuid_cachetype();
 	info->reg_dczid = read_cpuid(DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
+	info->reg_revidr = read_cpuid(REVIDR_EL1);
 
 	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
 	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
@@ -247,3 +248,71 @@ void __init cpuinfo_store_boot_cpu(void)
 	boot_cpu_data = *info;
 	init_cpu_features(&boot_cpu_data);
 }
+
+#define CPUINFO_ATTR_RO(_name)							\
+	static ssize_t show_##_name (struct device *dev,			\
+			struct device_attribute *attr, char *buf)		\
+	{									\
+		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, dev->id);	\
+		if (!cpu_present(dev->id))					\
+			return -ENODEV;						\
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
+static int __init cpuinfo_regs_init(void)
+{
+	int cpu, finalcpu, ret;
+	struct device *dev;
+
+	for_each_present_cpu(cpu) {
+		dev = get_cpu_device(cpu);
+
+		if (!dev) {
+			ret = -ENODEV;
+			break;
+		}
+
+		ret = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
+		if (ret)
+			break;
+	}
+
+	if (!ret)
+		return 0;
+	/*
+	 * We were unable to put down sysfs groups for all the CPUs, revert
+	 * all the groups we have placed down s.t. none are visible.
+	 * Otherwise we could give a misleading picture of what's present.
+	 */
+	finalcpu = cpu;
+	for_each_present_cpu(cpu) {
+		if (cpu == finalcpu)
+			break;
+		dev = get_cpu_device(cpu);
+		if (dev)
+			sysfs_remove_group(&dev->kobj, &cpuregs_attr_group);
+	}
+
+	return ret;
+}
+
+device_initcall(cpuinfo_regs_init);
-- 
1.7.9.5
