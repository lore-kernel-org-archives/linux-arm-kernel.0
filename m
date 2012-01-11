From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2012 13:08:50 +0000
Subject: [PATCH 11/15] ARM: imx6q: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326287334-1905-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new smp_twd runtime registration interface
to the imx6q platforms, and remove the old compile-time support.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-imx/Makefile     |    1 -
 arch/arm/mach-imx/localtimer.c |   35 -----------------------------------
 arch/arm/mach-imx/mach-imx6q.c |   11 +++++++++++
 3 files changed, 11 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-imx/localtimer.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 88531b6..a633e3f 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
 AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 
 # i.MX5 based machines
 obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
diff --git a/arch/arm/mach-imx/localtimer.c b/arch/arm/mach-imx/localtimer.c
deleted file mode 100644
index 3a16351..0000000
--- a/arch/arm/mach-imx/localtimer.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright 2011 Freescale Semiconductor, Inc.
- * Copyright 2011 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/init.h>
-#include <linux/clockchips.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <asm/smp_twd.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
-	if (!twd_base) {
-		twd_base = of_iomap(np, 0);
-		WARN_ON(!twd_base);
-	}
-	evt->irq = irq_of_parse_and_map(np, 0);
-	twd_timer_setup(evt);
-
-	return 0;
-}
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index c257281..5cd916c 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -21,6 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
+#include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
@@ -116,9 +117,19 @@ static void __init imx6q_init_irq(void)
 	of_irq_init(imx6q_irq_match);
 }
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static void __init imx6q_twd_init(void)
+{
+	twd_local_timer_of_register();
+}
+#else
+#define imx6q_twd_init		NULL
+#endif
+
 static void __init imx6q_timer_init(void)
 {
 	mx6q_clocks_init();
+	late_time_init = imx6q_twd_init;
 }
 
 static struct sys_timer imx6q_timer = {
-- 
1.7.7.1
