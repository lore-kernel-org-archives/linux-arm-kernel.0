From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 24 Jul 2013 16:35:22 -0700
Subject: [PATCH v2 1/2] ARM: bcm281xx: Board specific reboot code
In-Reply-To: <1374708923-11956-1-git-send-email-markus.mayer@linaro.org>
References: <1374708923-11956-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1374708923-11956-2-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the code needed to trigger a reboot on the bcm281xx
family.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Alex Elder <alex.elder@linaro.org>
Acked-by: Christian Daudt <csd@broadcom.com>
---
 arch/arm/mach-bcm/Makefile    |    4 +--
 arch/arm/mach-bcm/board_bcm.c |   20 +++++++++++--
 arch/arm/mach-bcm/kona.c      |   65 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/kona.h      |   17 +++++++++++
 4 files changed, 101 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-bcm/kona.c
 create mode 100644 arch/arm/mach-bcm/kona.h

diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 6adb6aec..7e5ca0a 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2012 Broadcom Corporation
+# Copyright (C) 2012-2013 Broadcom Corporation
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -10,6 +10,6 @@
 # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-obj-$(CONFIG_ARCH_BCM)		:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
+obj-$(CONFIG_ARCH_BCM)	:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o kona.o
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
index 2859932..1e49ec0 100644
--- a/arch/arm/mach-bcm/board_bcm.c
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012 Broadcom Corporation
+ * Copyright (C) 2012-2013 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -21,8 +21,8 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
 
-
 #include "bcm_kona_smc.h"
+#include "kona.h"
 
 static int __init kona_l2_cache_init(void)
 {
@@ -40,13 +40,26 @@ static int __init kona_l2_cache_init(void)
 	return 0;
 }
 
+static void bcm_board_setup_restart(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "bcm,bcm11351");
+	if (np) {
+		if (of_device_is_available(np))
+			bcm_kona_setup_restart();
+		of_node_put(np);
+	}
+	/* Restart setup for other boards goes here */
+}
+
 static void __init board_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL,
 		&platform_bus);
 
 	bcm_kona_smc_init();
-
+	bcm_board_setup_restart();
 	kona_l2_cache_init();
 }
 
@@ -55,5 +68,6 @@ static const char * const bcm11351_dt_compat[] = { "bcm,bcm11351", NULL, };
 DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
 	.init_time = clocksource_of_init,
 	.init_machine = board_init,
+	.restart = bcm_kona_restart,
 	.dt_compat = bcm11351_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-bcm/kona.c b/arch/arm/mach-bcm/kona.c
new file mode 100644
index 0000000..6939d90
--- /dev/null
+++ b/arch/arm/mach-bcm/kona.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2013 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of_address.h>
+#include <asm/io.h>
+
+#include "kona.h"
+
+static void __iomem *watchdog_base;
+
+void bcm_kona_setup_restart(void)
+{
+	struct device_node *np_wdog;
+
+	/*
+	 * The assumption is that whoever calls bcm_kona_setup_restart()
+	 * also needs a Kona Watchdog Timer entry in Device Tree, i.e. we
+	 * report an error if the DT entry is missing.
+	 */
+	np_wdog = of_find_compatible_node(NULL, NULL, "brcm,kona-wdt");
+	if (!np_wdog) {
+		pr_err("brcm,kona-wdt not found in DT, reboot disabled\n");
+		return;
+	}
+	watchdog_base = of_iomap(np_wdog, 0);
+	WARN(!watchdog_base, "failed to map watchdog base");
+	of_node_put(np_wdog);
+}
+
+#define SECWDOG_OFFSET			0x00000000
+#define SECWDOG_RESERVED_MASK		0xE2000000
+#define SECWDOG_WD_LOAD_FLAG_MASK	0x10000000
+#define SECWDOG_EN_MASK			0x08000000
+#define SECWDOG_SRSTEN_MASK		0x04000000
+#define SECWDOG_CLKS_SHIFT		20
+#define SECWDOG_LOCK_SHIFT		0
+
+void bcm_kona_restart(enum reboot_mode mode, const char *cmd)
+{
+	uint32_t val;
+
+	if (!watchdog_base)
+		panic("Watchdog not mapped. Reboot failed.\n");
+
+	/* Enable watchdog2 with very short timeout. */
+	val = readl(watchdog_base + SECWDOG_OFFSET);
+	val &= SECWDOG_RESERVED_MASK | SECWDOG_WD_LOAD_FLAG_MASK;
+	val |= SECWDOG_EN_MASK | SECWDOG_SRSTEN_MASK |
+		(0x8 << SECWDOG_CLKS_SHIFT) |
+		(0x8 << SECWDOG_LOCK_SHIFT);
+	writel(val, watchdog_base + SECWDOG_OFFSET);
+
+	while (1)
+		;
+}
diff --git a/arch/arm/mach-bcm/kona.h b/arch/arm/mach-bcm/kona.h
new file mode 100644
index 0000000..291eca3
--- /dev/null
+++ b/arch/arm/mach-bcm/kona.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2013 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/reboot.h>
+
+void bcm_kona_setup_restart(void);
+void bcm_kona_restart(enum reboot_mode mode, const char *cmd);
-- 
1.7.9.5
