From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 21 Aug 2012 20:59:35 +0400
Subject: [PATCH 4/4] ARM: clps711x: Added simple clock framework
In-Reply-To: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
References: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
Message-ID: <1345568375-28516-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
This patch adds simple clock framework for handling all possible CPU rates.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                            |    2 +
 arch/arm/mach-clps711x/common.c             |   89 ++++++++++++++++++++++-----
 arch/arm/mach-clps711x/include/mach/timex.h |   23 +-------
 3 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6d6e18f..2b23202 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -384,6 +384,8 @@ config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select CPU_ARM720T
 	select ARCH_USES_GETTIMEOFFSET
+	select COMMON_CLK
+	select CLKDEV_LOOKUP
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index f15293b..5f25ea3 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -19,24 +19,25 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/kernel.h>
-#include <linux/mm.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/sched.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 
 #include <asm/sizes.h>
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/leds.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
 
+#include <mach/hardware.h>
+
+static struct clk *clk_pll, *clk_bus, *clk_uart, *clk_timerl, *clk_timerh,
+		  *clk_tint, *clk_spi;
+static unsigned long latch;
+
 /*
  * This maps the generic CLPS711x registers
  */
@@ -166,8 +167,8 @@ void __init clps711x_init_irq(void)
 static unsigned long clps711x_gettimeoffset(void)
 {
 	unsigned long hwticks;
-	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
-	return (hwticks * (tick_nsec / 1000)) / LATCH;
+	hwticks = latch - (clps_readl(TC2D) & 0xffff);
+	return (hwticks * (tick_nsec / 1000)) / latch;
 }
 
 /*
@@ -185,15 +186,71 @@ static struct irqaction clps711x_timer_irq = {
 	.handler	= p720t_timer_interrupt,
 };
 
+static void add_fixed_clk(struct clk *clk, const char *name, int rate)
+{
+	clk = clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
+	clk_register_clkdev(clk, name, NULL);
+}
+
 static void __init clps711x_timer_init(void)
 {
-	unsigned int syscon;
+	int osc, ext, pll, cpu, bus, timl, timh, uart, spi;
+	u32 tmp;
+
+	osc = 3686400;
+	ext = 13000000;
+
+	tmp = clps_readl(PLLR) >> 24;
+	if (tmp)
+		pll = (osc * tmp) / 2;
+	else
+		pll = 73728000; /* Default value */
+
+	tmp = clps_readl(SYSFLG2);
+	if (tmp & SYSFLG2_CKMODE) {
+		cpu = ext;
+		bus = cpu;
+		spi = 135400;
+	} else {
+		cpu = pll;
+		if (cpu >= 36864000)
+			bus = cpu / 2;
+		else
+			bus = 36864000 / 2;
+		spi = cpu / 576;
+	}
+
+	uart = bus / 10;
+
+	if (tmp & SYSFLG2_CKMODE) {
+		tmp = clps_readl(SYSCON2);
+		if (tmp & SYSCON2_OSTB)
+			timh = ext / 26;
+		else
+			timh = 541440;
+	} else
+		timh = cpu / 144;
+
+	timl = timh / 256;
+
+	/* All clocks are fixed */
+	add_fixed_clk(clk_pll, "pll", pll);
+	add_fixed_clk(clk_bus, "bus", bus);
+	add_fixed_clk(clk_uart, "uart", uart);
+	add_fixed_clk(clk_timerl, "timer_lf", timl);
+	add_fixed_clk(clk_timerh, "timer_hf", timh);
+	add_fixed_clk(clk_tint, "tint", 64);
+	add_fixed_clk(clk_spi, "spi", spi);
+
+	pr_info("CPU frequency set at %i Hz.\n", cpu);
+
+	latch = (timh + HZ / 2) / HZ;
 
-	syscon = clps_readl(SYSCON1);
-	syscon |= SYSCON1_TC2S | SYSCON1_TC2M;
-	clps_writel(syscon, SYSCON1);
+	tmp = clps_readl(SYSCON1);
+	tmp |= SYSCON1_TC2S | SYSCON1_TC2M;
+	clps_writel(tmp, SYSCON1);
 
-	clps_writel(LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
+	clps_writel(latch - 1, TC2D);
 
 	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
 }
diff --git a/arch/arm/mach-clps711x/include/mach/timex.h b/arch/arm/mach-clps711x/include/mach/timex.h
index ac8823c..de6fd19 100644
--- a/arch/arm/mach-clps711x/include/mach/timex.h
+++ b/arch/arm/mach-clps711x/include/mach/timex.h
@@ -1,23 +1,2 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/timex.h
- *
- *  Prospector 720T architecture timex specifications
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
-
+/* Bogus value */
 #define CLOCK_TICK_RATE 512000
-- 
1.7.8.6
