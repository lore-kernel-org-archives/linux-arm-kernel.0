From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:43:00 +0000
Subject: [PATCH 09/41] ARM: restart: ep93xx: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6kG-0001XA-GF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather than
using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ep93xx/adssphere.c             |    1 +
 arch/arm/mach-ep93xx/core.c                  |   12 ++++++++++++
 arch/arm/mach-ep93xx/edb93xx.c               |    8 ++++++++
 arch/arm/mach-ep93xx/gesbc9312.c             |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h |    2 ++
 arch/arm/mach-ep93xx/include/mach/system.h   |   11 -----------
 arch/arm/mach-ep93xx/micro9.c                |    4 ++++
 arch/arm/mach-ep93xx/simone.c                |    1 +
 arch/arm/mach-ep93xx/snappercl15.c           |    1 +
 arch/arm/mach-ep93xx/ts72xx.c                |    1 +
 arch/arm/mach-ep93xx/vision_ep9307.c         |    1 +
 11 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 0713448..7b41651 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -38,4 +38,5 @@ MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= adssphere_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 94c78bc..348e13e 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -905,3 +905,15 @@ void __init ep93xx_init_devices(void)
 	platform_device_register(&ep93xx_ohci_device);
 	platform_device_register(&ep93xx_leds);
 }
+
+void ep93xx_restart(char mode, const char *cmd)
+{
+	/*
+	 * Set then clear the SWRST bit to initiate a software reset
+	 */
+	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
+
+	while (1)
+		;
+}
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 70ef8c5..c5731c6 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -252,6 +252,7 @@ MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -263,6 +264,7 @@ MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -274,6 +276,7 @@ MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -285,6 +288,7 @@ MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -296,6 +300,7 @@ MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -307,6 +312,7 @@ MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -318,6 +324,7 @@ MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -329,5 +336,6 @@ MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 45ee205..7b89e8a 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -38,4 +38,5 @@ MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= gesbc9312_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 5066045..d4c9349 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -66,4 +66,6 @@ void ep93xx_register_ac97(void);
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
 
+void ep93xx_restart(char, const char *);
+
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
index bdf6c4f..b27a654 100644
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ b/arch/arm/mach-ep93xx/include/mach/system.h
@@ -1,9 +1,6 @@
 /*
  * arch/arm/mach-ep93xx/include/mach/system.h
  */
-
-#include <mach/hardware.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -11,12 +8,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * Set then clear the SWRST bit to initiate a software reset
-	 */
-	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
-	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
-
-	while (1)
-		;
 }
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index e72f736..050ce92 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -82,6 +82,7 @@ MACHINE_START(MICRO9, "Contec Micro9-High")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -93,6 +94,7 @@ MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -104,6 +106,7 @@ MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
 
@@ -115,5 +118,6 @@ MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 52e090d..188cbdb 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -82,4 +82,5 @@ MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= simone_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 8121e3a..797afde 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -179,4 +179,5 @@ MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	.init_irq	= ep93xx_init_irq,
 	.timer 		= &ep93xx_timer,
 	.init_machine	= snappercl15_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 1ade3c3..8fa6169 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -262,4 +262,5 @@ MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= ts72xx_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index d96e4db..03dd401 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -361,4 +361,5 @@ MACHINE_START(VISION_EP9307, "Vision Engraving Systems EP9307")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= vision_init_machine,
+	.restart	= ep93xx_restart,
 MACHINE_END
-- 
1.7.4.4
