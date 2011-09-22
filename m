From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:46:25 +0200
Subject: [PATCH 2/7] clocksource: add DBX500 PRCMU Timer support
Message-ID: <1316699185-21292-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mattias Wallin <mattias.wallin@stericsson.com>

This patch adds the DBX500 PRCMU Timer driver as a clocksource
and as sched_clock.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/Kconfig               |   15 ++++
 drivers/clocksource/Makefile              |    1 +
 drivers/clocksource/clksrc-dbx500-prcmu.c |  104 +++++++++++++++++++++++++++++
 include/linux/clksrc-dbx500-prcmu.h       |   22 ++++++
 4 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clocksource/clksrc-dbx500-prcmu.c
 create mode 100644 include/linux/clksrc-dbx500-prcmu.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 34e9c4f..999d6a0 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -15,3 +15,18 @@ config CLKSRC_MMIO
 
 config DW_APB_TIMER
 	bool
+
+config CLKSRC_DBX500_PRCMU
+	bool "Clocksource PRCMU Timer"
+	depends on UX500_SOC_DB5500 || UX500_SOC_DB8500
+	default y
+	help
+	  Use the always on PRCMU Timer as clocksource
+
+config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
+	bool "Clocksource PRCMU Timer sched_clock"
+	depends on (CLKSRC_DBX500_PRCMU && !NOMADIK_MTU_SCHED_CLOCK)
+	select HAVE_SCHED_CLOCK
+	default y
+	help
+	  Use the always on PRCMU Timer as sched_clock
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 85ad1646..8d81a1d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
+obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
\ No newline at end of file
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
new file mode 100644
index 0000000..0ac5093
--- /dev/null
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
+ * Author: Sundar Iyer for ST-Ericsson
+ * sched_clock implementation is based on:
+ * plat-nomadik/timer.c Linus Walleij <linus.walleij@stericsson.com>
+ *
+ * DBx500-PRCMU Timer
+ * The PRCMU has 5 timers which are available in a always-on
+ * power domain.  We use the Timer 4 for our always-on clock
+ * source on DB8500 and Timer 3 on DB5500.
+ */
+#include <linux/clockchips.h>
+#include <linux/clksrc-dbx500-prcmu.h>
+
+#include <asm/sched_clock.h>
+
+#include <mach/setup.h>
+#include <mach/hardware.h>
+
+#define RATE_32K		32768
+
+#define TIMER_MODE_CONTINOUS	0x1
+#define TIMER_DOWNCOUNT_VAL	0xffffffff
+
+#define PRCMU_TIMER_REF		0
+#define PRCMU_TIMER_DOWNCOUNT	0x4
+#define PRCMU_TIMER_MODE	0x8
+
+#define SCHED_CLOCK_MIN_WRAP 131072 /* 2^32 / 32768 */
+
+void __iomem *clksrc_dbx500_timer_base;
+
+static cycle_t clksrc_dbx500_prcmu_read(struct clocksource *cs)
+{
+	u32 count, count2;
+
+	do {
+		count = readl(clksrc_dbx500_timer_base +
+			      PRCMU_TIMER_DOWNCOUNT);
+		count2 = readl(clksrc_dbx500_timer_base +
+			       PRCMU_TIMER_DOWNCOUNT);
+	} while (count2 != count);
+
+	/* Negate because the timer is a decrementing counter */
+	return ~count;
+}
+
+static struct clocksource clocksource_dbx500_prcmu = {
+	.name		= "dbx500-prcmu-timer",
+	.rating		= 300,
+	.read		= clksrc_dbx500_prcmu_read,
+	.shift		= 10,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+#ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
+static DEFINE_CLOCK_DATA(cd);
+
+unsigned long long notrace sched_clock(void)
+{
+	u32 cyc;
+
+	if (unlikely(!clksrc_dbx500_timer_base))
+		return 0;
+
+	cyc = clksrc_dbx500_prcmu_read(&clocksource_dbx500_prcmu);
+
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+static void notrace clksrc_dbx500_prcmu_update_sched_clock(void)
+{
+	u32 cyc = clksrc_dbx500_prcmu_read(&clocksource_dbx500_prcmu);
+	update_sched_clock(&cd, cyc, (u32)~0);
+}
+#endif
+
+void __init clksrc_dbx500_prcmu_init(void)
+{
+	/*
+	 * The A9 sub system expects the timer to be configured as
+	 * a continous looping timer.
+	 * The PRCMU should configure it but if it for some reason
+	 * don't we do it here.
+	 */
+	if (readl(clksrc_dbx500_timer_base + PRCMU_TIMER_MODE) !=
+	    TIMER_MODE_CONTINOUS) {
+		writel(TIMER_MODE_CONTINOUS,
+		       clksrc_dbx500_timer_base + PRCMU_TIMER_MODE);
+		writel(TIMER_DOWNCOUNT_VAL,
+		       clksrc_dbx500_timer_base + PRCMU_TIMER_REF);
+	}
+#ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
+	init_sched_clock(&cd, clksrc_dbx500_prcmu_update_sched_clock,
+			 32, RATE_32K);
+#endif
+	clocksource_calc_mult_shift(&clocksource_dbx500_prcmu,
+				    RATE_32K, SCHED_CLOCK_MIN_WRAP);
+	clocksource_register(&clocksource_dbx500_prcmu);
+}
diff --git a/include/linux/clksrc-dbx500-prcmu.h b/include/linux/clksrc-dbx500-prcmu.h
new file mode 100644
index 0000000..d1e9504
--- /dev/null
+++ b/include/linux/clksrc-dbx500-prcmu.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * License Terms: GNU General Public License v2
+ * Author: Mattias Wallin <mattias.wallin@stericsson.com>
+ *
+ */
+#ifndef __CLKSRC_DBX500_PRCMU_H
+#define __CLKSRC_DBX500_PRCMU_H
+
+#include <linux/init.h>
+#include <linux/io.h>
+
+extern void __iomem *clksrc_dbx500_timer_base;
+
+#ifdef CONFIG_CLKSRC_DBX500_PRCMU
+void __init clksrc_dbx500_prcmu_init(void);
+#else
+void __init clksrc_dbx500_prcmu_init(void) {}
+#endif
+
+#endif
-- 
1.7.3.2
