From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Oct 2015 11:22:08 -0500
Subject: [PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Message-ID: <1445012530-14126-10-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new clocksource driver for Texas
Instruments 32.768 Hz device which is available
on most OMAP-like devices.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel at vger.kernel.org
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/clocksource/Kconfig        |   7 +++
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-ti-32k.c | 126 +++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/clocksource/timer-ti-32k.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a7726db13abb..98b2a9b9bfad 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -115,6 +115,13 @@ config CLKSRC_PISTACHIO
 	bool
 	select CLKSRC_OF
 
+config CLKSRC_TI_32K
+	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
+	select CLKSRC_OF if OF
+	help
+	  This option enables support for Texas Instruments 32.768 Hz clocksource
+	  available on many OMAP-like platforms.
+
 config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
 	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5c00863c3e33..749abc3665b3 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
 obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
 obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
+obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
new file mode 100644
index 000000000000..8518d9dfba5c
--- /dev/null
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -0,0 +1,126 @@
+/**
+ * timer-ti-32k.c - OMAP2 32k Timer Support
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * Update to use new clocksource/clockevent layers
+ * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
+ * Copyright (C) 2007 MontaVista Software, Inc.
+ *
+ * Original driver:
+ * Copyright (C) 2005 Nokia Corporation
+ * Author: Paul Mundt <paul.mundt@nokia.com>
+ *         Juha Yrj?l? <juha.yrjola@nokia.com>
+ * OMAP Dual-mode timer framework support by Timo Teras
+ *
+ * Some parts based off of TI's 24xx code:
+ *
+ * Copyright (C) 2004-2009 Texas Instruments, Inc.
+ *
+ * Roughly modelled after the OMAP1 MPU timer code.
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/sched_clock.h>
+#include <linux/clocksource.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+/*
+ * 32KHz clocksource ... always available, on pretty most chips except
+ * OMAP 730 and 1510.  Other timers could be used as clocksources, with
+ * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
+ * but systems won't necessarily want to spend resources that way.
+ */
+
+#define OMAP2_32KSYNCNT_REV_OFF		0x0
+#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
+#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
+#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
+
+struct ti_32k {
+	void __iomem		*base;
+	void __iomem		*counter;
+	struct clocksource	cs;
+};
+
+static inline struct ti_32k *to_ti_32k(struct clocksource *cs)
+{
+	return container_of(cs, struct ti_32k, cs);
+}
+
+static cycle_t ti_32k_read_cycles(struct clocksource *cs)
+{
+	struct ti_32k *ti = to_ti_32k(cs);
+
+	return (cycle_t)readl_relaxed(ti->counter);
+}
+
+static struct ti_32k ti_32k_timer = {
+	.cs = {
+		.name		= "32k_counter",
+		.rating		= 250,
+		.read		= ti_32k_read_cycles,
+		.mask		= CLOCKSOURCE_MASK(32),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
+				CLOCK_SOURCE_SUSPEND_NONSTOP,
+	},
+};
+
+static u64 notrace omap_32k_read_sched_clock(void)
+{
+	return ti_32k_read_cycles(&ti_32k_timer.cs);
+}
+
+static void __init ti_32k_timer_init(struct device_node *np)
+{
+	int ret;
+
+	ti_32k_timer.base = of_iomap(np, 0);
+	if (!ti_32k_timer.base) {
+		pr_err("Can't ioremap 32k timer base\n");
+		return;
+	}
+
+	ti_32k_timer.counter = ti_32k_timer.base;
+
+	/*
+	 * 32k sync Counter IP register offsets vary between the highlander
+	 * version and the legacy ones.
+	 *
+	 * The 'SCHEME' bits(30-31) of the revision register is used to identify
+	 * the version.
+	 */
+	if (readl_relaxed(ti_32k_timer.base + OMAP2_32KSYNCNT_REV_OFF) &
+			OMAP2_32KSYNCNT_REV_SCHEME)
+		ti_32k_timer.counter += OMAP2_32KSYNCNT_CR_OFF_HIGH;
+	else
+		ti_32k_timer.counter += OMAP2_32KSYNCNT_CR_OFF_LOW;
+
+	ret = clocksource_register_hz(&ti_32k_timer.cs, 32768);
+	if (ret) {
+		pr_err("32k_counter: can't register clocksource\n");
+		return;
+	}
+
+	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
+	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
+}
+CLOCKSOURCE_OF_DECLARE(ti_32k_timer, "ti,omap-counter32k",
+		ti_32k_timer_init);
-- 
2.5.3
