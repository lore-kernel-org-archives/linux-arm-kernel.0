From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 24 Jan 2013 19:00:33 -0600
Subject: [PATCHv1 for soc 5/5] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
Message-ID: <1359075633-13502-6-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Because the CPU1 start address is different for socfpga-vt and
socfpga-cyclone5, we add code to use the correct CPU1 start addr.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
---
 arch/arm/configs/socfpga_defconfig |    1 +
 arch/arm/mach-socfpga/core.h       |    4 +++-
 arch/arm/mach-socfpga/headsmp.S    |   14 ++++++++++----
 arch/arm/mach-socfpga/platsmp.c    |    3 ++-
 arch/arm/mach-socfpga/socfpga.c    |   16 ++++++++++++++++
 5 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 4e1ce21..480ab64 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -21,6 +21,7 @@ CONFIG_ARM_THUMBEE=y
 # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
 # CONFIG_CACHE_L2X0 is not set
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_VMSPLIT_2G=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 9941caa..5b76dd4 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -20,7 +20,7 @@
 #ifndef __MACH_CORE_H
 #define __MACH_CORE_H
 
-extern void secondary_startup(void);
+extern void v7_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
 extern void socfpga_init_clocks(void);
@@ -29,6 +29,8 @@ extern void socfpga_sysmgr_init(void);
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
 
+extern unsigned long cpu1start_addr;
+
 #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
 
 #endif
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index f09b128..01911e8 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -13,13 +13,19 @@
 	__CPUINIT
 	.arch	armv7-a
 
-#define CPU1_START_ADDR 	        0xffd08010
-
 ENTRY(secondary_trampoline)
-	movw	r0, #:lower16:CPU1_START_ADDR
-	movt  r0, #:upper16:CPU1_START_ADDR
+	movw	r2, #:lower16:cpu1start_addr
+	movt  r2, #:upper16:cpu1start_addr
 
+	ldr	r0, [r2]
 	ldr	r1, [r0]
 	bx	r1
 
 ENTRY(secondary_trampoline_end)
+
+#ifdef CONFIG_SMP
+ENTRY(v7_secondary_startup)
+       bl      v7_invalidate_l1
+       b       secondary_startup
+ENDPROC(v7_secondary_startup)
+#endif
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 68dd1b6..c428519 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -49,7 +49,8 @@ static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct
 
 	memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-	__raw_writel(virt_to_phys(secondary_startup), (sys_manager_base_addr+0x10));
+	__raw_writel(virt_to_phys(v7_secondary_startup),
+		(sys_manager_base_addr + (cpu1start_addr & 0x000000ff)));
 
 	flush_cache_all();
 	smp_wmb();
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 198f491..317f4c3 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -29,6 +29,7 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
+unsigned long cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
 	.virtual	= SOCFPGA_SCU_VIRT_BASE,
@@ -55,6 +56,16 @@ static void __init socfpga_scu_map_io(void)
 	iotable_init(&scu_io_desc, 1);
 }
 
+static void __init init_socfpga_vt(void)
+{
+	cpu1start_addr = 0xffd08010;
+}
+
+static void __init init_socfpga(void)
+{
+	cpu1start_addr = 0xffd080c4;
+}
+
 static void __init socfpga_map_io(void)
 {
 	socfpga_scu_map_io();
@@ -82,6 +93,11 @@ static void __init gic_init_irq(void)
 {
 	of_irq_init(irq_match);
 	socfpga_sysmgr_init();
+
+	if (of_machine_is_compatible("altr,socfpga-vt"))
+		init_socfpga_vt();
+	else
+		init_socfpga();
 }
 
 static void socfpga_cyclone5_restart(char mode, const char *cmd)
-- 
1.7.9.5
