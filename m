From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:45:23 +0000
Subject: [PATCH 16/41] ARM: restart: ixp2000: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6mZ-0001Xd-9V@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

In doing so, we split out the IXDP2401, IXDP2801 and IXDP2805 platform
specific restart code into their own platform files.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ixp2000/core.c                  |    4 +++
 arch/arm/mach-ixp2000/enp2611.c               |    1 +
 arch/arm/mach-ixp2000/include/mach/platform.h |    1 +
 arch/arm/mach-ixp2000/include/mach/system.h   |   29 ----------------------
 arch/arm/mach-ixp2000/ixdp2400.c              |    1 +
 arch/arm/mach-ixp2000/ixdp2800.c              |    1 +
 arch/arm/mach-ixp2000/ixdp2x01.c              |   32 +++++++++++++++++++++++++
 7 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
index 59a5126..e5916b7 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -514,3 +514,7 @@ void __init ixp2000_init_irq(void)
 	}
 }
 
+void ixp2000_restart(char mode, const char *cmd)
+{
+	ixp2000_reg_wrb(IXP2000_RESET0, RSTALL);
+}
diff --git a/arch/arm/mach-ixp2000/enp2611.c b/arch/arm/mach-ixp2000/enp2611.c
index af99945..ee52541 100644
--- a/arch/arm/mach-ixp2000/enp2611.c
+++ b/arch/arm/mach-ixp2000/enp2611.c
@@ -259,6 +259,7 @@ MACHINE_START(ENP2611, "Radisys ENP-2611 PCI network processor board")
 	.init_irq	= ixp2000_init_irq,
 	.timer		= &enp2611_timer,
 	.init_machine	= enp2611_init_machine,
+	.restart	= ixp2000_restart,
 MACHINE_END
 
 
diff --git a/arch/arm/mach-ixp2000/include/mach/platform.h b/arch/arm/mach-ixp2000/include/mach/platform.h
index 42182c79..bb0f8dc 100644
--- a/arch/arm/mach-ixp2000/include/mach/platform.h
+++ b/arch/arm/mach-ixp2000/include/mach/platform.h
@@ -122,6 +122,7 @@ void ixp2000_map_io(void);
 void ixp2000_uart_init(void);
 void ixp2000_init_irq(void);
 void ixp2000_init_time(unsigned long);
+void ixp2000_restart(char, const char *);
 unsigned long ixp2000_gettimeoffset(void);
 
 struct pci_sys_data;
diff --git a/arch/arm/mach-ixp2000/include/mach/system.h b/arch/arm/mach-ixp2000/include/mach/system.h
index 810df7b..e981fd2 100644
--- a/arch/arm/mach-ixp2000/include/mach/system.h
+++ b/arch/arm/mach-ixp2000/include/mach/system.h
@@ -8,10 +8,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -19,29 +15,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
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
diff --git a/arch/arm/mach-ixp2000/ixdp2400.c b/arch/arm/mach-ixp2000/ixdp2400.c
index f7dfd97..f53e911 100644
--- a/arch/arm/mach-ixp2000/ixdp2400.c
+++ b/arch/arm/mach-ixp2000/ixdp2400.c
@@ -176,5 +176,6 @@ MACHINE_START(IXDP2400, "Intel IXDP2400 Development Platform")
 	.init_irq	= ixdp2400_init_irq,
 	.timer		= &ixdp2400_timer,
 	.init_machine	= ixdp2x00_init_machine,
+	.restart	= ixp2000_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-ixp2000/ixdp2800.c b/arch/arm/mach-ixp2000/ixdp2800.c
index d33bcac..a2e7c39 100644
--- a/arch/arm/mach-ixp2000/ixdp2800.c
+++ b/arch/arm/mach-ixp2000/ixdp2800.c
@@ -291,5 +291,6 @@ MACHINE_START(IXDP2800, "Intel IXDP2800 Development Platform")
 	.init_irq	= ixdp2800_init_irq,
 	.timer		= &ixdp2800_timer,
 	.init_machine	= ixdp2x00_init_machine,
+	.restart	= ixp2000_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 61a2867..7632bea 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -413,6 +413,35 @@ static void __init ixdp2x01_init_machine(void)
 	ixdp2x01_uart_init();
 }
 
+static void ixdp2401_restart(char mode, const char *cmd)
+{
+	/*
+	 * Reset flash banking register so that we are pointing at
+	 * RedBoot bank.
+	 */
+	ixp2000_reg_write(IXDP2X01_CPLD_FLASH_REG,
+				((0 >> IXDP2X01_FLASH_WINDOW_BITS)
+					| IXDP2X01_CPLD_FLASH_INTERN));
+	ixp2000_reg_wrb(IXDP2X01_CPLD_RESET_REG, 0xffffffff);
+
+	ixp2000_restart(mode, cmd);
+}
+
+static void ixdp280x_restart(char mode, const char *cmd)
+{
+	/*
+	 * On IXDP2801 we need to write this magic sequence to the CPLD
+	 * to cause a complete reset of the CPU and all external devices
+	 * and move the flash bank register back to 0.
+	 */
+	unsigned long reset_reg = *IXDP2X01_CPLD_RESET_REG;
+
+	reset_reg = 0x55AA0000 | (reset_reg & 0x0000FFFF);
+	ixp2000_reg_write(IXDP2X01_CPLD_RESET_REG, reset_reg);
+	ixp2000_reg_wrb(IXDP2X01_CPLD_RESET_REG, 0x80000000);
+
+	ixp2000_restart(mode, cmd);
+}
 
 #ifdef CONFIG_ARCH_IXDP2401
 MACHINE_START(IXDP2401, "Intel IXDP2401 Development Platform")
@@ -422,6 +451,7 @@ MACHINE_START(IXDP2401, "Intel IXDP2401 Development Platform")
 	.init_irq	= ixdp2x01_init_irq,
 	.timer		= &ixdp2x01_timer,
 	.init_machine	= ixdp2x01_init_machine,
+	.restart	= ixdp2401_restart,
 MACHINE_END
 #endif
 
@@ -433,6 +463,7 @@ MACHINE_START(IXDP2801, "Intel IXDP2801 Development Platform")
 	.init_irq	= ixdp2x01_init_irq,
 	.timer		= &ixdp2x01_timer,
 	.init_machine	= ixdp2x01_init_machine,
+	.restart	= ixdp280x_restart,
 MACHINE_END
 
 /*
@@ -446,6 +477,7 @@ MACHINE_START(IXDP28X5, "Intel IXDP2805/2855 Development Platform")
 	.init_irq	= ixdp2x01_init_irq,
 	.timer		= &ixdp2x01_timer,
 	.init_machine	= ixdp2x01_init_machine,
+	.restart	= ixdp280x_restart,
 MACHINE_END
 #endif
 
-- 
1.7.4.4
