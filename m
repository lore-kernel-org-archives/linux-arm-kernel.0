From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 19:39:08 +0100
Subject: [PATCH] ARM: make it easier to check the CPU part number correctly
Message-ID: <20140624183908.GB32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that platform maintainers check the CPU part number in the right
manner: the CPU part number is meaningless without also checking the
CPU implement(e|o)r (choose your preferred spelling!)  Provide an
interface which returns both the implementer and part number together,
and update the definitions to include the implementer.

Mark the old function as being deprecated... indeed, using the old
function with the definitions will now always evaluate as false, so
people must update their un-merged code to the new function.  While
this could be avoided by adding new definitions, we'd also have to
create new names for them which would be awkward.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/cputype.h         | 37 +++++++++++++++--------
 arch/arm/include/asm/smp_scu.h         |  2 +-
 arch/arm/kernel/perf_event_cpu.c       | 55 +++++++++++++++++-----------------
 arch/arm/kvm/guest.c                   |  8 +----
 arch/arm/mach-exynos/mcpm-exynos.c     |  2 +-
 arch/arm/mach-exynos/platsmp.c         |  4 +--
 arch/arm/mach-vexpress/tc2_pm.c        |  2 +-
 arch/arm/mm/cache-l2x0.c               |  2 +-
 arch/arm64/include/asm/cputype.h       |  5 ++++
 drivers/clocksource/arm_global_timer.c |  2 +-
 10 files changed, 64 insertions(+), 55 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 8c2b7321a478..963a2515906d 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -62,17 +62,18 @@
 #define ARM_CPU_IMP_ARM			0x41
 #define ARM_CPU_IMP_INTEL		0x69
 
-#define ARM_CPU_PART_ARM1136		0xB360
-#define ARM_CPU_PART_ARM1156		0xB560
-#define ARM_CPU_PART_ARM1176		0xB760
-#define ARM_CPU_PART_ARM11MPCORE	0xB020
-#define ARM_CPU_PART_CORTEX_A8		0xC080
-#define ARM_CPU_PART_CORTEX_A9		0xC090
-#define ARM_CPU_PART_CORTEX_A5		0xC050
-#define ARM_CPU_PART_CORTEX_A15		0xC0F0
-#define ARM_CPU_PART_CORTEX_A7		0xC070
-#define ARM_CPU_PART_CORTEX_A12		0xC0D0
-#define ARM_CPU_PART_CORTEX_A17		0xC0E0
+/* ARM implemented processors */
+#define ARM_CPU_PART_ARM1136		0x4100b360
+#define ARM_CPU_PART_ARM1156		0x4100b560
+#define ARM_CPU_PART_ARM1176		0x4100b760
+#define ARM_CPU_PART_ARM11MPCORE	0x4100b020
+#define ARM_CPU_PART_CORTEX_A8		0x4100c080
+#define ARM_CPU_PART_CORTEX_A9		0x4100c090
+#define ARM_CPU_PART_CORTEX_A5		0x4100c050
+#define ARM_CPU_PART_CORTEX_A7		0x4100c070
+#define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
+#define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
+#define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 
 #define ARM_CPU_XSCALE_ARCH_MASK	0xe000
 #define ARM_CPU_XSCALE_ARCH_V1		0x2000
@@ -171,14 +172,24 @@ static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
 	return (read_cpuid_id() & 0xFF000000) >> 24;
 }
 
-static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
+/*
+ * The CPU part number is meaningless without referring to the CPU
+ * implementer: implementers are free to define their own part numbers
+ * which are permitted to clash with other implementer part numbers.
+ */
+static inline unsigned int __attribute_const__ read_cpuid_part(void)
+{
+	return read_cpuid_id() & 0xff00fff0;
+}
+
+static inline unsigned int __attribute_const__ __deprecated read_cpuid_part_number(void)
 {
 	return read_cpuid_id() & 0xFFF0;
 }
 
 static inline unsigned int __attribute_const__ xscale_cpu_arch_version(void)
 {
-	return read_cpuid_part_number() & ARM_CPU_XSCALE_ARCH_MASK;
+	return read_cpuid_id() & ARM_CPU_XSCALE_ARCH_MASK;
 }
 
 static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 0393fbab8dd5..bfe163c40024 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -11,7 +11,7 @@
 
 static inline bool scu_a9_has_base(void)
 {
-	return read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9;
+	return read_cpuid_part() == ARM_CPU_PART_CORTEX_A9;
 }
 
 static inline unsigned long scu_a9_get_base(void)
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index af9e35e8836f..c02c2e8c877d 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -250,40 +250,38 @@ static struct platform_device_id cpu_pmu_plat_device_ids[] = {
 static int probe_current_pmu(struct arm_pmu *pmu)
 {
 	int cpu = get_cpu();
-	unsigned long implementor = read_cpuid_implementor();
-	unsigned long part_number = read_cpuid_part_number();
 	int ret = -ENODEV;
 
 	pr_info("probing PMU on CPU %d\n", cpu);
 
+	switch (read_cpuid_part()) {
 	/* ARM Ltd CPUs. */
-	if (implementor == ARM_CPU_IMP_ARM) {
-		switch (part_number) {
-		case ARM_CPU_PART_ARM1136:
-		case ARM_CPU_PART_ARM1156:
-		case ARM_CPU_PART_ARM1176:
-			ret = armv6pmu_init(pmu);
-			break;
-		case ARM_CPU_PART_ARM11MPCORE:
-			ret = armv6mpcore_pmu_init(pmu);
-			break;
-		case ARM_CPU_PART_CORTEX_A8:
-			ret = armv7_a8_pmu_init(pmu);
-			break;
-		case ARM_CPU_PART_CORTEX_A9:
-			ret = armv7_a9_pmu_init(pmu);
-			break;
-		}
-	/* Intel CPUs [xscale]. */
-	} else if (implementor == ARM_CPU_IMP_INTEL) {
-		switch (xscale_cpu_arch_version()) {
-		case ARM_CPU_XSCALE_ARCH_V1:
-			ret = xscale1pmu_init(pmu);
-			break;
-		case ARM_CPU_XSCALE_ARCH_V2:
-			ret = xscale2pmu_init(pmu);
-			break;
+	case ARM_CPU_PART_ARM1136:
+	case ARM_CPU_PART_ARM1156:
+	case ARM_CPU_PART_ARM1176:
+		ret = armv6pmu_init(pmu);
+		break;
+	case ARM_CPU_PART_ARM11MPCORE:
+		ret = armv6mpcore_pmu_init(pmu);
+		break;
+	case ARM_CPU_PART_CORTEX_A8:
+		ret = armv7_a8_pmu_init(pmu);
+		break;
+	case ARM_CPU_PART_CORTEX_A9:
+		ret = armv7_a9_pmu_init(pmu);
+		break;
+	default:
+		if (read_cpuid_implementor() == ARM_CPU_IMP_INTEL) {
+			switch (xscale_cpu_arch_version()) {
+			case ARM_CPU_XSCALE_ARCH_V1:
+				ret = xscale1pmu_init(pmu);
+				break;
+			case ARM_CPU_XSCALE_ARCH_V2:
+				ret = xscale2pmu_init(pmu);
+				break;
+			}
 		}
+		break;
 	}
 
 	put_cpu();
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index b23a59c1c522..70bf49b8b244 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -274,13 +274,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 int __attribute_const__ kvm_target_cpu(void)
 {
-	unsigned long implementor = read_cpuid_implementor();
-	unsigned long part_number = read_cpuid_part_number();
-
-	if (implementor != ARM_CPU_IMP_ARM)
-		return -EINVAL;
-
-	switch (part_number) {
+	switch (read_cpuid_part()) {
 	case ARM_CPU_PART_CORTEX_A7:
 		return KVM_ARM_TARGET_CORTEX_A7;
 	case ARM_CPU_PART_CORTEX_A15:
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index 0498d0b887ef..5cb0c9d60825 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -197,7 +197,7 @@ static void exynos_power_down(void)
 	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
 		arch_spin_unlock(&exynos_mcpm_lock);
 
-		if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
+		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
 			/*
 			 * On the Cortex-A15 we need to disable
 			 * L2 prefetching before flushing the cache.
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 1c8d31e39520..8dc1d3a3a8bf 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -188,7 +188,7 @@ static void __init exynos_smp_init_cpus(void)
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
 		ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 	else
 		/*
@@ -214,7 +214,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 
 	exynos_sysram_init();
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(scu_base_addr());
 
 	/*
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index b743a0ae02ce..154669ccaca6 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -152,7 +152,7 @@ static void tc2_pm_down(u64 residency)
 	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
 		arch_spin_unlock(&tc2_pm_lock);
 
-		if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
+		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A15) {
 			/*
 			 * On the Cortex-A15 we need to disable
 			 * L2 prefetching before flushing the cache.
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c012a673b4ef..948f12cf6180 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -733,7 +733,7 @@ static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, v
 static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
 	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
-	bool cortex_a9 = read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9;
+	bool cortex_a9 = read_cpuid_part() == ARM_CPU_PART_CORTEX_A9;
 
 	if (rev >= L310_CACHE_ID_RTL_R2P0) {
 		if (cortex_a9) {
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 60e5a170c4d2..e6833771a716 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -250,7 +250,7 @@ static void __init global_timer_of_register(struct device_node *np)
 	 * fire when the timer value is greater than or equal to. In previous
 	 * revisions the comparators fired when the timer value was equal to.
 	 */
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9
 	    && (read_cpuid_id() & 0xf0000f) < 0x200000) {
 		pr_warn("global-timer: non support for this cpu version.\n");
 		return;

-- 
FTTC broadband for 0.8mile line: now@9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
