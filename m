From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:50:49 +0000
Subject: [PATCH 32/41] ARM: restart: shark: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6rp-0001Yl-Oa@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook the Shark restart code into the new restart hook rather than
using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-shark/core.c                |    3 ++-
 arch/arm/mach-shark/include/mach/system.h |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index f4b25d8..a851c25 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -26,7 +26,7 @@
 #define ROMCARD_SIZE            0x08000000
 #define ROMCARD_START           0x10000000
 
-void arch_reset(char mode, const char *cmd)
+static void shark_restart(char mode, const char *cmd)
 {
         short temp;
         /* Reset the Machine via pc[3] of the sequoia chipset */
@@ -156,4 +156,5 @@ MACHINE_START(SHARK, "Shark")
 	.init_irq	= shark_init_irq,
 	.timer		= &shark_timer,
 	.dma_zone_size	= SZ_4M,
+	.restart	= shark_restart,
 MACHINE_END
diff --git a/arch/arm/mach-shark/include/mach/system.h b/arch/arm/mach-shark/include/mach/system.h
index 21c373b..2cc363a 100644
--- a/arch/arm/mach-shark/include/mach/system.h
+++ b/arch/arm/mach-shark/include/mach/system.h
@@ -6,8 +6,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-/* Found in arch/mach-shark/core.c */
-extern void arch_reset(char mode, const char *cmd);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 static inline void arch_idle(void)
 {
-- 
1.7.4.4
