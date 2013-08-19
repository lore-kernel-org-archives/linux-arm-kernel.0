From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Aug 2013 21:28:10 +0200
Subject: [PATCH v2] ARM: ux500: add restart support via prcmu
Message-ID: <1376940490-13277-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Baltieri <fabio.baltieri@linaro.org>

Add necessary code to restart ux500 based machines using
prcmu_system_reset().

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased to use the new signature of the restart hook
  taking an enum rather than a char.
---
 arch/arm/mach-ux500/board-mop500.c | 5 ++++-
 arch/arm/mach-ux500/cpu-db8500.c   | 2 +-
 arch/arm/mach-ux500/cpu.c          | 8 ++++++++
 arch/arm/mach-ux500/setup.h        | 3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index df5d27a..4e7ab3a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -42,7 +42,6 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 
 #include <asm/mach-types.h>
-#include <asm/mach/arch.h>
 
 #include "setup.h"
 #include "devices.h"
@@ -686,6 +685,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.init_time	= ux500_timer_init,
 	.init_machine	= mop500_init_machine,
 	.init_late	= ux500_init_late,
+	.restart        = ux500_restart,
 MACHINE_END
 
 MACHINE_START(U8520, "ST-Ericsson U8520 Platform HREFP520")
@@ -695,6 +695,7 @@ MACHINE_START(U8520, "ST-Ericsson U8520 Platform HREFP520")
 	.init_time	= ux500_timer_init,
 	.init_machine	= mop500_init_machine,
 	.init_late	= ux500_init_late,
+	.restart        = ux500_restart,
 MACHINE_END
 
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
@@ -705,6 +706,7 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.init_time	= ux500_timer_init,
 	.init_machine	= hrefv60_init_machine,
 	.init_late	= ux500_init_late,
+	.restart        = ux500_restart,
 MACHINE_END
 
 MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
@@ -716,4 +718,5 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.init_time	= ux500_timer_init,
 	.init_machine	= snowball_init_machine,
 	.init_late	= NULL,
+	.restart        = ux500_restart,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 12eee81..03ec8a2 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -26,7 +26,6 @@
 
 #include <asm/pmu.h>
 #include <asm/mach/map.h>
-#include <asm/mach/arch.h>
 
 #include "setup.h"
 #include "devices.h"
@@ -325,6 +324,7 @@ DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
 	.init_machine	= u8500_init_machine,
 	.init_late	= NULL,
 	.dt_compat      = stericsson_dt_platform_compat,
+	.restart        = ux500_restart,
 MACHINE_END
 
 #endif
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e6fb023..5d7eebc 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -31,6 +31,14 @@
 #include "db8500-regs.h"
 #include "id.h"
 
+void ux500_restart(enum reboot_mode mode, const char *cmd)
+{
+	local_irq_disable();
+	local_fiq_disable();
+
+	prcmu_system_reset(0);
+}
+
 /*
  * FIXME: Should we set up the GPIO domain here?
  *
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index cad3ca8..656324a 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -11,10 +11,13 @@
 #ifndef __ASM_ARCH_SETUP_H
 #define __ASM_ARCH_SETUP_H
 
+#include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <linux/init.h>
 #include <linux/mfd/abx500/ab8500.h>
 
+void ux500_restart(enum reboot_mode mode, const char *cmd);
+
 void __init ux500_map_io(void);
 extern void __init u8500_map_io(void);
 
-- 
1.8.1.4
