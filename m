From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Tue,  2 Jun 2015 21:14:01 -0500
Subject: [PATCH 1/2] ARM: socfpga: use CPU_METHOD_OF_DECLARE for
 socfpga_cyclone5
In-Reply-To: <1433297642-3818-1-git-send-email-dinh.linux@gmail.com>
References: <1433297642-3818-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <1433297642-3818-2-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Convert cyclone5/arria5 to use CPU_METHOD_OF_DECLARE for smp operations.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/core.h    | 1 -
 arch/arm/mach-socfpga/platsmp.c | 4 +++-
 arch/arm/mach-socfpga/socfpga.c | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 5913bbb..38e5cbf 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -39,7 +39,6 @@ extern void socfpga_sysmgr_init(void);
 extern void __iomem *sys_manager_base_addr;
 extern void __iomem *rst_manager_base_addr;
 
-extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
 
 extern unsigned long socfpga_cpu1start_addr;
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 7886eae..b84c1a1 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -83,10 +83,12 @@ static void socfpga_cpu_die(unsigned int cpu)
 		cpu_do_idle();
 }
 
-struct smp_operations socfpga_smp_ops __initdata = {
+static struct smp_operations socfpga_smp_ops __initdata = {
 	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
 	.smp_boot_secondary	= socfpga_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= socfpga_cpu_die,
 #endif
 };
+
+CPU_METHOD_OF_DECLARE(socfpga_smp, "altr,socfpga-smp", &socfpga_smp_ops);
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index b63dec6..a154920 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -78,7 +78,6 @@ static const char *altera_dt_match[] = {
 DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.smp		= smp_ops(socfpga_smp_ops),
 	.init_irq	= socfpga_init_irq,
 	.restart	= socfpga_cyclone5_restart,
 	.dt_compat	= altera_dt_match,
-- 
1.9.1.315.g3f09db0
