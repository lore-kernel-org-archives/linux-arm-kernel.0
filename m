From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 15:08:42 +0100
Subject: [PATCH] ARM: socfpga: hide unused functions
Message-ID: <1456236527-189885-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu_die and cpu_kill callbacks are only used when CONFIG_HOTPLUG_CPU
is enabled, otherwise we get a warning about them:

arch/arm/mach-socfpga/platsmp.c:102:13: error: 'socfpga_cpu_die' defined but not used [-Werror=unused-function]
arch/arm/mach-socfpga/platsmp.c:115:12: error: 'socfpga_cpu_kill' defined but not used [-Werror=unused-function]

This adds the appropriate #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-socfpga/platsmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index cbb0a54df80a..07945748b571 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -94,6 +94,7 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
 	scu_enable(socfpga_scu_base_addr);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -116,6 +117,7 @@ static int socfpga_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
+#endif
 
 static const struct smp_operations socfpga_smp_ops __initconst = {
 	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
-- 
2.7.0
