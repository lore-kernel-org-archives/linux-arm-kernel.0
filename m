From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:42:40 +0000
Subject: [PATCH 08/41] ARM: restart: ebsa110: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6jw-0001X6-25@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook the EBSA110 platform restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ebsa110/core.c                |    6 ++++++
 arch/arm/mach-ebsa110/include/mach/system.h |    4 +++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index ce3ed24..294aad0 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -278,6 +278,11 @@ static int __init ebsa110_init(void)
 
 arch_initcall(ebsa110_init);
 
+static void ebsa110_restart(char mode, const char *cmd)
+{
+	soft_restart(0x80000000);
+}
+
 MACHINE_START(EBSA110, "EBSA110")
 	/* Maintainer: Russell King */
 	.atag_offset	= 0x400,
@@ -287,4 +292,5 @@ MACHINE_START(EBSA110, "EBSA110")
 	.map_io		= ebsa110_map_io,
 	.init_irq	= ebsa110_init_irq,
 	.timer		= &ebsa110_timer,
+	.restart	= ebsa110_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ebsa110/include/mach/system.h b/arch/arm/mach-ebsa110/include/mach/system.h
index 0d5df72..574e633 100644
--- a/arch/arm/mach-ebsa110/include/mach/system.h
+++ b/arch/arm/mach-ebsa110/include/mach/system.h
@@ -34,6 +34,8 @@ static inline void arch_idle(void)
 	asm volatile ("mcr p15, 0, ip, c15, c1, 2" : : : "cc");
 }
 
-#define arch_reset(mode, cmd)	soft_restart(0x80000000)
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 #endif
-- 
1.7.4.4
