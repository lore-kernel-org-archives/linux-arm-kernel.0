From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:55:48 +0000
Subject: [PATCH 2/5] ARM: restart: omap: use new restart hook XXX WIP XXX
In-Reply-To: <20111106175457.GK12913@n2100.arm.linux.org.uk>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6we-0001aR-Qs@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/board-voiceblue.c     |    5 ++---
 arch/arm/mach-omap1/include/mach/system.h |    6 ++++++
 arch/arm/mach-omap1/reset.c               |    4 +---
 arch/arm/mach-omap2/include/mach/system.h |    6 ++++++
 arch/arm/mach-omap2/prcm.c                |    4 +---
 arch/arm/plat-omap/include/plat/system.h  |    2 --
 6 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 2a6545b..b0111b6 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -220,7 +220,7 @@ void voiceblue_wdt_ping(void)
 	gpio_set_value(0, wdt_gpio_state);
 }
 
-static void voiceblue_reset(char mode, const char *cmd)
+static void voiceblue_restart(char mode, const char *cmd)
 {
 	/*
 	 * Workaround for 5912/1611b bug mentioned in sprz209d.pdf p. 28
@@ -284,8 +284,6 @@ static void __init voiceblue_init(void)
 	 * (it is connected through invertor) */
 	omap_writeb(0x00, OMAP_LPG1_LCR);
 	omap_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
-
-	arch_reset = voiceblue_reset;
 }
 
 MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
@@ -297,4 +295,5 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.init_irq	= omap1_init_irq,
 	.init_machine	= voiceblue_init,
 	.timer		= &omap1_timer,
+	.restart	= voiceblue_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/include/mach/system.h b/arch/arm/mach-omap1/include/mach/system.h
index a6c1b3a..4faeef6 100644
--- a/arch/arm/mach-omap1/include/mach/system.h
+++ b/arch/arm/mach-omap1/include/mach/system.h
@@ -1,5 +1,11 @@
 /*
  * arch/arm/mach-omap1/include/mach/system.h
  */
+void omap1_restart(char mode, const char *cmd);
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	omap1_restart(mode, cmd);
+}
 
 #include <plat/system.h>
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index ad951ee..8b1cc6e 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -8,7 +8,7 @@
 #include <mach/system.h>
 #include <plat/prcm.h>
 
-void omap1_arch_reset(char mode, const char *cmd)
+void omap1_restart(char mode, const char *cmd)
 {
 	/*
 	 * Workaround for 5912/1611b bug mentioned in sprz209d.pdf p. 28
@@ -21,5 +21,3 @@ void omap1_arch_reset(char mode, const char *cmd)
 
 	omap_writew(1, ARM_RSTCT1);
 }
-
-void (*arch_reset)(char, const char *) = omap1_arch_reset;
diff --git a/arch/arm/mach-omap2/include/mach/system.h b/arch/arm/mach-omap2/include/mach/system.h
index d488721..3062142 100644
--- a/arch/arm/mach-omap2/include/mach/system.h
+++ b/arch/arm/mach-omap2/include/mach/system.h
@@ -1,5 +1,11 @@
 /*
  * arch/arm/mach-omap2/include/mach/system.h
  */
+void omap_prcm_restart(char mode, const char *cmd);
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	omap_prcm_restart(mode, cmd);
+}
 
 #include <plat/system.h>
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 8db5f03..e64ffed 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -58,7 +58,7 @@ u32 omap_prcm_get_reset_sources(void)
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
-static void omap_prcm_arch_reset(char mode, const char *cmd)
+void omap_prcm_restart(char mode, const char *cmd)
 {
 	s16 prcm_offs = 0;
 
@@ -109,8 +109,6 @@ static void omap_prcm_arch_reset(char mode, const char *cmd)
 	omap2_prm_read_mod_reg(prcm_offs, OMAP2_RM_RSTCTRL); /* OCP barrier */
 }
 
-void (*arch_reset)(char, const char *) = omap_prcm_arch_reset;
-
 /**
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
  * @reg: physical address of module IDLEST register
diff --git a/arch/arm/plat-omap/include/plat/system.h b/arch/arm/plat-omap/include/plat/system.h
index c5fa9e9..8e5ebd7 100644
--- a/arch/arm/plat-omap/include/plat/system.h
+++ b/arch/arm/plat-omap/include/plat/system.h
@@ -12,6 +12,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-extern void (*arch_reset)(char, const char *);
-
 #endif
-- 
1.7.4.4
