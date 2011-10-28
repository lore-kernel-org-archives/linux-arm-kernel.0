From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:59 +0100
Subject: [PATCH 31/51] ARM: mach-orion5x: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-32-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-orion5x to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-orion5x/common.c              |   17 +++++++++++++++++
 arch/arm/mach-orion5x/include/mach/system.h |    8 --------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 0ab531d..557e4eb 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/serial_8250.h>
 #include <linux/mbus.h>
@@ -268,6 +269,17 @@ static void __init orion5x_id(u32 *dev, u32 *rev, char **dev_name)
 	}
 }
 
+static void orion5x_arch_reset(char mode, const char *cmd)
+{
+	/*
+	 * Enable and issue soft reset
+	 */
+	orion5x_setbits(RSTOUTn_MASK, (1 << 2));
+	orion5x_setbits(CPU_SOFT_RESET, 1);
+	mdelay(200);
+	orion5x_clrbits(CPU_SOFT_RESET, 1);
+}
+
 void __init orion5x_init(void)
 {
 	char *dev_name;
@@ -302,6 +314,11 @@ void __init orion5x_init(void)
 	 * Register watchdog driver
 	 */
 	orion5x_wdt_init();
+
+	/*
+	 * Assign reset hook.
+	 */
+	arm_arch_reset = orion5x_arch_reset;
 }
 
 /*
diff --git a/arch/arm/mach-orion5x/include/mach/system.h b/arch/arm/mach-orion5x/include/mach/system.h
index a1d6e46..91a933c 100644
--- a/arch/arm/mach-orion5x/include/mach/system.h
+++ b/arch/arm/mach-orion5x/include/mach/system.h
@@ -20,14 +20,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * Enable and issue soft reset
-	 */
-	orion5x_setbits(RSTOUTn_MASK, (1 << 2));
-	orion5x_setbits(CPU_SOFT_RESET, 1);
-	mdelay(200);
-	orion5x_clrbits(CPU_SOFT_RESET, 1);
 }
 
-
 #endif
-- 
1.7.4.1
