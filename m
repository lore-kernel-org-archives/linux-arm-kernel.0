From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:46:55 +0530
Subject: [PATCH v9 01/12] ARM: EXYNOS: refactor firmware specific routines
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131419epcas5p4ac36250d3a9225643e327e60f47956c2@epcas5p4.samsung.com>
Message-ID: <1490879826-16754-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To remove dependency on soc_is_exynosMMMM macros and remove multiple
checks for such macros, let's refactor code in firmware.c file.
SoC specific firmware_ops are separated and registered during
exynos_firmware_init based on matching machine compatible.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 114 +++++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index e81a78b..b04c47a 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -35,6 +35,25 @@ static void exynos_save_cp15(void)
 	     : : "cc");
 }
 
+static int exynos3250_do_idle(unsigned long mode)
+{
+	switch (mode) {
+	case FW_DO_IDLE_AFTR:
+		writel_relaxed(virt_to_phys(exynos_cpu_resume_ns),
+			       sysram_ns_base_addr + 0x24);
+		writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
+		flush_cache_all();
+		exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
+				SMC_POWERSTATE_IDLE, 0);
+		exynos_smc(SMC_CMD_SHUTDOWN, OP_TYPE_CLUSTER,
+				SMC_POWERSTATE_IDLE, 0);
+		break;
+	case FW_DO_IDLE_SLEEP:
+		exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+	}
+	return 0;
+}
+
 static int exynos_do_idle(unsigned long mode)
 {
 	switch (mode) {
@@ -44,14 +63,7 @@ static int exynos_do_idle(unsigned long mode)
 		writel_relaxed(__pa_symbol(exynos_cpu_resume_ns),
 			       sysram_ns_base_addr + 0x24);
 		writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
-		if (soc_is_exynos3250()) {
-			flush_cache_all();
-			exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
-				   SMC_POWERSTATE_IDLE, 0);
-			exynos_smc(SMC_CMD_SHUTDOWN, OP_TYPE_CLUSTER,
-				   SMC_POWERSTATE_IDLE, 0);
-		} else
-			exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
+		exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
 		break;
 	case FW_DO_IDLE_SLEEP:
 		exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
@@ -59,28 +71,25 @@ static int exynos_do_idle(unsigned long mode)
 	return 0;
 }
 
-static int exynos_cpu_boot(int cpu)
+static int exynos4212_cpu_boot(int cpu)
 {
 	/*
-	 * Exynos3250 doesn't need to send smc command for secondary CPU boot
-	 * because Exynos3250 removes WFE in secure mode.
-	 */
-	if (soc_is_exynos3250())
-		return 0;
-
-	/*
 	 * The second parameter of SMC_CMD_CPU1BOOT command means CPU id.
 	 * But, Exynos4212 has only one secondary CPU so second parameter
 	 * isn't used for informing secure firmware about CPU id.
 	 */
-	if (soc_is_exynos4212())
-		cpu = 0;
+	cpu = 0;
+	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
+	return 0;
+}
 
+static int exynos_cpu_boot(int cpu)
+{
 	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
 	return 0;
 }
 
-static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
+static int exynos4412_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 {
 	void __iomem *boot_reg;
 
@@ -94,14 +103,24 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	 * additional offset for every CPU, with Exynos4412 being the only
 	 * exception.
 	 */
-	if (soc_is_exynos4412())
-		boot_reg += 4 * cpu;
+	boot_reg += 4 * cpu;
+	writel_relaxed(boot_addr, boot_reg);
+	return 0;
+}
+
+static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
+{
+	void __iomem *boot_reg;
+
+	if (!sysram_ns_base_addr)
+		return -ENODEV;
 
+	boot_reg = sysram_ns_base_addr + 0x1c;
 	writel_relaxed(boot_addr, boot_reg);
 	return 0;
 }
 
-static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
+static int exynos4412_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
 {
 	void __iomem *boot_reg;
 
@@ -109,10 +128,19 @@ static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
 		return -ENODEV;
 
 	boot_reg = sysram_ns_base_addr + 0x1c;
+	boot_reg += 4 * cpu;
+	*boot_addr = readl_relaxed(boot_reg);
+	return 0;
+}
+
+static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
+{
+	void __iomem *boot_reg;
 
-	if (soc_is_exynos4412())
-		boot_reg += 4 * cpu;
+	if (!sysram_ns_base_addr)
+		return -ENODEV;
 
+	boot_reg = sysram_ns_base_addr + 0x1c;
 	*boot_addr = readl_relaxed(boot_reg);
 	return 0;
 }
@@ -148,6 +176,32 @@ static int exynos_resume(void)
 	return 0;
 }
 
+static const struct firmware_ops exynos3250_firmware_ops = {
+	.do_idle		= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos3250_do_idle : NULL,
+	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
+	.get_cpu_boot_addr	= exynos_get_cpu_boot_addr,
+	.suspend		= IS_ENABLED(CONFIG_PM_SLEEP) ? exynos_suspend : NULL,
+	.resume			= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_resume : NULL,
+};
+
+static const struct firmware_ops exynos4212_firmware_ops = {
+	.do_idle		= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_do_idle : NULL,
+	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
+	.get_cpu_boot_addr	= exynos_get_cpu_boot_addr,
+	.cpu_boot		= exynos4212_cpu_boot,
+	.suspend		= IS_ENABLED(CONFIG_PM_SLEEP) ? exynos_suspend : NULL,
+	.resume			= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_resume : NULL,
+};
+
+static const struct firmware_ops exynos4412_firmware_ops = {
+	.do_idle		= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_do_idle : NULL,
+	.set_cpu_boot_addr	= exynos4412_set_cpu_boot_addr,
+	.get_cpu_boot_addr	= exynos4412_get_cpu_boot_addr,
+	.cpu_boot		= exynos_cpu_boot,
+	.suspend		= IS_ENABLED(CONFIG_PM_SLEEP) ? exynos_suspend : NULL,
+	.resume			= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_resume : NULL,
+};
+
 static const struct firmware_ops exynos_firmware_ops = {
 	.do_idle		= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_do_idle : NULL,
 	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
@@ -198,6 +252,7 @@ void __init exynos_firmware_init(void)
 {
 	struct device_node *nd;
 	const __be32 *addr;
+	const struct firmware_ops *ops;
 
 	nd = of_find_compatible_node(NULL, NULL,
 					"samsung,secure-firmware");
@@ -212,7 +267,16 @@ void __init exynos_firmware_init(void)
 
 	pr_info("Running under secure firmware.\n");
 
-	register_firmware_ops(&exynos_firmware_ops);
+	if (of_machine_is_compatible("samsung,exynos3250"))
+		ops = &exynos3250_firmware_ops;
+	else if (of_machine_is_compatible("samsung,exynos4212"))
+		ops = &exynos4212_firmware_ops;
+	else if (of_machine_is_compatible("samsung,exynos4412"))
+		ops = &exynos4412_firmware_ops;
+	else
+		ops = &exynos_firmware_ops;
+
+	register_firmware_ops(ops);
 
 	/*
 	 * Exynos 4 SoCs (based on Cortex A9 and equipped with L2C-310),
-- 
2.7.4
