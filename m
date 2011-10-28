From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:31 +0100
Subject: [PATCH 03/51] ARM: bcmring: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-bcmring to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-bcmring/arch.c                |   27 +++++++++++++++++++++++++--
 arch/arm/mach-bcmring/include/mach/system.h |   20 --------------------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
index a604b9e..4b90876 100644
--- a/arch/arm/mach-bcmring/arch.c
+++ b/arch/arm/mach-bcmring/arch.c
@@ -49,7 +49,7 @@ HW_DECLARE_SPINLOCK(gpio)
 #endif
 
 /* sysctl */
-int bcmring_arch_warm_reboot;	/* do a warm reboot on hard reset */
+static int bcmring_arch_warm_reboot;	/* do a warm reboot on hard reset */
 
 static struct ctl_table_header *bcmring_sysctl_header;
 
@@ -105,6 +105,29 @@ static struct platform_device *devices[] __initdata = {
 	&pmu_device,
 };
 
+static void bcmring_arch_reset(char mode, const char *cmd)
+{
+	printk("arch_reset:%c %x\n", mode, bcmring_arch_warm_reboot);
+
+	if (mode == 'h') {
+		/* Reboot configured in proc entry */
+		if (bcmring_arch_warm_reboot) {
+			printk("warm reset\n");
+			/* Issue Warm reset (do not reset ethernet switch, keep alive) */
+			chipcHw_reset(chipcHw_REG_SOFT_RESET_CHIP_WARM);
+		} else {
+			/* Force reset of everything */
+			printk("force reset\n");
+			chipcHw_reset(chipcHw_REG_SOFT_RESET_CHIP_SOFT);
+		}
+	} else {
+		/* Force reset of everything */
+		printk("force reset\n");
+		chipcHw_reset(chipcHw_REG_SOFT_RESET_CHIP_SOFT);
+	}
+}
+
+
 /****************************************************************************
 *
 *   Called from the customize_machine function in arch/arm/kernel/setup.c
@@ -116,7 +139,7 @@ static struct platform_device *devices[] __initdata = {
 *****************************************************************************/
 static void __init bcmring_init_machine(void)
 {
-
+	arm_arch_reset = bcmring_arch_reset;
 	bcmring_sysctl_header = register_sysctl_table(bcmring_sysctl_reboot);
 
 	/* Enable spread spectrum */
diff --git a/arch/arm/mach-bcmring/include/mach/system.h b/arch/arm/mach-bcmring/include/mach/system.h
index 38b3706..6cd872d 100644
--- a/arch/arm/mach-bcmring/include/mach/system.h
+++ b/arch/arm/mach-bcmring/include/mach/system.h
@@ -22,8 +22,6 @@
 
 #include <mach/csp/chipcHw_inline.h>
 
-extern int bcmring_arch_warm_reboot;
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -31,24 +29,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	printk("arch_reset:%c %x\n", mode, bcmring_arch_warm_reboot);
-
-	if (mode == 'h') {
-		/* Reboot configured in proc entry */
-		if (bcmring_arch_warm_reboot) {
-			printk("warm reset\n");
-			/* Issue Warm reset (do not reset ethernet switch, keep alive) */
-			chipcHw_reset(chipcHw_REG_SOFT_RESET_CHIP_WARM);
-		} else {
-			/* Force reset of everything */
-			printk("force reset\n");
-			chipcHw_reset(chipcHw_REG_SOFT_RESET_CHIP_SOFT);
-		}
-	} else {
-		/* Force reset of everything */
-		printk("force reset\n");
-		chipcHw_reset(chipcHw_REG_SOFT_RESET_CHIP_SOFT);
-	}
 }
 
 #endif
-- 
1.7.4.1
