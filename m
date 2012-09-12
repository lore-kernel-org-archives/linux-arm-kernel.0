From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 22:18:28 -0600
Subject: [PATCH V3 4/5] ARM: bcm2708: add stub clock driver
In-Reply-To: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347423509-30647-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Arlott <simon@fire.lp0.eu>

This patch adds a minimal stub clock driver for the BCM2708. Its sole
purpose is to allow the PL011 AMBA clk_get() API calls to provide
something that looks enough like a clock that the driver probes and
operates correctly.

This patch was extracted from git://github.com/lp0/linux.git branch
rpi-split as of 2012/09/08, and modified as follows:

* Modified .dev_id for UART clocks to match UART DT node names.

Signed-off-by: Chris Boot <bootc@bootc.net>
Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dom Cobley <dc4@broadcom.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
--
v3: New patch.
---
 arch/arm/mach-bcm2708/Makefile  |    1 +
 arch/arm/mach-bcm2708/bcm2708.c |    3 +++
 arch/arm/mach-bcm2708/clock.c   |   53 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm2708/clock.h   |   24 ++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 arch/arm/mach-bcm2708/clock.c
 create mode 100644 arch/arm/mach-bcm2708/clock.h

diff --git a/arch/arm/mach-bcm2708/Makefile b/arch/arm/mach-bcm2708/Makefile
index 597f811..4902453 100644
--- a/arch/arm/mach-bcm2708/Makefile
+++ b/arch/arm/mach-bcm2708/Makefile
@@ -1,2 +1,3 @@
 obj-y += bcm2708.o
+obj-y += clock.o
 obj-y += irq.o
diff --git a/arch/arm/mach-bcm2708/bcm2708.c b/arch/arm/mach-bcm2708/bcm2708.c
index 8ee11d9..05a3fc1 100644
--- a/arch/arm/mach-bcm2708/bcm2708.c
+++ b/arch/arm/mach-bcm2708/bcm2708.c
@@ -22,6 +22,7 @@
 
 #include <mach/bcm2708_soc.h>
 
+#include "clock.h"
 #include "irq.h"
 
 static struct map_desc io_map __initdata = {
@@ -40,6 +41,8 @@ void __init bcm2708_init(void)
 {
 	int ret;
 
+	bcm2708_init_clocks();
+
 	ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
 				   NULL);
 	if (ret) {
diff --git a/arch/arm/mach-bcm2708/clock.c b/arch/arm/mach-bcm2708/clock.c
new file mode 100644
index 0000000..83b26ec
--- /dev/null
+++ b/arch/arm/mach-bcm2708/clock.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2010 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-private.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+#include "clock.h"
+
+/*
+ * These are fixed clocks (and device tree doesn't support clk!).
+ *
+ * They're probably not all root clocks and it may be possible to
+ * turn them on and off but until this is mapped out better it's
+ * the only way they can be used.
+ */
+DEFINE_CLK_FIXED_RATE(sys_pclk,   CLK_IS_ROOT, 250000000, 0);
+DEFINE_CLK_FIXED_RATE(apb_pclk,   CLK_IS_ROOT, 126000000, 0);
+DEFINE_CLK_FIXED_RATE(uart0_pclk, CLK_IS_ROOT,   3000000, 0);
+DEFINE_CLK_FIXED_RATE(uart1_pclk, CLK_IS_ROOT, 125000000, 0);
+
+static struct clk_lookup lookups[] = {
+	{ .con_id = "sys_pclk", .clk = &sys_pclk },
+	{ .con_id = "apb_pclk", .clk = &apb_pclk },
+	{ .dev_id = "20201000.uart", .clk = &uart0_pclk },
+	{ .dev_id = "20215000.uart", .clk = &uart1_pclk }
+};
+
+void __init bcm2708_init_clocks(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lookups); i++) {
+		__clk_init(NULL, lookups[i].clk);
+		clkdev_add(&lookups[i]);
+	}
+}
diff --git a/arch/arm/mach-bcm2708/clock.h b/arch/arm/mach-bcm2708/clock.h
new file mode 100644
index 0000000..8670060
--- /dev/null
+++ b/arch/arm/mach-bcm2708/clock.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2010 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __BCM2708_CLOCK_H
+#define __BCM2708_CLOCK_H
+
+void __init bcm2708_init_clocks(void);
+
+#endif
-- 
1.7.9.5
