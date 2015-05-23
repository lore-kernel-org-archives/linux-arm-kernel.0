From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Fri, 22 May 2015 23:28:52 -0500
Subject: [PATCH 2/3] ARM: socfpga: add CPU_METHOD_OF_DECLARE for Arria 10
In-Reply-To: <1432355333-15515-1-git-send-email-dinguyen@opensource.altera.com>
References: <1432355333-15515-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1432355333-15515-3-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add boot_secondary implementation for the Arria10 platform. Bringing up
the secondary core on the Arria 10 platform is pretty similar to the
Cyclone/Arria 5 platform, with the exception of the following differences:

- Register offset to bringup CPU1 out of reset is different.
- The cpu1-start-addr for Arria10 contains an additional nibble.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/core.h    |  2 ++
 arch/arm/mach-socfpga/platsmp.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 5913bbb..7637b7f 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -25,6 +25,8 @@
 #define SOCFPGA_RSTMGR_MODPERRST	0x14
 #define SOCFPGA_RSTMGR_BRGMODRST	0x1c
 
+#define SOCFPGA_A10_RSTMGR_MODMPURST	0x20
+
 /* System Manager bits */
 #define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
 #define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 08250c8..bcc7ce8 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -54,6 +54,27 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+
+	if (socfpga_cpu1start_addr) {
+		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+
+		writel(virt_to_phys(socfpga_secondary_startup),
+		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
+
+		flush_cache_all();
+		smp_wmb();
+		outer_clean_range(0, trampoline_size);
+
+		/* This will release CPU #1 out of reset. */
+		writel(0, rst_manager_base_addr + SOCFPGA_A10_RSTMGR_MODMPURST);
+	}
+
+	return 0;
+}
+
 static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
@@ -91,4 +112,13 @@ struct smp_operations socfpga_smp_ops __initdata = {
 #endif
 };
 
+struct smp_operations socfpga_a10_smp_ops __initdata = {
+	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
+	.smp_boot_secondary	= socfpga_a10_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= socfpga_cpu_die,
+#endif
+};
+
 CPU_METHOD_OF_DECLARE(socfpga_smp, "altr,socfpga-smp", &socfpga_smp_ops);
+CPU_METHOD_OF_DECLARE(socfpga_a10_smp, "altr,socfpga-a10-smp", &socfpga_a10_smp_ops);
-- 
2.2.1
