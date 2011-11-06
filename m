From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:40:16 +0000
Subject: [PATCH 01/41] ARM: clps711x: consolidate irq/mm/time code into a
 single file
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6hc-0001Wd-NK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The separate files for clps711x which contain maybe one or two data
structures or functions is an inefficient use of files, and encourages
further small files as other changes happen.  Collapse down these into
a single core.c file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-clps711x/Makefile |    2 +-
 arch/arm/mach-clps711x/common.c |  222 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-clps711x/irq.c    |  143 -------------------------
 arch/arm/mach-clps711x/mm.c     |   48 ---------
 arch/arm/mach-clps711x/time.c   |   84 ---------------
 5 files changed, 223 insertions(+), 276 deletions(-)
 create mode 100644 arch/arm/mach-clps711x/common.c
 delete mode 100644 arch/arm/mach-clps711x/irq.c
 delete mode 100644 arch/arm/mach-clps711x/mm.c
 delete mode 100644 arch/arm/mach-clps711x/time.c

diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index 4a19731..f2f0256 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= irq.o mm.o time.o
+obj-y			:= common.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
new file mode 100644
index 0000000..aa273e7
--- /dev/null
+++ b/arch/arm/mach-clps711x/common.c
@@ -0,0 +1,222 @@
+/*
+ *  linux/arch/arm/mach-clps711x/core.c
+ *
+ *  Core support for the CLPS711x-based machines.
+ *
+ *  Copyright (C) 2001,2011 Deep Blue Solutions Ltd
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
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/timex.h>
+
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <asm/irq.h>
+#include <asm/leds.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/clps7111.h>
+
+/*
+ * This maps the generic CLPS711x registers
+ */
+static struct map_desc clps711x_io_desc[] __initdata = {
+	{
+		.virtual	= CLPS7111_VIRT_BASE,
+		.pfn		= __phys_to_pfn(CLPS7111_PHYS_BASE),
+		.length		= SZ_1M,
+		.type		= MT_DEVICE
+	}
+};
+
+void __init clps711x_map_io(void)
+{
+	iotable_init(clps711x_io_desc, ARRAY_SIZE(clps711x_io_desc));
+}
+
+static void int1_mask(struct irq_data *d)
+{
+	u32 intmr1;
+
+	intmr1 = clps_readl(INTMR1);
+	intmr1 &= ~(1 << d->irq);
+	clps_writel(intmr1, INTMR1);
+}
+
+static void int1_ack(struct irq_data *d)
+{
+	u32 intmr1;
+
+	intmr1 = clps_readl(INTMR1);
+	intmr1 &= ~(1 << d->irq);
+	clps_writel(intmr1, INTMR1);
+
+	switch (d->irq) {
+	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
+	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
+	case IRQ_TC2OI:  clps_writel(0, TC2EOI); break;
+	case IRQ_RTCMI:  clps_writel(0, RTCEOI); break;
+	case IRQ_TINT:   clps_writel(0, TEOI);   break;
+	case IRQ_UMSINT: clps_writel(0, UMSEOI); break;
+	}
+}
+
+static void int1_unmask(struct irq_data *d)
+{
+	u32 intmr1;
+
+	intmr1 = clps_readl(INTMR1);
+	intmr1 |= 1 << d->irq;
+	clps_writel(intmr1, INTMR1);
+}
+
+static struct irq_chip int1_chip = {
+	.irq_ack	= int1_ack,
+	.irq_mask	= int1_mask,
+	.irq_unmask	= int1_unmask,
+};
+
+static void int2_mask(struct irq_data *d)
+{
+	u32 intmr2;
+
+	intmr2 = clps_readl(INTMR2);
+	intmr2 &= ~(1 << (d->irq - 16));
+	clps_writel(intmr2, INTMR2);
+}
+
+static void int2_ack(struct irq_data *d)
+{
+	u32 intmr2;
+
+	intmr2 = clps_readl(INTMR2);
+	intmr2 &= ~(1 << (d->irq - 16));
+	clps_writel(intmr2, INTMR2);
+
+	switch (d->irq) {
+	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
+	}
+}
+
+static void int2_unmask(struct irq_data *d)
+{
+	u32 intmr2;
+
+	intmr2 = clps_readl(INTMR2);
+	intmr2 |= 1 << (d->irq - 16);
+	clps_writel(intmr2, INTMR2);
+}
+
+static struct irq_chip int2_chip = {
+	.irq_ack	= int2_ack,
+	.irq_mask	= int2_mask,
+	.irq_unmask	= int2_unmask,
+};
+
+void __init clps711x_init_irq(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_IRQS; i++) {
+	        if (INT1_IRQS & (1 << i)) {
+	        	irq_set_chip_and_handler(i, &int1_chip,
+						 handle_level_irq);
+	        	set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		}
+		if (INT2_IRQS & (1 << i)) {
+			irq_set_chip_and_handler(i, &int2_chip,
+						 handle_level_irq);
+			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		}			
+	}
+
+	/*
+	 * Disable interrupts
+	 */
+	clps_writel(0, INTMR1);
+	clps_writel(0, INTMR2);
+
+	/*
+	 * Clear down any pending interrupts
+	 */
+	clps_writel(0, COEOI);
+	clps_writel(0, TC1EOI);
+	clps_writel(0, TC2EOI);
+	clps_writel(0, RTCEOI);
+	clps_writel(0, TEOI);
+	clps_writel(0, UMSEOI);
+	clps_writel(0, SYNCIO);
+	clps_writel(0, KBDEOI);
+}
+
+/*
+ * gettimeoffset() returns time since last timer tick, in usecs.
+ *
+ * 'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
+ * 'tick' is usecs per jiffy.
+ */
+static unsigned long clps711x_gettimeoffset(void)
+{
+	unsigned long hwticks;
+	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
+	return (hwticks * (tick_nsec / 1000)) / LATCH;
+}
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t p720t_timer_interrupt(int irq, void *dev_id)
+{
+	timer_tick();
+	return IRQ_HANDLED;
+}
+
+static struct irqaction clps711x_timer_irq = {
+	.name		= "CLPS711x Timer Tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= p720t_timer_interrupt,
+};
+
+static void __init clps711x_timer_init(void)
+{
+	struct timespec tv;
+	unsigned int syscon;
+
+	syscon = clps_readl(SYSCON1);
+	syscon |= SYSCON1_TC2S | SYSCON1_TC2M;
+	clps_writel(syscon, SYSCON1);
+
+	clps_writel(LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
+
+	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
+
+	tv.tv_nsec = 0;
+	tv.tv_sec = clps_readl(RTCDR);
+	do_settimeofday(&tv);
+}
+
+struct sys_timer clps711x_timer = {
+	.init		= clps711x_timer_init,
+	.offset		= clps711x_gettimeoffset,
+};
diff --git a/arch/arm/mach-clps711x/irq.c b/arch/arm/mach-clps711x/irq.c
deleted file mode 100644
index c2eceee..0000000
--- a/arch/arm/mach-clps711x/irq.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- *  linux/arch/arm/mach-clps711x/irq.c
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-#include <linux/list.h>
-#include <linux/io.h>
-
-#include <asm/mach/irq.h>
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#include <asm/hardware/clps7111.h>
-
-static void int1_mask(struct irq_data *d)
-{
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << d->irq);
-	clps_writel(intmr1, INTMR1);
-}
-
-static void int1_ack(struct irq_data *d)
-{
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << d->irq);
-	clps_writel(intmr1, INTMR1);
-
-	switch (d->irq) {
-	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
-	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
-	case IRQ_TC2OI:  clps_writel(0, TC2EOI); break;
-	case IRQ_RTCMI:  clps_writel(0, RTCEOI); break;
-	case IRQ_TINT:   clps_writel(0, TEOI);   break;
-	case IRQ_UMSINT: clps_writel(0, UMSEOI); break;
-	}
-}
-
-static void int1_unmask(struct irq_data *d)
-{
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 |= 1 << d->irq;
-	clps_writel(intmr1, INTMR1);
-}
-
-static struct irq_chip int1_chip = {
-	.irq_ack	= int1_ack,
-	.irq_mask	= int1_mask,
-	.irq_unmask	= int1_unmask,
-};
-
-static void int2_mask(struct irq_data *d)
-{
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (d->irq - 16));
-	clps_writel(intmr2, INTMR2);
-}
-
-static void int2_ack(struct irq_data *d)
-{
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (d->irq - 16));
-	clps_writel(intmr2, INTMR2);
-
-	switch (d->irq) {
-	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
-	}
-}
-
-static void int2_unmask(struct irq_data *d)
-{
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 |= 1 << (d->irq - 16);
-	clps_writel(intmr2, INTMR2);
-}
-
-static struct irq_chip int2_chip = {
-	.irq_ack	= int2_ack,
-	.irq_mask	= int2_mask,
-	.irq_unmask	= int2_unmask,
-};
-
-void __init clps711x_init_irq(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < NR_IRQS; i++) {
-	        if (INT1_IRQS & (1 << i)) {
-	        	irq_set_chip_and_handler(i, &int1_chip,
-						 handle_level_irq);
-	        	set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-		}
-		if (INT2_IRQS & (1 << i)) {
-			irq_set_chip_and_handler(i, &int2_chip,
-						 handle_level_irq);
-			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-		}			
-	}
-
-	/*
-	 * Disable interrupts
-	 */
-	clps_writel(0, INTMR1);
-	clps_writel(0, INTMR2);
-
-	/*
-	 * Clear down any pending interrupts
-	 */
-	clps_writel(0, COEOI);
-	clps_writel(0, TC1EOI);
-	clps_writel(0, TC2EOI);
-	clps_writel(0, RTCEOI);
-	clps_writel(0, TEOI);
-	clps_writel(0, UMSEOI);
-	clps_writel(0, SYNCIO);
-	clps_writel(0, KBDEOI);
-}
diff --git a/arch/arm/mach-clps711x/mm.c b/arch/arm/mach-clps711x/mm.c
deleted file mode 100644
index 9865921..0000000
--- a/arch/arm/mach-clps711x/mm.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *  linux/arch/arm/mach-clps711x/mm.c
- *
- *  Generic MM setup for the CLPS711x-based machines.
- *
- *  Copyright (C) 2001 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-
-#include <asm/sizes.h>
-#include <mach/hardware.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <asm/mach/map.h>
-#include <asm/hardware/clps7111.h>
-
-/*
- * This maps the generic CLPS711x registers
- */
-static struct map_desc clps711x_io_desc[] __initdata = {
-	{
-		.virtual	= CLPS7111_VIRT_BASE,
-		.pfn		= __phys_to_pfn(CLPS7111_PHYS_BASE),
-		.length		= SZ_1M,
-		.type		= MT_DEVICE
-	}
-};
-
-void __init clps711x_map_io(void)
-{
-	iotable_init(clps711x_io_desc, ARRAY_SIZE(clps711x_io_desc));
-}
diff --git a/arch/arm/mach-clps711x/time.c b/arch/arm/mach-clps711x/time.c
deleted file mode 100644
index d581ef0..0000000
--- a/arch/arm/mach-clps711x/time.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- *  linux/arch/arm/mach-clps711x/time.c
- *
- *  Copyright (C) 2001 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/timex.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/leds.h>
-#include <asm/hardware/clps7111.h>
-
-#include <asm/mach/time.h>
-
-
-/*
- * gettimeoffset() returns time since last timer tick, in usecs.
- *
- * 'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
- * 'tick' is usecs per jiffy.
- */
-static unsigned long clps711x_gettimeoffset(void)
-{
-	unsigned long hwticks;
-	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
-	return (hwticks * (tick_nsec / 1000)) / LATCH;
-}
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t
-p720t_timer_interrupt(int irq, void *dev_id)
-{
-	timer_tick();
-	return IRQ_HANDLED;
-}
-
-static struct irqaction clps711x_timer_irq = {
-	.name		= "CLPS711x Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= p720t_timer_interrupt,
-};
-
-static void __init clps711x_timer_init(void)
-{
-	struct timespec tv;
-	unsigned int syscon;
-
-	syscon = clps_readl(SYSCON1);
-	syscon |= SYSCON1_TC2S | SYSCON1_TC2M;
-	clps_writel(syscon, SYSCON1);
-
-	clps_writel(LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
-
-	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = clps_readl(RTCDR);
-	do_settimeofday(&tv);
-}
-
-struct sys_timer clps711x_timer = {
-	.init		= clps711x_timer_init,
-	.offset		= clps711x_gettimeoffset,
-};
-- 
1.7.4.4
