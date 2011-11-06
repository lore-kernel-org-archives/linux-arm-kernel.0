From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:50:29 +0000
Subject: [PATCH 31/41] ARM: restart: sa1100: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6rV-0001Yh-K7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c             |    1 +
 arch/arm/mach-sa1100/badge4.c              |    1 +
 arch/arm/mach-sa1100/cerf.c                |    1 +
 arch/arm/mach-sa1100/collie.c              |    1 +
 arch/arm/mach-sa1100/generic.c             |   11 +++++++++++
 arch/arm/mach-sa1100/generic.h             |    1 +
 arch/arm/mach-sa1100/h3100.c               |    1 +
 arch/arm/mach-sa1100/h3600.c               |    1 +
 arch/arm/mach-sa1100/hackkit.c             |    1 +
 arch/arm/mach-sa1100/include/mach/system.h |    9 ---------
 arch/arm/mach-sa1100/jornada720.c          |    1 +
 arch/arm/mach-sa1100/lart.c                |    1 +
 arch/arm/mach-sa1100/nanoengine.c          |    1 +
 arch/arm/mach-sa1100/pleb.c                |    1 +
 arch/arm/mach-sa1100/shannon.c             |    1 +
 arch/arm/mach-sa1100/simpad.c              |    1 +
 16 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 3dd133f..6b93e20 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -455,4 +455,5 @@ MACHINE_START(ASSABET, "Intel-Assabet")
 #ifdef CONFIG_SA1111
 	.dma_zone_size	= SZ_1M,
 #endif
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index bda83e1..b07a2c0 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -309,4 +309,5 @@ MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
 #ifdef CONFIG_SA1111
 	.dma_zone_size	= SZ_1M,
 #endif
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 7f3da4b..11bb6d0 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -139,4 +139,5 @@ MACHINE_START(CERF, "Intrinsyc CerfBoard/CerfCube")
 	.init_irq	= cerf_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= cerf_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index bd3e1bf..2428fc9 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -386,4 +386,5 @@ MACHINE_START(COLLIE, "Sharp-Collie")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= collie_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 5fa5ae1..bb10ee2 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -126,6 +126,17 @@ static void sa1100_power_off(void)
 	PMCR = PMCR_SF;
 }
 
+void sa11x0_restart(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/* Jump into ROM at address 0 */
+		soft_restart(0);
+	} else {
+		/* Use on-chip reset capability */
+		RSRR = RSRR_SWR;
+	}
+}
+
 static void sa11x0_register_device(struct platform_device *dev, void *data)
 {
 	int err;
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index b7a9a60..33268cf 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -10,6 +10,7 @@ extern struct sys_timer sa1100_timer;
 extern void __init sa1100_map_io(void);
 extern void __init sa1100_init_irq(void);
 extern void __init sa1100_init_gpio(void);
+extern void sa11x0_restart(char, const char *);
 
 #define SET_BANK(__nr,__start,__size) \
 	mi->bank[__nr].start = (__start), \
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index b30733a..1e6b3c1 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -89,5 +89,6 @@ MACHINE_START(H3100, "Compaq iPAQ H3100")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= h3100_mach_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 6fd324d..6b58e74 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -130,5 +130,6 @@ MACHINE_START(H3600, "Compaq iPAQ H3600")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= h3600_mach_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 30f4a55..c01bb36 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -200,4 +200,5 @@ MACHINE_START(HACKKIT, "HackKit Cpu Board")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= hackkit_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/include/mach/system.h b/arch/arm/mach-sa1100/include/mach/system.h
index 345d35b..3c3e842 100644
--- a/arch/arm/mach-sa1100/include/mach/system.h
+++ b/arch/arm/mach-sa1100/include/mach/system.h
@@ -3,8 +3,6 @@
  *
  * Copyright (c) 1999 Nicolas Pitre <nico@fluxnic.net>
  */
-#include <mach/hardware.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -12,11 +10,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (mode == 's') {
-		/* Jump into ROM at address 0 */
-		soft_restart(0);
-	} else {
-		/* Use on-chip reset capability */
-		RSRR = RSRR_SWR;
-	}
 }
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 0bb520d..065aada 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -372,4 +372,5 @@ MACHINE_START(JORNADA720, "HP Jornada 720")
 #ifdef CONFIG_SA1111
 	.dma_zone_size	= SZ_1M,
 #endif
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 5bc59d0..af4e276 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -66,4 +66,5 @@ MACHINE_START(LART, "LART")
 	.init_irq	= sa1100_init_irq,
 	.init_machine	= lart_init,
 	.timer		= &sa1100_timer,
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 032f388..ed77f85 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -116,4 +116,5 @@ MACHINE_START(NANOENGINE, "BSE nanoEngine")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= nanoengine_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 65161f2..9307df0 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -150,4 +150,5 @@ MACHINE_START(PLEB, "PLEB")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine   = pleb_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 1cccbf5..318b2b7 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -87,4 +87,5 @@ MACHINE_START(SHANNON, "Shannon (AKA: Tuxscreen)")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= shannon_init,
+	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 4790f3f..e17c04d 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -396,4 +396,5 @@ MACHINE_START(SIMPAD, "Simpad")
 	.map_io		= simpad_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
+	.restart	= sa11x0_restart,
 MACHINE_END
-- 
1.7.4.4
