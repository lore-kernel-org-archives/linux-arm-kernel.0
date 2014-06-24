From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Jun 2014 15:57:11 +0200
Subject: [PATCH 2/6] ARM: EXYNOS: Fix core ID used by platsmp and hotplug code
In-Reply-To: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
Message-ID: <1403618235-19353-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CPU topology is specified in device tree, cpu_logical_map() does
not return core ID anymore, but rather full MPIDR value. This breaks
existing calculation of PMU register offsets on Exynos SoCs.

This patch fixes the problem by adjusting the code to use only core ID
bits of the value returned by cpu_logical_map() to allow CPU topology to
be specified in device tree on Exynos SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c | 10 ++++++----
 arch/arm/mach-exynos/platsmp.c | 34 +++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 69fa483..5644dac 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -40,11 +40,13 @@ static inline void cpu_leave_lowpower(void)
 
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 {
+	u32 mpidr = cpu_logical_map(cpu);
+	u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+
 	for (;;) {
 
-		/* make cpu1 to be turned off at next WFI command */
-		if (cpu == 1)
-			exynos_cpu_power_down(cpu);
+		/* Turn the CPU off on next WFI instruction. */
+		exynos_cpu_power_down(core_id);
 
 		/*
 		 * here's the WFI
@@ -54,7 +56,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		    :
 		    : "memory", "cc");
 
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (pen_release == core_id) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 1c8d31e..50b9aad 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -90,7 +90,8 @@ static void exynos_secondary_init(unsigned int cpu)
 static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
-	unsigned long phys_cpu = cpu_logical_map(cpu);
+	u32 mpidr = cpu_logical_map(cpu);
+	u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	int ret = -ENOSYS;
 
 	/*
@@ -104,17 +105,18 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the holding pen - release it, then wait for it to flag
 	 * that it has been released by resetting pen_release.
 	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * Note that "pen_release" is the hardware CPU core ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	write_pen_release(phys_cpu);
+	write_pen_release(core_id);
 
-	if (!exynos_cpu_power_state(cpu)) {
-		exynos_cpu_power_up(cpu);
+	if (!exynos_cpu_power_state(core_id)) {
+		exynos_cpu_power_up(core_id);
 		timeout = 10;
 
 		/* wait max 10 ms until cpu1 is on */
-		while (exynos_cpu_power_state(cpu) != S5P_CORE_LOCAL_PWR_EN) {
+		while (exynos_cpu_power_state(core_id)
+		       != S5P_CORE_LOCAL_PWR_EN) {
 			if (timeout-- == 0)
 				break;
 
@@ -145,20 +147,20 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		 * Try to set boot address using firmware first
 		 * and fall back to boot register if it fails.
 		 */
-		ret = call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr);
+		ret = call_firmware_op(set_cpu_boot_addr, core_id, boot_addr);
 		if (ret && ret != -ENOSYS)
 			goto fail;
 		if (ret == -ENOSYS) {
-			void __iomem *boot_reg = cpu_boot_reg(phys_cpu);
+			void __iomem *boot_reg = cpu_boot_reg(core_id);
 
 			if (IS_ERR(boot_reg)) {
 				ret = PTR_ERR(boot_reg);
 				goto fail;
 			}
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			__raw_writel(boot_addr, cpu_boot_reg(core_id));
 		}
 
-		call_firmware_op(cpu_boot, phys_cpu);
+		call_firmware_op(cpu_boot, core_id);
 
 		arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
@@ -227,22 +229,24 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 	 * boot register if it fails.
 	 */
 	for (i = 1; i < max_cpus; ++i) {
-		unsigned long phys_cpu;
 		unsigned long boot_addr;
+		u32 mpidr;
+		u32 core_id;
 		int ret;
 
-		phys_cpu = cpu_logical_map(i);
+		mpidr = cpu_logical_map(i);
+		core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 		boot_addr = virt_to_phys(exynos4_secondary_startup);
 
-		ret = call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr);
+		ret = call_firmware_op(set_cpu_boot_addr, core_id, boot_addr);
 		if (ret && ret != -ENOSYS)
 			break;
 		if (ret == -ENOSYS) {
-			void __iomem *boot_reg = cpu_boot_reg(phys_cpu);
+			void __iomem *boot_reg = cpu_boot_reg(core_id);
 
 			if (IS_ERR(boot_reg))
 				break;
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			__raw_writel(boot_addr, cpu_boot_reg(core_id));
 		}
 	}
 }
-- 
1.9.3
