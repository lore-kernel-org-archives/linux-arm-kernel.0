From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Oct 2012 12:28:12 -0600
Subject: [PATCH 3/3] ARM: tegra: move timer.c to drivers/clocksource/
In-Reply-To: <1351016892-21211-1-git-send-email-swarren@wwwdotorg.org>
References: <1351016892-21211-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1351016892-21211-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Move arch/arm/mach-tegra/timer.c to drivers/clocksource/tegra20_timer.c
so that the code is co-located with other clocksource drivers, and to
reduce the size of the mach-tegra directory.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                       |    1 -
 arch/arm/mach-tegra/board-dt-tegra20.c             |    3 +-
 arch/arm/mach-tegra/board-dt-tegra30.c             |    3 +-
 arch/arm/mach-tegra/board.h                        |    1 -
 drivers/clocksource/Makefile                       |    1 +
 .../timer.c => drivers/clocksource/tegra20_timer.c |    7 +----
 include/linux/tegra20_timer.h                      |   24 ++++++++++++++++++++
 7 files changed, 31 insertions(+), 9 deletions(-)
 rename arch/arm/mach-tegra/timer.c => drivers/clocksource/tegra20_timer.c (98%)
 create mode 100644 include/linux/tegra20_timer.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 9aa653b..4a59038 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -2,7 +2,6 @@ obj-y                                   += common.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y                                   += clock.o
-obj-y                                   += timer.o
 obj-y					+= fuse.o
 obj-y					+= pmc.o
 obj-y					+= flowctrl.o
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 0419056..b66f7e7 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -33,6 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-tegra.h>
 #include <linux/usb/tegra_usb_phy.h>
+#include <linux/tegra20_timer.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
@@ -184,7 +185,7 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.init_early	= tegra20_init_early,
 	.init_irq	= tegra_dt_init_irq,
 	.handle_irq	= gic_handle_irq,
-	.timer		= &tegra_sys_timer,
+	.timer		= &tegra20_sys_timer,
 	.init_machine	= tegra_dt_init,
 	.init_late	= tegra_dt_init_late,
 	.restart	= tegra_assert_system_reset,
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 7368ebd..a47d19e 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -29,6 +29,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/tegra20_timer.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
@@ -92,7 +93,7 @@ DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
 	.init_early	= tegra30_init_early,
 	.init_irq	= tegra_dt_init_irq,
 	.handle_irq	= gic_handle_irq,
-	.timer		= &tegra_sys_timer,
+	.timer		= &tegra20_sys_timer,
 	.init_machine	= tegra30_dt_init,
 	.init_late	= tegra_init_late,
 	.restart	= tegra_assert_system_reset,
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 91fbe73..da8f5a3 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -55,5 +55,4 @@ static inline int harmony_pcie_init(void) { return 0; }
 
 void __init tegra_paz00_wifikill_init(void);
 
-extern struct sys_timer tegra_sys_timer;
 #endif
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 603be36..a09c598 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
+obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 
 obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
diff --git a/arch/arm/mach-tegra/timer.c b/drivers/clocksource/tegra20_timer.c
similarity index 98%
rename from arch/arm/mach-tegra/timer.c
rename to drivers/clocksource/tegra20_timer.c
index e4863f3..996ceb8 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -1,6 +1,4 @@
 /*
- * arch/arch/mach-tegra/timer.c
- *
  * Copyright (C) 2010 Google, Inc.
  *
  * Author:
@@ -17,6 +15,7 @@
  *
  */
 
+#include <linux/tegra20_timer.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/time.h>
@@ -33,8 +32,6 @@
 #include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
 
-#include "board.h"
-
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
 #define RTC_MILLISECONDS       0x10
@@ -273,7 +270,7 @@ static void __init tegra_init_timer(void)
 	register_persistent_clock(NULL, tegra_read_persistent_clock);
 }
 
-struct sys_timer tegra_sys_timer = {
+struct sys_timer tegra20_sys_timer = {
 	.init = tegra_init_timer,
 };
 
diff --git a/include/linux/tegra20_timer.h b/include/linux/tegra20_timer.h
new file mode 100644
index 0000000..aa9b9c4
--- /dev/null
+++ b/include/linux/tegra20_timer.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __TEGRA20_TIMER_H
+#define __TEGRA20_TIMER_H
+
+#include <asm/mach/time.h>
+
+extern struct sys_timer tegra20_sys_timer;
+
+#endif
-- 
1.7.0.4
