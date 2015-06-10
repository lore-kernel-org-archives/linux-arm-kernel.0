From: hiraku.toyooka.gu@hitachi.com (Hiraku Toyooka)
Date: Wed, 10 Jun 2015 16:47:19 +0900
Subject: [PATCH v2] ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump
 available
Message-ID: <20150610074719.22583.63623.stgit@arietta>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kexec_load syscall in ARM requires that machine-specific code
has the smp_ops.cpu_kill() before loading kernel image.
This patch adds the cpu_kill(), as a result, kexec reboot and
kernel crash dump become available in mach-socfpga.

Signed-off-by: Hiraku Toyooka <hiraku.toyooka.gu@hitachi.com>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-socfpga/platsmp.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index c64d89b..3caf7c3 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -95,11 +95,23 @@ static void socfpga_cpu_die(unsigned int cpu)
 		cpu_do_idle();
 }
 
+/*
+ * We need a dummy function so that platform_can_cpu_hotplug() knows
+ * we support CPU hotplug. However, the function does not need to do
+ * anything, because CPUs going offline just do WFI. We could reset
+ * the CPUs but it would increase power consumption.
+ */
+static int socfpga_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
 struct smp_operations socfpga_smp_ops __initdata = {
 	.smp_init_cpus		= socfpga_smp_init_cpus,
 	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
 	.smp_boot_secondary	= socfpga_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= socfpga_cpu_die,
+	.cpu_kill		= socfpga_cpu_kill,
 #endif
 };
