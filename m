From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 24 Jul 2015 16:02:37 +0100
Subject: [RFC PATCH] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
Message-ID: <1437750157-25238-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---

Hello,

This RFC is meant to sit on top of Suzuki's set at:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358990.html

On systems with different core types (for instance big.LITTLE systems),
we need to be *very* careful that the REVIDR and MIDR are both read
from the same core. Thus these registers are exposed in /sys rather
than via MRS emulation.

Cheers,
-- 
Steve

---
 arch/arm64/include/asm/cpu.h |  1 +
 arch/arm64/kernel/cpuinfo.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 17a871d..048b7bf 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -187,6 +187,7 @@ struct cpuinfo_arm64 {
 	u32		reg_cntfrq;
 	u32		reg_dczid;
 	u32		reg_midr;
+	u32		reg_revidr;
 
 	u64		reg_id_aa64dfr0;
 	u64		reg_id_aa64dfr1;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 678e7f6..d50eda1 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -533,6 +533,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_ctr = read_cpuid_cachetype();
 	info->reg_dczid = read_cpuid(DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
+	info->reg_revidr = read_cpuid(REVIDR_EL1);
 
 	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
 	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
@@ -886,3 +887,50 @@ int __init arm64_cpuinfo_init(void)
 }
 
 late_initcall(arm64_cpuinfo_init);
+
+#define CPUINFO_ATTR_RO(_name)							\
+	static ssize_t show_##_name (struct device *dev,			\
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
+static int __init cpuinfo_regs_init(void)
+{
+	int cpu, ret;
+
+	for_each_present_cpu(cpu) {
+		struct device *dev = get_cpu_device(cpu);
+
+		if (!dev)
+			return -1;
+
+		ret = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+device_initcall(cpuinfo_regs_init);
-- 
2.1.0
