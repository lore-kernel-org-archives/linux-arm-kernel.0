From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 7 Jul 2015 15:10:35 +0800
Subject: [PATCH 2/2] arm: berlin: add CPU hotplug support
In-Reply-To: <1436253035-371-1-git-send-email-jszhang@marvell.com>
References: <1436253035-371-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436253035-371-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpu hotplug support for berlin SoCs such as BG2 and BG2Q. These SoC
don't support power off cpu independently, but we also want cpu hotplug
support in these SoCs. We achieve this goal by putting the dying CPU in
WFI state after the coherency is disabled, then asserting the dying CPU
reset bit to put the CPU in reset state.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-berlin/platsmp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index bde327b..c1e0540 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
@@ -93,8 +94,32 @@ unmap_scu:
 	iounmap(scu_base);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void berlin_cpu_die(unsigned int cpu)
+{
+	v7_exit_coherency_flush(louis);
+	while (1)
+		cpu_do_idle();
+}
+
+static int berlin_cpu_kill(unsigned int cpu)
+{
+	u32 val;
+
+	val = readl(cpu_ctrl + CPU_RESET);
+	val &= ~BIT(cpu_logical_map(cpu));
+	writel(val, cpu_ctrl + CPU_RESET);
+
+	return 1;
+}
+#endif
+
 static struct smp_operations berlin_smp_ops __initdata = {
 	.smp_prepare_cpus	= berlin_smp_prepare_cpus,
 	.smp_boot_secondary	= berlin_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= berlin_cpu_die,
+	.cpu_kill		= berlin_cpu_kill,
+#endif
 };
 CPU_METHOD_OF_DECLARE(berlin_smp, "marvell,berlin-smp", &berlin_smp_ops);
-- 
2.1.4
