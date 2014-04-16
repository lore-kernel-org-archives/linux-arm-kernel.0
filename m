From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:50 +0900
Subject: [PATCH 7/8] ARM: shmobile: Check r8a7791 MD21 at SMP boot
In-Reply-To: <cover.1397627619.git.horms+renesas@verge.net.au>
References: <cover.1397627619.git.horms+renesas@verge.net.au>
Message-ID: <277efd30cfc72ec2f44a9bc95d93807b867bd9e9.1397627619.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

On r8a7791 the hardware boot mode bit MD21 indicates if hardware
debug mode is enabled or not. In case hardware debug mode is enabled
print a warning and refrain from booting secondary CPU cores.

Without this patch Koelsch with SW8-4 set to OFF will hang at SMP boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7791.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 2df5bd1..ec97952 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -20,6 +20,7 @@
 #include <asm/smp_plat.h>
 #include <mach/common.h>
 #include <mach/r8a7791.h>
+#include <mach/rcar-gen2.h>
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
@@ -51,9 +52,21 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 	iounmap(p);
 }
 
+static int r8a7791_smp_boot_secondary(unsigned int cpu,
+				      struct task_struct *idle)
+{
+	/* Error out when hardware debug mode is enabled */
+	if (rcar_gen2_read_mode_pins() & BIT(21)) {
+		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
+		return -ENOTSUPP;
+	}
+
+	return shmobile_smp_apmu_boot_secondary(cpu, idle);
+}
+
 struct smp_operations r8a7791_smp_ops __initdata = {
 	.smp_prepare_cpus	= r8a7791_smp_prepare_cpus,
-	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
+	.smp_boot_secondary	= r8a7791_smp_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable		= shmobile_smp_cpu_disable,
 	.cpu_die		= shmobile_smp_apmu_cpu_die,
-- 
1.8.5.2
