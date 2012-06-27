From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 27 Jun 2012 08:50:06 -0500
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's SOCFPGA
 platform.
In-Reply-To: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
Message-ID: <1340805007-3313-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Adding core definitions for Altera's SOCFPGA ARM platform.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 MAINTAINERS                                        |    5 +
 arch/arm/Kconfig                                   |   19 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-socfpga/Kconfig                      |   21 ++
 arch/arm/mach-socfpga/Makefile                     |    8 +
 arch/arm/mach-socfpga/Makefile.boot                |    3 +
 arch/arm/mach-socfpga/clock.c                      |   50 ++++
 arch/arm/mach-socfpga/common.c                     |  156 ++++++++++
 arch/arm/mach-socfpga/common.h                     |   38 +++
 arch/arm/mach-socfpga/dw_apb_timer.c               |  164 +++++++++++
 arch/arm/mach-socfpga/headsmp.S                    |   41 +++
 arch/arm/mach-socfpga/hotplug.c                    |  125 ++++++++
 arch/arm/mach-socfpga/include/mach/clock.h         |   11 +
 arch/arm/mach-socfpga/include/mach/debug-macro.S   |   29 ++
 arch/arm/mach-socfpga/include/mach/dw_apb_timer.h  |   38 +++
 arch/arm/mach-socfpga/include/mach/io.h            |   27 ++
 arch/arm/mach-socfpga/include/mach/iomap.h         |   37 +++
 arch/arm/mach-socfpga/include/mach/irqs.h          |  305 ++++++++++++++++++++
 arch/arm/mach-socfpga/include/mach/memory.h        |   32 ++
 arch/arm/mach-socfpga/include/mach/smp.h           |   15 +
 arch/arm/mach-socfpga/include/mach/socfpga-timer.h |   27 ++
 arch/arm/mach-socfpga/include/mach/system.h        |   31 ++
 arch/arm/mach-socfpga/include/mach/timex.h         |   19 ++
 arch/arm/mach-socfpga/include/mach/uncompress.h    |   44 +++
 arch/arm/mach-socfpga/localtimer.c                 |   34 +++
 arch/arm/mach-socfpga/platsmp.c                    |  154 ++++++++++
 arch/arm/mm/Kconfig                                |    2 +-
 27 files changed, 1435 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-socfpga/Kconfig
 create mode 100644 arch/arm/mach-socfpga/Makefile
 create mode 100644 arch/arm/mach-socfpga/Makefile.boot
 create mode 100644 arch/arm/mach-socfpga/clock.c
 create mode 100644 arch/arm/mach-socfpga/common.c
 create mode 100644 arch/arm/mach-socfpga/common.h
 create mode 100644 arch/arm/mach-socfpga/dw_apb_timer.c
 create mode 100644 arch/arm/mach-socfpga/headsmp.S
 create mode 100644 arch/arm/mach-socfpga/hotplug.c
 create mode 100644 arch/arm/mach-socfpga/include/mach/clock.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-socfpga/include/mach/dw_apb_timer.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/io.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/iomap.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/irqs.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/memory.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/smp.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/socfpga-timer.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/system.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/timex.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-socfpga/localtimer.c
 create mode 100644 arch/arm/mach-socfpga/platsmp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eb22272..193b4e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1103,6 +1103,11 @@ S:	Supported
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
+ARM/SOCFPGA ARCHITECTURE
+M:	Dinh Nguyen <dinguyen@altera.com>
+S:	Supported
+F:	arch/arm/mach-socfpga/
+
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..b1578e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -250,6 +250,22 @@ choice
 	prompt "ARM system type"
 	default ARCH_VERSATILE
 
+config ARCH_SOCFPGA
+	bool "Altera SOCFPGA family"
+	select CPU_V7
+	select ARM_GIC
+	select ARM_AMBA
+	select CLKDEV_LOOKUP
+	select MIGHT_HAVE_CACHE_L2X0
+	select HAVE_MACH_CLKDEV
+	select GENERIC_CLOCKEVENTS
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select GPIO_PL061 if GPIOLIB
+	select NEED_MACH_MEMORY_H
+	select USE_OF
+	help
+	  This enables support for Altera SOCFPGA Cyclone V platform
+
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	select ARM_AMBA
@@ -1056,6 +1072,8 @@ source "arch/arm/mach-sa1100/Kconfig"
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 
+source "arch/arm/mach-socfpga/Kconfig"
+
 source "arch/arm/plat-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
@@ -1596,6 +1614,7 @@ config HZ
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
+	default SOCFPGA_TIMER_HZ if ARCH_SOCFPGA
 	default 100
 
 config THUMB2_KERNEL
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0298b00..1fe5702 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -193,6 +193,7 @@ machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
 machine-$(CONFIG_ARCH_ZYNQ)		:= zynq
+machine-$(CONFIG_ARCH_SOCFPGA) 	:= socfpga
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
new file mode 100644
index 0000000..3fbbd0a
--- /dev/null
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -0,0 +1,21 @@
+choice
+	prompt "Altera SOCFPGA Platform"
+	default MACH_SOCFPGA_CYCLONE5
+	depends on ARCH_SOCFPGA
+	help
+		Select SOCFPGA platform type
+
+config MACH_SOCFPGA_CYCLONE5
+	bool "SOCFPGA Cyclone5 platform"
+	select HAVE_SMP
+	select PLAT_SOCFPGA_ETH
+	help
+	  Include support for the Altera(R) Cyclone5 development platform.
+endchoice
+
+config SOCFPGA_TIMER_HZ
+	int "Kernel internal timer frequency "
+	range 20 1024
+	default "100"
+	help
+	  Kernel internal timer frequency should be a divisor of 77161.
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
new file mode 100644
index 0000000..5502add
--- /dev/null
+++ b/arch/arm/mach-socfpga/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y					:= common.o clock.o dw_apb_timer.o
+obj-$(CONFIG_MACH_SOCFPGA_CYCLONE5)	+= socfpga_cyclone5.o
+obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
\ No newline at end of file
diff --git a/arch/arm/mach-socfpga/Makefile.boot b/arch/arm/mach-socfpga/Makefile.boot
new file mode 100644
index 0000000..7a1f3c0
--- /dev/null
+++ b/arch/arm/mach-socfpga/Makefile.boot
@@ -0,0 +1,3 @@
+zreladdr-y	:= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-socfpga/clock.c b/arch/arm/mach-socfpga/clock.c
new file mode 100644
index 0000000..b5a82cd
--- /dev/null
+++ b/arch/arm/mach-socfpga/clock.c
@@ -0,0 +1,50 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2004 ARM Limited.
+ *  Written by Deep Blue Solutions Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <mach/clkdev.h>
+
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
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	long ret = -EIO;
+	if (clk->ops && clk->ops->round)
+		ret = clk->ops->round(clk, rate);
+	return ret;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EIO;
+	if (clk->ops && clk->ops->set)
+		ret = clk->ops->set(clk, rate);
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rate);
diff --git a/arch/arm/mach-socfpga/common.c b/arch/arm/mach-socfpga/common.c
new file mode 100644
index 0000000..a2c734a
--- /dev/null
+++ b/arch/arm/mach-socfpga/common.c
@@ -0,0 +1,156 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/clkdev.h>
+#include <linux/gfp.h>
+#include <linux/of_platform.h>
+
+#include <mach/iomap.h>
+#include <mach/socfpga_cyclone5.h>
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+#include <asm/hardware/arm_timer.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
+#include <asm/mach/map.h>
+
+#include <mach/irqs.h>
+#include <mach/socfpga-timer.h>
+
+#include <linux/mmc/dw_mmc.h>
+#include <linux/serial_8250.h>
+
+#include "common.h"
+
+extern struct dw_mci_board sdmmc_platform_data;
+extern struct dma_pl330_platdata dma_platform_data;
+
+#define DW_APB_UART_OF_COMPATIBLE			"snps,dw-apb-uart"
+
+#define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
+#define SOCFPGA_L4_MAIN_CLK					(400000000)
+
+static struct clk dummy_apb_pclk;
+static struct clk dummy_i2c_clk = {
+	.rate   = 100000000,
+};
+static struct clk dummy_spim_clk = {
+	.rate   = 100000000,
+};
+static struct clk mpu_periphclk = {
+	.rate   = SOCFPGA_MPU_PERIHCLK_FREQ_HZ,
+};
+
+static struct clk l4_main_clk = {
+	.rate   = SOCFPGA_L4_MAIN_CLK,
+};
+
+static struct clk_lookup lookups[] = {
+	{	/* Bus clock */
+		.con_id		= "apb_pclk",
+		.clk		= &dummy_apb_pclk,
+	},
+	{
+		.dev_id		= "ffc04000.i2c",
+		.clk		= &dummy_i2c_clk,
+	},
+	{
+		.dev_id		= "ffc05000.i2c",
+		.clk		= &dummy_i2c_clk,
+	},
+	{
+		.dev_id		= "dw-spi-mmio.0",
+		.clk		= &dummy_spim_clk,
+	},
+	{
+		.dev_id		= "dw-spi-mmio.1",
+		.clk		= &dummy_spim_clk,
+	},
+	{
+		.dev_id		= "smp_twd",
+		.clk		= &mpu_periphclk,
+	},
+	{
+		.dev_id		= "dma-pl330",
+		.clk		= &l4_main_clk,
+	}
+};
+
+struct plat_serial8250_port uart_platform_data[] = {
+		{
+		.type		= PORT_16850,
+		.flags 		= UPF_BOOT_AUTOCONF | UPF_IOREMAP | \
+				  UPF_FIXED_TYPE,
+		},
+};
+
+void __init socfpga_init_early(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+}
+
+/*
+ * Where is the timer (VA)?
+ */
+void __iomem *sp_timer0_va_base;
+void __iomem *sp_timer1_va_base;
+void __iomem *osc_timer0_va_base;
+void __iomem *osc_timer1_va_base;
+
+/*
+ * Set up the clock source and clock events devices
+ */
+
+void __init socfpga_timer_init(void __iomem *src_timer_base,
+				void __iomem *event_timer_base,
+				unsigned int event_timer_irq)
+{
+	/*
+	 * Initialise to a known state (all timers off)
+	 */
+	writel(0, sp_timer0_va_base + TIMER_CTRL);
+	writel(0, sp_timer1_va_base + TIMER_CTRL);
+	writel(0, osc_timer0_va_base + TIMER_CTRL);
+	writel(0, osc_timer1_va_base + TIMER_CTRL);
+
+	dwapbt_clocksource_init(src_timer_base);
+	dwapbt_clockevents_init(event_timer_base, event_timer_irq);
+}
+
+/*
+ * Setup the memory banks.
+ */
+void socfpga_fixup(struct tag *tags, char **from, struct meminfo *meminfo)
+{
+	meminfo->bank[0].start = 0x0;
+	meminfo->bank[0].size = SZ_256M;
+	meminfo->nr_banks = 1;
+}
+
+int socfpga_notifier(struct device *device)
+{
+	struct device_node *dn = device->of_node;
+
+	if (of_device_is_compatible(dn, DW_APB_UART_OF_COMPATIBLE))
+		device->platform_data = &uart_platform_data;
+	return 0;
+}
diff --git a/arch/arm/mach-socfpga/common.h b/arch/arm/mach-socfpga/common.h
new file mode 100644
index 0000000..7cad4f1
--- /dev/null
+++ b/arch/arm/mach-socfpga/common.h
@@ -0,0 +1,38 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_ARCH_SOCFPGA_H
+#define __ASM_ARCH_SOCFPGA_H
+
+#include <asm/setup.h>
+
+struct machine_desc;
+
+extern void __iomem *sp_timer0_va_base;
+extern void __iomem *sp_timer1_va_base;
+extern void __iomem *osc_timer0_va_base;
+extern void __iomem *osc_timer1_va_base;
+
+extern void socfpga_init_early(void);
+extern void socfpga_fixup(struct tag *tags, char **from,
+				struct meminfo *meminfo);
+extern void socfpga_timer_init(void __iomem *src_timer_base,
+				void __iomem *event_timer_base,
+				unsigned int event_timer_irq);
+extern int socfpga_notifier(struct device *device);
+
+#endif
diff --git a/arch/arm/mach-socfpga/dw_apb_timer.c b/arch/arm/mach-socfpga/dw_apb_timer.c
new file mode 100644
index 0000000..64c8d96
--- /dev/null
+++ b/arch/arm/mach-socfpga/dw_apb_timer.c
@@ -0,0 +1,164 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/dw_apb_timer.h>
+#include <mach/socfpga-timer.h>
+#include <mach/iomap.h>
+#include <mach/clock.h>
+
+#define TIMER_SP_FREQ_KHZ	(SOCFPGA_SP_TIMER_FREQ_HZ / 1000)
+#define TIMER_OSC_FREQ_KHZ	(SOCFPGA_OSC_TIMER_FREQ_HZ / 1000)
+
+#define TIMER_RELOAD	(TIMER_OSC_FREQ_KHZ * 1000 / HZ)
+
+static void __iomem *clksrc_base;
+
+static cycle_t dwapbt_read(struct clocksource *cs)
+{
+	return ~readl(clksrc_base + TIMER_VALUE);
+}
+
+static struct clocksource clocksource_dwapbt = {
+	.name		= "SP Timer 0",
+	.rating		= 200,
+	.read		= dwapbt_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init dwapbt_clocksource_init(void __iomem *base)
+{
+	struct clocksource *cs = &clocksource_dwapbt;
+
+	clksrc_base = base;
+
+	/* setup free-running clocksource */
+	writel(0, clksrc_base + TIMER_CTRL);
+	writel(~0, clksrc_base + TIMER_LOAD);
+	writel(TIMER_CTRL_INTMASK | TIMER_CTRL_ENABLE,
+		clksrc_base + TIMER_CTRL);
+
+	clocksource_register_khz(cs, TIMER_SP_FREQ_KHZ);
+}
+
+
+static void __iomem *clkevt_base;
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t dwapbt_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/* clear the interrupt */
+	readl(clkevt_base + TIMER_INT_CLEAR);
+
+	/* Ooppss... spurious interrupt */
+	if (unlikely(!evt->event_handler))
+		return IRQ_NONE;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void dwapbt_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt)
+{
+	unsigned long ctrl = 0;
+
+	ctrl = readl(clkevt_base + TIMER_CTRL);
+
+	/* Reset control register and disable the timer */
+	writel(0, clkevt_base + TIMER_CTRL);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* Program load register */
+		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
+
+		ctrl |= TIMER_CTRL_ENABLE;
+		ctrl |= TIMER_CTRL_PERIODIC;
+		ctrl &= ~TIMER_CTRL_INTMASK;
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* period set, and timer enabled in 'next_event' hook */
+		ctrl &= ~TIMER_CTRL_PERIODIC;
+		ctrl &= ~TIMER_CTRL_INTMASK;
+		writel(ctrl, clkevt_base + TIMER_CTRL);
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		break;
+	}
+}
+
+static int dwapbt_set_next_event(unsigned long next,
+	struct clock_event_device *evt)
+{
+	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
+
+	/* Disable timer */
+	writel(ctrl & ~TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+
+	writel(next, clkevt_base + TIMER_LOAD);
+	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+
+	return 0;
+}
+
+static struct clock_event_device dwapbt_clockevent = {
+	.name		= "OSC Timer 0",
+	.shift		= 32,
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= dwapbt_set_mode,
+	.set_next_event	= dwapbt_set_next_event,
+	.rating		= 250,
+	.cpumask	= cpu_all_mask,
+};
+
+static struct irqaction dwapbt_timer_irq = {
+	.name		= "timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= dwapbt_timer_interrupt,
+	.dev_id		= &dwapbt_clockevent,
+};
+
+void __init dwapbt_clockevents_init(void __iomem *base, unsigned int timer_irq)
+{
+	struct clock_event_device *evt = &dwapbt_clockevent;
+
+	clkevt_base = base;
+
+	evt->irq = timer_irq;
+	evt->mult = div_sc(TIMER_OSC_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
+	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
+	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
+
+	setup_irq(timer_irq, &dwapbt_timer_irq);
+	clockevents_register_device(evt);
+}
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
new file mode 100644
index 0000000..e432aec
--- /dev/null
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -0,0 +1,41 @@
+/*
+ *  Modified from: linux/arch/arm/plat-versatile/headsmp.S
+ *
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * Entry point for secondary CPUs.
+ * This provides a "holding pen" into which all secondary cores are held
+ * until we're ready for them to initialise.
+ */
+ENTRY(socfpga_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+	.align
+1:	.long	.
+	.long	pen_release
+ENDPROC(socfpga_secondary_startup)
diff --git a/arch/arm/mach-socfpga/hotplug.c b/arch/arm/mach-socfpga/hotplug.c
new file mode 100644
index 0000000..f9fc9ff
--- /dev/null
+++ b/arch/arm/mach-socfpga/hotplug.c
@@ -0,0 +1,125 @@
+/*
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/smp_plat.h>
+
+extern int pen_release;
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	asm volatile(
+	"	mcr	p15, 0, %1, c7, c5, 0\n"
+	"	mcr	p15, 0, %1, c7, c10, 4\n"
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %2\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0), "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile("mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+{
+	/*
+	 * there is no power-control hardware on this platform, so all
+	 * we can do is put the core into WFI; this is safe as the calling
+	 * code will have already disabled interrupts
+	 */
+	for (;;) {
+		/*
+		 * here's the WFI
+		 */
+		asm volatile(".word	0xe320f003\n"
+		    : : : "memory", "cc");
+
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+
+		/*
+		 * Getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * Just note it happening - when we're woken, we can report
+		 * its occurrence.
+		 */
+		(*spurious)++;
+	}
+}
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	platform_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/mach-socfpga/include/mach/clock.h b/arch/arm/mach-socfpga/include/mach/clock.h
new file mode 100644
index 0000000..5187064
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/clock.h
@@ -0,0 +1,11 @@
+#ifndef __MACH_CLOCK_H
+#define __MACH_CLOCK_H
+
+struct clk;
+
+struct clk_ops {
+	long	(*round)(struct clk *, unsigned long);
+	int	(*set)(struct clk *, unsigned long);
+};
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/debug-macro.S b/arch/arm/mach-socfpga/include/mach/debug-macro.S
new file mode 100644
index 0000000..d6283f5
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/debug-macro.S
@@ -0,0 +1,29 @@
+/*
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef DEBUG_LL_UART_OFFSET
+#define DEBUG_LL_UART_OFFSET	0x00002000
+#elif DEBUG_LL_UART_OFFSET != 0x00002000
+#warning "DEBUG_LL_UART_OFFSET already defined to a different value"
+#endif
+
+#ifndef DEBUG_LL_UART_OFFSET
+#error "Unknown SOCFPGA platform"
+#endif
+
+		.macro	addruart, rp, rv, tmp
+		mov	\rp, #DEBUG_LL_UART_OFFSET
+		orr	\rp, \rp, #0x00c00000
+		orr	\rv, \rp, #0xfe000000	@ virtual base
+		orr	\rp, \rp, #0xff000000	@ physical base
+		.endm
+
+#define UART_SHIFT	2
+
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-socfpga/include/mach/dw_apb_timer.h b/arch/arm/mach-socfpga/include/mach/dw_apb_timer.h
new file mode 100644
index 0000000..3c58a56
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/dw_apb_timer.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+
+#ifndef __ASM_ARM_HARDWARE_DW_APB_TIMER_H
+#define __ASM_ARM_HARDWARE_DW_APB_TIMER_H
+
+/* Individual timer register */
+#define TIMER_LOAD              0x00            /* Load value rw */
+#define TIMER_VALUE             0x04            /* Current value ro */
+#define TIMER_CTRL              0x08            /* Control register rw */
+#define TIMER_INT_CLEAR         0x0c            /* Interrupt clear ro */
+#define TIMER_INT_STAT          0x10            /* Interrupt status ro */
+
+/* Shared timer register */
+#define TIMERS_INT_STAT         0xa0            /* Masked interrupt status ro */
+#define TIMERS_INT_CLEAR        0xa4            /* Interrupt clear ro */
+#define TIMERS_INT_STAT_RAW     0xa8            /* Raw interrupt status ro */
+#define TIMERS_VERSION          0xac            /* Version */
+
+#define TIMER_CTRL_ENABLE	(1 << 0)        /* Timer Enable = 1 */
+#define TIMER_CTRL_PERIODIC	(1 << 1)        /* Periodic mode = 0 */
+#define TIMER_CTRL_INTMASK	(1 << 2)        /* Interrupt mask = 1 */
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/io.h b/arch/arm/mach-socfpga/include/mach/io.h
new file mode 100644
index 0000000..ff150b0
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/io.h
@@ -0,0 +1,27 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2003 ARM Limited
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
+#ifndef __MACH_ARCH_IO_H
+#define __MACH_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/iomap.h b/arch/arm/mach-socfpga/include/mach/iomap.h
new file mode 100644
index 0000000..656482d
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/iomap.h
@@ -0,0 +1,37 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __MACH_SOCFPGA_IOMAP_H
+#define __MACH_SOCFPGA_IOMAP_H
+
+#include <asm/sizes.h>
+
+/* macro to get at IO space when running virtually */
+#ifdef CONFIG_MMU
+/*
+ * Statically mapped addresses:
+ *
+ * 10xx xxxx -> fbxx xxxx
+ * 1exx xxxx -> fdxx xxxx
+ * 1fxx xxxx -> fexx xxxx
+ */
+#define IO_ADDRESS(x)		(((x) & 0x03ffffff) + 0xfb000000)
+#else
+#define IO_ADDRESS(x)		(x)
+#endif
+#define __io_address(n)		IOMEM(IO_ADDRESS(n))
+
+#endif
\ No newline at end of file
diff --git a/arch/arm/mach-socfpga/include/mach/irqs.h b/arch/arm/mach-socfpga/include/mach/irqs.h
new file mode 100644
index 0000000..65db73a
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/irqs.h
@@ -0,0 +1,305 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
+
+#define IRQ_SOCFPGA_GIC_START	32
+#define IRQ_LOCALWDOG		30
+
+
+/*
+ * SOCFPGA interrupt sources
+ */
+#define IRQ_SOCFPGA_CPU0_PARITY	(IRQ_SOCFPGA_GIC_START + 0)		/* CPU0 parity */
+#define IRQ_SOCFPGA_CPU0_PARITY_BTAG	(IRQ_SOCFPGA_GIC_START + 1)		/* CPU0 parity BTAG		*/
+#define IRQ_SOCFPGA_CPU0_PARITY_GHB		(IRQ_SOCFPGA_GIC_START + 2)		/* CPU0 parity GHB		*/
+#define IRQ_SOCFPGA_CPU0_PARITY_ITAG	(IRQ_SOCFPGA_GIC_START + 3)		/* CPU0 parity ITAG		*/
+#define IRQ_SOCFPGA_CPU0_PARITY_IDATA	(IRQ_SOCFPGA_GIC_START + 4)		/* CPU0 parity IDATA	*/
+#define IRQ_SOCFPGA_CPU0_PARITY_TLB		(IRQ_SOCFPGA_GIC_START + 5)		/* CPU0 parity TLB		*/
+#define IRQ_SOCFPGA_CPU0_PARITY_DOUTER	(IRQ_SOCFPGA_GIC_START + 6)		/* CPU0 parity DOUTER	*/
+#define IRQ_SOCFPGA_CPU0_PARITY_DTAG	(IRQ_SOCFPGA_GIC_START + 7)		/* CPU0 parity DTAG		*/
+#define IRQ_SOCFPGA_CPU0_PARITY_DDATA	(IRQ_SOCFPGA_GIC_START + 8)		/* CPU0 parity DDATA	*/
+#define IRQ_SOCFPGA_CPU0_DEFLAGS0	(IRQ_SOCFPGA_GIC_START + 9)			/* CPU0 deflasg 0 */
+#define IRQ_SOCFPGA_CPU0_DEFLAGS1	(IRQ_SOCFPGA_GIC_START + 10)		/* CPU0 deflags 1 */
+#define IRQ_SOCFPGA_CPU0_DEFLAGS2	(IRQ_SOCFPGA_GIC_START + 11)		/* CPU0 deflags 2 */
+#define IRQ_SOCFPGA_CPU0_DEFLAGS3	(IRQ_SOCFPGA_GIC_START + 12)		/* CPU0 deflags 3 */
+#define IRQ_SOCFPGA_CPU0_DEFLAGS4	(IRQ_SOCFPGA_GIC_START + 13)		/* CPU0 deflags 4 */
+#define IRQ_SOCFPGA_CPU0_DEFLAGS5	(IRQ_SOCFPGA_GIC_START + 14)		/* CPU0 deflags 5 */
+#define IRQ_SOCFPGA_CPU0_DEFLAGS6	(IRQ_SOCFPGA_GIC_START + 15)		/* CPU0 deflags 6 */
+#define IRQ_SOCFPGA_CPU1_PARITY		(IRQ_SOCFPGA_GIC_START + 16)		/* CPU1 parity */
+#define IRQ_SOCFPGA_CPU1_PARITY_BTAG	(IRQ_SOCFPGA_GIC_START + 17)	/* CPU1 parity BTAG		*/
+#define IRQ_SOCFPGA_CPU1_PARITY_GHB		(IRQ_SOCFPGA_GIC_START + 18)	/* CPU1 parity GHB		*/
+#define IRQ_SOCFPGA_CPU1_PARITY_ITAG	(IRQ_SOCFPGA_GIC_START + 19)	/* CPU1 parity ITAG		*/
+#define IRQ_SOCFPGA_CPU1_PARITY_IDATA	(IRQ_SOCFPGA_GIC_START + 20)	/* CPU1 parity IDATA	*/
+#define IRQ_SOCFPGA_CPU1_PARITY_TLB		(IRQ_SOCFPGA_GIC_START + 21)	/* CPU1 parity TLB		*/
+#define IRQ_SOCFPGA_CPU1_PARITY_DOUTER	(IRQ_SOCFPGA_GIC_START + 22)	/* CPU1 parity DOUTER	*/
+#define IRQ_SOCFPGA_CPU1_PARITY_DTAG	(IRQ_SOCFPGA_GIC_START + 23)	/* CPU1 parity DTAG		*/
+#define IRQ_SOCFPGA_CPU1_PARITY_DDATA	(IRQ_SOCFPGA_GIC_START + 24)	/* CPU1 parity DDATA	*/
+#define IRQ_SOCFPGA_CPU1_DEFLAGS0	(IRQ_SOCFPGA_GIC_START + 25)		/* CPU1 deflags 0 */
+#define IRQ_SOCFPGA_CPU1_DEFLAGS1	(IRQ_SOCFPGA_GIC_START + 26)	/* CPU1 deflags 1 */
+#define IRQ_SOCFPGA_CPU1_DEFLAGS2	(IRQ_SOCFPGA_GIC_START + 27)	/* CPU1 deflags 2 */
+#define IRQ_SOCFPGA_CPU1_DEFLAGS3	(IRQ_SOCFPGA_GIC_START + 28)	/* CPU1 deflags 3 */
+#define IRQ_SOCFPGA_CPU1_DEFLAGS4	(IRQ_SOCFPGA_GIC_START + 29)	/* CPU1 deflags 4 */
+#define IRQ_SOCFPGA_CPU1_DEFLAGS5	(IRQ_SOCFPGA_GIC_START + 30)	/* CPU1 deflags 5 */
+#define IRQ_SOCFPGA_CPU1_DEFLAGS6	(IRQ_SOCFPGA_GIC_START + 31)	/* CPU1 deflags 6 */
+#define IRQ_SOCFPGA_SCU0_PARITY	(IRQ_SOCFPGA_GIC_START + 32)	/* SCU0 parity */
+#define IRQ_SOCFPGA_SCU1_PARITY	(IRQ_SOCFPGA_GIC_START + 33)	/* SCU1 parity */
+#define IRQ_SOCFPGA_SCU_EV_ABORT	(IRQ_SOCFPGA_GIC_START + 34)	/* SCU EV abort */
+#define IRQ_SOCFPGA_L2_ECC_WRITE	(IRQ_SOCFPGA_GIC_START + 35)	/* L2 ECC write */
+#define IRQ_SOCFPGA_L2_ECC_CERR	(IRQ_SOCFPGA_GIC_START + 36)	/* L2 ECC error corrected */
+#define IRQ_SOCFPGA_L2_ECC_UERR	(IRQ_SOCFPGA_GIC_START + 37)	/* L2 ECC error uncorrected */
+#define IRQ_SOCFPGA_L2		(IRQ_SOCFPGA_GIC_START + 38)	/* L2 combined interrupts */
+#define IRQ_SOCFPGA_DDR_ECC_ERR	(IRQ_SOCFPGA_GIC_START + 39)	/* DDR ECC error */
+#define IRQ_SOCFPGA_F2S_FPGA0 	(IRQ_SOCFPGA_GIC_START + 40) 	/* FPGA IRQ 0 */
+#define IRQ_SOCFPGA_F2S_FPGA1 	(IRQ_SOCFPGA_GIC_START + 41) 	/* FPGA IRQ 1 */
+#define IRQ_SOCFPGA_F2S_FPGA2 	(IRQ_SOCFPGA_GIC_START + 42) 	/* FPGA IRQ 2 */
+#define IRQ_SOCFPGA_F2S_FPGA3 	(IRQ_SOCFPGA_GIC_START + 43) 	/* FPGA IRQ 3 */
+#define IRQ_SOCFPGA_F2S_FPGA4 	(IRQ_SOCFPGA_GIC_START + 44) 	/* FPGA IRQ 4 */
+#define IRQ_SOCFPGA_F2S_FPGA5 	(IRQ_SOCFPGA_GIC_START + 45) 	/* FPGA IRQ 5 */
+#define IRQ_SOCFPGA_F2S_FPGA6 	(IRQ_SOCFPGA_GIC_START + 46) 	/* FPGA IRQ 6 */
+#define IRQ_SOCFPGA_F2S_FPGA7 	(IRQ_SOCFPGA_GIC_START + 47) 	/* FPGA IRQ 7 */
+#define IRQ_SOCFPGA_F2S_FPGA8 	(IRQ_SOCFPGA_GIC_START + 48) 	/* FPGA IRQ 8 */
+#define IRQ_SOCFPGA_F2S_FPGA9 	(IRQ_SOCFPGA_GIC_START + 49) 	/* FPGA IRQ 9 */
+#define IRQ_SOCFPGA_F2S_FPGA10 	(IRQ_SOCFPGA_GIC_START + 50) 	/* FPGA IRQ 10 */
+#define IRQ_SOCFPGA_F2S_FPGA11 	(IRQ_SOCFPGA_GIC_START + 51) 	/* FPGA IRQ 11 */
+#define IRQ_SOCFPGA_F2S_FPGA12 	(IRQ_SOCFPGA_GIC_START + 52) 	/* FPGA IRQ 12 */
+#define IRQ_SOCFPGA_F2S_FPGA13 	(IRQ_SOCFPGA_GIC_START + 53) 	/* FPGA IRQ 13 */
+#define IRQ_SOCFPGA_F2S_FPGA14 	(IRQ_SOCFPGA_GIC_START + 54) 	/* FPGA IRQ 14 */
+#define IRQ_SOCFPGA_F2S_FPGA15 	(IRQ_SOCFPGA_GIC_START + 55) 	/* FPGA IRQ 15 */
+#define IRQ_SOCFPGA_F2S_FPGA16 	(IRQ_SOCFPGA_GIC_START + 56) 	/* FPGA IRQ 16 */
+#define IRQ_SOCFPGA_F2S_FPGA17 	(IRQ_SOCFPGA_GIC_START + 57) 	/* FPGA IRQ 17 */
+#define IRQ_SOCFPGA_F2S_FPGA18 	(IRQ_SOCFPGA_GIC_START + 58) 	/* FPGA IRQ 18 */
+#define IRQ_SOCFPGA_F2S_FPGA19 	(IRQ_SOCFPGA_GIC_START + 59) 	/* FPGA IRQ 19 */
+#define IRQ_SOCFPGA_F2S_FPGA20 	(IRQ_SOCFPGA_GIC_START + 60) 	/* FPGA IRQ 20 */
+#define IRQ_SOCFPGA_F2S_FPGA21 	(IRQ_SOCFPGA_GIC_START + 61) 	/* FPGA IRQ 21 */
+#define IRQ_SOCFPGA_F2S_FPGA22 	(IRQ_SOCFPGA_GIC_START + 62) 	/* FPGA IRQ 22 */
+#define IRQ_SOCFPGA_F2S_FPGA23 	(IRQ_SOCFPGA_GIC_START + 63) 	/* FPGA IRQ 23 */
+#define IRQ_SOCFPGA_F2S_FPGA24 	(IRQ_SOCFPGA_GIC_START + 64) 	/* FPGA IRQ 24 */
+#define IRQ_SOCFPGA_F2S_FPGA25 	(IRQ_SOCFPGA_GIC_START + 65) 	/* FPGA IRQ 25 */
+#define IRQ_SOCFPGA_F2S_FPGA26 	(IRQ_SOCFPGA_GIC_START + 66) 	/* FPGA IRQ 26 */
+#define IRQ_SOCFPGA_F2S_FPGA27 	(IRQ_SOCFPGA_GIC_START + 67) 	/* FPGA IRQ 27 */
+#define IRQ_SOCFPGA_F2S_FPGA28 	(IRQ_SOCFPGA_GIC_START + 68) 	/* FPGA IRQ 28 */
+#define IRQ_SOCFPGA_F2S_FPGA29 	(IRQ_SOCFPGA_GIC_START + 69) 	/* FPGA IRQ 29 */
+#define IRQ_SOCFPGA_F2S_FPGA30 	(IRQ_SOCFPGA_GIC_START + 70) 	/* FPGA IRQ 30 */
+#define IRQ_SOCFPGA_F2S_FPGA31 	(IRQ_SOCFPGA_GIC_START + 71) 	/* FPGA IRQ 31 */
+#define IRQ_SOCFPGA_F2S_FPGA32 	(IRQ_SOCFPGA_GIC_START + 72) 	/* FPGA IRQ 32 */
+#define IRQ_SOCFPGA_F2S_FPGA33 	(IRQ_SOCFPGA_GIC_START + 73) 	/* FPGA IRQ 33 */
+#define IRQ_SOCFPGA_F2S_FPGA34 	(IRQ_SOCFPGA_GIC_START + 74) 	/* FPGA IRQ 34 */
+#define IRQ_SOCFPGA_F2S_FPGA35 	(IRQ_SOCFPGA_GIC_START + 75) 	/* FPGA IRQ 35 */
+#define IRQ_SOCFPGA_F2S_FPGA36 	(IRQ_SOCFPGA_GIC_START + 76) 	/* FPGA IRQ 36 */
+#define IRQ_SOCFPGA_F2S_FPGA37 	(IRQ_SOCFPGA_GIC_START + 77) 	/* FPGA IRQ 37 */
+#define IRQ_SOCFPGA_F2S_FPGA38 	(IRQ_SOCFPGA_GIC_START + 78) 	/* FPGA IRQ 38 */
+#define IRQ_SOCFPGA_F2S_FPGA39 	(IRQ_SOCFPGA_GIC_START + 79) 	/* FPGA IRQ 39 */
+#define IRQ_SOCFPGA_F2S_FPGA40 	(IRQ_SOCFPGA_GIC_START + 80) 	/* FPGA IRQ 40 */
+#define IRQ_SOCFPGA_F2S_FPGA41 	(IRQ_SOCFPGA_GIC_START + 81) 	/* FPGA IRQ 41 */
+#define IRQ_SOCFPGA_F2S_FPGA42 	(IRQ_SOCFPGA_GIC_START + 82) 	/* FPGA IRQ 42 */
+#define IRQ_SOCFPGA_F2S_FPGA43 	(IRQ_SOCFPGA_GIC_START + 83) 	/* FPGA IRQ 43 */
+#define IRQ_SOCFPGA_F2S_FPGA44 	(IRQ_SOCFPGA_GIC_START + 84) 	/* FPGA IRQ 44 */
+#define IRQ_SOCFPGA_F2S_FPGA45 	(IRQ_SOCFPGA_GIC_START + 85) 	/* FPGA IRQ 45 */
+#define IRQ_SOCFPGA_F2S_FPGA46 	(IRQ_SOCFPGA_GIC_START + 86) 	/* FPGA IRQ 46 */
+#define IRQ_SOCFPGA_F2S_FPGA47 	(IRQ_SOCFPGA_GIC_START + 87) 	/* FPGA IRQ 47 */
+#define IRQ_SOCFPGA_F2S_FPGA48 	(IRQ_SOCFPGA_GIC_START + 88) 	/* FPGA IRQ 48 */
+#define IRQ_SOCFPGA_F2S_FPGA49 	(IRQ_SOCFPGA_GIC_START + 89) 	/* FPGA IRQ 49 */
+#define IRQ_SOCFPGA_F2S_FPGA50 	(IRQ_SOCFPGA_GIC_START + 90) 	/* FPGA IRQ 50 */
+#define IRQ_SOCFPGA_F2S_FPGA51 	(IRQ_SOCFPGA_GIC_START + 91) 	/* FPGA IRQ 51 */
+#define IRQ_SOCFPGA_F2S_FPGA52 	(IRQ_SOCFPGA_GIC_START + 92) 	/* FPGA IRQ 52 */
+#define IRQ_SOCFPGA_F2S_FPGA53 	(IRQ_SOCFPGA_GIC_START + 93) 	/* FPGA IRQ 53 */
+#define IRQ_SOCFPGA_F2S_FPGA54 	(IRQ_SOCFPGA_GIC_START + 94) 	/* FPGA IRQ 54 */
+#define IRQ_SOCFPGA_F2S_FPGA55 	(IRQ_SOCFPGA_GIC_START + 95) 	/* FPGA IRQ 55 */
+#define IRQ_SOCFPGA_F2S_FPGA56 	(IRQ_SOCFPGA_GIC_START + 96) 	/* FPGA IRQ 56 */
+#define IRQ_SOCFPGA_F2S_FPGA57 	(IRQ_SOCFPGA_GIC_START + 97) 	/* FPGA IRQ 57 */
+#define IRQ_SOCFPGA_F2S_FPGA58 	(IRQ_SOCFPGA_GIC_START + 98) 	/* FPGA IRQ 58 */
+#define IRQ_SOCFPGA_F2S_FPGA59 	(IRQ_SOCFPGA_GIC_START + 99) 	/* FPGA IRQ 59 */
+#define IRQ_SOCFPGA_F2S_FPGA60 	(IRQ_SOCFPGA_GIC_START + 100)	/* FPGA IRQ 60 */
+#define IRQ_SOCFPGA_F2S_FPGA61 	(IRQ_SOCFPGA_GIC_START + 101)	/* FPGA IRQ 61 */
+#define IRQ_SOCFPGA_F2S_FPGA62 	(IRQ_SOCFPGA_GIC_START + 102)	/* FPGA IRQ 62 */
+#define IRQ_SOCFPGA_F2S_FPGA63 	(IRQ_SOCFPGA_GIC_START + 103)	/* FPGA IRQ 63 */
+#define IRQ_SOCFPGA_DMA0		(IRQ_SOCFPGA_GIC_START + 104)	/* DMA Channel 0 */
+#define IRQ_SOCFPGA_DMA1		(IRQ_SOCFPGA_GIC_START + 105)	/* DMA Channel 1 */
+#define IRQ_SOCFPGA_DMA2		(IRQ_SOCFPGA_GIC_START + 106)	/* DMA Channel 2 */
+#define IRQ_SOCFPGA_DMA3		(IRQ_SOCFPGA_GIC_START + 107)	/* DMA Channel 3 */
+#define IRQ_SOCFPGA_DMA4		(IRQ_SOCFPGA_GIC_START + 108)	/* DMA Channel 3 */
+#define IRQ_SOCFPGA_DMA5		(IRQ_SOCFPGA_GIC_START + 109)	/* DMA Channel 5 */
+#define IRQ_SOCFPGA_DMA6		(IRQ_SOCFPGA_GIC_START + 110)	/* DMA Channel 6 */
+#define IRQ_SOCFPGA_DMA7		(IRQ_SOCFPGA_GIC_START + 111)	/* DMA Channel 7 */
+#define IRQ_SOCFPGA_DMA_ABORT	(IRQ_SOCFPGA_GIC_START + 112)	/* DMA abort */
+#define IRQ_SOCFPGA_DMA_CECC	(IRQ_SOCFPGA_GIC_START + 113)	/* DMA ECC corrected */
+#define IRQ_SOCFPGA_DMA_UECC	(IRQ_SOCFPGA_GIC_START + 114)	/* DMA ECC uncorrected */
+#define IRQ_SOCFPGA_EMAC0		(IRQ_SOCFPGA_GIC_START + 115)	/* Gb-Ethernet MAC0 */
+#define IRQ_SOCFPGA_EMAC0_TX_CECC	(IRQ_SOCFPGA_GIC_START + 116)	/* Gb-Ethernet MAC0 ECC corrected */
+#define IRQ_SOCFPGA_EMAC0_TX_UECC	(IRQ_SOCFPGA_GIC_START + 117)	/* Gb-Ethernet MAC0 ECC uncorrected */
+#define IRQ_SOCFPGA_EMAC0_RX_CECC	(IRQ_SOCFPGA_GIC_START + 118)	/* Gb-Ethernet MAC0 ECC corrected */
+#define IRQ_SOCFPGA_EMAC0_RX_UECC	(IRQ_SOCFPGA_GIC_START + 119)	/* Gb-Ethernet MAC0 ECC uncorrected */
+#define IRQ_SOCFPGA_EMAC1		(IRQ_SOCFPGA_GIC_START + 120)	/* Gb-Ethernet MAC1 */
+#define IRQ_SOCFPGA_EMAC1_TX_CECC	(IRQ_SOCFPGA_GIC_START + 121)	/* Gb-Ethernet MAC1 ECC corrected */
+#define IRQ_SOCFPGA_EMAC1_TX_UECC	(IRQ_SOCFPGA_GIC_START + 122)	/* Gb-Ethernet MAC1 ECC uncorrected */
+#define IRQ_SOCFPGA_EMAC1_RX_CECC	(IRQ_SOCFPGA_GIC_START + 123)	/* Gb-Ethernet MAC1 ECC corrected */
+#define IRQ_SOCFPGA_EMAC1_RX_UECC	(IRQ_SOCFPGA_GIC_START + 124)	/* Gb-Ethernet MAC1 ECC uncorrected */
+#define IRQ_SOCFPGA_USB0		(IRQ_SOCFPGA_GIC_START + 125)	/* USB 0 generic */
+#define IRQ_SOCFPGA_USB0_CECC	(IRQ_SOCFPGA_GIC_START + 126)	/* USB 0 ECC corrected */
+#define IRQ_SOCFPGA_USB0_UECC	(IRQ_SOCFPGA_GIC_START + 127)	/* USB 0 ECC uncorrected */
+#define IRQ_SOCFPGA_USB1		(IRQ_SOCFPGA_GIC_START + 128)	/* USB 1 generic */
+#define IRQ_SOCFPGA_USB1_CECC	(IRQ_SOCFPGA_GIC_START + 129)	/* USB 1 ECC corrected */
+#define IRQ_SOCFPGA_USB1_UECC	(IRQ_SOCFPGA_GIC_START + 130)	/* USB 1 ECC uncorrected */
+#define IRQ_SOCFPGA_CAN0_STS	(IRQ_SOCFPGA_GIC_START + 131)	/* CAN0 interrupt 0 */
+#define IRQ_SOCFPGA_CAN0_MO		(IRQ_SOCFPGA_GIC_START + 132)	/* CAN0 interrupt 1 */
+#define IRQ_SOCFPGA_CAN0_CECC	(IRQ_SOCFPGA_GIC_START + 133)	/* CAN0 ECC corrected */
+#define IRQ_SOCFPGA_CAN0_UECC	(IRQ_SOCFPGA_GIC_START + 134)	/* CAN0 ECC uncorrected */
+#define IRQ_SOCFPGA_CAN1_STS	(IRQ_SOCFPGA_GIC_START + 135)	/* CAN1 interrupt 0 */
+#define IRQ_SOCFPGA_CAN1_MO		(IRQ_SOCFPGA_GIC_START + 136)	/* CAN1 interrupt 1 */
+#define IRQ_SOCFPGA_CAN1_CECC	(IRQ_SOCFPGA_GIC_START + 137)	/* CAN1 ECC corrected */
+#define IRQ_SOCFPGA_CAN1_UECC	(IRQ_SOCFPGA_GIC_START + 138)	/* CAN1 ECC uncorrected */
+#define IRQ_SOCFPGA_SDMMC		(IRQ_SOCFPGA_GIC_START + 139)	/* SD/MMC */
+#define IRQ_SOCFPGA_SDMMC_PA_CECC	(IRQ_SOCFPGA_GIC_START + 140)	/* SD/MMC PortA ECC corrected */
+#define IRQ_SOCFPGA_SDMMC_PA_UECC	(IRQ_SOCFPGA_GIC_START + 141)	/* SD/MMC PortA ECC uncorrected */
+#define IRQ_SOCFPGA_SDMMC_PB_CECC	(IRQ_SOCFPGA_GIC_START + 142)	/* SD/MMC PortB ECC corrected */
+#define IRQ_SOCFPGA_SDMMC_PB_UECC	(IRQ_SOCFPGA_GIC_START + 143)	/* SD/MMC PortB ECC uncorrected */
+#define IRQ_SOCFPGA_NAND		(IRQ_SOCFPGA_GIC_START + 144)	/* NAND */
+#define IRQ_SOCFPGA_NAND_R_CECC	(IRQ_SOCFPGA_GIC_START + 145)	/* NAND read ECC corrected */
+#define IRQ_SOCFPGA_NAND_R_UECC	(IRQ_SOCFPGA_GIC_START + 146)	/* NAND read ECC uncorrected */
+#define IRQ_SOCFPGA_NAND_W_CECC	(IRQ_SOCFPGA_GIC_START + 147)	/* NAND write ECC corrected */
+#define IRQ_SOCFPGA_NAND_W_UECC	(IRQ_SOCFPGA_GIC_START + 148)	/* NAND write ECC uncorrected */
+#define IRQ_SOCFPGA_NAND_E_CECC	(IRQ_SOCFPGA_GIC_START + 149)	/* NAND error ECC corrected */
+#define IRQ_SOCFPGA_NAND_E_UECC	(IRQ_SOCFPGA_GIC_START + 150)	/* NAND error ECC uncorrected */
+#define IRQ_SOCFPGA_QSPI		(IRQ_SOCFPGA_GIC_START + 151)	/* Quad-SPI */
+#define IRQ_SOCFPGA_QSPI_CECC	(IRQ_SOCFPGA_GIC_START + 152)	/* Quad-SPI ECC corrected */
+#define IRQ_SOCFPGA_QSPI_UECC	(IRQ_SOCFPGA_GIC_START + 153)	/* Quad-SPI ECC uncorrected */
+#define IRQ_SOCFPGA_SPI0		(IRQ_SOCFPGA_GIC_START + 154)	/* SPI 0 */
+#define IRQ_SOCFPGA_SPI1		(IRQ_SOCFPGA_GIC_START + 155)	/* SPI 1 */
+#define IRQ_SOCFPGA_SPI2		(IRQ_SOCFPGA_GIC_START + 156)	/* SPI 2 */
+#define IRQ_SOCFPGA_SPI3		(IRQ_SOCFPGA_GIC_START + 157)	/* SPI 3 */
+#define IRQ_SOCFPGA_I2C0		(IRQ_SOCFPGA_GIC_START + 158)	/* I2C 0 */
+#define IRQ_SOCFPGA_I2C1		(IRQ_SOCFPGA_GIC_START + 159)	/* I2C 1 */
+#define IRQ_SOCFPGA_I2C2		(IRQ_SOCFPGA_GIC_START + 160)	/* I2C 2 */
+#define IRQ_SOCFPGA_I2C3		(IRQ_SOCFPGA_GIC_START + 161)	/* I2C 3 */
+#define IRQ_SOCFPGA_UART0		(IRQ_SOCFPGA_GIC_START + 162)	/* UART 0 */
+#define IRQ_SOCFPGA_UART1		(IRQ_SOCFPGA_GIC_START + 163)	/* UART 1 */
+#define IRQ_SOCFPGA_GPIO0		(IRQ_SOCFPGA_GIC_START + 164)	/* GPIO 0 */
+#define IRQ_SOCFPGA_GPIO1		(IRQ_SOCFPGA_GIC_START + 165)	/* GPIO 1 */
+#define IRQ_SOCFPGA_GPIO2		(IRQ_SOCFPGA_GIC_START + 166)	/* GPIO 2 */
+#define IRQ_SOCFPGA_L4_SP_TIMER0	(IRQ_SOCFPGA_GIC_START + 167)	/* L4 SP timer 0 */
+#define IRQ_SOCFPGA_L4_SP_TIMER1	(IRQ_SOCFPGA_GIC_START + 168)	/* L4 SP timer 1 */
+#define IRQ_SOCFPGA_L4_OSC1_TIMER0	(IRQ_SOCFPGA_GIC_START + 169)	/* L4 OSC1 timer 0 */
+#define IRQ_SOCFPGA_L4_OSC1_TIMER1	(IRQ_SOCFPGA_GIC_START + 170)	/* L4 OSC1 timer 1 */
+#define IRQ_SOCFPGA_WD0		(IRQ_SOCFPGA_GIC_START + 171)	/* Watchdog timer 0 */
+#define IRQ_SOCFPGA_WD1		(IRQ_SOCFPGA_GIC_START + 172)	/* Watchdog timer 1 */
+#define IRQ_SOCFPGA_CLK_MAN		(IRQ_SOCFPGA_GIC_START + 173)	/* Clock manager */
+#define IRQ_SOCFPGA_MPU_WAKE	(IRQ_SOCFPGA_GIC_START + 174)	/* MPU wake */
+#define IRQ_SOCFPGA_FPGA_MON	(IRQ_SOCFPGA_GIC_START + 175)	/* FPGA monitor */
+#define IRQ_SOCFPGA_CPU0_CTI	(IRQ_SOCFPGA_GIC_START + 176)	/* Coresight CPU0 CTI */
+#define IRQ_SOCFPGA_CPU1_CTI	(IRQ_SOCFPGA_GIC_START + 177)	/* Coresight CPU1 CTI */
+#define IRQ_SOCFPGA_OCRAM_CECC	(IRQ_SOCFPGA_GIC_START + 178)	/* on-chip RAM ECC corrected */
+#define IRQ_SOCFPGA_OCRAM_UECC	(IRQ_SOCFPGA_GIC_START + 179)	/* on-chip RAM ECC uncorrected */
+
+/* Soft IRQ */
+#define SOFTIRQ_SOCFPGA_DMADEV 	(IRQ_SOCFPGA_GIC_START + 180)
+#define SOFTIRQ_SOCFPGA_GPIO_0_0	(IRQ_SOCFPGA_GIC_START + 181)
+#define SOFTIRQ_SOCFPGA_GPIO_0_1	(IRQ_SOCFPGA_GIC_START + 182)
+#define SOFTIRQ_SOCFPGA_GPIO_0_2	(IRQ_SOCFPGA_GIC_START + 183)
+#define SOFTIRQ_SOCFPGA_GPIO_0_3	(IRQ_SOCFPGA_GIC_START + 184)
+#define SOFTIRQ_SOCFPGA_GPIO_0_4	(IRQ_SOCFPGA_GIC_START + 185)
+#define SOFTIRQ_SOCFPGA_GPIO_0_5	(IRQ_SOCFPGA_GIC_START + 186)
+#define SOFTIRQ_SOCFPGA_GPIO_0_6	(IRQ_SOCFPGA_GIC_START + 187)
+#define SOFTIRQ_SOCFPGA_GPIO_0_7	(IRQ_SOCFPGA_GIC_START + 188)
+#define SOFTIRQ_SOCFPGA_GPIO_0_8	(IRQ_SOCFPGA_GIC_START + 189)
+#define SOFTIRQ_SOCFPGA_GPIO_0_9	(IRQ_SOCFPGA_GIC_START + 190)
+#define SOFTIRQ_SOCFPGA_GPIO_0_10	(IRQ_SOCFPGA_GIC_START + 191)
+#define SOFTIRQ_SOCFPGA_GPIO_0_11	(IRQ_SOCFPGA_GIC_START + 192)
+#define SOFTIRQ_SOCFPGA_GPIO_0_12	(IRQ_SOCFPGA_GIC_START + 193)
+#define SOFTIRQ_SOCFPGA_GPIO_0_13	(IRQ_SOCFPGA_GIC_START + 194)
+#define SOFTIRQ_SOCFPGA_GPIO_0_14	(IRQ_SOCFPGA_GIC_START + 195)
+#define SOFTIRQ_SOCFPGA_GPIO_0_15	(IRQ_SOCFPGA_GIC_START + 196)
+#define SOFTIRQ_SOCFPGA_GPIO_0_16	(IRQ_SOCFPGA_GIC_START + 197)
+#define SOFTIRQ_SOCFPGA_GPIO_0_17	(IRQ_SOCFPGA_GIC_START + 198)
+#define SOFTIRQ_SOCFPGA_GPIO_0_18	(IRQ_SOCFPGA_GIC_START + 199)
+#define SOFTIRQ_SOCFPGA_GPIO_0_19	(IRQ_SOCFPGA_GIC_START + 200)
+#define SOFTIRQ_SOCFPGA_GPIO_0_20	(IRQ_SOCFPGA_GIC_START + 201)
+#define SOFTIRQ_SOCFPGA_GPIO_0_21	(IRQ_SOCFPGA_GIC_START + 202)
+#define SOFTIRQ_SOCFPGA_GPIO_0_22	(IRQ_SOCFPGA_GIC_START + 203)
+#define SOFTIRQ_SOCFPGA_GPIO_0_23	(IRQ_SOCFPGA_GIC_START + 204)
+#define SOFTIRQ_SOCFPGA_GPIO_0_24	(IRQ_SOCFPGA_GIC_START + 205)
+#define SOFTIRQ_SOCFPGA_GPIO_0_25	(IRQ_SOCFPGA_GIC_START + 206)
+#define SOFTIRQ_SOCFPGA_GPIO_0_26	(IRQ_SOCFPGA_GIC_START + 207)
+#define SOFTIRQ_SOCFPGA_GPIO_0_27	(IRQ_SOCFPGA_GIC_START + 208)
+#define SOFTIRQ_SOCFPGA_GPIO_0_28	(IRQ_SOCFPGA_GIC_START + 209)
+#define SOFTIRQ_SOCFPGA_GPIO_0_29	(IRQ_SOCFPGA_GIC_START + 210)
+#define SOFTIRQ_SOCFPGA_GPIO_1_0	(IRQ_SOCFPGA_GIC_START + 211)
+#define SOFTIRQ_SOCFPGA_GPIO_1_1	(IRQ_SOCFPGA_GIC_START + 212)
+#define SOFTIRQ_SOCFPGA_GPIO_1_2	(IRQ_SOCFPGA_GIC_START + 213)
+#define SOFTIRQ_SOCFPGA_GPIO_1_3	(IRQ_SOCFPGA_GIC_START + 214)
+#define SOFTIRQ_SOCFPGA_GPIO_1_4	(IRQ_SOCFPGA_GIC_START + 215)
+#define SOFTIRQ_SOCFPGA_GPIO_1_5	(IRQ_SOCFPGA_GIC_START + 216)
+#define SOFTIRQ_SOCFPGA_GPIO_1_6	(IRQ_SOCFPGA_GIC_START + 217)
+#define SOFTIRQ_SOCFPGA_GPIO_1_7	(IRQ_SOCFPGA_GIC_START + 218)
+#define SOFTIRQ_SOCFPGA_GPIO_1_8	(IRQ_SOCFPGA_GIC_START + 219)
+#define SOFTIRQ_SOCFPGA_GPIO_1_9	(IRQ_SOCFPGA_GIC_START + 220)
+#define SOFTIRQ_SOCFPGA_GPIO_1_10	(IRQ_SOCFPGA_GIC_START + 221)
+#define SOFTIRQ_SOCFPGA_GPIO_1_11	(IRQ_SOCFPGA_GIC_START + 222)
+#define SOFTIRQ_SOCFPGA_GPIO_1_12	(IRQ_SOCFPGA_GIC_START + 223)
+#define SOFTIRQ_SOCFPGA_GPIO_1_13	(IRQ_SOCFPGA_GIC_START + 224)
+#define SOFTIRQ_SOCFPGA_GPIO_1_14	(IRQ_SOCFPGA_GIC_START + 225)
+#define SOFTIRQ_SOCFPGA_GPIO_1_15	(IRQ_SOCFPGA_GIC_START + 226)
+#define SOFTIRQ_SOCFPGA_GPIO_1_16	(IRQ_SOCFPGA_GIC_START + 227)
+#define SOFTIRQ_SOCFPGA_GPIO_1_17	(IRQ_SOCFPGA_GIC_START + 228)
+#define SOFTIRQ_SOCFPGA_GPIO_1_18	(IRQ_SOCFPGA_GIC_START + 229)
+#define SOFTIRQ_SOCFPGA_GPIO_1_19	(IRQ_SOCFPGA_GIC_START + 230)
+#define SOFTIRQ_SOCFPGA_GPIO_1_20	(IRQ_SOCFPGA_GIC_START + 231)
+#define SOFTIRQ_SOCFPGA_GPIO_1_21	(IRQ_SOCFPGA_GIC_START + 232)
+#define SOFTIRQ_SOCFPGA_GPIO_1_22	(IRQ_SOCFPGA_GIC_START + 233)
+#define SOFTIRQ_SOCFPGA_GPIO_1_23	(IRQ_SOCFPGA_GIC_START + 234)
+#define SOFTIRQ_SOCFPGA_GPIO_1_24	(IRQ_SOCFPGA_GIC_START + 235)
+#define SOFTIRQ_SOCFPGA_GPIO_1_25	(IRQ_SOCFPGA_GIC_START + 236)
+#define SOFTIRQ_SOCFPGA_GPIO_1_26	(IRQ_SOCFPGA_GIC_START + 237)
+#define SOFTIRQ_SOCFPGA_GPIO_1_27	(IRQ_SOCFPGA_GIC_START + 238)
+#define SOFTIRQ_SOCFPGA_GPIO_1_28	(IRQ_SOCFPGA_GIC_START + 239)
+#define SOFTIRQ_SOCFPGA_GPIO_1_29	(IRQ_SOCFPGA_GIC_START + 240)
+#define SOFTIRQ_SOCFPGA_GPIO_2_0	(IRQ_SOCFPGA_GIC_START + 241)
+#define SOFTIRQ_SOCFPGA_GPIO_2_1	(IRQ_SOCFPGA_GIC_START + 242)
+#define SOFTIRQ_SOCFPGA_GPIO_2_2	(IRQ_SOCFPGA_GIC_START + 243)
+#define SOFTIRQ_SOCFPGA_GPIO_2_3	(IRQ_SOCFPGA_GIC_START + 244)
+#define SOFTIRQ_SOCFPGA_GPIO_2_4	(IRQ_SOCFPGA_GIC_START + 245)
+#define SOFTIRQ_SOCFPGA_GPIO_2_5	(IRQ_SOCFPGA_GIC_START + 246)
+#define SOFTIRQ_SOCFPGA_GPIO_2_6	(IRQ_SOCFPGA_GIC_START + 247)
+#define SOFTIRQ_SOCFPGA_GPIO_2_7	(IRQ_SOCFPGA_GIC_START + 248)
+#define SOFTIRQ_SOCFPGA_GPIO_2_8	(IRQ_SOCFPGA_GIC_START + 249)
+#define SOFTIRQ_SOCFPGA_GPIO_2_9	(IRQ_SOCFPGA_GIC_START + 250)
+#define SOFTIRQ_SOCFPGA_GPIO_2_10	(IRQ_SOCFPGA_GIC_START + 251)
+#define SOFTIRQ_SOCFPGA_GPIO_2_11	(IRQ_SOCFPGA_GIC_START + 252)
+#define SOFTIRQ_SOCFPGA_GPIO_2_12	(IRQ_SOCFPGA_GIC_START + 253)
+#define SOFTIRQ_SOCFPGA_GPIO_2_13	(IRQ_SOCFPGA_GIC_START + 254)
+#define SOFTIRQ_SOCFPGA_GPIO_2_14	(IRQ_SOCFPGA_GIC_START + 255)
+#define SOFTIRQ_SOCFPGA_GPIO_2_15	(IRQ_SOCFPGA_GIC_START + 256)
+#define SOFTIRQ_SOCFPGA_GPIO_2_16	(IRQ_SOCFPGA_GIC_START + 257)
+#define SOFTIRQ_SOCFPGA_GPIO_2_17	(IRQ_SOCFPGA_GIC_START + 258)
+#define SOFTIRQ_SOCFPGA_GPIO_2_18	(IRQ_SOCFPGA_GIC_START + 259)
+#define SOFTIRQ_SOCFPGA_GPIO_2_19	(IRQ_SOCFPGA_GIC_START + 260)
+#define SOFTIRQ_SOCFPGA_GPIO_2_20	(IRQ_SOCFPGA_GIC_START + 261)
+#define SOFTIRQ_SOCFPGA_GPIO_2_21	(IRQ_SOCFPGA_GIC_START + 262)
+#define SOFTIRQ_SOCFPGA_GPIO_2_22	(IRQ_SOCFPGA_GIC_START + 263)
+#define SOFTIRQ_SOCFPGA_GPIO_2_23	(IRQ_SOCFPGA_GIC_START + 264)
+#define SOFTIRQ_SOCFPGA_GPIO_2_24	(IRQ_SOCFPGA_GIC_START + 265)
+#define SOFTIRQ_SOCFPGA_GPIO_2_25	(IRQ_SOCFPGA_GIC_START + 266)
+#define SOFTIRQ_SOCFPGA_GPIO_2_26	(IRQ_SOCFPGA_GIC_START + 267)
+#define SOFTIRQ_SOCFPGA_GPIO_2_27	(IRQ_SOCFPGA_GIC_START + 268)
+#define SOFTIRQ_SOCFPGA_GPIO_2_28	(IRQ_SOCFPGA_GIC_START + 269)
+#define SOFTIRQ_SOCFPGA_GPIO_2_29	(IRQ_SOCFPGA_GIC_START + 270)
+
+#define NR_IRQS			512
+
+#define MAX_GIC_NR		1
+
+#endif	/* __MACH_IRQS_H */
diff --git a/arch/arm/mach-socfpga/include/mach/memory.h b/arch/arm/mach-socfpga/include/mach/memory.h
new file mode 100644
index 0000000..88e0ae9
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/memory.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
+
+#if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
+
+#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_256M - 1)
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_256M)
+#endif
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/smp.h b/arch/arm/mach-socfpga/include/mach/smp.h
new file mode 100644
index 0000000..07cc087
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/smp.h
@@ -0,0 +1,15 @@
+/*
+ * SMP support
+ */
+
+#ifndef __MACH_SMP_H
+#define __MACH_SMP_H
+
+#include <asm/hardware/gic.h>
+
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
+{
+	gic_raise_softirq(mask, ipi);
+}
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/socfpga-timer.h b/arch/arm/mach-socfpga/include/mach/socfpga-timer.h
new file mode 100644
index 0000000..9d577f9
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/socfpga-timer.h
@@ -0,0 +1,27 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+#ifndef __SOCFPGA_TIMER
+#define __SOCFPGA_TIMER
+
+#define SOCFPGA_SP_TIMER_FREQ_HZ 2400000
+#define SOCFPGA_OSC_TIMER_FREQ_HZ 2400000
+
+void dwapbt_clocksource_init(void __iomem *);
+void dwapbt_clockevents_init(void __iomem *, unsigned int);
+
+#endif /* __SOCFPGA_TIMER */
diff --git a/arch/arm/mach-socfpga/include/mach/system.h b/arch/arm/mach-socfpga/include/mach/system.h
new file mode 100644
index 0000000..c76834c
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/system.h
@@ -0,0 +1,31 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
+ *
+ * Modified from arch/arm/mach-realview/include/mach/system.h
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+static inline void arch_idle(void)
+{
+	/*
+	 * This should do all the clock switching
+	 * and wait for interrupt tricks
+	 */
+	cpu_do_idle();
+}
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/timex.h b/arch/arm/mach-socfpga/include/mach/timex.h
new file mode 100644
index 0000000..43df435
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/timex.h
@@ -0,0 +1,19 @@
+/*
+ *  Copyright (C) 2003 ARM Limited
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
+#define CLOCK_TICK_RATE		(50000000 / 16)
diff --git a/arch/arm/mach-socfpga/include/mach/uncompress.h b/arch/arm/mach-socfpga/include/mach/uncompress.h
new file mode 100644
index 0000000..1525dbd
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/uncompress.h
@@ -0,0 +1,44 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+#include <linux/serial_reg.h>
+#include <mach/socfpga_cyclone5.h>
+
+#define UART8250_UART_THR(base)	(*(unsigned char *)((base) + 0x0))
+#define UART8250_UART_LSR(base)	(*(unsigned char *)((base) + 0x14))
+
+/*
+ * This does not append a newline
+ */
+static inline void putc(int c)
+{
+	unsigned long base = SOCFPGA_UART0_BASE;
+
+	while ((UART8250_UART_LSR(base) & UART_LSR_THRE) == 0)
+		barrier();
+
+	UART8250_UART_THR(base) = c;
+}
+
+/*
+ * Not implemented
+ */
+static inline void flush(void)
+{
+}
+
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-socfpga/localtimer.c b/arch/arm/mach-socfpga/localtimer.c
new file mode 100644
index 0000000..4aa9221
--- /dev/null
+++ b/arch/arm/mach-socfpga/localtimer.c
@@ -0,0 +1,34 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/clockchips.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <asm/smp_twd.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+int __cpuinit socfpga_local_timer_setup(struct clock_event_device *evt)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
+	if (!twd_base) {
+		twd_base = of_iomap(np, 0);
+		WARN_ON(!twd_base);
+	}
+	evt->irq = irq_of_parse_and_map(np, 0);
+	twd_timer_setup(evt);
+	return 0;
+}
+
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
new file mode 100644
index 0000000..5cd148f
--- /dev/null
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -0,0 +1,154 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+
+#include <mach/iomap.h>
+#include <mach/socfpga_cyclone5.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach-types.h>
+#include <asm/smp_scu.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+
+#include "common.h"
+
+extern void socfpga_secondary_startup(void);
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+int __cpuinitdata pen_release = -1;
+
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void __cpuinit write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	write_pen_release(-1);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+	/*
+	 * Set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * This is really belt and braces; we hold unintended secondary
+	 * CPUs in the holding pen until we're ready for them.  However,
+	 * since we haven't sent them a soft interrupt, they shouldn't
+	 * be there.
+	 */
+	write_pen_release(cpu_logical_map(cpu));
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * the boot monitor to read the system wide flags register,
+	 * and branch to the address found there.
+	 */
+	gic_raise_softirq(cpumask_of(cpu), 1);
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+static void __iomem *scu_base_addr(void)
+{
+	return __io_address(SOCFPGA_MPUSCU_BASE);
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	void __iomem *scu_base = scu_base_addr();
+	unsigned int i, ncores;
+
+	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+
+	/* sanity check */
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(scu_base_addr());
+
+	/*
+	 * Write the address of secondary startup into the
+	 * system-wide flags register. The BootMonitor waits
+	 * until it receives a soft interrupt, and then the
+	 * secondary CPU branches to this address.
+	 */
+	__raw_writel(virt_to_phys(socfpga_secondary_startup),
+		      __io_address(SOCFPGA_SMP_FLAG));
+}
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 101b968..2f9a81e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -381,7 +381,7 @@ config CPU_V6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_SOCFPGA
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
1.7.9.5
