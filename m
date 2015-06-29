From: vitalya@ti.com (Vitaly Andrianov)
Date: Mon, 29 Jun 2015 13:52:32 -0400
Subject: [PATCH] keystone: adds cpu_die implementation
Message-ID: <1435600352-32733-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit add cpu_die implementation

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---

The discussion of the "keystone: psci: adds cpu_die implementation" commit
shows that if PCSI is enabled platform code doesn't need that implementation
at all. Having PSCI commands in DTB should be sufficient. Unfortunately 
Keystone with LPAE enable requires some additional development.

To support HOTPLUG_CPU w/o PSCI we need platform implementation of
the cpu_die(), which is added by this patch.

 arch/arm/mach-keystone/keystone.h |  1 +
 arch/arm/mach-keystone/platsmp.c  | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
index cd04a1c..93549cf 100644
--- a/arch/arm/mach-keystone/keystone.h
+++ b/arch/arm/mach-keystone/keystone.h
@@ -12,6 +12,7 @@
 #define __KEYSTONE_H__
 
 #define KEYSTONE_MON_CPU_UP_IDX		0x00
+#define KEYSTONE_MON_CPU_DIE_IDX	0x84000002
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 5f46a7c..4e5bdde 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -51,7 +51,31 @@ static inline void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
 {}
 #endif
 
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void keystone_cpu_die(unsigned int cpu)
+{
+	int error;
+
+	pr_debug("keystone-smp: cpu_die %d\n", cpu);
+
+	error = keystone_cpu_smc(KEYSTONE_MON_CPU_DIE_IDX, cpu, 0);
+	if (error)
+		pr_err("CPU %d die failed with %d\n", cpu, error);
+
+	/*
+	 * we shouldn't come here. But in case something went
+	 * wrong the code below prevents kernel from crush
+	 */
+	while (1)
+		cpu_do_idle();
+}
+#endif
+
 struct smp_operations keystone_smp_ops __initdata = {
 	.smp_boot_secondary	= keystone_smp_boot_secondary,
 	.smp_secondary_init     = keystone_smp_secondary_initmem,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= keystone_cpu_die,
+#endif
 };
-- 
1.9.1
