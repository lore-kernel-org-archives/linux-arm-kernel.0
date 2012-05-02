From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:28 +0800
Subject: [PATCH 03/15] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-ep93xx/adssphere.c             |    1 +
 arch/arm/mach-ep93xx/core.c                  |    5 +++++
 arch/arm/mach-ep93xx/crunch.c                |    4 +---
 arch/arm/mach-ep93xx/edb93xx.c               |    8 ++++++++
 arch/arm/mach-ep93xx/gesbc9312.c             |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h |    7 +++++++
 arch/arm/mach-ep93xx/micro9.c                |    4 ++++
 arch/arm/mach-ep93xx/simone.c                |    1 +
 arch/arm/mach-ep93xx/snappercl15.c           |    1 +
 arch/arm/mach-ep93xx/ts72xx.c                |    1 +
 arch/arm/mach-ep93xx/vision_ep9307.c         |    1 +
 11 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 2d45947..a472777 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -41,5 +41,6 @@ MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= adssphere_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8d25895..365a90b 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -904,3 +904,8 @@ void ep93xx_restart(char mode, const char *cmd)
 	while (1)
 		;
 }
+
+void __init ep93xx_init_late(void)
+{
+	crunch_init();
+}
diff --git a/arch/arm/mach-ep93xx/crunch.c b/arch/arm/mach-ep93xx/crunch.c
index 74753e2..a4a2ab9 100644
--- a/arch/arm/mach-ep93xx/crunch.c
+++ b/arch/arm/mach-ep93xx/crunch.c
@@ -79,12 +79,10 @@ static struct notifier_block crunch_notifier_block = {
 	.notifier_call	= crunch_do,
 };
 
-static int __init crunch_init(void)
+int __init crunch_init(void)
 {
 	thread_register_notifier(&crunch_notifier_block);
 	elf_hwcap |= HWCAP_CRUNCH;
 
 	return 0;
 }
-
-late_initcall(crunch_init);
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index da9047d..d74c5cd 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -255,6 +255,7 @@ MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -268,6 +269,7 @@ MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -281,6 +283,7 @@ MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -294,6 +297,7 @@ MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -307,6 +311,7 @@ MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -320,6 +325,7 @@ MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -333,6 +339,7 @@ MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -346,6 +353,7 @@ MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index fcdffbe..437c341 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -41,5 +41,6 @@ MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= gesbc9312_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 602bd87..1ecb040 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -53,5 +53,12 @@ void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
 
 void ep93xx_restart(char, const char *);
+void ep93xx_init_late(void);
+
+#ifdef CONFIG_CRUNCH
+int crunch_init(void);
+#else
+static inline int crunch_init(void) { return 0; }
+#endif
 
 #endif
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index dc431c5..3d7cdab 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -85,6 +85,7 @@ MACHINE_START(MICRO9, "Contec Micro9-High")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -98,6 +99,7 @@ MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -111,6 +113,7 @@ MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
@@ -124,6 +127,7 @@ MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index f40c298..33dc079 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -86,5 +86,6 @@ MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= simone_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 0c00852..eb28237 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -183,5 +183,6 @@ MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	.handle_irq	= vic_handle_irq,
 	.timer 		= &ep93xx_timer,
 	.init_machine	= snappercl15_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 5ea7909..d4ef339 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -252,5 +252,6 @@ MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= ts72xx_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index ba156eb..2905a49 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -367,5 +367,6 @@ MACHINE_START(VISION_EP9307, "Vision Engraving Systems EP9307")
 	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= vision_init_machine,
+	.init_late	= ep93xx_init_late,
 	.restart	= ep93xx_restart,
 MACHINE_END
-- 
1.7.5.4
