From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jan 2012 12:03:58 +0000
Subject: [PATCH v4 11/15] ARM: imx6q: convert to twd_local_timer_register()
 interface
In-Reply-To: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1327061042-14857-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new smp_twd runtime registration interface
to the imx6q platforms, and remove the old compile-time support.

The imx6q DTS file is updated to match the TWD DT documentation.
Also present in this patch a DTS fix to the timer interrupt routing
(the PPI connection uses bits [15:8]) and trigger (rising edge).

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/imx6q.dtsi   |    6 +++---
 arch/arm/mach-imx/Makefile     |    1 -
 arch/arm/mach-imx/localtimer.c |   35 -----------------------------------
 arch/arm/mach-imx/mach-imx6q.c |    2 ++
 4 files changed, 5 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-imx/localtimer.c

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 263e8f3..4905f51 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -88,9 +88,9 @@
 		ranges;
 
 		timer at 00a00600 {
-			compatible = "arm,smp-twd";
-			reg = <0x00a00600 0x100>;
-			interrupts = <1 13 0xf4>;
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x00a00600 0x20>;
+			interrupts = <1 13 0xf01>;
 		};
 
 		L2: l2-cache at 00a02000 {
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index f5920c2..dd46f07 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -69,7 +69,6 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
 AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
 
 ifeq ($(CONFIG_PM),y)
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
index c257281..a2eea86 100644
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
@@ -119,6 +120,7 @@ static void __init imx6q_init_irq(void)
 static void __init imx6q_timer_init(void)
 {
 	mx6q_clocks_init();
+	twd_local_timer_of_register();
 }
 
 static struct sys_timer imx6q_timer = {
-- 
1.7.7.1
