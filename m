From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:06 +0100
Subject: [PATCH 38/51] ARM: mach-sa1100: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-39-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-sa1100 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-sa1100/generic.c             |   13 +++++++++++++
 arch/arm/mach-sa1100/include/mach/system.h |    8 --------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index e21f347..fb49654 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -25,6 +25,7 @@
 #include <asm/mach/flash.h>
 #include <asm/irq.h>
 #include <asm/gpio.h>
+#include <asm/proc-fns.h>
 
 #include "generic.h"
 
@@ -126,6 +127,17 @@ static void sa1100_power_off(void)
 	PMCR = PMCR_SF;
 }
 
+static void sa1100_arch_reset(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/* Jump into ROM at address 0 */
+		cpu_reset(0);
+	} else {
+		/* Use on-chip reset capability */
+		RSRR = RSRR_SWR;
+	}
+}
+
 static void sa11x0_register_device(struct platform_device *dev, void *data)
 {
 	int err;
@@ -351,6 +363,7 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 
 static int __init sa1100_init(void)
 {
+	arm_arch_reset = sa1100_arch_reset;
 	pm_power_off = sa1100_power_off;
 	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
 }
diff --git a/arch/arm/mach-sa1100/include/mach/system.h b/arch/arm/mach-sa1100/include/mach/system.h
index ba9da9f..ac3bdb8 100644
--- a/arch/arm/mach-sa1100/include/mach/system.h
+++ b/arch/arm/mach-sa1100/include/mach/system.h
@@ -3,7 +3,6 @@
  *
  * Copyright (c) 1999 Nicolas Pitre <nico@fluxnic.net>
  */
-#include <mach/hardware.h>
 
 static inline void arch_idle(void)
 {
@@ -12,11 +11,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (mode == 's') {
-		/* Jump into ROM at address 0 */
-		cpu_reset(0);
-	} else {
-		/* Use on-chip reset capability */
-		RSRR = RSRR_SWR;
-	}
 }
-- 
1.7.4.1
