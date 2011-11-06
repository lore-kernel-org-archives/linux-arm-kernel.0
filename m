From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:42:19 +0000
Subject: [PATCH 07/41] ARM: restart: dove: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6jb-0001X2-K7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather than
using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-dove/cm-a510.c             |    1 +
 arch/arm/mach-dove/common.c              |   16 ++++++++++++++++
 arch/arm/mach-dove/common.h              |    1 +
 arch/arm/mach-dove/dove-db-setup.c       |    1 +
 arch/arm/mach-dove/include/mach/system.h |   14 --------------
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index c8a406f..792b4e2 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -93,4 +93,5 @@ MACHINE_START(CM_A510, "Compulab CM-A510 Board")
 	.init_early	= dove_init_early,
 	.init_irq	= dove_init_irq,
 	.timer		= &dove_timer,
+	.restart	= dove_restart,
 MACHINE_END
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index a9e0dae..13bb236 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -292,3 +292,19 @@ void __init dove_init(void)
 	dove_xor0_init();
 	dove_xor1_init();
 }
+
+void dove_restart(char mode, const char *cmd)
+{
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
+
+	while (1)
+		;
+}
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 6a2046e..4202730 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -39,5 +39,6 @@ void dove_spi1_init(void);
 void dove_i2c_init(void);
 void dove_sdio0_init(void);
 void dove_sdio1_init(void);
+void dove_restart(char, const char *);
 
 #endif
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index 11ea34e..ea77ae4 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -100,4 +100,5 @@ MACHINE_START(DOVE_DB, "Marvell DB-MV88AP510-BP Development Board")
 	.init_early	= dove_init_early,
 	.init_irq	= dove_init_irq,
 	.timer		= &dove_timer,
+	.restart	= dove_restart,
 MACHINE_END
diff --git a/arch/arm/mach-dove/include/mach/system.h b/arch/arm/mach-dove/include/mach/system.h
index 356afda..25a3a65 100644
--- a/arch/arm/mach-dove/include/mach/system.h
+++ b/arch/arm/mach-dove/include/mach/system.h
@@ -9,8 +9,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <mach/bridge-regs.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -18,18 +16,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * Enable soft reset to assert RSTOUTn.
-	 */
-	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
-
-	/*
-	 * Assert soft reset.
-	 */
-	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
-
-	while (1)
-		;
 }
 
 
-- 
1.7.4.4
