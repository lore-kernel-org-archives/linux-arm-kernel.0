From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:46:40 +0200
Subject: [PATCH 4/7] ARM: ux500: Move timer code to separate file
Message-ID: <1316699200-21359-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Just split off the timer code to its own file so we have a
more fine-grained file tree.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile |    2 +-
 arch/arm/mach-ux500/cpu.c    |   36 --------------------------
 arch/arm/mach-ux500/timer.c  |   58 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/mach-ux500/timer.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 1694916..be915a1 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y				:= clock.o cpu.o devices.o devices-common.o \
-				   id.o usb.o
+				   id.o usb.o timer.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index c0e4593..797f364 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -18,7 +18,6 @@
 #include <asm/mach/map.h>
 #include <asm/localtimer.h>
 
-#include <plat/mtu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
@@ -120,38 +119,3 @@ static int ux500_l2x0_init(void)
 }
 early_initcall(ux500_l2x0_init);
 #endif
-
-static void __init ux500_timer_init(void)
-{
-#ifdef CONFIG_LOCAL_TIMERS
-	/* Setup the local timer base */
-	if (cpu_is_u5500())
-		twd_base = __io_address(U5500_TWD_BASE);
-	else if (cpu_is_u8500())
-		twd_base = __io_address(U8500_TWD_BASE);
-	else
-		ux500_unknown_soc();
-#endif
-	if (cpu_is_u5500())
-		mtu_base = __io_address(U5500_MTU0_BASE);
-	else if (cpu_is_u8500ed())
-		mtu_base = __io_address(U8500_MTU0_BASE_ED);
-	else if (cpu_is_u8500())
-		mtu_base = __io_address(U8500_MTU0_BASE);
-	else
-		ux500_unknown_soc();
-
-	if (cpu_is_u8500())
-		clksrc_dbx500_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
-	else if (cpu_is_u5500())
-		clksrc_dbx500_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
-	else
-		ux500_unknown_soc();
-
-	nmdk_timer_init();
-	clksrc_dbx500_prcmu_init();
-}
-
-struct sys_timer ux500_timer = {
-	.init	= ux500_timer_init,
-};
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
new file mode 100644
index 0000000..36a82bf
--- /dev/null
+++ b/arch/arm/mach-ux500/timer.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
+ */
+#include <linux/io.h>
+#include <linux/clksrc-dbx500-prcmu.h>
+
+#include <asm/localtimer.h>
+
+#include <plat/mtu.h>
+
+#include <mach/setup.h>
+#include <mach/hardware.h>
+
+static void __init ux500_timer_init(void)
+{
+	if (cpu_is_u5500()) {
+#ifdef CONFIG_LOCAL_TIMERS
+		twd_base = __io_address(U5500_TWD_BASE);
+#endif
+		mtu_base = __io_address(U5500_MTU0_BASE);
+		clksrc_dbx500_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
+	} else if (cpu_is_u8500()) {
+#ifdef CONFIG_LOCAL_TIMERS
+		twd_base = __io_address(U8500_TWD_BASE);
+#endif
+		mtu_base = __io_address(U8500_MTU0_BASE);
+		clksrc_dbx500_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
+	} else {
+		ux500_unknown_soc();
+	}
+
+	/*
+	 * Here we register the timerblocks active in the system.
+	 * Localtimers (twd) is started when both cpu is up and running.
+	 * MTU register a clocksource, clockevent and sched_clock.
+	 * Since the MTU is located in the VAPE power domain
+	 * it will be cleared in sleep which makes it unsuitable.
+	 * We however need it as a timer tick (clockevent)
+	 * during boot to calibrate delay until twd is started.
+	 * RTC-RTT have problems as timer tick during boot since it is
+	 * depending on delay which is not yet calibrated. RTC-RTT is in the
+	 * always-on powerdomain and is used as clockevent instead of twd when
+	 * sleeping.
+	 * The PRCMU timer 4(3 for DB5500) register a clocksource and
+	 * sched_clock with higher rating then MTU since is always-on.
+	 *
+	 */
+
+	nmdk_timer_init();
+	clksrc_dbx500_prcmu_init();
+}
+
+struct sys_timer ux500_timer = {
+	.init		= ux500_timer_init,
+};
-- 
1.7.3.2
