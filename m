From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 16 Jul 2012 22:21:48 +0400
Subject: [PATCH 4/4] ARM: clps711x: Added simple clkdev framework
In-Reply-To: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
References: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
Message-ID: <1342462908-18547-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
This patch adds simple clkdev framework for handling all possible CPU rates.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-clps711x/common.c             |  104 +++++++++++++++++++++++++--
 arch/arm/mach-clps711x/include/mach/timex.h |   23 +------
 drivers/tty/serial/clps711x.c               |   19 ++++-
 4 files changed, 115 insertions(+), 32 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..fc2b454 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -361,6 +361,7 @@ config ARCH_HIGHBANK
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select CPU_ARM720T
+	select CLKDEV_LOOKUP
 	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
 	help
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index f15293b..daab6bf 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -26,6 +26,9 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/sched.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/module.h>
 
 #include <asm/sizes.h>
 #include <mach/hardware.h>
@@ -37,6 +40,52 @@
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
 
+struct clk {
+	unsigned long rate;
+};
+
+static struct clk rtc_clk;
+static struct clk osc_clk;
+static struct clk ext_clk;
+static struct clk pll_clk;
+static struct clk cpu_clk;
+static struct clk bus_clk;
+static struct clk uart_clk;
+static struct clk timer_h_clk;
+static struct clk timer_l_clk;
+
+static unsigned long latch;
+
+/* Enable and Disable do nothing */
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+static struct clk_lookup clps711x_lookups[] = {
+	CLKDEV_INIT( NULL, "rtc", &rtc_clk),
+	CLKDEV_INIT( NULL, "osc", &pll_clk),
+	CLKDEV_INIT( NULL, "ext", &ext_clk),
+	CLKDEV_INIT( NULL, "pll", &pll_clk),
+	CLKDEV_INIT( NULL, "cpu", &cpu_clk),
+	CLKDEV_INIT( NULL, "bus", &bus_clk),
+	CLKDEV_INIT( NULL, "uart", &uart_clk),
+	CLKDEV_INIT( NULL, "timer_h", &timer_h_clk),
+	CLKDEV_INIT( NULL, "timer_l", &timer_l_clk),
+};
+
 /*
  * This maps the generic CLPS711x registers
  */
@@ -166,8 +215,8 @@ void __init clps711x_init_irq(void)
 static unsigned long clps711x_gettimeoffset(void)
 {
 	unsigned long hwticks;
-	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
-	return (hwticks * (tick_nsec / 1000)) / LATCH;
+	hwticks = latch - (clps_readl(TC2D) & 0xffff);
+	return (hwticks * (tick_nsec / 1000)) / latch;
 }
 
 /*
@@ -187,13 +236,54 @@ static struct irqaction clps711x_timer_irq = {
 
 static void __init clps711x_timer_init(void)
 {
-	unsigned int syscon;
+	u32 tmp;
+
+	rtc_clk.rate = 32768;
+	osc_clk.rate = 3686400;
+	ext_clk.rate = 13000000;
+
+	tmp = clps_readl(PLLR) >> 24;
+	if (tmp)
+		pll_clk.rate = (osc_clk.rate * tmp) / 2;
+	else
+		pll_clk.rate = 73728000; /* Default value */
+
+	tmp = clps_readl(SYSFLG2);
+	if (tmp & SYSFLG2_CKMODE) {
+		cpu_clk.rate = ext_clk.rate;
+		bus_clk.rate = cpu_clk.rate;
+	} else {
+		cpu_clk.rate = pll_clk.rate;
+		if (cpu_clk.rate >= 36864000)
+			bus_clk.rate = cpu_clk.rate / 2;
+		else
+			bus_clk.rate = 36864000 / 2;
+	}
+
+	uart_clk.rate = bus_clk.rate / 10;
+
+	if (tmp & SYSFLG2_CKMODE) {
+		tmp = clps_readl(SYSCON2);
+		if (tmp & SYSCON2_OSTB)
+			timer_h_clk.rate = ext_clk.rate / 26; /* 500 kHz */
+		else
+			timer_h_clk.rate = 541440;
+	} else
+		timer_h_clk.rate = cpu_clk.rate / 144;
+
+	timer_l_clk.rate = timer_h_clk.rate / 256;
+
+	latch = (timer_h_clk.rate + HZ / 2) / HZ;
+
+	clkdev_add_table(clps711x_lookups, ARRAY_SIZE(clps711x_lookups));
+
+	pr_info("CPU frequency set at %lu Hz.\n", cpu_clk.rate);
 
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
index ac8823c..3d98736 100644
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
+/* Bugus value */
 #define CLOCK_TICK_RATE 512000
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index d0f719f..d9f4983 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -37,6 +37,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -401,7 +402,6 @@ static struct uart_port clps711x_ports[UART_NR] = {
 	{
 		.iobase		= SYSCON1,
 		.irq		= IRQ_UTXINT1, /* IRQ_URXINT1, IRQ_UMSINT */
-		.uartclk	= 3686400,
 		.fifosize	= 16,
 		.ops		= &clps711x_pops,
 		.line		= 0,
@@ -410,7 +410,6 @@ static struct uart_port clps711x_ports[UART_NR] = {
 	{
 		.iobase		= SYSCON2,
 		.irq		= IRQ_UTXINT2, /* IRQ_URXINT2 */
-		.uartclk	= 3686400,
 		.fifosize	= 16,
 		.ops		= &clps711x_pops,
 		.line		= 1,
@@ -418,6 +417,17 @@ static struct uart_port clps711x_ports[UART_NR] = {
 	}
 };
 
+static unsigned long clps711xuart_get_uartclk(void)
+{
+	struct clk *uart_clk;
+
+	uart_clk = clk_get(NULL, "uart");
+	if (!IS_ERR(uart_clk))
+		return clk_get_rate(uart_clk);
+
+	return 3686400; /* Default value */
+}
+
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
 static void clps711xuart_console_putchar(struct uart_port *port, int ch)
 {
@@ -501,6 +511,7 @@ static int __init clps711xuart_console_setup(struct console *co, char *options)
 	 * console support.
 	 */
 	port = uart_get_console(clps711x_ports, UART_NR, co);
+	port->uartclk = clps711xuart_get_uartclk();
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -553,8 +564,10 @@ static int __init clps711xuart_init(void)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < UART_NR; i++)
+	for (i = 0; i < UART_NR; i++) {
+		clps711x_ports[i].uartclk = clps711xuart_get_uartclk();
 		uart_add_one_port(&clps711x_reg, &clps711x_ports[i]);
+	}
 
 	return 0;
 }
-- 
1.7.3.4
