From: pavel@denx.de (Pavel Machek)
Date: Wed, 20 Mar 2013 16:29:15 +0100
Subject: [PATCHv2 1/2] ARM: socfpga: Enable soft reset
In-Reply-To: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130320152915.GA32083@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Enable a cold or warm reset to the HW from userspace.
> 
> Also fix a few sparse errors:
> 
> warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
> warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Tested-by: Pavel Machek <pavel@denx.de>

Would it make sense to apply something like this? Struct looks cleaner
than offset defines... 

Thanks,
									Pavel

    Switch reset manager to using struct (not defines), cleanups.
    
    Convert SMP code to use the struct instead of open-coded numbers.

    Also none of the code is time-critical, so it
    does not make sense to use __raw_writel variants.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index d2a251f..f4b6048 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -20,19 +20,21 @@
 #ifndef __MACH_CORE_H
 #define __MACH_CORE_H
 
-#define SOCFPGA_RSTMGR_CTRL	0x04
-#define SOCFPGA_RSTMGR_MODPERRST	0x14
-#define SOCFPGA_RSTMGR_BRGMODRST	0x1c
-
-/* System Manager bits */
-#define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
-#define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
-/*MPU Module Reset Register */
-#define RSTMGR_MPUMODRST_CPU0	0x1	/*CPU0 Reset*/
-#define RSTMGR_MPUMODRST_CPU1	0x2	/*CPU1 Reset*/
-#define RSTMGR_MPUMODRST_WDS		0x4	/*Watchdog Reset*/
-#define RSTMGR_MPUMODRST_SCUPER	0x8	/*SCU and periphs reset*/
-#define RSTMGR_MPUMODRST_L2		0x10	/*L2 Cache reset*/
+struct socfpga_rstmgr_hw {
+	u32 unk;
+	u32 ctrl;		/* 0x04 */
+	u32 unk2, unk3;
+/* MPU Module Reset Register */
+#define RSTMGR_MPUMODRST_CPU0	0x1	/* CPU0 Reset */
+#define RSTMGR_MPUMODRST_CPU1	0x2	/* CPU1 Reset */
+#define RSTMGR_MPUMODRST_WDS	0x4	/* Watchdog Reset */
+#define RSTMGR_MPUMODRST_SCUPER	0x8	/* SCU and periphs reset */
+#define RSTMGR_MPUMODRST_L2	0x10	/* L2 Cache reset */
+	u32 mpumodrst; 		/* 0x10 */
+	u32 modperrst;		/* 0x14 */
+	u32 unk5;
+	u32 bgrmodrst;		/* 0x1c */
+};
 
 extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
@@ -41,7 +43,7 @@ extern void socfpga_init_clocks(void);
 extern void socfpga_sysmgr_init(void);
 
 extern void __iomem *sys_manager_base_addr;
-extern void __iomem *rst_manager_base_addr;
+extern struct socfpga_rstmgr_hw __iomem *rst_manager_base_addr;
 
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index b41a945..81b8f1e 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -28,7 +28,7 @@
 
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
-void __iomem *rst_manager_base_addr;
+struct socfpga_rstmgr_hw __iomem *rst_manager_base_addr;
 unsigned long cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -89,13 +89,13 @@ static void socfpga_cyclone5_restart(char mode, const char *cmd)
 {
 	u32 temp;
 
-	temp = __raw_readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
+	temp = readl(&rst_manager_base_addr->ctrl);
 
 	if (mode == 'h')
-		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
+		temp |= 1; /* RSTMGR_CTRL_SWCOLDRSTREQ, cold reset */
 	else
-		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
-	__raw_writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
+		temp |= 2; /* RSTMGR_CTRL_SWWARMRSTREQ, warm reset */
+	writel(temp, &rst_manager_base_addr->ctrl);
 }
 
 static void __init socfpga_cyclone5_init(void)


diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index c75c33d..822a93e 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -47,7 +47,7 @@ static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct
 	if (cpu1start_addr) {
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-		__raw_writel(virt_to_phys(socfpga_secondary_startup),
+		writel(virt_to_phys(socfpga_secondary_startup),
 			(sys_manager_base_addr + (cpu1start_addr & 0x000000ff)));
 
 		flush_cache_all();
@@ -55,7 +55,7 @@ static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct
 		outer_clean_range(0, trampoline_size);
 
 		/* This will release CPU #1 out of reset.*/
-		__raw_writel(0, rst_manager_base_addr + 0x10);
+		writel(0, &rst_manager_base_addr->mpumodrst);
 	}
 
 	return 0;
@@ -101,7 +101,7 @@ static void socfpga_cpu_die(unsigned int cpu)
 	flush_cache_all();
 
 	/* This will put CPU1 into reset.*/
-	__raw_writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr + 0x10);
+	writel(RSTMGR_MPUMODRST_CPU1, &rst_manager_base_addr->mpumodrst);
 
 	cpu_do_idle();
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
