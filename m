From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Aug 2010 16:58:04 +0100
Subject: [PATCH 3/3] ARM: vexpress: add support for CPU hotplug to ct-ca9x4
	tile
In-Reply-To: <1282060684-27761-3-git-send-email-will.deacon@arm.com>
References: <1282060684-27761-1-git-send-email-will.deacon@arm.com>
	<1282060684-27761-2-git-send-email-will.deacon@arm.com>
	<1282060684-27761-3-git-send-email-will.deacon@arm.com>
Message-ID: <1282060684-27761-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express platform can support a quad-core Cortex-A9 tile running
SMP Linux.

This patch adds support for CPU hotplug when running in this configuration.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-vexpress/Makefile   |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c |   43 +++++++++++++++++++++++++++
 arch/arm/mach-vexpress/hotplug.c  |   58 +++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 0 deletions(-)
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
index 6353459..ff350e6 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -9,6 +9,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 
+#include <asm/cacheflush.h>
 #include <asm/clkdev.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/arm_timer.h>
@@ -220,6 +221,48 @@ static struct platform_device pmu_device = {
 	.resource	= pmu_resources,
 };
 
+#ifdef CONFIG_HOTPLUG_CPU
+void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	dsb();
+	asm volatile(
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	dsb\n"
+	/* Disable D-cache */
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, #0x04\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0)
+	  : "memory");
+}
+
+void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	dsb();
+	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, #0x04\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  :
+	  : "memory");
+}
+#endif
+
 static void ct_ca9x4_init(void)
 {
 	int i;
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
new file mode 100644
index 0000000..9fc2476
--- /dev/null
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -0,0 +1,58 @@
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
+#include <plat/hotplug.h>
+
+extern volatile int pen_release;
+
+/* CPU-specific functions implemented in the tile support code */
+extern void cpu_enter_lowpower(void);
+extern void cpu_leave_lowpower(void);
+
+void __ref platform_do_lowpower(unsigned int cpu)
+{
+	cpu_enter_lowpower();
+	/*
+	 * there is no power-control hardware on this platform, so all
+	 * we can do is put the core into WFI; this is safe as the calling
+	 * code will have already disabled interrupts
+	 */
+	for (;;) {
+		/*
+		 * here's the WFI
+		 */
+		asm volatile("wfi" : : : "memory");
+
+		if (pen_release == cpu) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+
+		/*
+		 * getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * The trouble is, letting people know about this is not really
+		 * possible, since we are currently running incoherently, and
+		 * therefore cannot safely call printk() or anything else
+		 */
+#ifdef DEBUG
+		printk("CPU%u: spurious wakeup call\n", cpu);
+#endif
+	}
+	cpu_leave_lowpower();
+}
-- 
1.6.3.3
