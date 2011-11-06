From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:48:47 +0000
Subject: [PATCH 26/41] ARM: restart: pnx4008: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6pr-0001YM-VW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/core.c                |    6 ++++++
 arch/arm/mach-pnx4008/include/mach/system.h |    5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pnx4008/core.c b/arch/arm/mach-pnx4008/core.c
index cdb95e7..4cfb40b 100644
--- a/arch/arm/mach-pnx4008/core.c
+++ b/arch/arm/mach-pnx4008/core.c
@@ -260,6 +260,11 @@ void __init pnx4008_map_io(void)
 	iotable_init(pnx4008_io_desc, ARRAY_SIZE(pnx4008_io_desc));
 }
 
+static void pnx4008_restart(char mode, const char *cmd)
+{
+	soft_restart(0);
+}
+
 extern struct sys_timer pnx4008_timer;
 
 MACHINE_START(PNX4008, "Philips PNX4008")
@@ -269,4 +274,5 @@ MACHINE_START(PNX4008, "Philips PNX4008")
 	.init_irq 		= pnx4008_init_irq,
 	.init_machine 		= pnx4008_init,
 	.timer 			= &pnx4008_timer,
+	.restart		= pnx4008_restart,
 MACHINE_END
diff --git a/arch/arm/mach-pnx4008/include/mach/system.h b/arch/arm/mach-pnx4008/include/mach/system.h
index 5d6384a..6710ed3 100644
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
-	soft_restart(0);
 }
 
 #endif
-- 
1.7.4.4
