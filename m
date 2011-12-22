From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:41 +0000
Subject: [PATCH v2 11/15] ARM: local timers: switch imx6q to standalone smp_twd
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the imx6q platforms to the standalone version of smp_twd.c.
Since the timer calibration code requires another timer to be up
and running, the actual initialisation is left to the late_timer_init
hook.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-imx/Makefile     |    1 -
 arch/arm/mach-imx/localtimer.c |   35 -----------------------------------
 arch/arm/mach-imx/mach-imx6q.c |   12 ++++++++++++
 3 files changed, 12 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-imx/localtimer.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 88a3966..94cbed6 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
 AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
 
 # i.MX5 based machines
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
index c257281..85031b8 100644
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
@@ -116,9 +117,20 @@ static void __init imx6q_init_irq(void)
 	of_irq_init(imx6q_irq_match);
 }
 
+const static struct of_device_id imx6q_twd_match[] __initconst = {
+	{ .compatible = "arm,smp-twd", },
+	{}
+};
+
+static void __init imx6q_twd_init(void)
+{
+	twd_timer_of_init(imx6q_twd_match);
+}
+
 static void __init imx6q_timer_init(void)
 {
 	mx6q_clocks_init();
+	late_time_init = imx6q_twd_init;
 }
 
 static struct sys_timer imx6q_timer = {
-- 
1.7.7.1
