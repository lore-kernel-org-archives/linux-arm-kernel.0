From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:48:49 +0000
Subject: [PATCH 09/11] ARM: realview/vexpress: consolidate localtimer support
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSDR-0003pP-FK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Realview and Versatile Express local timer support is identical, so
consolidate the implementations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/Makefile      |    1 -
 arch/arm/mach-realview/localtimer.c  |   26 --------------------------
 arch/arm/mach-vexpress/Makefile      |    1 -
 arch/arm/mach-vexpress/localtimer.c  |   26 --------------------------
 arch/arm/plat-versatile/Makefile     |    1 +
 arch/arm/plat-versatile/localtimer.c |   26 ++++++++++++++++++++++++++
 6 files changed, 27 insertions(+), 54 deletions(-)
 delete mode 100644 arch/arm/mach-realview/localtimer.c
 delete mode 100644 arch/arm/mach-vexpress/localtimer.c
 create mode 100644 arch/arm/plat-versatile/localtimer.c

diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index a01b76b..ba85e52 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -10,4 +10,3 @@ obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= realview_pba8.o
 obj-$(CONFIG_MACH_REALVIEW_PBX)		+= realview_pbx.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
diff --git a/arch/arm/mach-realview/localtimer.c b/arch/arm/mach-realview/localtimer.c
deleted file mode 100644
index 60b4e11..0000000
--- a/arch/arm/mach-realview/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-
-#include <asm/irq.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
-}
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 2c0ac7d..cfe344e 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -6,4 +6,3 @@ obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
diff --git a/arch/arm/mach-vexpress/localtimer.c b/arch/arm/mach-vexpress/localtimer.c
deleted file mode 100644
index c0e3a59..0000000
--- a/arch/arm/mach-vexpress/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  linux/arch/arm/mach-vexpress/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <mach/irqs.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
-}
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 41f57f4..b511abb 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,5 @@
 obj-y	:= clock.o
+obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
new file mode 100644
index 0000000..83ebee5
--- /dev/null
+++ b/arch/arm/plat-versatile/localtimer.c
@@ -0,0 +1,26 @@
+/*
+ *  linux/arch/arm/plat-versatile/localtimer.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+#include <mach/irqs.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	twd_timer_setup(evt);
+}
-- 
1.6.2.5
