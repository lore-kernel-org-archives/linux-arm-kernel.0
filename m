From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 09 Mar 2010 18:38:36 +0200
Subject: [RFC/PATCH] ARM: add Tegra support
Message-ID: <4B96798C.6060201@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for Nvidia Tegra2 platform.

 From 13fac106b9383478a3337e443a946286998536d7 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <mike@compulab.co.il>
Date: Tue, 9 Mar 2010 18:35:45 +0200
Subject: [PATCH] ARM: add Tegra support

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
  arch/arm/Kconfig                               |   13 +
  arch/arm/Makefile                              |    1 +
  arch/arm/mach-tegra/Kconfig                    |   27 +
  arch/arm/mach-tegra/Makefile                   |   12 +
  arch/arm/mach-tegra/Makefile.boot              |    1 +
  arch/arm/mach-tegra/board-harmony.c            |   93 +++
  arch/arm/mach-tegra/clock.c                    |  105 +++
  arch/arm/mach-tegra/clock.h                    |   84 +++
  arch/arm/mach-tegra/common.h                   |   26 +
  arch/arm/mach-tegra/gpio.c                     |  335 ++++++++++
  arch/arm/mach-tegra/include/mach/clkdev.h      |   29 +
  arch/arm/mach-tegra/include/mach/debug-macro.S |   29 +
  arch/arm/mach-tegra/include/mach/entry-macro.S |  113 ++++
  arch/arm/mach-tegra/include/mach/gpio.h        |   44 ++
  arch/arm/mach-tegra/include/mach/hardware.h    |   58 ++
  arch/arm/mach-tegra/include/mach/io.h          |   35 +
  arch/arm/mach-tegra/include/mach/irqs.h        |  169 +++++
  arch/arm/mach-tegra/include/mach/memory.h      |   24 +
  arch/arm/mach-tegra/include/mach/system.h      |   34 +
  arch/arm/mach-tegra/include/mach/tegra.h       |  110 ++++
  arch/arm/mach-tegra/include/mach/timex.h       |   22 +
  arch/arm/mach-tegra/include/mach/uncompress.h  |   46 ++
  arch/arm/mach-tegra/include/mach/vmalloc.h     |   22 +
  arch/arm/mach-tegra/io.c                       |   73 +++
  arch/arm/mach-tegra/irq.c                      |   31 +
  arch/arm/mach-tegra/tegra2_clocks.c            |  809 ++++++++++++++++++++++++
  arch/arm/mach-tegra/timer.c                    |  182 ++++++
  27 files changed, 2527 insertions(+), 0 deletions(-)
  create mode 100644 arch/arm/mach-tegra/Kconfig
  create mode 100644 arch/arm/mach-tegra/Makefile
  create mode 100644 arch/arm/mach-tegra/Makefile.boot
  create mode 100644 arch/arm/mach-tegra/board-harmony.c
  create mode 100644 arch/arm/mach-tegra/clock.c
  create mode 100644 arch/arm/mach-tegra/clock.h
  create mode 100644 arch/arm/mach-tegra/common.h
  create mode 100644 arch/arm/mach-tegra/gpio.c
  create mode 100644 arch/arm/mach-tegra/include/mach/clkdev.h
  create mode 100644 arch/arm/mach-tegra/include/mach/debug-macro.S
  create mode 100644 arch/arm/mach-tegra/include/mach/entry-macro.S
  create mode 100644 arch/arm/mach-tegra/include/mach/gpio.h
  create mode 100644 arch/arm/mach-tegra/include/mach/hardware.h
  create mode 100644 arch/arm/mach-tegra/include/mach/io.h
  create mode 100644 arch/arm/mach-tegra/include/mach/irqs.h
  create mode 100644 arch/arm/mach-tegra/include/mach/memory.h
  create mode 100644 arch/arm/mach-tegra/include/mach/system.h
  create mode 100644 arch/arm/mach-tegra/include/mach/tegra.h
  create mode 100644 arch/arm/mach-tegra/include/mach/timex.h
  create mode 100644 arch/arm/mach-tegra/include/mach/uncompress.h
  create mode 100644 arch/arm/mach-tegra/include/mach/vmalloc.h
  create mode 100644 arch/arm/mach-tegra/io.c
  create mode 100644 arch/arm/mach-tegra/irq.c
  create mode 100644 arch/arm/mach-tegra/tegra2_clocks.c
  create mode 100644 arch/arm/mach-tegra/timer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3b18128..d479cd8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -750,6 +750,17 @@ config ARCH_U8500
  	help
  	  Support for ST-Ericsson's Ux500 architecture

+config ARCH_TEGRA
+        bool "NVIDIA Tegra"
+        select GENERIC_TIME
+        select GENERIC_CLOCKEVENTS
+        select GENERIC_GPIO
+        select HAVE_CLK
+        select COMMON_CLKDEV
+        help
+          This enables support for NVIDIA Tegra based systems (Tegra APX,
+          Tegra 6xx and Tegra 2 series).
+
  endchoice

  source "arch/arm/mach-aaec2000/Kconfig"
@@ -852,6 +863,8 @@ if ARCH_S5PC1XX
  source "arch/arm/mach-s5pc100/Kconfig"
  endif

+source "arch/arm/mach-tegra/Kconfig"
+
  source "arch/arm/mach-u300/Kconfig"

  source "arch/arm/mach-ux500/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 81f54ca..9f2a5fe 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -167,6 +167,7 @@ machine-$(CONFIG_ARCH_SA1100)		:= sa1100
  machine-$(CONFIG_ARCH_SHARK)		:= shark
  machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
  machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
+machine-$(CONFIG_ARCH_TEGRA)		:= tegra
  machine-$(CONFIG_ARCH_U300)		:= u300
  machine-$(CONFIG_ARCH_U8500)		:= ux500
  machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
new file mode 100644
index 0000000..731405f
--- /dev/null
+++ b/arch/arm/mach-tegra/Kconfig
@@ -0,0 +1,27 @@
+if ARCH_TEGRA
+
+comment "NVIDIA Tegra options"
+
+choice
+	prompt "Tegra processor family"
+
+config ARCH_TEGRA_2x_SOC
+	bool "Tegra 2 family"
+	select CPU_V7
+	select ARM_GIC
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
+	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
+
+endchoice
+
+
+comment "Tegra-based boards"
+
+config MACH_HARMONY
+       bool "Harmony board"
+       help
+         Support for nVidia Harmony development platform
+
+endif
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
new file mode 100644
index 0000000..ed4fb3b
--- /dev/null
+++ b/arch/arm/mach-tegra/Makefile
@@ -0,0 +1,12 @@
+#
+# Makefile for the linux kernel.
+#
+
+# Common support
+obj-y += irq.o io.o
+
+# SoC-specific support
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)	+= clock.o tegra2_clocks.o timer.o gpio.o
+
+# Board-specific support
+obj-$(CONFIG_MACH_HARMONY) += board-harmony.o
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
new file mode 100644
index 0000000..dae9661
--- /dev/null
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
new file mode 100644
index 0000000..f713393
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -0,0 +1,93 @@
+/*
+ * arch/arm/mach-tegra/board-harmony.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/clk.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/setup.h>
+
+#include <mach/hardware.h>
+
+#include "common.h"
+
+static struct plat_serial8250_port debug_uart_platform_data[] = {
+	{
+		.membase	= IO_ADDRESS(TEGRA_UARTD_BASE),
+		.mapbase	= TEGRA_UARTD_BASE,
+		.irq		= INT_UARTD,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 216000000/16 * 16,
+	}, {
+		.flags		= 0
+	}
+};
+
+static struct platform_device debug_uart = {
+	.name = "serial8250",
+	.id = 0,
+	.dev = {
+		.platform_data = debug_uart_platform_data,
+	},
+};
+
+static struct platform_device *harmony_devices[] __initdata = {
+	&debug_uart,
+};
+
+static void __init tegra_harmony_fixup(struct machine_desc *desc,
+				       struct tag *tags,
+				       char **cmdline, struct meminfo *mi)
+{
+	mi->nr_banks = 2;
+	mi->bank[0].start = PHYS_OFFSET;
+	mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
+	mi->bank[0].size = (448*1024*1024);
+	mi->bank[1].start = 512*1024*1024;
+	mi->bank[1].node = PHYS_TO_NID(512*1024*1024);
+	mi->bank[1].size = (512*1024*1024);
+}
+
+static void __init tegra_harmony_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_get_sys(NULL, "pll_p");
+	clk_enable(clk);
+	clk_set_rate(clk, 216000000);
+
+	clk = clk_get_sys("uart.3", NULL);
+	clk_set_rate(clk, 216000000);
+	clk_enable(clk);
+
+	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
+}
+
+MACHINE_START(HARMONY, "harmony")
+	.boot_params  = 0x00000100,
+	.phys_io        = IO_APB_PHYS,
+	.io_pg_offst    = ((IO_APB_VIRT) >> 18) & 0xfffc,
+	.timer          = &tegra_timer,
+	.init_irq       = tegra_init_irq,
+	.map_io         = tegra_map_common_io,
+	.init_machine   = tegra_harmony_init,
+	.fixup		= tegra_harmony_fixup,
+MACHINE_END
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
new file mode 100644
index 0000000..729ddb5
--- /dev/null
+++ b/arch/arm/mach-tegra/clock.c
@@ -0,0 +1,105 @@
+/*
+ * arch/arm/mach-tegra/clock.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/clkdev.h>
+
+#include "clock.h"
+
+static DEFINE_SPINLOCK(clk_spinlock);
+
+int clk_enable(struct clk *c)
+{
+	int ret = 0;
+	unsigned long flags;
+	if (c->refcnt == 0) {
+		if (c->parent) {
+			ret = clk_enable(c->parent);
+			if (ret)
+				goto err;
+		}
+
+		if (c->ops && c->ops->enable) {
+			spin_lock_irqsave(&clk_spinlock, flags);
+			ret = c->ops->enable(c);
+			spin_unlock_irqrestore(&clk_spinlock, flags);
+			if (ret) {
+				if (c->parent)
+					clk_disable(c->parent);
+				goto err;
+			}
+		}
+	}
+	c->refcnt++;
+err:
+	return ret;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *c)
+{
+	unsigned long flags;
+	if (c->refcnt == 0) {
+		WARN(1, "Trying to disable clock %s with refcnt 0", c->name);
+		return;
+	}
+
+	if (c->refcnt == 1) {
+		if (c->parent)
+			clk_disable(c->parent);
+
+		if (c->ops && c->ops->disable) {
+			spin_lock_irqsave(&clk_spinlock, flags);
+			c->ops->disable(c);
+			spin_unlock_irqrestore(&clk_spinlock, flags);
+		}
+	}
+	c->refcnt--;
+}
+EXPORT_SYMBOL(clk_disable);
+
+int clk_set_parent(struct clk *c, struct clk *parent)
+{
+	if (c->ops && c->ops->set_parent)
+		return c->ops->set_parent(c, parent);
+	else
+		BUG();
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+int clk_set_rate(struct clk *c, unsigned long rate)
+{
+	if (c->ops && c->ops->set_rate)
+		return c->ops->set_rate(c, rate);
+	else
+		BUG();
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+unsigned long clk_get_rate(struct clk *c)
+{
+	if (c->ops && c->ops->get_rate)
+		return c->ops->get_rate(c);
+	else if (c->parent)
+		return clk_get_rate(c->parent);
+	else
+		BUG();
+}
+EXPORT_SYMBOL(clk_get_rate);
diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
new file mode 100644
index 0000000..a6c77bb
--- /dev/null
+++ b/arch/arm/mach-tegra/clock.h
@@ -0,0 +1,84 @@
+/*
+ * arch/arm/mach-tegra/include/mach/clock.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define ENABLE_ON_INIT	0x00000001
+#define DIV_U71 	0x00000002
+#define DIV_U71_FIXED	0x00000004
+#define DIV_2		0x00000008
+#define PLL_FIXED 	0x00000010
+#define PLL_HAS_CPCON 	0x00000020
+#define MUX		0x00000040
+
+struct clk;
+
+struct clk_mux_sel {
+	struct clk	*input;
+	u32		value;
+};
+
+struct clk_pll_table {
+	unsigned long   input_rate;
+	unsigned long   output_rate;
+	u16             n;
+	u16             m;
+	u8              p;
+	u8              cpcon;
+};
+
+struct clk_ops {
+	void		(*init)(struct clk *);
+	int		(*enable)(struct clk *);
+	void		(*disable)(struct clk *);
+	void		(*recalc)(struct clk *);
+	int		(*set_parent)(struct clk *, struct clk *);
+	int		(*set_rate)(struct clk *, unsigned long);
+	unsigned long   (*get_rate)(struct clk *);
+	long		(*round_rate)(struct clk *, unsigned long);
+};
+
+struct clk {
+	const char			*name;
+	struct clk_ops			*ops;
+	struct clk			*parent;
+	unsigned long			rate;
+	u32				flags;
+	u32				refcnt;
+	u32				reg;
+	u32				reg_shift;
+	unsigned int                    clk_num;
+
+	/* PLL */
+	unsigned long			input_min;
+	unsigned long			input_max;
+	unsigned long			cf_min;
+	unsigned long			cf_max;
+	unsigned long			vco_min;
+	unsigned long			vco_max;
+	u32				m;
+	u32				n;
+	u32				p;
+	u32                             cpcon;
+	const struct clk_pll_table      *pll_table;
+
+	/* DIV */
+
+	/* MUX */
+	const struct clk_mux_sel 	*inputs;
+	u32                     	sel;
+	u32                     	reg_mask;
+};
+
+extern void tegra2_arch_clk_init(void);
diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
new file mode 100644
index 0000000..4430e36
--- /dev/null
+++ b/arch/arm/mach-tegra/common.h
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-tegra/include/mach/board.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_BOARD_H
+#define __MACH_TEGRA_BOARD_H
+
+extern struct sys_timer tegra_timer;
+
+void __init tegra_map_common_io(void);
+void __init tegra_init_irq(void);
+void __init tegra_init_clock(void);
+
+#endif
diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
new file mode 100644
index 0000000..9625bd2
--- /dev/null
+++ b/arch/arm/mach-tegra/gpio.c
@@ -0,0 +1,335 @@
+/*
+ * arch/arm/mach-tegra/gpio.c
+ *
+ * Copyright (c) 2010 Google, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/gpio.h>
+
+#include <mach/hardware.h>
+
+#define GPIO_BANK(x)		((x) >> 5)
+#define GPIO_PORT(x)		(((x) >> 3) & 0x3)
+#define GPIO_BIT(x)		((x) & 0x7)
+
+#define GPIO_REG(x)		(IO_TO_VIRT(TEGRA_GPIO_BASE) +	\
+				 GPIO_BANK(x) * 0x80 +		\
+				 GPIO_PORT(x) * 4)
+
+#define GPIO_CNF(x)		(GPIO_REG(x) + 0x00)
+#define GPIO_OE(x)		(GPIO_REG(x) + 0x10)
+#define GPIO_OUT(x)		(GPIO_REG(x) + 0X20)
+#define GPIO_IN(x)		(GPIO_REG(x) + 0x30)
+#define GPIO_INT_STA(x)		(GPIO_REG(x) + 0x40)
+#define GPIO_INT_ENB(x)		(GPIO_REG(x) + 0x50)
+#define GPIO_INT_LVL(x)		(GPIO_REG(x) + 0x60)
+#define GPIO_INT_CLR(x)		(GPIO_REG(x) + 0x70)
+
+#define GPIO_MSK_CNF(x)		(GPIO_REG(x) + 0x800)
+#define GPIO_MSK_OE(x)		(GPIO_REG(x) + 0x810)
+#define GPIO_MSK_OUT(x)		(GPIO_REG(x) + 0X820)
+#define GPIO_MSK_INT_STA(x)	(GPIO_REG(x) + 0x840)
+#define GPIO_MSK_INT_ENB(x)	(GPIO_REG(x) + 0x850)
+#define GPIO_MSK_INT_LVL(x)	(GPIO_REG(x) + 0x860)
+
+#define GPIO_INT_LVL_MASK		0x010101
+#define GPIO_INT_LVL_EDGE_RISING	0x000101
+#define GPIO_INT_LVL_EDGE_FALLING	0x000100
+#define GPIO_INT_LVL_EDGE_BOTH		0x010100
+#define GPIO_INT_LVL_LEVEL_HIGH		0x000001
+#define GPIO_INT_LVL_LEVEL_LOW		0x000000
+
+struct tegra_gpio_bank {
+	int bank;
+	int irq;
+	spinlock_t lvl_lock[4];
+};
+
+static struct tegra_gpio_bank tegra_gpio_banks[] = {
+	{.bank = 0, .irq = INT_GPIO1},
+	{.bank = 1, .irq = INT_GPIO2},
+	{.bank = 2, .irq = INT_GPIO3},
+	{.bank = 3, .irq = INT_GPIO4},
+	{.bank = 4, .irq = INT_GPIO5},
+	{.bank = 5, .irq = INT_GPIO6},
+	{.bank = 6, .irq = INT_GPIO7},
+};
+
+static int tegra_gpio_compose(int bank, int port, int bit)
+{
+	return (bank << 5) | ((port & 0x3) << 3) | (bit & 0x7);
+}
+
+static void tegra_gpio_mask_write(u32 reg, int gpio, int value)
+{
+	u32 val;
+
+	val = 0x100 << GPIO_BIT(gpio);
+	if (value)
+		val |= 1 << GPIO_BIT(gpio);
+	__raw_writel(val, reg);
+}
+
+static void tegra_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	tegra_gpio_mask_write(GPIO_MSK_OUT(offset), offset, value);
+}
+
+static int tegra_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	return (__raw_readl(GPIO_IN(offset)) >> GPIO_BIT(offset)) & 0x1;
+}
+
+static int tegra_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	tegra_gpio_mask_write(GPIO_MSK_OE(offset), offset, 0);
+	return 0;
+}
+
+static int tegra_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+					int value)
+{
+	tegra_gpio_mask_write(GPIO_MSK_OE(offset), offset, 1);
+	return 0;
+}
+
+static struct gpio_chip tegra_gpio_chip = {
+	.label			= "tegra-gpio",
+	.direction_input	= tegra_gpio_direction_input,
+	.get			= tegra_gpio_get,
+	.direction_output	= tegra_gpio_direction_output,
+	.set			= tegra_gpio_set,
+	.base			= 0,
+	.ngpio			= ARCH_NR_GPIOS,
+};
+
+static void tegra_gpio_irq_ack(unsigned int irq)
+{
+	int gpio = irq - INT_GPIO_BASE;
+
+	__raw_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
+}
+
+static void tegra_gpio_irq_mask(unsigned int irq)
+{
+	int gpio = irq - INT_GPIO_BASE;
+
+	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 0);
+}
+
+static void tegra_gpio_irq_unmask(unsigned int irq)
+{
+	int gpio = irq - INT_GPIO_BASE;
+
+	tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 1);
+}
+
+static int tegra_gpio_irq_set_type(unsigned int irq, unsigned int type)
+{
+	int gpio = irq - INT_GPIO_BASE;
+	struct tegra_gpio_bank *bank = get_irq_data(irq);
+	int port = GPIO_PORT(gpio);
+	int lvl_type;
+	int val;
+	unsigned long flags;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		lvl_type = GPIO_INT_LVL_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		lvl_type = GPIO_INT_LVL_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		lvl_type = GPIO_INT_LVL_EDGE_BOTH;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		lvl_type = GPIO_INT_LVL_LEVEL_HIGH;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		lvl_type = GPIO_INT_LVL_LEVEL_LOW;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&bank->lvl_lock[port], flags);
+
+	val = __raw_readl(GPIO_INT_LVL(gpio));
+	val &= ~(GPIO_INT_LVL_MASK << GPIO_BIT(gpio));
+	val |= lvl_type << GPIO_BIT(gpio);
+	__raw_writel(val, GPIO_INT_LVL(gpio));
+
+	spin_unlock_irqrestore(&bank->lvl_lock[port], flags);
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
+		__set_irq_handler_unlocked(irq, handle_level_irq);
+	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
+		__set_irq_handler_unlocked(irq, handle_edge_irq);
+
+	return 0;
+}
+
+static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct tegra_gpio_bank *bank;
+	int port;
+	int pin;
+	int unmasked = 0;
+
+	desc->chip->ack(irq);
+
+	bank = get_irq_data(irq);
+
+	for (port = 0; port < 4; port++) {
+		int gpio = tegra_gpio_compose(bank->bank, port, 0);
+		unsigned long sta = __raw_readl(GPIO_INT_STA(gpio)) &
+			__raw_readl(GPIO_INT_ENB(gpio));
+		u32 lvl = __raw_readl(GPIO_INT_LVL(gpio));
+
+		for_each_bit(pin, &sta, 8) {
+			__raw_writel(1 << pin, GPIO_INT_CLR(gpio));
+
+			/* if gpio is edge triggered, clear condition
+			 * before executing the hander so that we don't
+			 * miss edges
+			 */
+			if (lvl & (0x100 << pin)) {
+				unmasked = 1;
+				desc->chip->unmask(irq);
+			}
+
+			generic_handle_irq(gpio_to_irq(gpio + pin));
+		}
+	}
+
+	if (!unmasked)
+		desc->chip->unmask(irq);
+
+}
+
+
+static struct irq_chip tegra_gpio_irq_chip = {
+	.name		= "GPIO",
+	.ack		= tegra_gpio_irq_ack,
+	.mask		= tegra_gpio_irq_mask,
+	.unmask		= tegra_gpio_irq_unmask,
+	.set_type	= tegra_gpio_irq_set_type,
+};
+
+
+/* This lock class tells lockdep that GPIO irqs are in a different
+ * category than their parents, so it won't report false recursion.
+ */
+static struct lock_class_key gpio_lock_class;
+
+static int __init tegra_gpio_init(void)
+{
+	struct tegra_gpio_bank *bank;
+	int i;
+	int j;
+
+	for (i = 0; i < 7; i++) {
+		for (j = 0; j < 4; j++) {
+			int gpio = tegra_gpio_compose(i, j, 0);
+			__raw_writel(0x00, GPIO_INT_ENB(gpio));
+		}
+	}
+
+	gpiochip_add(&tegra_gpio_chip);
+
+	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + ARCH_NR_GPIOS); i++) {
+		bank = &tegra_gpio_banks[GPIO_BANK(i)];
+
+		lockdep_set_class(&irq_desc[i].lock, &gpio_lock_class);
+		set_irq_chip_data(i, bank);
+		set_irq_chip(i, &tegra_gpio_irq_chip);
+		set_irq_handler(i, handle_simple_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
+		bank = &tegra_gpio_banks[i];
+
+		set_irq_chained_handler(bank->irq, tegra_gpio_irq_handler);
+		set_irq_data(bank->irq, bank);
+
+		for (j = 0; j < 4; j++)
+			spin_lock_init(&bank->lvl_lock[j]);
+	}
+
+	return 0;
+}
+
+postcore_initcall(tegra_gpio_init);
+
+#ifdef	CONFIG_DEBUG_FS
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static int dbg_gpio_show(struct seq_file *s, void *unused)
+{
+	int i;
+	int j;
+
+	for (i = 0; i < 7; i++) {
+		for (j = 0; j < 4; j++) {
+			int gpio = tegra_gpio_compose(i, j, 0);
+			seq_printf(s, "%d:%d %02x %02x %02x %02x %02x %02x %06x\n",
+			       i, j,
+			       __raw_readl(GPIO_CNF(gpio)),
+			       __raw_readl(GPIO_OE(gpio)),
+			       __raw_readl(GPIO_OUT(gpio)),
+			       __raw_readl(GPIO_IN(gpio)),
+			       __raw_readl(GPIO_INT_STA(gpio)),
+			       __raw_readl(GPIO_INT_ENB(gpio)),
+			       __raw_readl(GPIO_INT_LVL(gpio)));
+		}
+	}
+	return 0;
+}
+
+static int dbg_gpio_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dbg_gpio_show, &inode->i_private);
+}
+
+static const struct file_operations debug_fops = {
+	.open		= dbg_gpio_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init tegra_gpio_debuginit(void)
+{
+	(void) debugfs_create_file("tegra_gpio", S_IRUGO,
+					NULL, NULL, &debug_fops);
+	return 0;
+}
+late_initcall(tegra_gpio_debuginit);
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/clkdev.h b/arch/arm/mach-tegra/include/mach/clkdev.h
new file mode 100644
index 0000000..f3dd0d3
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/clkdev.h
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-tegra/include/mach/clkdev.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_CLKDEV_H
+#define __MACH_CLKDEV_H
+
+static inline int __clk_get(struct clk *clk)
+{
+	return 1;
+}
+
+static inline void __clk_put(struct clk *clk)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/mach-tegra/include/mach/debug-macro.S
new file mode 100644
index 0000000..0c119f3
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/debug-macro.S
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-tegra/include/mach/debug-macro.S
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <mach/hardware.h>
+
+	.macro  addruart, rx, tmp
+        mrc     p15, 0, \rx, c1, c0
+        tst     \rx, #1                 @ MMU enabled?
+        ldreq   \rx, =IO_APB_PHYS       @ physical
+        ldrne   \rx, =IO_APB_VIRT       @ virtual
+        orr     \rx, \rx, #0x6300	@ UART D
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
+
diff --git a/arch/arm/mach-tegra/include/mach/entry-macro.S b/arch/arm/mach-tegra/include/mach/entry-macro.S
new file mode 100644
index 0000000..05a618c
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/entry-macro.S
@@ -0,0 +1,113 @@
+/*
+ * arch/arm/mach-tegra/include/mach/entry-macro.S
+ *
+ * Copyright (C) 2009 Palm, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <mach/hardware.h>
+
+#if defined(CONFIG_ARM_GIC)
+
+#include <asm/hardware/gic.h>
+
+	/* Uses the GIC interrupt controller built into the cpu */
+#define ICTRL_BASE (IO_CPU_VIRT + 0x100)
+
+	.macro	disable_fiq
+	.endm
+
+	.macro	get_irqnr_preamble, base, tmp
+	movw \base, #(ICTRL_BASE & 0x0000ffff)
+	movt \base, #((ICTRL_BASE & 0xffff0000) >> 16)
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	/*
+	 * The interrupt numbering scheme is defined in the
+	 * interrupt controller spec.  To wit:
+	 *
+	 * Interrupts 0-15 are IPI
+	 * 16-28 are reserved
+	 * 29-31 are local.  We allow 30 to be used for the watchdog.
+	 * 32-1020 are global
+	 * 1021-1022 are reserved
+	 * 1023 is "spurious" (no interrupt)
+	 *
+	 * For now, we ignore all local interrupts so only return an
+	 * interrupt if it's between 30 and 1020.  The test_for_ipi
+	 * routine below will pick up on IPIs.
+	 *
+	 * A simple read from the controller will tell us the number
+	 * of the highest priority enabled interrupt.  We then just
+	 * need to check whether it is in the valid range for an IRQ
+	 * (30-1020 inclusive).
+	 */
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+	/* bits 12-10 = src CPU, 9-0 = int # */
+	ldr     \irqstat, [\base, #GIC_CPU_INTACK]
+	ldr	\tmp, =1021
+	bic     \irqnr, \irqstat, #0x1c00
+	cmp     \irqnr, #29
+	cmpcc	\irqnr, \irqnr
+	cmpne	\irqnr, \tmp
+	cmpcs	\irqnr, \irqnr
+	.endm
+
+	/*
+	 * We assume that irqstat (the raw value of the IRQ acknowledge
+	 * register) is preserved from the macro above.
+	 * If there is an IPI, we immediately signal end of interrupt on the
+	 * controller, since this requires the original irqstat value which
+	 * we won't easily be able to recreate later.
+	 */
+	.macro test_for_ipi, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	cmp	\irqnr, #16
+	strcc	\irqstat, [\base, #GIC_CPU_EOI]
+	cmpcs	\irqnr, \irqnr
+	.endm
+
+	/* As above, this assumes that irqstat and base are preserved.. */
+	.macro test_for_ltirq, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	mov 	\tmp, #0
+	cmp	\irqnr, #29
+	moveq	\tmp, #1
+	streq	\irqstat, [\base, #GIC_CPU_EOI]
+	cmp	\tmp, #0
+	.endm
+
+#else
+	/* legacy interrupt controller for AP16 */
+	.macro	disable_fiq
+	.endm
+
+	.macro	get_irqnr_preamble, base, tmp
+	@ enable imprecise aborts
+	cpsie	a
+	@ EVP base at 0xf010f000
+	mov \base, #0xf0000000
+	orr \base, #0x00100000
+	orr \base, #0x0000f000
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr \irqnr, [\base, #0x20]	@ EVT_IRQ_STS
+	cmp \irqnr, #0x80
+	.endm
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
new file mode 100644
index 0000000..612f49e
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -0,0 +1,44 @@
+/*
+ * arch/arm/mach-tegra/include/mach/gpio.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_GPIO_H
+#define __MACH_TEGRA_GPIO_H
+
+#include <mach/irqs.h>
+
+#define ARCH_NR_GPIOS		INT_GPIO_NR
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value		__gpio_get_value
+#define gpio_set_value		__gpio_set_value
+#define gpio_cansleep		__gpio_cansleep
+
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	if (gpio < ARCH_NR_GPIOS)
+		return INT_GPIO_BASE + gpio;
+	return -EINVAL;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	if ((irq >= INT_GPIO_BASE) && (irq < INT_GPIO_BASE + INT_GPIO_NR))
+		return irq - INT_GPIO_BASE;
+	return -EINVAL;
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/hardware.h b/arch/arm/mach-tegra/include/mach/hardware.h
new file mode 100644
index 0000000..381adb1
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/hardware.h
@@ -0,0 +1,58 @@
+/*
+ * arch/arm/mach-tegra/include/mach/hardware.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_HARDWARE_H
+#define __MACH_TEGRA_HARDWARE_H
+
+#include "tegra.h"
+
+/* On TEGRA, many peripherals are very closely packed in
+ * two 256MB io windows (that actually only use about 64KB
+ *@the start of each).
+ *
+ * We will just map the first 1MB of each window (to minimize
+ * pt entries needed) and provide a macro to transform physical
+ * io addresses to an appropriate void __iomem *.
+ *
+ */
+
+#define IO_CPU_PHYS     0x50040000
+#define IO_CPU_VIRT     0xFE000000
+#define IO_CPU_SIZE	SZ_16K
+
+#define IO_PPSB_PHYS	0x60000000
+#define IO_PPSB_VIRT	0xFE200000
+#define IO_PPSB_SIZE	SZ_1M
+
+#define IO_APB_PHYS	0x70000000
+#define IO_APB_VIRT	0xFE300000
+#define IO_APB_SIZE	SZ_1M
+
+#define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
+#define IO_TO_VIRT_XLATE(p, pst, vst)	(((p) - (pst) + (vst)))
+
+#define IO_TO_VIRT(n) ( \
+	IO_TO_VIRT_BETWEEN((n), IO_PPSB_PHYS, IO_PPSB_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_PPSB_PHYS, IO_PPSB_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_APB_PHYS, IO_APB_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_APB_PHYS, IO_APB_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_CPU_PHYS, IO_CPU_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_CPU_PHYS, IO_CPU_VIRT) :	\
+	0)
+
+#define IO_ADDRESS(n) ((void __iomem *) IO_TO_VIRT(n))
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
new file mode 100644
index 0000000..7198934
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/mach-tegra/include/mach/io.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_IO_H
+#define __MACH_TEGRA_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+#define __io(a)         __typesafe_io(a)
+#define __mem_pci(a)    (a)
+
+#ifndef __ASSEMBLER__
+
+#define __arch_ioremap(p, s, t)	tegra_ioremap(p, s, t)
+#define __arch_iounmap(v)	tegra_iounmap(v)
+
+void __iomem *tegra_ioremap(unsigned long phys, size_t size, unsigned int type);
+void tegra_iounmap(volatile void __iomem *addr);
+
+#endif
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/irqs.h b/arch/arm/mach-tegra/include/mach/irqs.h
new file mode 100644
index 0000000..230fae3
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/irqs.h
@@ -0,0 +1,169 @@
+/*
+ * arch/arm/mach-tegra/include/mach/irqs.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_IRQS_H
+#define __MACH_TEGRA_IRQS_H
+
+#define INT_GIC_BASE			0
+
+#define IRQ_LOCALTIMER                  29
+
+/* Primary Interrupt Controller */
+#define INT_PRI_BASE			(INT_GIC_BASE + 32)
+#define INT_TMR1			(INT_PRI_BASE + 0)
+#define INT_TMR2			(INT_PRI_BASE + 1)
+#define INT_RTC				(INT_PRI_BASE + 2)
+#define INT_I2S2			(INT_PRI_BASE + 3)
+#define INT_SHR_SEM_INBOX_IBF		(INT_PRI_BASE + 4)
+#define INT_SHR_SEM_INBOX_IBE		(INT_PRI_BASE + 5)
+#define INT_SHR_SEM_OUTBOX_IBF		(INT_PRI_BASE + 6)
+#define INT_SHR_SEM_OUTBOX_IBE		(INT_PRI_BASE + 7)
+#define INT_VDE_UCQ_ERROR		(INT_PRI_BASE + 8)
+#define INT_VDE_SYNC_TOKEN		(INT_PRI_BASE + 9)
+#define INT_VDE_BSE_V			(INT_PRI_BASE + 10)
+#define INT_VDE_BSE_A			(INT_PRI_BASE + 11)
+#define INT_VDE_SXE			(INT_PRI_BASE + 12)
+#define INT_I2S1			(INT_PRI_BASE + 13)
+#define INT_SDMMC1			(INT_PRI_BASE + 14)
+#define INT_SDMMC2			(INT_PRI_BASE + 15)
+#define INT_XIO				(INT_PRI_BASE + 16)
+#define INT_VDE				(INT_PRI_BASE + 17)
+#define INT_AVP_UCQ			(INT_PRI_BASE + 18)
+#define INT_SDMMC3			(INT_PRI_BASE + 19)
+#define INT_USB				(INT_PRI_BASE + 20)
+#define INT_USB2			(INT_PRI_BASE + 21)
+#define INT_PRI_RES_22			(INT_PRI_BASE + 22)
+#define INT_EIDE			(INT_PRI_BASE + 23)
+#define INT_NANDFLASH			(INT_PRI_BASE + 24)
+#define INT_VCP				(INT_PRI_BASE + 25)
+#define INT_APB_DMA			(INT_PRI_BASE + 26)
+#define INT_AHB_DMA			(INT_PRI_BASE + 27)
+#define INT_GNT_0			(INT_PRI_BASE + 28)
+#define INT_GNT_1			(INT_PRI_BASE + 29)
+#define INT_OWR				(INT_PRI_BASE + 30)
+#define INT_SDMMC4			(INT_PRI_BASE + 31)
+
+/* Secondary Interrupt Controller */
+#define INT_SEC_BASE			(INT_PRI_BASE + 32)
+#define INT_GPIO1			(INT_SEC_BASE + 0)
+#define INT_GPIO2			(INT_SEC_BASE + 1)
+#define INT_GPIO3			(INT_SEC_BASE + 2)
+#define INT_GPIO4			(INT_SEC_BASE + 3)
+#define INT_UARTA			(INT_SEC_BASE + 4)
+#define INT_UARTB			(INT_SEC_BASE + 5)
+#define INT_I2C				(INT_SEC_BASE + 6)
+#define INT_SPI				(INT_SEC_BASE + 7)
+#define INT_TWC				(INT_SEC_BASE + 8)
+#define INT_TMR3			(INT_SEC_BASE + 9)
+#define INT_TMR4			(INT_SEC_BASE + 10)
+#define INT_FLOW_RSM0			(INT_SEC_BASE + 11)
+#define INT_FLOW_RSM1			(INT_SEC_BASE + 12)
+#define INT_SPDIF			(INT_SEC_BASE + 13)
+#define INT_UARTC			(INT_SEC_BASE + 14)
+#define INT_MIPI			(INT_SEC_BASE + 15)
+#define INT_EVENTA			(INT_SEC_BASE + 16)
+#define INT_EVENTB			(INT_SEC_BASE + 17)
+#define INT_EVENTC			(INT_SEC_BASE + 18)
+#define INT_EVENTD			(INT_SEC_BASE + 19)
+#define INT_VFIR			(INT_SEC_BASE + 20)
+#define INT_DVC				(INT_SEC_BASE + 21)
+#define INT_SYS_STATS_MON		(INT_SEC_BASE + 22)
+#define INT_GPIO5			(INT_SEC_BASE + 23)
+#define INT_CPU0_PMU_INTR		(INT_SEC_BASE + 24)
+#define INT_CPU2_PMU_INTR		(INT_SEC_BASE + 25)
+#define INT_SEC_RES_26			(INT_SEC_BASE + 26)
+#define INT_S_LINK1			(INT_SEC_BASE + 27)
+#define INT_APB_DMA_COP			(INT_SEC_BASE + 28)
+#define INT_AHB_DMA_COP			(INT_SEC_BASE + 29)
+#define INT_DMA_TX			(INT_SEC_BASE + 30)
+#define INT_DMA_RX			(INT_SEC_BASE + 31)
+
+/* Tertiary Interrupt Controller */
+#define INT_TRI_BASE			(INT_SEC_BASE + 32)
+#define INT_HOST1X_COP_SYNCPT		(INT_TRI_BASE + 0)
+#define INT_HOST1X_MPCORE_SYNCPT	(INT_TRI_BASE + 1)
+#define INT_HOST1X_COP_GENERAL		(INT_TRI_BASE + 2)
+#define INT_HOST1X_MPCORE_GENERAL	(INT_TRI_BASE + 3)
+#define INT_MPE_GENERAL			(INT_TRI_BASE + 4)
+#define INT_VI_GENERAL			(INT_TRI_BASE + 5)
+#define INT_EPP_GENERAL			(INT_TRI_BASE + 6)
+#define INT_ISP_GENERAL			(INT_TRI_BASE + 7)
+#define INT_2D_GENERAL			(INT_TRI_BASE + 8)
+#define INT_DISPLAY_GENERAL		(INT_TRI_BASE + 9)
+#define INT_DISPLAY_B_GENERAL		(INT_TRI_BASE + 10)
+#define INT_HDMI			(INT_TRI_BASE + 11)
+#define INT_TVO_GENERAL			(INT_TRI_BASE + 12)
+#define INT_MC_GENERAL			(INT_TRI_BASE + 13)
+#define INT_EMC_GENERAL			(INT_TRI_BASE + 14)
+#define INT_TRI_RES_15			(INT_TRI_BASE + 15)
+#define INT_TRI_RES_16			(INT_TRI_BASE + 16)
+#define INT_AC97			(INT_TRI_BASE + 17)
+#define INT_SPI_2			(INT_TRI_BASE + 18)
+#define INT_SPI_3			(INT_TRI_BASE + 19)
+#define INT_I2C2			(INT_TRI_BASE + 20)
+#define INT_KBC				(INT_TRI_BASE + 21)
+#define INT_EXTERNAL_PMU		(INT_TRI_BASE + 22)
+#define INT_GPIO6			(INT_TRI_BASE + 23)
+#define INT_TVDAC			(INT_TRI_BASE + 24)
+#define INT_GPIO7			(INT_TRI_BASE + 25)
+#define INT_UARTD			(INT_TRI_BASE + 26)
+#define INT_UARTE			(INT_TRI_BASE + 27)
+#define INT_I2C3			(INT_TRI_BASE + 28)
+#define INT_SPI4			(INT_TRI_BASE + 29)
+#define INT_TRI_RES_30			(INT_TRI_BASE + 30)
+#define INT_SW_RESERVED			(INT_TRI_BASE + 31)
+
+/* Quaternary Interrupt Controller */
+#define INT_QUAD_BASE			(INT_TRI_BASE + 32)
+#define INT_SNOR			(INT_QUAD_BASE + 0)
+#define INT_USB3			(INT_QUAD_BASE + 1)
+#define INT_PCIE_INTR			(INT_QUAD_BASE + 2)
+#define INT_PCIE_MSI			(INT_QUAD_BASE + 3)
+#define INT_QUAD_RES_4			(INT_QUAD_BASE + 4)
+#define INT_QUAD_RES_5			(INT_QUAD_BASE + 5)
+#define INT_QUAD_RES_6			(INT_QUAD_BASE + 6)
+#define INT_QUAD_RES_7			(INT_QUAD_BASE + 7)
+#define INT_APB_DMA_CH0			(INT_QUAD_BASE + 8)
+#define INT_APB_DMA_CH1			(INT_QUAD_BASE + 9)
+#define INT_APB_DMA_CH2			(INT_QUAD_BASE + 10)
+#define INT_APB_DMA_CH3			(INT_QUAD_BASE + 11)
+#define INT_APB_DMA_CH4			(INT_QUAD_BASE + 12)
+#define INT_APB_DMA_CH5			(INT_QUAD_BASE + 13)
+#define INT_APB_DMA_CH6			(INT_QUAD_BASE + 14)
+#define INT_APB_DMA_CH7			(INT_QUAD_BASE + 15)
+#define INT_APB_DMA_CH8			(INT_QUAD_BASE + 16)
+#define INT_APB_DMA_CH9			(INT_QUAD_BASE + 17)
+#define INT_APB_DMA_CH10		(INT_QUAD_BASE + 18)
+#define INT_APB_DMA_CH11		(INT_QUAD_BASE + 19)
+#define INT_APB_DMA_CH12		(INT_QUAD_BASE + 20)
+#define INT_APB_DMA_CH13		(INT_QUAD_BASE + 21)
+#define INT_APB_DMA_CH14		(INT_QUAD_BASE + 22)
+#define INT_APB_DMA_CH15		(INT_QUAD_BASE + 23)
+#define INT_QUAD_RES_24			(INT_QUAD_BASE + 24)
+#define INT_QUAD_RES_25			(INT_QUAD_BASE + 25)
+#define INT_QUAD_RES_26			(INT_QUAD_BASE + 26)
+#define INT_QUAD_RES_27			(INT_QUAD_BASE + 27)
+#define INT_QUAD_RES_28			(INT_QUAD_BASE + 28)
+#define INT_QUAD_RES_29			(INT_QUAD_BASE + 29)
+#define INT_QUAD_RES_30			(INT_QUAD_BASE + 30)
+#define INT_QUAD_RES_31			(INT_QUAD_BASE + 31)
+
+#define INT_GPIO_BASE			(INT_QUAD_BASE + 32)
+#define INT_GPIO_NR			(28 * 8)
+
+#define NR_IRQS				(INT_GPIO_BASE + INT_GPIO_NR)
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/memory.h b/arch/arm/mach-tegra/include/mach/memory.h
new file mode 100644
index 0000000..9507b08
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/memory.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/mach-tegra/include/mach/memory.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_MEMORY_H
+#define __MACH_TEGRA_MEMORY_H
+
+/* physical offset of RAM */
+#define PHYS_OFFSET		UL(0)
+
+#endif
+
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
new file mode 100644
index 0000000..0aef65a
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -0,0 +1,34 @@
+/*
+ * arch/arm/mach-tegra/include/mach/system.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_SYSTEM_H
+#define __MACH_TEGRA_SYSTEM_H
+
+#include <mach/hardware.h>
+
+static inline void arch_idle(void)
+{
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
+	u32 reg = readl(reset);
+	reg |= 0x04;
+	writel(reg, reset);
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/tegra.h b/arch/arm/mach-tegra/include/mach/tegra.h
new file mode 100644
index 0000000..9ef99ee
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/tegra.h
@@ -0,0 +1,110 @@
+/*
+ * arch/arm/mach-tegra/include/mach/iomap.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_IOMAP_H
+#define __MACH_TEGRA_IOMAP_H
+
+#include <asm/sizes.h>
+
+#define TEGRA_ARM_PERIF_BASE    	0x50040000
+#define TEGRA_ARM_PERIF_SIZE    	SZ_8K
+
+#define TEGRA_ARM_INT_DIST_BASE      	0x50041000
+#define TEGRA_ARM_INT_DIST_SIZE      	SZ_4K
+
+#define TEGRA_DISPLAY_BASE		0x54200000
+#define TEGRA_DISPLAY_SIZE		SZ_256K
+
+#define TEGRA_DISPLAY2_BASE		0x54240000
+#define TEGRA_DISPLAY2_SIZE		SZ_256K
+
+#define TEGRA_PRIMARY_ICTLR_BASE     	0x60004000
+#define TEGRA_PRIMARY_ICTLR_SIZE     	SZ_64
+
+#define TEGRA_SECONDARY_ICTLR_BASE   	0x60004100
+#define TEGRA_SECONDARY_ICTLR_SIZE   	SZ_64
+
+#define TEGRA_TERTIARY_ICTLR_BASE   	0x60004200
+#define TEGRA_TERTIARY_ICTLR_SIZE   	SZ_64
+
+#define TEGRA_QUATERNARY_ICTLR_BASE	0x60004300
+#define TEGRA_QUATERNARY_ICTLR_SIZE	SZ_64
+
+#define TEGRA_TMR1_BASE			0x60005000
+#define TEGRA_TMR1_SIZE			SZ_8
+
+#define TEGRA_TMR2_BASE			0x60005008
+#define TEGRA_TMR2_SIZE			SZ_8
+
+#define TEGRA_TMRUS_BASE		0x60005010
+#define TEGRA_TMRUS_SIZE		SZ_64
+
+#define TEGRA_TMR3_BASE			0x60005050
+#define TEGRA_TMR3_SIZE			SZ_8
+
+#define TEGRA_TMR4_BASE			0x60005058
+#define TEGRA_TMR4_SIZE			SZ_8
+
+#define TEGRA_CLK_RESET_BASE		0x60006000
+#define TEGRA_CLK_RESET_SIZE		SZ_4K
+
+#define TEGRA_FLOW_CTRL_BASE		0x60007000
+#define TEGRA_FLOW_CTRL_SIZE		20
+
+#define TEGRA_GPIO_BASE			0x6000D000
+#define TEGRA_GPIO_SIZE			SZ_1K
+
+#define TEGRA_EXCEPTION_VECTORS_BASE    0x6000F000
+#define TEGRA_EXCEPTION_VECTORS_SIZE    SZ_4K
+
+#define TEGRA_APB_MISC_BASE		0x70000000
+#define TEGRA_APB_MISC_SIZE		SZ_4K
+
+#define TEGRA_UARTA_BASE		0x70006000
+#define TEGRA_UARTA_SIZE		SZ_64
+
+#define TEGRA_UARTB_BASE		0x70006040
+#define TEGRA_UARTB_SIZE		SZ_64
+
+#define TEGRA_UARTC_BASE		0x70006200
+#define TEGRA_UARTC_SIZE		SZ_256
+
+#define TEGRA_UARTD_BASE		0x70006300
+#define TEGRA_UARTD_SIZE		SZ_256
+
+#define TEGRA_UARTE_BASE		0x70006400
+#define TEGRA_UARTE_SIZE		SZ_256
+
+#define TEGRA_NAND_BASE			0x70008000
+#define TEGRA_NAND_SIZE			SZ_256
+
+#define TEGRA_RTC_BASE			0x7000E000
+#define TEGRA_RTC_SIZE			SZ_256
+
+#define TEGRA_PMC_BASE  		0x7000E400
+#define TEGRA_PMC_SIZE  		SZ_256
+
+#define TEGRA_USB_BASE			0xC5000000
+#define TEGRA_USB_SIZE			SZ_16K
+
+#define TEGRA_USB1_BASE			0xC5004000
+#define TEGRA_USB1_SIZE			SZ_16K
+
+#define TEGRA_USB2_BASE			0xC5008000
+#define TEGRA_USB2_SIZE			SZ_16K
+
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/timex.h b/arch/arm/mach-tegra/include/mach/timex.h
new file mode 100644
index 0000000..8e1a3c4
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/timex.h
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-tegra/include/mach/timex.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_TIMEX_H
+#define __MACH_TEGRA_TIMEX_H
+
+#define CLOCK_TICK_RATE		1000000
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
new file mode 100644
index 0000000..1400798
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -0,0 +1,46 @@
+/*
+ * arch/arm/mach-tegra/include/mach/uncompress.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_UNCOMPRESS_H
+#define __MACH_TEGRA_UNCOMPRESS_H
+
+#include <linux/serial_reg.h>
+
+#include "tegra.h"
+
+static void putc(int c)
+{
+	volatile u8 *uart = (volatile u8 *)(TEGRA_UARTD_BASE);
+	int shift = 2;
+
+	while (!(uart[UART_LSR << shift] & UART_LSR_THRE))
+		barrier();
+	uart[UART_TX << shift] = c;
+}
+
+static inline void flush(void)
+{
+}
+
+static inline void arch_decomp_setup(void)
+{
+}
+
+static inline void arch_decomp_wdog(void)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/vmalloc.h b/arch/arm/mach-tegra/include/mach/vmalloc.h
new file mode 100644
index 0000000..33444b1
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/vmalloc.h
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-tegra/include/mach/vmalloc.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_VMALLOC_H
+#define __MACH_TEGRA_VMALLOC_H
+
+#define VMALLOC_END        ((PAGE_OFFSET) + 0x38000000)
+
+#endif
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
new file mode 100644
index 0000000..f856269
--- /dev/null
+++ b/arch/arm/mach-tegra/io.c
@@ -0,0 +1,73 @@
+/*
+ * arch/arm/mach-tegra/io.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+
+static struct map_desc tegra_io_desc[] __initdata = {
+	{
+		.virtual = IO_PPSB_VIRT,
+		.pfn = __phys_to_pfn(IO_PPSB_PHYS),
+		.length = IO_PPSB_SIZE,
+		.type = MT_DEVICE,
+	},
+	{
+		.virtual = IO_APB_VIRT,
+		.pfn = __phys_to_pfn(IO_APB_PHYS),
+		.length = IO_APB_SIZE,
+		.type = MT_DEVICE,
+	},
+	{
+		.virtual = IO_CPU_VIRT,
+		.pfn = __phys_to_pfn(IO_CPU_PHYS),
+		.length = IO_CPU_SIZE,
+		.type = MT_DEVICE,
+	},
+};
+
+void __init tegra_map_common_io(void)
+{
+	iotable_init(tegra_io_desc, ARRAY_SIZE(tegra_io_desc));
+}
+
+/*
+ * Intercept ioremap() requests for addresses in our fixed mapping regions.
+ */
+void __iomem *tegra_ioremap(unsigned long p, size_t size, unsigned int type)
+{
+	void __iomem *v = IO_ADDRESS(p);
+	if (v == NULL)
+		v = __arm_ioremap(p, size, type);
+	return v;
+}
+EXPORT_SYMBOL(tegra_ioremap);
+
+void tegra_iounmap(volatile void __iomem *addr)
+{
+	unsigned long virt = (unsigned long)addr;
+
+	if (virt >= VMALLOC_START && virt < VMALLOC_END)
+		__iounmap(addr);
+}
+EXPORT_SYMBOL(tegra_iounmap);
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
new file mode 100644
index 0000000..9690a1b
--- /dev/null
+++ b/arch/arm/mach-tegra/irq.c
@@ -0,0 +1,31 @@
+/*
+ * arch/arm/mach-tegra/irq.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+
+#include <asm/hardware/gic.h>
+
+#include <mach/hardware.h>
+
+#include "common.h"
+
+void __init tegra_init_irq(void)
+{
+	gic_dist_init(0, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE), 29);
+	gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
+	tegra_init_clock();
+}
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
new file mode 100644
index 0000000..e480625
--- /dev/null
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -0,0 +1,809 @@
+/*
+ * arch/arm/mach-tegra/tegra2_clocks.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <asm/clkdev.h>
+
+#include <mach/hardware.h>
+
+#include "clock.h"
+
+#define CLK_RST_CONTROLLER_RST_DEVICES         0x004
+#define CLK_RST_CONTROLLER_RST_DEVICES_SET_CLR 0x300
+#define CLK_RST_CONTROLLER_CLK_OUT_ENB         0x010
+#define CLK_RST_CONTROLLER_CLK_OUT_ENB_SET_CLR 0x320
+#define CLK_RST_CONTROLLER_CLK_SOURCE          0x100
+
+static void __iomem *reg_clk_base;
+
+#define clk_writel(value, reg) \
+	__raw_writel(value, (u32)reg_clk_base + (reg))
+#define clk_readl(reg) \
+	__raw_readl((u32)reg_clk_base + (reg))
+
+static int clk_div71_possible_rate(struct clk *c, unsigned long rate)
+{
+	unsigned long input_rate = clk_get_rate(c);
+	int divider_u71;
+
+	divider_u71 = (input_rate*2)/rate;
+	if (rate * divider_u71 == input_rate*2)
+		return divider_u71 - 2;
+	else
+		return -1;
+}
+
+/* Default clk ops */
+static int tegra2_clk_enable(struct clk *c)
+{
+	return 0;
+}
+
+static void tegra2_clk_disable(struct clk *c)
+{
+}
+
+static unsigned long tegra2_clk_get_rate(struct clk *c)
+{
+	return c->rate;
+}
+
+/* clk_m functions */
+static unsigned long tegra2_clk_m_autodetect_rate(struct clk *c)
+{
+	u32 clk_autodetect;
+	u32 auto_clk_ctl = clk_readl(0x50) & ~(3<<30);
+
+	clk_writel(0x80000001, 0x58);
+
+	while ((clk_autodetect = clk_readl(0x5c)) & 0x80000000)
+		;
+
+	switch (clk_autodetect) {
+	case 732:
+	case 733:
+		c->rate = 12000000;
+		auto_clk_ctl |= 2<<30;
+		break;
+	case 794:
+		c->rate = 13000000;
+		auto_clk_ctl |= 0<<30;
+		break;
+	case 1172:
+		c->rate = 19200000;
+		auto_clk_ctl |= 1<<30;
+		break;
+	case 1587:
+		c->rate = 26000000;
+		auto_clk_ctl |= 3<<30;
+		break;
+	default:
+		WARN(1, "Unexpected clock autodetect value %d", clk_autodetect);
+	}
+
+	clk_writel(auto_clk_ctl, 0x50);
+
+	return c->rate;
+}
+
+static void tegra2_clk_m_init(struct clk *c)
+{
+	tegra2_clk_m_autodetect_rate(c);
+}
+
+static int tegra2_clk_m_enable(struct clk *c)
+{
+	return 0;
+}
+
+static void tegra2_clk_m_disable(struct clk *c)
+{
+	BUG();
+}
+
+static struct clk_ops tegra_clk_m_ops = {
+	.init     = tegra2_clk_m_init,
+	.enable   = tegra2_clk_m_enable,
+	.disable  = tegra2_clk_m_disable,
+	.get_rate = tegra2_clk_get_rate,
+};
+
+/* PLL Functions */
+static int tegra2_pll_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	u32 reg;
+	unsigned long input_rate;
+	const struct clk_pll_table *sel;
+
+	input_rate = clk_get_rate(c->parent);
+	for (sel = c->pll_table; sel->input_rate != 0; sel++) {
+		if (sel->input_rate == input_rate && sel->output_rate == rate) {
+			c->n = sel->n;
+			c->m = sel->m;
+			c->p = sel->p;
+			c->cpcon = sel->cpcon;
+			reg = clk_readl(c->reg);
+			if (c->flags & PLL_FIXED)
+				reg |= 1<<28;
+			reg &= ~0x7FFF;
+			reg |= (c->m << 0) | (c->n << 8);
+			BUG_ON(c->p > 2);
+			if (c->p == 2)
+				reg |= 1<<20;
+			clk_writel(reg, c->reg);
+			c->rate = rate;
+
+			if (c->flags & PLL_HAS_CPCON) {
+				reg = c->cpcon << 8;
+				clk_writel(reg, c->reg+0xC);
+			}
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int tegra2_pll_clk_enable(struct clk *c)
+{
+	int ret = 0;
+	u32 reg;
+
+	reg = clk_readl(c->reg);
+	reg &= ~(1 << 31);
+	reg |= 1 << 30;
+	clk_writel(reg, c->reg);
+	return ret;
+}
+
+static void tegra2_pll_clk_disable(struct clk *c)
+{
+	u32 reg;
+
+	reg = clk_readl(c->reg);
+	reg &= ~(1 << 31);
+	reg &= ~(1 << 30);
+	clk_writel(reg, c->reg);
+}
+
+static struct clk_ops tegra_pll_ops = {
+	.enable   = tegra2_pll_clk_enable,
+	.disable  = tegra2_pll_clk_disable,
+	.set_rate = tegra2_pll_clk_set_rate,
+	.get_rate = tegra2_clk_get_rate,
+};
+
+/* Clock divider ops */
+static int tegra2_div_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	int ret = 0;
+	u32 reg;
+	u32 new_reg;
+	int divider_u71;
+
+	if (c->flags & DIV_U71) {
+		divider_u71 = clk_div71_possible_rate(c->parent, rate);
+		if (divider_u71 >= 0) {
+			reg = clk_readl(c->reg);
+			new_reg = reg >> c->reg_shift;
+			new_reg &= 0xFFFF;
+
+			if (c->flags & DIV_U71_FIXED)
+				new_reg &= ~(1<<2);
+			new_reg &= ~(0xFF);
+			new_reg |= divider_u71;
+
+			reg &= ~(0xFFFF << c->reg_shift);
+			reg |= new_reg << c->reg_shift;
+			clk_writel(reg, c->reg);
+			return 1;
+		}
+	} else if (c->flags & DIV_2) {
+		if (clk_get_rate(c->parent) == rate * 2)
+			return 1;
+	}
+	BUG();
+	return ret;
+}
+
+
+static struct clk_ops tegra_div_ops = {
+	.enable   = tegra2_clk_enable,
+	.disable  = tegra2_clk_disable,
+	.set_rate = tegra2_div_clk_set_rate,
+	.get_rate = tegra2_clk_get_rate,
+};
+
+/* Periph clk ops */
+static void tegra2_periph_clk_init(struct clk *c)
+{
+	clk_set_parent(c, c->inputs[0].input);
+}
+
+static int tegra2_periph_clk_enable(struct clk *c)
+{
+	u32 reg, bit;
+
+	reg = (1 << (c->clk_num % 32));
+	bit = (c->clk_num / 32) << 3;
+
+	clk_writel(reg, CLK_RST_CONTROLLER_CLK_OUT_ENB_SET_CLR | bit);
+	clk_writel(reg, CLK_RST_CONTROLLER_RST_DEVICES_SET_CLR | bit | 4);
+	return 0;
+}
+
+static void tegra2_periph_clk_disable(struct clk *c)
+{
+	u32 reg, bit;
+
+	reg = (1 << (c->clk_num % 32));
+	bit = (c->clk_num / 32) << 3;
+
+	clk_writel(reg, CLK_RST_CONTROLLER_CLK_OUT_ENB_SET_CLR | bit | 4);
+	clk_writel(reg, CLK_RST_CONTROLLER_RST_DEVICES_SET_CLR | bit);
+}
+
+static int tegra2_periph_clk_set_parent(struct clk *c, struct clk *p)
+{
+	int ret = 0;
+	u32 reg;
+	const struct clk_mux_sel *sel;
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (sel->input == p) {
+			c->parent = p;
+			reg = clk_readl(c->reg);
+			reg &= ~(0x3<<30);
+			reg |= (sel->value)<<30;
+			clk_writel(reg, c->reg);
+		}
+	}
+
+	return ret;
+}
+
+static int tegra2_periph_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	int ret = 0;
+	u32 reg;
+	int divider_u71;
+	const struct clk_mux_sel *sel;
+
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (c->flags & DIV_U71) {
+			divider_u71 = clk_div71_possible_rate(sel->input, rate);
+			if (divider_u71 >= 0) {
+				/* FIXME: ensure we don't have too high rate */
+				clk_set_parent(c, sel->input);
+				udelay(1);
+				reg = clk_readl(c->reg);
+				reg &= ~(0xFF);
+				reg |= divider_u71;
+				clk_writel(reg, c->reg);
+				return 1;
+			}
+		} else {
+			if (clk_get_rate(sel->input) == rate) {
+				clk_set_parent(c, sel->input);
+				return 1;
+			}
+		}
+	}
+	BUG();
+	return ret;
+}
+
+static struct clk_ops tegra_periph_clk_ops = {
+	.init       = &tegra2_periph_clk_init,
+	.enable     = &tegra2_periph_clk_enable,
+	.disable    = &tegra2_periph_clk_disable,
+	.set_parent = &tegra2_periph_clk_set_parent,
+	.set_rate   = &tegra2_periph_clk_set_rate,
+};
+
+static struct clk tegra_clk_32k = {
+	.name = "tegra_clk_32k",
+	.rate = 32678,
+	.ops  = NULL,
+};
+
+static struct clk tegra_clk_input = {
+	.name = "tegra_clk_input",
+	.flags = ENABLE_ON_INIT,
+	.rate = 12000000,
+	.ops = NULL,
+};
+
+static struct clk_pll_table tegra_pll_s_table[] = {
+	{32768, 12000000, 366, 1, 1, 0},
+	{32768, 13000000, 397, 1, 1, 0},
+	{32768, 19200000, 586, 1, 1, 0},
+	{32768, 26000000, 793, 1, 1, 0},
+	{0, 0, 0, 0, 0, 0},
+};
+
+static struct clk tegra_pll_s = {
+	.name = "tegra_pll_s",
+	.ops = &tegra_pll_ops,
+	.reg       = 0xf0,
+	.input_min = 32768,
+	.input_max = 32768,
+	.parent     = &tegra_clk_32k,
+	.cf_min    = 0, /* FIXME */
+	.cf_max    = 0, /* FIXME */
+	.vco_min   = 12000000,
+	.vco_max   = 26000000,
+	.pll_table = tegra_pll_s_table,
+};
+
+static struct clk_mux_sel tegra_clk_m_sel[] = {
+	{ .input = &tegra_clk_32k, .value = 0},
+	{ .input = &tegra_pll_s,  .value = 1},
+	{ 0, 0},
+};
+
+static struct clk tegra_clk_m = {
+	.name      = "tegra_clk_m",
+	.flags     = ENABLE_ON_INIT,
+	.ops       = &tegra_clk_m_ops,
+	.inputs    = tegra_clk_m_sel,
+	.reg       = 0x1fc,
+	.reg_mask  = (1<<28),
+	.reg_shift = 28,
+};
+
+static struct clk_pll_table tegra_pll_c_table[] = {
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_c = {
+	.name      = "tegra_pll_c",
+	.flags	   = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0x80,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_c_table,
+};
+
+static struct clk tegra_pll_c_out1 = {
+	.name      = "tegra_pll_c_out1",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_c,
+	.reg       = 0x84,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_m_table[] = {
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_m = {
+	.name      = "tegra_pll_m",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0x90,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1200000000,
+	.pll_table = tegra_pll_m_table,
+};
+
+static struct clk tegra_pll_m_out1 = {
+	.name      = "tegra_pll_m_out1",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_m,
+	.reg       = 0x94,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_p_table[] = {
+	{ 12000000, 216000000, 432, 12, 2, 8},
+	{ 13000000, 216000000, 432, 13, 2, 8},
+	{ 19200000, 216000000, 90,   4, 2, 1},
+	{ 26000000, 216000000, 432, 26, 2, 8},
+	{ 12000000, 432000000, 432, 12, 1, 8},
+	{ 13000000, 432000000, 432, 13, 1, 8},
+	{ 19200000, 432000000, 90,   4, 1, 1},
+	{ 26000000, 432000000, 432, 26, 1, 8},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_p = {
+	.name      = "tegra_pll_p",
+	.flags     = ENABLE_ON_INIT | PLL_FIXED | PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xa0,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_p_table,
+};
+
+static struct clk tegra_pll_p_out1 = {
+	.name      = "tegra_pll_p_out1",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa4,
+	.reg_shift = 0,
+};
+
+static struct clk tegra_pll_p_out2 = {
+	.name      = "tegra_pll_p_out2",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa4,
+	.reg_shift = 16,
+};
+
+static struct clk tegra_pll_p_out3 = {
+	.name      = "tegra_pll_p_out3",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa8,
+	.reg_shift = 0,
+};
+
+static struct clk tegra_pll_p_out4 = {
+	.name      = "tegra_pll_p_out4",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa8,
+	.reg_shift = 16,
+};
+
+static struct clk_pll_table tegra_pll_a_table[] = {
+	{ 28800000, 56448000, 49, 25, 1, 1},
+	{ 28800000, 73728000, 64, 25, 1, 1},
+	{ 28800000, 11289600, 49, 25, 1, 1},
+	{ 28800000, 12288000, 64, 25, 1, 1},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_a = {
+	.name      = "tegra_pll_a",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xb0,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_pll_p_out1,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_a_table,
+};
+
+static struct clk tegra_pll_a_out0 = {
+	.name      = "tegra_pll_a_out0",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_a,
+	.reg       = 0xb4,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_d_table[] = {
+	{ 12000000, 1000000000, 1000, 12, 1, 12},
+	{ 13000000, 1000000000, 1000, 13, 1, 12},
+	{ 19200000, 1000000000, 625,  12, 1, 8},
+	{ 26000000, 1000000000, 1000, 26, 1, 12},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_d = {
+	.name      = "tegra_pll_d",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xd0,
+	.input_min = 2000000,
+	.input_max = 40000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 40000000,
+	.vco_max   = 1000000000,
+	.pll_table = tegra_pll_d_table,
+};
+
+static struct clk tegra_pll_d_out0 = {
+	.name      = "tegra_pll_d_out0",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_2,
+	.parent    = &tegra_pll_d,
+};
+
+static struct clk_pll_table tegra_pll_u_table[] = {
+	{ 12000000, 480000000, 960, 12, 1, 0},
+	{ 13000000, 480000000, 960, 13, 1, 0},
+	{ 19200000, 480000000, 200, 4,  1, 0},
+	{ 26000000, 480000000, 960, 26, 1, 0},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_u = {
+	.name      = "tegra_pll_u",
+	.flags     = 0,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xc0,
+	.input_min = 2000000,
+	.input_max = 40000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 480000000,
+	.vco_max   = 960000000,
+	.pll_table = tegra_pll_u_table,
+};
+
+static struct clk_mux_sel mux_pllm_pllc_pllp_plla[] = {
+	{ .input = &tegra_pll_m, .value = 0},
+	{ .input = &tegra_pll_c, .value = 1},
+	{ .input = &tegra_pll_p, .value = 2},
+	{ .input = &tegra_pll_a_out0, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_pllm_clkm[] = {
+	{ .input = &tegra_pll_p, .value = 0},
+	{ .input = &tegra_pll_c, .value = 1},
+	{ .input = &tegra_pll_m, .value = 2},
+	{ .input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_plla_audio_pllp_clkm[] = {
+	{.input = &tegra_pll_a, .value = 0},
+	/* FIXME: no mux defined for tegra_audio
+	{.input = &tegra_audio, .value = 1},*/
+	{.input = &tegra_pll_p, .value = 2},
+	{.input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_plld_pllc_clkm[] = {
+	{.input = &tegra_pll_p, .value = 0},
+	{.input = &tegra_pll_d_out0, .value = 1},
+	{.input = &tegra_pll_c, .value = 2},
+	{.input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_audio_clkm_clk32[] = {
+	{.input = &tegra_pll_p,     .value = 0},
+	{.input = &tegra_pll_c,     .value = 1},
+	/* FIXME: no mux defined for tegra_audio
+	{.input = &tegra_audio,     .value = 2},*/
+	{.input = &tegra_clk_m,     .value = 3},
+	{.input = &tegra_clk_32k,   .value = 4},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_pllm[] = {
+	{.input = &tegra_pll_p,     .value = 0},
+	{.input = &tegra_pll_c,     .value = 1},
+	{.input = &tegra_pll_m,     .value = 2},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_clk_m[] = {
+	{ .input = &tegra_clk_m, .value = 0},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_clk_32k[] = {
+	{ .input = &tegra_clk_32k, .value = 0},
+	{ 0, 0},
+};
+
+#define PERIPH_CLK(_name, _clk_num, _reg, _inputs, _flags) \
+	struct clk clk_##_name = {		   \
+		.name      = __stringify(_name),	   \
+		.ops       = &tegra_periph_clk_ops,	   \
+		.clk_num   = _clk_num,			   \
+		.reg       = _reg,			   \
+		.inputs    = _inputs,			   \
+		.flags     = _flags,			   \
+	}
+
+#define PERIPH_CLK_U71(_name, _clk_num, _reg, _inputs) \
+	PERIPH_CLK(_name, _clk_num, _reg, _inputs, MUX | DIV_U71)
+
+static PERIPH_CLK(rtc, 4, 0, mux_clk_32k, 0);
+static PERIPH_CLK(usbd, 22, 0, mux_clk_m, 0);
+static PERIPH_CLK(usb2, 58, 0, mux_clk_m, 0);
+static PERIPH_CLK(usb3, 59, 0, mux_clk_m, 0);
+static PERIPH_CLK(timer, 5, 0, mux_clk_m, 0);
+
+static PERIPH_CLK_U71(i2s1, 11, 0x100, mux_plla_audio_pllp_clkm);
+static PERIPH_CLK_U71(i2s2, 18, 0x104, mux_plla_audio_pllp_clkm);
+static PERIPH_CLK_U71(spdif_in, 10, 0x10c, mux_pllp_pllc_pllm);
+static PERIPH_CLK_U71(spdif_out, 10, 0x108, mux_plla_audio_pllp_clkm);
+static PERIPH_CLK_U71(pwm, 17, 0x110, mux_pllp_pllc_audio_clkm_clk32);
+static PERIPH_CLK_U71(spi, 43, 0x114, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(xio, 45, 0x120, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(twc, 16, 0x12c, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sbc1, 41, 0x134, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sbc2, 44, 0x118, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sbc3, 46, 0x11c, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sbc4, 68, 0x1b4, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(ide, 25, 0x144, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(ndflash, 13, 0x160, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(vfir, 7, 0x168, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sdmmc1, 14, 0x150, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sdmmc2, 9, 0x154, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sdmmc3, 69, 0x1bc, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(sdmmc4, 15, 0x160, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(vde, 61, 0x1c8, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(csite, 73, 0x1d4, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(la, 76, 0x1f8, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(owr, 71, 0x1cc, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(nor, 42, 0x1d0, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(mipi, 50, 0x174, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(i2c1, 12, 0x124, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(i2c2, 54, 0x198, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(i2c3, 67, 0x1b8, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(dvc, 47, 0x128, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(uarta, 6, 0x178, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(uartb, 7, 0x17c, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(uartc, 55, 0x1a0, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(uartd, 65, 0x1c0, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(uarte, 66, 0x1c4, mux_pllp_pllc_pllm_clkm);
+static PERIPH_CLK_U71(3d, 24, 0x158, mux_pllm_pllc_pllp_plla);
+static PERIPH_CLK_U71(2d, 21, 0x15c, mux_pllm_pllc_pllp_plla);
+static PERIPH_CLK_U71(vi, 20, 0x148, mux_pllm_pllc_pllp_plla);
+static PERIPH_CLK_U71(vi_sensor, 20, 0x1a8, mux_pllm_pllc_pllp_plla);
+static PERIPH_CLK_U71(epp, 19, 0x16c, mux_pllm_pllc_pllp_plla);
+static PERIPH_CLK_U71(mpe, 60, 0x170, mux_pllm_pllc_pllp_plla);
+static PERIPH_CLK_U71(host1x, 28, 0x180, mux_pllm_pllc_pllp_plla);
+static PERIPH_CLK_U71(cve, 49, 0x140, mux_pllp_plld_pllc_clkm);
+static PERIPH_CLK_U71(tvo, 49, 0x188, mux_pllp_plld_pllc_clkm);
+static PERIPH_CLK_U71(hdmi, 51, 0x18c, mux_pllp_plld_pllc_clkm);
+static PERIPH_CLK_U71(tvdac, 53, 0x194, mux_pllp_plld_pllc_clkm);
+static PERIPH_CLK_U71(disp1, 27, 0x138, mux_pllp_plld_pllc_clkm);
+static PERIPH_CLK_U71(disp2, 26, 0x13c, mux_pllp_plld_pllc_clkm);
+
+#define CLK(dev, con, ck)     \
+	{       \
+		.dev_id = dev,  \
+		.con_id = con,  \
+		.clk = ck,  \
+	}
+
+struct clk_lookup tegra_clk_lookups[] = {
+	/* external root sources */
+	CLK(NULL, "input_clk",	&tegra_clk_input),
+	CLK(NULL, "32k_clk",	&tegra_clk_32k),
+	CLK(NULL, "clk_m",	&tegra_clk_m),
+
+	/* PLLs */
+	CLK(NULL, "pll_a",	&tegra_pll_a),
+	CLK(NULL, "pll_c",	&tegra_pll_c),
+	CLK(NULL, "pll_d",      &tegra_pll_d),
+	CLK(NULL, "pll_m",	&tegra_pll_m),
+	CLK(NULL, "pll_p",	&tegra_pll_p),
+	CLK(NULL, "pll_s",	&tegra_pll_s),
+	CLK(NULL, "pll_u",      &tegra_pll_u),
+
+	/* PLL outputs */
+	CLK(NULL, "pll_a_out0", &tegra_pll_a_out0),
+	CLK(NULL, "pll_c_out1", &tegra_pll_c_out1),
+	CLK(NULL, "pll_d_out0", &tegra_pll_d_out0),
+	CLK(NULL, "pll_m_out1", &tegra_pll_m_out1),
+	CLK(NULL, "pll_p_out1", &tegra_pll_p_out1),
+	CLK(NULL, "pll_p_out2", &tegra_pll_p_out2),
+	CLK(NULL, "pll_p_out3", &tegra_pll_p_out3),
+	CLK(NULL, "pll_p_out4", &tegra_pll_p_out4),
+
+	/* peripheral clocks */
+	CLK("rtc-tegra",	NULL,	&clk_rtc),
+	CLK("timer",		NULL,	&clk_timer),
+	CLK("i2s.0",		NULL,	&clk_i2s1),
+	CLK("i2s.1",		NULL,	&clk_i2s2),
+	CLK("spdif_out",	NULL,	&clk_spdif_out),
+	CLK("spdif_in",		NULL,	&clk_spdif_in),
+	CLK("pwm",		NULL,	&clk_pwm),
+	CLK("spi",		NULL,	&clk_spi),
+	CLK("xio",		NULL,	&clk_xio),
+	CLK("twc",		NULL,	&clk_twc),
+	CLK("sbc.0",		NULL,	&clk_sbc1),
+	CLK("sbc.1",		NULL,	&clk_sbc2),
+	CLK("sbc.2",		NULL,	&clk_sbc3),
+	CLK("sbc.3",		NULL,	&clk_sbc4),
+	CLK("ide",		NULL,	&clk_ide),
+	CLK("tegra_nand",	NULL,	&clk_ndflash),
+	CLK("vfir",		NULL,	&clk_vfir),
+	CLK("sdmmc.0",		NULL,	&clk_sdmmc1),
+	CLK("sdmmc.1",		NULL,	&clk_sdmmc2),
+	CLK("sdmmc.2",		NULL,	&clk_sdmmc3),
+	CLK("sdmmc.3",		NULL,	&clk_sdmmc4),
+	CLK("vde",		NULL,	&clk_vde),
+	CLK("csite",		NULL,	&clk_csite),
+	CLK("la",		NULL,	&clk_la),
+	CLK("owr",		NULL,	&clk_owr),
+	CLK("nor",		NULL,	&clk_nor),
+	CLK("mipi",		NULL,	&clk_mipi),
+	CLK("i2c.0",		NULL,	&clk_i2c1),
+	CLK("i2c.1",		NULL,	&clk_i2c2),
+	CLK("i2c.2",		NULL,	&clk_i2c3),
+	CLK("dvc",		NULL,	&clk_dvc),
+	CLK("uart.0",		NULL,	&clk_uarta),
+	CLK("uart.1",		NULL,	&clk_uartb),
+	CLK("uart.2",		NULL,	&clk_uartc),
+	CLK("uart.3",		NULL,	&clk_uartd),
+	CLK("uart.4",		NULL,	&clk_uarte),
+	CLK("3d",		NULL,	&clk_3d),
+	CLK("2d",		NULL,	&clk_2d),
+	CLK("vi",		NULL,	&clk_vi),
+	CLK("vi_sensor",	NULL,	&clk_vi_sensor),
+	CLK("epp",		NULL,	&clk_epp),
+	CLK("mpe",		NULL,	&clk_mpe),
+	CLK("host1x",		NULL,	&clk_host1x),
+	CLK("cve",		NULL,	&clk_cve),
+	CLK("tvo",		NULL,	&clk_tvo),
+	CLK("hdmi",		NULL,	&clk_hdmi),
+	CLK("tvdac",		NULL,	&clk_tvdac),
+	CLK("tegrafb.0",	NULL,	&clk_disp1),
+	CLK("tegrafb.1",	NULL,	&clk_disp2),
+	CLK("usb.0",		NULL,	&clk_usbd),
+	CLK("usb.1",		NULL,	&clk_usb2),
+	CLK("usb.2",		NULL,	&clk_usb3),
+};
+
+int __init tegra_init_clock(void)
+{
+	int i;
+	struct clk_lookup *cl;
+
+	reg_clk_base = IO_ADDRESS(TEGRA_CLK_RESET_BASE);
+
+	for (i = 0; i < ARRAY_SIZE(tegra_clk_lookups); i++) {
+		cl = &tegra_clk_lookups[i];
+		if (cl->clk->ops && cl->clk->ops->init)
+			cl->clk->ops->init(cl->clk);
+		clkdev_add(cl);
+
+		if (cl->clk->flags & ENABLE_ON_INIT)
+			clk_enable(cl->clk);
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
new file mode 100644
index 0000000..a82f808
--- /dev/null
+++ b/arch/arm/mach-tegra/timer.c
@@ -0,0 +1,182 @@
+/*
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/clk.h>
+#include <asm/mach/time.h>
+#include <asm/io.h>
+#include <asm/mach/time.h>
+#include <asm/localtimer.h>
+
+#include <mach/hardware.h>
+
+#define TIMERUS_CNTR_1US 0x10
+#define TIMERUS_USEC_CFG 0x14
+#define TIMERUS_CNTR_FREEZE 0x4c
+
+#define TIMER1_BASE 0x0
+#define TIMER2_BASE 0x8
+#define TIMER3_BASE 0x50
+#define TIMER4_BASE 0x58
+
+#define TIMER_PTV 0x0
+#define TIMER_PCR 0x4
+
+#define TIMER1_IRQ 32
+#define TIMER2_IRQ 33
+#define TIMER3_IRQ 41
+#define TIMER4_IRQ 42
+
+struct tegra_timer;
+
+static void __iomem *timer_reg_base = IO_ADDRESS(TEGRA_TMR1_BASE);
+
+#define timer_writel(value, reg) \
+	__raw_writel(value, (u32)timer_reg_base + (reg))
+#define timer_readl(reg) \
+	__raw_readl((u32)timer_reg_base + (reg))
+
+static int tegra_timer_set_next_event(unsigned long cycles,
+					 struct clock_event_device *evt)
+{
+	u32 reg;
+
+	reg = 0x80000000 | ((1000000/HZ)*(cycles+1)-1);
+	timer_writel(reg, TIMER1_BASE + TIMER_PTV);
+
+	return 0;
+}
+
+static void tegra_timer_set_mode(enum clock_event_mode mode,
+				    struct clock_event_device *evt)
+{
+	u32 reg;
+
+	timer_writel(0, TIMER1_BASE + TIMER_PTV);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		reg = 0xC0000000 | ((1000000/HZ)-1);
+		timer_writel(reg, TIMER1_BASE + TIMER_PTV);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static cycle_t tegra_clocksource_read(struct clocksource *cs)
+{
+	return timer_readl(TIMERUS_CNTR_1US);
+}
+
+static struct clock_event_device tegra_clockevent = {
+	.name		= "timer0",
+	.rating         = 300,
+	.features       = CLOCK_EVT_FEAT_ONESHOT, CLOCK_EVT_FEAT_PERIODIC,
+	.mult           = 16777,
+	.shift		= 24,
+	.set_next_event	= tegra_timer_set_next_event,
+	.set_mode	= tegra_timer_set_mode,
+};
+
+static struct clocksource tegra_clocksource = {
+	.name	= "timer_us",
+	.rating	= 300,
+	.read	= tegra_clocksource_read,
+	.mask	= 0xFFFFFFFFUL,
+	.mult	= 1000,
+	.shift	= 0,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	timer_writel(1<<30, TIMER1_BASE + TIMER_PCR);
+	evt->event_handler(evt);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction tegra_timer_irq = {
+	.name		= "timer0",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_HIGH,
+	.handler	= tegra_timer_interrupt,
+	.dev_id		= &tegra_clockevent,
+	.irq            = TIMER1_IRQ,
+};
+
+static void __init tegra_init_timer(void)
+{
+	struct clk *c;
+	int ret;
+
+#ifdef CONFIG_HAVE_ARM_TWD
+	twd_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x600);
+#endif
+
+	c = clk_get_sys("timer", NULL);
+	pr_info("Timer clock rate %lu\n", clk_get_rate(c));
+
+	switch (clk_get_rate(c)) {
+	case 12000000:
+		timer_writel(0x000b, TIMERUS_USEC_CFG);
+		break;
+	case 13000000:
+		timer_writel(0x000c, TIMERUS_USEC_CFG);
+		break;
+	case 19200000:
+		timer_writel(0x045f, TIMERUS_USEC_CFG);
+		break;
+	case 26000000:
+		timer_writel(0x0019, TIMERUS_USEC_CFG);
+		break;
+	default:
+		WARN(1, "Unknown clock rate");
+	}
+
+	if (clocksource_register(&tegra_clocksource)) {
+		printk(KERN_ERR "Failed to register clocksource\n");
+		BUG();
+	}
+
+	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
+	if (ret) {
+		printk(KERN_ERR "Failed to register timer IRQ: %d\n", ret);
+		BUG();
+	}
+
+	tegra_clockevent.max_delta_ns =
+		clockevent_delta2ns(0x1fffffff, &tegra_clockevent);
+	tegra_clockevent.max_delta_ns =
+		clockevent_delta2ns(0x1, &tegra_clockevent);
+	tegra_clockevent.cpumask = cpu_all_mask;
+	tegra_clockevent.irq = TIMER1_IRQ;
+	clockevents_register_device(&tegra_clockevent);
+
+	return;
+}
+
+struct sys_timer tegra_timer = {
+	.init = tegra_init_timer,
+};
-- 
1.6.4.4




-- 
Sincerely yours,
Mike.
