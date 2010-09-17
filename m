From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Sep 2010 14:12:04 +0100
Subject: [PATCH 4/4] ARM: vexpress: add support for CPU hotplug to ct-ca9x4
	tile
In-Reply-To: <1284729124-15297-1-git-send-email-will.deacon@arm.com>
References: <1284729124-15297-1-git-send-email-will.deacon@arm.com>
Message-ID: <1284729124-15297-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express platform can support a quad-core Cortex-A9 tile running
SMP Linux.

This patch adds support for CPU hotplug when running in this configuration.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-vexpress/Makefile                   |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   55 +++++++++++++++++++++
 arch/arm/mach-vexpress/hotplug.c                  |   39 +++++++++++++++
 arch/arm/mach-vexpress/include/mach/motherboard.h |    5 ++
 4 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-vexpress/hotplug.c

diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 1b71b77..15a34f0 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -6,3 +6,4 @@ obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index a59ffa8..a8853fa 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -9,6 +9,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 
+#include <asm/cacheflush.h>
 #include <asm/clkdev.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -248,6 +249,55 @@ static void ct_ca9x4_smp_enable(void)
 }
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void ct_ca9x4_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	dsb();
+	asm volatile(
+	/*
+	* Turn off coherency
+	*/
+	"       mrc     p15, 0, %0, c1, c0, 1\n"
+	"       bic     %0, %0, #0x40\n"
+	"       mcr     p15, 0, %0, c1, c0, 1\n"
+	"       dsb\n"
+	/* Disable D-cache */
+	"       mrc     p15, 0, %0, c1, c0, 0\n"
+	"       bic     %0, %0, #0x04\n"
+	"       mcr     p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0)
+	  : "memory");
+	isb();
+}
+
+static void ct_ca9x4_leave_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	dsb();
+	asm volatile(   "mrc    p15, 0, %0, c1, c0, 0\n"
+	"       orr     %0, %0, #0x04\n"
+	"       mcr     p15, 0, %0, c1, c0, 0\n"
+	"       mrc     p15, 0, %0, c1, c0, 1\n"
+	"       orr     %0, %0, #0x40\n"
+	"       mcr     p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  :
+	  : "memory");
+	isb();
+}
+
+static int ct_ca9x4_do_lowpower(void)
+{
+	return -ENODEV;
+}
+#endif
+
 struct ct_desc ct_ca9x4_desc = {
 	.id		= V2M_CT_ID_CA9,
 	.name		= "CA9x4",
@@ -258,4 +308,9 @@ struct ct_desc ct_ca9x4_desc = {
 	.get_core_count	= ct_ca9x4_get_core_count,
 	.smp_enable	= ct_ca9x4_smp_enable,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	.enter_lowpower	= ct_ca9x4_enter_lowpower,
+	.do_lowpower	= ct_ca9x4_do_lowpower,
+	.leave_lowpower	= ct_ca9x4_leave_lowpower,
+#endif
 };
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
new file mode 100644
index 0000000..8c4d46e
--- /dev/null
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -0,0 +1,39 @@
+/*
+ *  linux/arch/arm/mach-vexpress/hotplug.c
+ *
+ *  Copyright (C) 2010 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+
+#include <mach/motherboard.h>
+
+#include <plat/hotplug.h>
+
+extern volatile int pen_release;
+
+void __ref platform_do_lowpower(unsigned int cpu)
+{
+	ct_desc->enter_lowpower();
+
+	for (;;) {
+		if (ct_desc->do_lowpower() == -ENODEV)
+			asm volatile("wfi" : : : "memory");
+
+		if (pen_release == cpu)
+			break;
+
+#ifdef DEBUG
+		printk("CPU%u: spurious wakeup call\n", cpu);
+#endif
+	}
+
+	ct_desc->leave_lowpower();
+}
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 6433ae5..2451947 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -135,6 +135,11 @@ struct ct_desc {
 	unsigned int		(*get_core_count)(void);
 	void			(*smp_enable)(void);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	void			(*enter_lowpower)(void);
+	int			(*do_lowpower)(void);
+	void			(*leave_lowpower)(void);
+#endif
 };
 
 extern struct ct_desc *ct_desc;
-- 
1.7.0.4
