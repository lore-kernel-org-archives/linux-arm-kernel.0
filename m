From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:00 +0100
Subject: [PATCH 32/51] ARM: mach-pnx4008: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-33-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-pnx4008 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-pnx4008/core.c                |    6 ++++++
 arch/arm/mach-pnx4008/include/mach/system.h |    5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pnx4008/core.c b/arch/arm/mach-pnx4008/core.c
index 6339975..7184172 100644
--- a/arch/arm/mach-pnx4008/core.c
+++ b/arch/arm/mach-pnx4008/core.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/proc-fns.h>
 #include <asm/system.h>
 
 #include <asm/mach/arch.h>
@@ -208,6 +209,10 @@ static struct platform_device *devices[] __initdata = {
 	&watchdog_device,
 };
 
+static void pnx4008_arch_reset(char mode, const char *cmd)
+{
+	cpu_reset(0);
+}
 
 extern void pnx4008_uart_init(void);
 
@@ -224,6 +229,7 @@ static void __init pnx4008_init(void)
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 	/* Switch on the UART clocks */
 	pnx4008_uart_init();
+	arm_arch_reset = pnx4008_arch_reset;
 }
 
 static struct map_desc pnx4008_io_desc[] __initdata = {
diff --git a/arch/arm/mach-pnx4008/include/mach/system.h b/arch/arm/mach-pnx4008/include/mach/system.h
index 5dda2bb..6710ed3 100644
--- a/arch/arm/mach-pnx4008/include/mach/system.h
+++ b/arch/arm/mach-pnx4008/include/mach/system.h
@@ -21,10 +21,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
 static void arch_idle(void)
 {
 	cpu_do_idle();
@@ -32,7 +28,6 @@ static void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	cpu_reset(0);
 }
 
 #endif
-- 
1.7.4.1
