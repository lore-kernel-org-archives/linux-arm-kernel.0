From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Apr 2012 22:12:50 +0200
Subject: [PATCH 16/17][V2] ARM: OMAP3/4: consolidate cpuidle Makefile
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1333570371-1389-17-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/Makefile      |   11 +++++++----
 arch/arm/mach-omap2/cpuidle34xx.c |    8 --------
 arch/arm/mach-omap2/cpuidle44xx.c |    8 --------
 arch/arm/mach-omap2/pm.h          |   17 +++++++++++++++--
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 49f92bc..f46c735 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -64,10 +64,8 @@ endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
-					   cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o \
-					   cpuidle44xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
@@ -81,6 +79,11 @@ endif
 
 endif
 
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
+endif
+
 # PRCM
 obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f54e6ae..882d349 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -36,8 +36,6 @@
 #include "control.h"
 #include "common.h"
 
-#ifdef CONFIG_CPU_IDLE
-
 /* Mach specific information to be recorded in the C-state driver_data */
 struct omap3_idle_statedata {
 	u32 mpu_state;
@@ -391,9 +389,3 @@ int __init omap3_idle_init(void)
 
 	return 0;
 }
-#else
-int __init omap3_idle_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index b0dd220..41303a7 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -22,8 +22,6 @@
 #include "pm.h"
 #include "prm.h"
 
-#ifdef CONFIG_CPU_IDLE
-
 /* Machine specific information */
 struct omap4_idle_statedata {
 	u32 cpu_state;
@@ -204,9 +202,3 @@ int __init omap4_idle_init(void)
 
 	return 0;
 }
-#else
-int __init omap4_idle_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7856489..ab04d3b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -15,12 +15,25 @@
 
 #include "powerdomain.h"
 
+#ifdef CONFIG_CPU_IDLE
+extern int __init omap3_idle_init(void);
+extern int __init omap4_idle_init(void);
+#else
+static inline int omap3_idle_init(void)
+{
+	return 0;
+}
+
+static inline int omap4_idle_init(void)
+{
+	return 0;
+}
+#endif
+
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
-extern int omap3_idle_init(void);
-extern int omap4_idle_init(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 extern int (*omap_pm_suspend)(void);
 
-- 
1.7.5.4
