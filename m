From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:46 +0100
Subject: [PATCH 18/51] ARM: mach-ixp2000: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-19-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-ixp2000 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ixp2000/core.c                |   38 +++++++++++++++++++++++++++
 arch/arm/mach-ixp2000/include/mach/system.h |   30 ---------------------
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
index 4068166..59e987f 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -28,6 +28,7 @@
 
 #include <asm/types.h>
 #include <asm/setup.h>
+#include <asm/mach-types.h>
 #include <asm/memory.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -514,3 +515,40 @@ void __init ixp2000_init_irq(void)
 	}
 }
 
+static void ixp2000_arch_reset(char mode, const char *cmd)
+{
+	local_irq_disable();
+
+	/*
+	 * Reset flash banking register so that we are pointing at
+	 * RedBoot bank.
+	 */
+	if (machine_is_ixdp2401()) {
+		ixp2000_reg_write(IXDP2X01_CPLD_FLASH_REG,
+					((0 >> IXDP2X01_FLASH_WINDOW_BITS)
+						| IXDP2X01_CPLD_FLASH_INTERN));
+		ixp2000_reg_wrb(IXDP2X01_CPLD_RESET_REG, 0xffffffff);
+	}
+
+	/*
+	 * On IXDP2801 we need to write this magic sequence to the CPLD
+	 * to cause a complete reset of the CPU and all external devices
+	 * and move the flash bank register back to 0.
+	 */
+	if (machine_is_ixdp2801() || machine_is_ixdp28x5()) {
+		unsigned long reset_reg = *IXDP2X01_CPLD_RESET_REG;
+
+		reset_reg = 0x55AA0000 | (reset_reg & 0x0000FFFF);
+		ixp2000_reg_write(IXDP2X01_CPLD_RESET_REG, reset_reg);
+		ixp2000_reg_wrb(IXDP2X01_CPLD_RESET_REG, 0x80000000);
+	}
+
+	ixp2000_reg_wrb(IXP2000_RESET0, RSTALL);
+}
+
+static int __init ixp2000_arch_reset_init(void)
+{
+	arm_arch_reset = ixp2000_arch_reset;
+	return 0;
+}
+arch_initcall(ixp2000_arch_reset_init);
diff --git a/arch/arm/mach-ixp2000/include/mach/system.h b/arch/arm/mach-ixp2000/include/mach/system.h
index de37099..d79c7ad 100644
--- a/arch/arm/mach-ixp2000/include/mach/system.h
+++ b/arch/arm/mach-ixp2000/include/mach/system.h
@@ -9,9 +9,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -19,31 +16,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	local_irq_disable();
-
-	/*
-	 * Reset flash banking register so that we are pointing at
-	 * RedBoot bank.
-	 */
-	if (machine_is_ixdp2401()) {
-		ixp2000_reg_write(IXDP2X01_CPLD_FLASH_REG,
-					((0 >> IXDP2X01_FLASH_WINDOW_BITS)
-						| IXDP2X01_CPLD_FLASH_INTERN));
-		ixp2000_reg_wrb(IXDP2X01_CPLD_RESET_REG, 0xffffffff);
-	}
-
-	/*
-	 * On IXDP2801 we need to write this magic sequence to the CPLD
-	 * to cause a complete reset of the CPU and all external devices
-	 * and move the flash bank register back to 0.
-	 */
-	if (machine_is_ixdp2801() || machine_is_ixdp28x5()) {
-		unsigned long reset_reg = *IXDP2X01_CPLD_RESET_REG;
-
-		reset_reg = 0x55AA0000 | (reset_reg & 0x0000FFFF);
-		ixp2000_reg_write(IXDP2X01_CPLD_RESET_REG, reset_reg);
-		ixp2000_reg_wrb(IXDP2X01_CPLD_RESET_REG, 0x80000000);
-	}
-
-	ixp2000_reg_wrb(IXP2000_RESET0, RSTALL);
 }
-- 
1.7.4.1
