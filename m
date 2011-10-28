From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:48 +0100
Subject: [PATCH 20/51] ARM: mach-ixp4xx: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-21-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-ixp4xx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ixp4xx/common.c              |   22 ++++++++++++++++++++++
 arch/arm/mach-ixp4xx/include/mach/system.h |   19 -------------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0777257..9e38334 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -375,6 +375,26 @@ static struct platform_device *ixp46x_devices[] __initdata = {
 unsigned long ixp4xx_exp_bus_size;
 EXPORT_SYMBOL(ixp4xx_exp_bus_size);
 
+static void ixp4xx_arch_reset(char mode, const char *cmd)
+{
+	if ( 1 && mode == 's') {
+		/* Jump into ROM at address 0 */
+		cpu_reset(0);
+	} else {
+		/* Use on-chip reset capability */
+
+		/* set the "key" register to enable access to
+		 * "timer" and "enable" registers
+		 */
+		*IXP4XX_OSWK = IXP4XX_WDT_KEY;
+
+		/* write 0 to the timer register for an immediate reset */
+		*IXP4XX_OSWT = 0;
+
+		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
+	}
+}
+
 void __init ixp4xx_sys_init(void)
 {
 	ixp4xx_exp_bus_size = SZ_16M;
@@ -397,6 +417,8 @@ void __init ixp4xx_sys_init(void)
 
 	printk("IXP4xx: Using %luMiB expansion bus window size\n",
 			ixp4xx_exp_bus_size >> 20);
+
+	arm_arch_reset = ixp4xx_arch_reset;
 }
 
 /*
diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
index 54c0af7..ed5964c 100644
--- a/arch/arm/mach-ixp4xx/include/mach/system.h
+++ b/arch/arm/mach-ixp4xx/include/mach/system.h
@@ -9,8 +9,6 @@
  *
  */
 
-#include <mach/hardware.h>
-
 static inline void arch_idle(void)
 {
 	/* ixp4xx does not implement the XScale PWRMODE register,
@@ -24,21 +22,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if ( 1 && mode == 's') {
-		/* Jump into ROM at address 0 */
-		cpu_reset(0);
-	} else {
-		/* Use on-chip reset capability */
-
-		/* set the "key" register to enable access to
-		 * "timer" and "enable" registers
-		 */
-		*IXP4XX_OSWK = IXP4XX_WDT_KEY;
-
-		/* write 0 to the timer register for an immediate reset */
-		*IXP4XX_OSWT = 0;
-
-		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
-	}
 }
-
-- 
1.7.4.1
