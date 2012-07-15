From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:07 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <1342363754-30808-2-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Moschip's MCS814x SoCs, and in particular
MCS8140. This SoC has the following characteristics:

- uses an ARM926EJS CPU core with an AHB/VCI64 interconnect
- simple clocking scheme and clock gating
- strap registers defining CPU, SDRAM and Timer frequency
- various on-chip peripherals:
	* 2x OHCI controller
	* 1x EHCI controller
	* IPsec unit
	* Watchdog
	* Random number generator
	* 10/100 Ethernet MAC w/ TCP offloading and checksumming
	* I2S
	* 4 + 20 GPIOs
	* PCI master interface

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/mach-mcs814x/Kconfig                    |   11 +
 arch/arm/mach-mcs814x/Makefile                   |    6 +
 arch/arm/mach-mcs814x/Makefile.boot              |    3 +
 arch/arm/mach-mcs814x/clock.c                    |  271 +++++++++++++
 arch/arm/mach-mcs814x/common.c                   |   97 +++++
 arch/arm/mach-mcs814x/common.h                   |   15 +
 arch/arm/mach-mcs814x/include/mach/cpu.h         |   16 +
 arch/arm/mach-mcs814x/include/mach/debug-macro.S |   11 +
 arch/arm/mach-mcs814x/include/mach/entry-macro.S |   29 ++
 arch/arm/mach-mcs814x/include/mach/gpio.h        |    1 +
 arch/arm/mach-mcs814x/include/mach/hardware.h    |   16 +
 arch/arm/mach-mcs814x/include/mach/irqs.h        |   22 ++
 arch/arm/mach-mcs814x/include/mach/mcs814x.h     |   53 +++
 arch/arm/mach-mcs814x/include/mach/memory.h      |   16 +
 arch/arm/mach-mcs814x/include/mach/timex.h       |   18 +
 arch/arm/mach-mcs814x/include/mach/uncompress.h  |   41 ++
 arch/arm/mach-mcs814x/irq.c                      |   69 ++++
 arch/arm/mach-mcs814x/pci.c                      |  446 ++++++++++++++++++++++
 arch/arm/mach-mcs814x/timer.c                    |  133 +++++++
 19 files changed, 1274 insertions(+)
 create mode 100644 arch/arm/mach-mcs814x/Kconfig
 create mode 100644 arch/arm/mach-mcs814x/Makefile
 create mode 100644 arch/arm/mach-mcs814x/Makefile.boot
 create mode 100644 arch/arm/mach-mcs814x/clock.c
 create mode 100644 arch/arm/mach-mcs814x/common.c
 create mode 100644 arch/arm/mach-mcs814x/common.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/cpu.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-mcs814x/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-mcs814x/include/mach/gpio.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/hardware.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/irqs.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/mcs814x.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/memory.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/timex.h
 create mode 100644 arch/arm/mach-mcs814x/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-mcs814x/irq.c
 create mode 100644 arch/arm/mach-mcs814x/pci.c
 create mode 100644 arch/arm/mach-mcs814x/timer.c

diff --git a/arch/arm/mach-mcs814x/Kconfig b/arch/arm/mach-mcs814x/Kconfig
new file mode 100644
index 0000000..c89422f
--- /dev/null
+++ b/arch/arm/mach-mcs814x/Kconfig
@@ -0,0 +1,11 @@
+if ARCH_MCS814X
+
+config MCS8140
+	select CPU_ARM926T
+	bool
+
+menu "Moschip MCS8140 boards"
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-mcs814x/Makefile b/arch/arm/mach-mcs814x/Makefile
new file mode 100644
index 0000000..bad95cc
--- /dev/null
+++ b/arch/arm/mach-mcs814x/Makefile
@@ -0,0 +1,6 @@
+obj-y += clock.o
+obj-y += common.o
+obj-y += irq.o
+obj-y += timer.o
+obj-y += board-mcs8140-dt.o
+obj-$(CONFIG_PCI)       += pci.o
diff --git a/arch/arm/mach-mcs814x/Makefile.boot b/arch/arm/mach-mcs814x/Makefile.boot
new file mode 100644
index 0000000..414db8b
--- /dev/null
+++ b/arch/arm/mach-mcs814x/Makefile.boot
@@ -0,0 +1,3 @@
+    zreladdr-y := 0x00008000
+ params_phys-y := 0x00000008
+ initrd_phys-y := 0x00400000
diff --git a/arch/arm/mach-mcs814x/clock.c b/arch/arm/mach-mcs814x/clock.c
new file mode 100644
index 0000000..eb30ae2
--- /dev/null
+++ b/arch/arm/mach-mcs814x/clock.c
@@ -0,0 +1,271 @@
+/*
+ * Moschip MCS814x clock routines
+ *
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * Licensed under GPLv2
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clkdev.h>
+#include <linux/clk.h>
+
+#include <mach/mcs814x.h>
+
+#include "common.h"
+
+#define KHZ	1000
+#define MHZ	(KHZ * KHZ)
+
+struct clk_ops {
+	unsigned long (*get_rate)(struct clk *clk);
+	int (*set_rate)(struct clk *clk, unsigned long rate);
+	struct clk *(*get_parent)(struct clk *clk);
+	int (*enable)(struct clk *clk, int enable);
+};
+
+struct clk {
+	struct clk *parent;		/* parent clk */
+	unsigned long rate;		/* clock rate in Hz */
+	unsigned long divider;		/* clock divider */
+	u32 usecount;			/* reference count */
+	struct clk_ops *ops;		/* clock operation */
+	u32 enable_reg;			/* clock enable register */
+	u32 enable_mask;		/* clock enable mask */
+};
+
+static unsigned long clk_divide_parent(struct clk *clk)
+{
+	if (clk->parent && clk->divider)
+		return clk_get_rate(clk->parent) / clk->divider;
+	else
+		return 0;
+}
+
+static int clk_local_onoff_enable(struct clk *clk, int enable)
+{
+	u32 tmp;
+
+	/* no enable_reg means the clock is always enabled */
+	if (!clk->enable_reg)
+		return 0;
+
+	tmp = __raw_readl(mcs814x_sysdbg_base + clk->enable_reg);
+	if (!enable)
+		tmp &= ~clk->enable_mask;
+	else
+		tmp |= clk->enable_mask;
+
+	__raw_writel(tmp, mcs814x_sysdbg_base + clk->enable_reg);
+
+	return 0;
+}
+
+static struct clk_ops default_clk_ops = {
+	.get_rate	= clk_divide_parent,
+	.enable		= clk_local_onoff_enable,
+};
+
+static DEFINE_SPINLOCK(clocks_lock);
+
+static const unsigned long cpu_freq_table[] = {
+	175000,
+	300000,
+	125000,
+	137500,
+	212500,
+	250000,
+	162500,
+	187500,
+	162500,
+	150000,
+	225000,
+	237500,
+	200000,
+	262500,
+	275000,
+	287500
+};
+
+static struct clk clk_cpu;
+
+/* System clock is fixed at 50Mhz */
+static struct clk clk_sys = {
+	.rate	= 50 * MHZ,
+};
+
+static struct clk clk_sdram;
+
+static struct clk clk_timer0 = {
+	.parent	= &clk_sdram,
+	.divider = 2,
+	.ops	= &default_clk_ops,
+};
+
+static struct clk clk_timer1_2 = {
+	.parent	= &clk_sys,
+};
+
+/* Watchdog clock is system clock / 128 */
+static struct clk clk_wdt = {
+	.parent	= &clk_sys,
+	.divider = 128,
+	.ops	= &default_clk_ops,
+};
+
+static struct clk clk_emac = {
+	.ops		= &default_clk_ops,
+	.enable_reg	= SYSDBG_SYSCTL,
+	.enable_mask	= SYSCTL_EMAC,
+};
+
+static struct clk clk_ephy = {
+	.ops		= &default_clk_ops,
+	.enable_reg	= SYSDBG_PLL_CTL,
+	.enable_mask	= ~SYSCTL_EPHY,	/* active low */
+};
+
+static struct clk clk_cipher = {
+	.ops		= &default_clk_ops,
+	.enable_reg	= SYSDBG_SYSCTL,
+	.enable_mask	= SYSCTL_CIPHER,
+};
+
+#define CLK(_dev, _con, _clk)	\
+{ .dev_id = (_dev), .con_id = (_con), .clk = (_clk) },
+
+static struct clk_lookup mcs814x_chip_clks[] = {
+	CLK("cpu", NULL, &clk_cpu)
+	CLK("sys", NULL, &clk_sys)
+	CLK("sdram", NULL, &clk_sdram)
+	/* 32-bits timer0 */
+	CLK("timer0", NULL, &clk_timer0)
+	/* 16-bits timer1 */
+	CLK("timer1", NULL, &clk_timer1_2)
+	/* 64-bits timer2, same as timer 1 */
+	CLK("timer2", NULL, &clk_timer1_2)
+	CLK(NULL, "wdt", &clk_wdt)
+	CLK(NULL, "emac", &clk_emac)
+	CLK(NULL, "ephy", &clk_ephy)
+	CLK(NULL, "cipher", &clk_cipher)
+};
+
+static void local_clk_disable(struct clk *clk)
+{
+	WARN_ON(!clk->usecount);
+
+	if (clk->usecount > 0) {
+		clk->usecount--;
+
+		if ((clk->usecount == 0) && (clk->ops->enable))
+			clk->ops->enable(clk, 0);
+
+		if (clk->parent)
+			local_clk_disable(clk->parent);
+	}
+}
+
+static int local_clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (clk->parent)
+		ret = local_clk_enable(clk->parent);
+
+	if (ret)
+		return ret;
+
+	if ((clk->usecount == 0) && (clk->ops->enable))
+		ret = clk->ops->enable(clk, 1);
+
+	if (!ret)
+		clk->usecount++;
+	else if (clk->parent && clk->parent->ops->enable)
+		local_clk_disable(clk->parent);
+
+	return ret;
+}
+
+int clk_enable(struct clk *clk)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	ret = local_clk_enable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	local_clk_disable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return 0;
+
+	if (clk->rate)
+		return clk->rate;
+
+	if (clk->ops && clk->ops->get_rate)
+		return clk->ops->get_rate(clk);
+
+	return clk_get_rate(clk->parent);
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return NULL;
+
+	if (!clk->ops || !clk->ops->get_parent)
+		return clk->parent;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	clk->parent = clk->ops->get_parent(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+void __init mcs814x_clk_init(void)
+{
+	u32 bs1;
+	u8 cpu_freq;
+
+	clkdev_add_table(mcs814x_chip_clks, ARRAY_SIZE(mcs814x_chip_clks));
+
+	/* read the bootstrap registers to know the exact clocking scheme */
+	bs1 = __raw_readl(mcs814x_sysdbg_base + SYSDBG_BS1);
+	cpu_freq = (bs1 >> CPU_FREQ_SHIFT) & CPU_FREQ_MASK;
+
+	pr_info("CPU frequency: %lu (kHz)\n", cpu_freq_table[cpu_freq]);
+	clk_cpu.rate = cpu_freq * KHZ;
+
+	/* read SDRAM frequency */
+	if (bs1 & SDRAM_FREQ_BIT)
+		clk_sdram.rate = 100 * MHZ;
+	else
+		clk_sdram.rate = 133 * MHZ;
+
+	pr_info("SDRAM frequency: %lu (MHz)\n", clk_sdram.rate / MHZ);
+}
+
diff --git a/arch/arm/mach-mcs814x/common.c b/arch/arm/mach-mcs814x/common.c
new file mode 100644
index 0000000..0652633
--- /dev/null
+++ b/arch/arm/mach-mcs814x/common.c
@@ -0,0 +1,97 @@
+/*
+ * arch/arm/mach-mcs814x/common.c
+ *
+ * Core functions for Moschip MCS814x SoCs
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/mcs814x.h>
+#include <mach/cpu.h>
+#include <asm/pgtable.h>
+#include <asm/mach/map.h>
+
+void __iomem *mcs814x_sysdbg_base;
+
+static struct map_desc mcs814x_io_desc[] __initdata = {
+	{
+		.virtual	= MCS814X_IO_BASE,
+		.pfn		= __phys_to_pfn(MCS814X_IO_START),
+		.length		= MCS814X_IO_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+struct cpu_mode {
+	const char *name;
+	int gpio_start;
+	int gpio_end;
+};
+
+static const struct cpu_mode cpu_modes[] = {
+	{
+		.name		= "I2S",
+		.gpio_start	= 4,
+		.gpio_end	= 8,
+	},
+	{
+		.name		= "UART",
+		.gpio_start	= 4,
+		.gpio_end	= 9,
+	},
+	{
+		.name		= "External MII",
+		.gpio_start	= 0,
+		.gpio_end	= 16,
+	},
+	{
+		.name		= "Normal",
+		.gpio_start	= -1,
+		.gpio_end	= -1,
+	},
+};
+
+void __init mcs814x_init_machine(void)
+{
+	u32 bs2, cpu_mode;
+	int gpio;
+
+	bs2 = __raw_readl(mcs814x_sysdbg_base + SYSDBG_BS2);
+	cpu_mode = (bs2 >> CPU_MODE_SHIFT) & CPU_MODE_MASK;
+
+	pr_info("CPU mode: %s\n", cpu_modes[cpu_mode].name);
+
+	/* request the gpios since the pins are muxed for functionnality */
+	for (gpio = cpu_modes[cpu_mode].gpio_start;
+		gpio == cpu_modes[cpu_mode].gpio_end; gpio++) {
+		if (gpio != -1)
+			gpio_request(gpio, cpu_modes[cpu_mode].name);
+	}
+}
+
+void __init mcs814x_map_io(void)
+{
+	iotable_init(mcs814x_io_desc, ARRAY_SIZE(mcs814x_io_desc));
+
+	mcs814x_sysdbg_base = ioremap(MCS814X_IO_START + MCS814X_SYSDBG,
+					MCS814X_SYSDBG_SIZE);
+	if (!mcs814x_sysdbg_base)
+		panic("unable to remap sysdbg base");
+}
+
+void mcs814x_restart(char mode, const char *cmd)
+{
+	__raw_writel(~(1 << 31), mcs814x_sysdbg_base);
+}
diff --git a/arch/arm/mach-mcs814x/common.h b/arch/arm/mach-mcs814x/common.h
new file mode 100644
index 0000000..e523abe
--- /dev/null
+++ b/arch/arm/mach-mcs814x/common.h
@@ -0,0 +1,15 @@
+#ifndef __ARCH_MCS814X_COMMON_H
+#define __ARCH_MCS814X_COMMON_H
+
+#include <asm/mach/time.h>
+
+void mcs814x_map_io(void);
+void mcs814x_clk_init(void);
+void mcs814x_of_irq_init(void);
+void mcs814x_init_machine(void);
+void mcs814x_handle_irq(struct pt_regs *regs);
+void mcs814x_restart(char mode, const char *cmd);
+extern struct sys_timer mcs814x_timer;
+extern void __iomem *mcs814x_sysdbg_base;
+
+#endif /* __ARCH_MCS814X_COMMON_H */
diff --git a/arch/arm/mach-mcs814x/include/mach/cpu.h b/arch/arm/mach-mcs814x/include/mach/cpu.h
new file mode 100644
index 0000000..1ef3c4a
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/cpu.h
@@ -0,0 +1,16 @@
+#ifndef __ASM_ARCH_CPU_H__
+#define __ASM_ARCH_CPU_H__
+
+#include <asm/cputype.h>
+
+#define MCS8140_ID	0x41069260	/* ARM926EJ-S */
+#define MCS814X_MASK	0xff0ffff0
+
+#ifdef CONFIG_MCS8140
+/* Moschip MCS8140 is based on an ARM926EJ-S core */
+#define soc_is_mcs8140()	((read_cpuid_id() & MCS814X_MASK) == MCS8140_ID)
+#else
+#define soc_is_mcs8140()	(0)
+#endif /* !CONFIG_MCS8140 */
+
+#endif /* __ASM_ARCH_CPU_H__ */
diff --git a/arch/arm/mach-mcs814x/include/mach/debug-macro.S b/arch/arm/mach-mcs814x/include/mach/debug-macro.S
new file mode 100644
index 0000000..93ecea4
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/debug-macro.S
@@ -0,0 +1,11 @@
+#include <mach/mcs814x.h>
+
+                .macro  addruart, rp, rv, tmp
+		ldr	\rp, =MCS814X_PHYS_BASE
+		ldr	\rv, =MCS814X_VIRT_BASE
+		orr	\rp, \rp, #MCS814X_UART
+		orr	\rv, \rv, #MCS814X_UART
+                .endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-mcs814x/include/mach/entry-macro.S b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
new file mode 100644
index 0000000..cbad566
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
@@ -0,0 +1,29 @@
+#include <mach/mcs814x.h>
+                .macro  disable_fiq
+                .endm
+
+		.macro arch_ret_to_user, tmp1, tmp2
+		.endm
+
+		.macro  get_irqnr_preamble, base, tmp
+		ldr	\base, =mcs814x_intc_base@ base virtual address of INTC
+		ldr	\base, [\base]
+		.endm
+
+		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+		mov	\tmp, #MCS814X_IRQ_STS0	 @ load tmp with STS0 register offset
+		ldr	\irqstat, [\base, \tmp]	 @ load value at base + tmp
+		tst	\irqstat, \irqstat       @ test if no active IRQ's
+		beq	1002f                    @ if no active irqs return with status 0
+		mov	\irqnr, #0               @ start from irq zero
+		mov	\tmp,   #1               @ the mask initially 1
+1001:
+		tst     \irqstat, \tmp           @ and with mask
+		addeq   \irqnr, \irqnr, #1       @ if  zero then add one to nr
+		moveq   \tmp,   \tmp, lsl #1     @ shift mask one to left
+		beq     1001b                    @ if  zero then loop again
+		mov     \irqstat, \tmp           @ save the return mask
+		mov	\tmp, #MCS814X_IRQ_STS0  @ load tmp with ICR offset
+		str     \irqstat,  [\base, \tmp] @ clear irq with selected mask
+1002:
+                .endm
diff --git a/arch/arm/mach-mcs814x/include/mach/gpio.h b/arch/arm/mach-mcs814x/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-mcs814x/include/mach/hardware.h b/arch/arm/mach-mcs814x/include/mach/hardware.h
new file mode 100644
index 0000000..529f648
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/hardware.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2003 Artec Design Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+#include "mcs814x.h"
+
+#endif
+
diff --git a/arch/arm/mach-mcs814x/include/mach/irqs.h b/arch/arm/mach-mcs814x/include/mach/irqs.h
new file mode 100644
index 0000000..78021d1
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/irqs.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2003 Artec Design Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H
+
+#define FIQ_START	0
+
+#define NR_IRQS		32
+
+#define IRQ_PCI_INTA            22
+#define IRQ_PCI_INTB            23
+#define IRQ_PCI_INTC            24
+#define IRQ_PCI_INTD            26
+
+#endif
diff --git a/arch/arm/mach-mcs814x/include/mach/mcs814x.h b/arch/arm/mach-mcs814x/include/mach/mcs814x.h
new file mode 100644
index 0000000..a4a369e
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/mcs814x.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2003 Artec Design Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_ARCH_MCS814X_H
+#define __ASM_ARCH_MCS814X_H
+
+#define MCS814X_IO_BASE		0xF0000000
+#define MCS814X_IO_START	0x40000000
+#define MCS814X_IO_SIZE		0x00100000
+
+/* IRQ controller register offset */
+#define MCS814X_IRQ_ICR		0x00
+#define MCS814X_IRQ_ISR		0x04
+#define MCS814X_IRQ_MASK	0x20
+#define MCS814X_IRQ_STS0	0x40
+
+#define MCS814X_PHYS_BASE	0x40000000
+#define MCS814X_VIRT_BASE	MCS814X_IO_BASE
+
+#define MCS814X_UART		0x000DC000
+#define MCS814X_DBGLED		0x000EC000
+#define MCS814X_SYSDBG		0x000F8000
+#define MCS814X_SYSDBG_SIZE	0x50
+
+/* System configuration and bootstrap registers */
+#define SYSDBG_BS1		0x00
+#define  CPU_FREQ_SHIFT		27
+#define  CPU_FREQ_MASK		0x0F
+#define  SDRAM_FREQ_BIT		(1 << 22)
+
+#define SYSDBG_BS2		0x04
+#define  LED_CFG_MASK		0x03
+#define  CPU_MODE_SHIFT		23
+#define  CPU_MODE_MASK		0x03
+
+#define SYSDBG_SYSCTL_MAC	0x1d
+#define  BUF_SHIFT_BIT		(1 << 0)
+
+#define SYSDBG_SYSCTL		0x08
+#define  SYSCTL_EMAC		(1 << 0)
+#define  SYSCTL_EPHY		(1 << 0) /* active low */
+#define  SYSCTL_CIPHER		(1 << 16)
+
+#define SYSDBG_PLL_CTL		0x3C
+
+#endif /* __ASM_ARCH_MCS814X_H */
+
diff --git a/arch/arm/mach-mcs814x/include/mach/memory.h b/arch/arm/mach-mcs814x/include/mach/memory.h
new file mode 100644
index 0000000..ad87c7b
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/memory.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2003 Artec Design Ltd.
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+#define PLAT_PHYS_OFFSET		UL(0x00000000)
+
+#endif
diff --git a/arch/arm/mach-mcs814x/include/mach/timex.h b/arch/arm/mach-mcs814x/include/mach/timex.h
new file mode 100644
index 0000000..f05c8ee
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/timex.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2003 Artec Design Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H
+
+/*
+ * Timex specification for MCS814X
+ */
+#define CLOCK_TICK_RATE		100
+
+#endif
diff --git a/arch/arm/mach-mcs814x/include/mach/uncompress.h b/arch/arm/mach-mcs814x/include/mach/uncompress.h
new file mode 100644
index 0000000..21b9821
--- /dev/null
+++ b/arch/arm/mach-mcs814x/include/mach/uncompress.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H
+
+#include <linux/serial_reg.h>
+#include <asm/io.h>
+#include <mach/mcs814x.h>
+#include <mach/cpu.h>
+
+#define UART_SHIFT	(2)
+
+/* cannot be static because the code will be inlined */
+void __iomem *uart_base;
+
+static inline void putc(int c)
+{
+	while (!(__raw_readb(uart_base + (UART_LSR << UART_SHIFT)) & UART_LSR_TEMT))
+		;
+	__raw_writeb(c, uart_base + (UART_TX << UART_SHIFT));
+}
+
+static inline void flush(void)
+{
+}
+
+static inline void arch_decomp_setup(void)
+{
+	if (soc_is_mcs8140())
+		uart_base = (void __iomem *)(MCS814X_PHYS_BASE + MCS814X_UART);
+}
+
+#define arch_decomp_wdog()
+
+#endif
diff --git a/arch/arm/mach-mcs814x/irq.c b/arch/arm/mach-mcs814x/irq.c
new file mode 100644
index 0000000..089937b
--- /dev/null
+++ b/arch/arm/mach-mcs814x/irq.c
@@ -0,0 +1,69 @@
+/*
+ * Moschip MCS814x generic interrupt controller routines
+ *
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * Licensed under the GPLv2
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/irqdomain.h>
+
+#include <asm/exception.h>
+#include <asm/mach/irq.h>
+#include <mach/mcs814x.h>
+
+void __iomem *mcs814x_intc_base;
+
+static void __init mcs814x_alloc_gc(void __iomem *base, unsigned int irq_start,
+					unsigned int num)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("mcs814x-intc", 1,
+			irq_start, base, handle_level_irq);
+	if (!gc)
+		panic("unable to allocate generic irq chip");
+
+	ct = gc->chip_types;
+	ct->chip.irq_ack = irq_gc_unmask_enable_reg;
+	ct->chip.irq_mask = irq_gc_mask_clr_bit;
+	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->regs.mask = MCS814X_IRQ_MASK;
+	ct->regs.enable = MCS814X_IRQ_ICR;
+
+	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
+		IRQ_NOREQUEST, 0);
+
+	/* Clear all interrupts */
+	__raw_writel(0xffffffff, base + MCS814X_IRQ_ICR);
+}
+
+static const struct of_device_id mcs814x_intc_ids[] = {
+	{ .compatible = "moschip,mcs814x-intc" },
+	{ /* sentinel */ },
+};
+
+void __init mcs814x_of_irq_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, mcs814x_intc_ids);
+	if (!np)
+		panic("unable to find compatible intc node in dtb\n");
+
+	mcs814x_intc_base = of_iomap(np, 0);
+	if (!mcs814x_intc_base)
+		panic("unable to map intc cpu registers\n");
+
+	irq_domain_add_legacy(np, 32, 0, 0, &irq_domain_simple_ops, NULL);
+
+	of_node_put(np);
+
+	mcs814x_alloc_gc(mcs814x_intc_base, 0, 32);
+}
+
diff --git a/arch/arm/mach-mcs814x/pci.c b/arch/arm/mach-mcs814x/pci.c
new file mode 100644
index 0000000..a75bfe6
--- /dev/null
+++ b/arch/arm/mach-mcs814x/pci.c
@@ -0,0 +1,446 @@
+/*
+ * Moschip MCS8140 PCI support
+ *
+ * Copyright (C) 2003 Moschip Semiconductors Ltd.
+ * Copyright (C) 2003 Artec Design Ltd.
+ * Copyright (C) 2012 Florian Fainelli <florian@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/mach/pci.h>
+#include <asm/mach/map.h>
+#include <mach/mcs814x.h>
+#include <mach/irqs.h>
+
+#define MCS8140_PCI_CONFIG_SIZE		SZ_64M
+#define MCS8140_PCI_IOMISC_SIZE		SZ_64M
+
+#define MCS8140_PCI_HOST_BASE           0x80000000
+#define MCS8140_PCI_IOMISC_BASE         0x00000000
+#define MCS8140_PCI_PRE_BASE            0x10000000
+#define MCS8140_PCI_NONPRE_BASE         0x30000000
+
+#define MCS8140_PCI_CFG_BASE		(MCS8140_PCI_HOST_BASE + 0x04000000)
+#define MCS8140_PCI_IO_BASE		(MCS8140_PCI_HOST_BASE)
+
+#define MCS8140_PCI_IO_VIRT_BASE	(MCS814X_IO_BASE - \
+					 MCS8140_PCI_CONFIG_SIZE - \
+					 MCS8140_PCI_IOMISC_SIZE)
+#define MCS8140_PCI_CFG_VIRT_BASE	(MCS814X_IO_BASE - \
+					 MCS8140_PCI_CONFIG_SIZE)
+
+#define PCI_FATAL_ERROR			1
+#define EXTERNAL_ABORT_NON_LINE_FETCH	8
+#define EPRM_DONE			0x80
+#define EPRM_SDRAM_FUNC0		0xAC
+#define PCI_INTD			4
+#define MCS8140_PCI_DEVICE_ID		0xA0009710
+#define MCS8140_PCI_CLASS_ID		0x02000011  /* Host-Class id :0x0600 */
+#define PCI_IF_CONFIG			0x200
+
+static void __iomem *mcs8140_pci_master_base;
+static void __iomem *mcs8140_eeprom_emu_base;
+
+static unsigned long __pci_addr(struct pci_bus *bus,
+				unsigned int devfn, int offset)
+{
+	unsigned int busnr = bus->number;
+	unsigned int slot;
+
+	/* we only support bus 0 */
+	if (busnr != 0)
+		return 0;
+
+	/*
+	 * Trap out illegal values
+	 */
+	BUG_ON(devfn > 255 || busnr > 255 || devfn > 255);
+
+	/* Scan 3 slots */
+	slot = PCI_SLOT(devfn);
+	switch (slot) {
+	case 1:
+	case 2:
+	case 3:
+		if (PCI_FUNC(devfn) >= 4)
+			return 0;
+
+		return MCS8140_PCI_CFG_VIRT_BASE | (PCI_SLOT(devfn) << 11) |
+			(PCI_FUNC(devfn) << 8) | offset;
+	default:
+		pr_warn("Ignoring: PCI Slot is %x\n", PCI_SLOT(devfn));
+		return 0;
+	}
+}
+
+static int mcs8140_pci_host_status(void)
+{
+	u32 host_status;
+
+	host_status = __raw_readl(mcs8140_pci_master_base + PCI_IF_CONFIG);
+	if (host_status & PCI_FATAL_ERROR) {
+		__raw_writel(host_status & 0xfffffff0,
+			mcs8140_pci_master_base + PCI_IF_CONFIG);
+		/* flush write */
+		host_status =
+			__raw_readl(mcs8140_pci_master_base + PCI_IF_CONFIG);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int mcs8140_pci_read_config(struct pci_bus *bus,
+					unsigned int devfn, int where,
+					int size, u32 *val)
+{
+	unsigned long v = 0xFFFFFFFF;
+	unsigned long addr = __pci_addr(bus, devfn, where);
+
+	if (addr != 0) {
+		switch (size) {
+		case 1:
+			v = __raw_readb(addr);
+			break;
+		case 2:
+			addr &= ~1;
+			v = __raw_readw(addr);
+			break;
+		default:
+			addr &= ~3;
+			v = __raw_readl(addr);
+			break;
+		}
+	} else
+		v = 0xffffffff;
+
+	if (mcs8140_pci_host_status())
+		v = 0xffffffff;
+
+	*val = v;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static void mcs8140_eeprom_emu_init(void)
+{
+	__raw_writel(0x0000000F, mcs8140_eeprom_emu_base + EPRM_SDRAM_FUNC0);
+	__raw_writel(0x08000000, MCS8140_PCI_CFG_VIRT_BASE + 0x10);
+	/* Set the DONE bit of the EEPROM emulator */
+	__raw_writel(0x01, mcs8140_eeprom_emu_base + EPRM_DONE);
+}
+
+static int mcs8140_pci_write_config(struct pci_bus *bus,
+					unsigned int devfn, int where,
+					int size, u32 val)
+{
+	unsigned long addr = __pci_addr(bus, devfn, where);
+
+	if (addr != 0) {
+		switch (size) {
+		case 1:
+			__raw_writeb((u8)val, addr);
+			break;
+		case 2:
+			__raw_writew((u16)val, addr);
+			break;
+		case 4:
+			__raw_writel(val, addr);
+			break;
+		}
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops pci_mcs8140_ops = {
+	.read	= mcs8140_pci_read_config,
+	.write	= mcs8140_pci_write_config,
+};
+
+
+static struct resource io_mem = {
+	.name	= "PCI I/O space",
+	.start	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_IOMISC_BASE,
+	.end	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_IOMISC_BASE + SZ_64M,
+	.flags	= IORESOURCE_IO,
+};
+
+static struct resource pre_mem = {
+	.name	= "PCI prefetchable",
+	.start	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_PRE_BASE,
+	.end	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_PRE_BASE + SZ_512M,
+	.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
+};
+
+static struct resource non_mem = {
+	.name	= "PCI non-prefetchable",
+	.start	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_NONPRE_BASE,
+	.end	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_NONPRE_BASE + SZ_256M,
+	.flags	= IORESOURCE_MEM,
+};
+
+int __init pci_mcs8140_setup_resources(struct pci_sys_data *sys)
+{
+	int ret = 0;
+
+	ret = request_resource(&iomem_resource, &io_mem);
+	if (ret)
+		goto out;
+
+	ret = request_resource(&iomem_resource, &non_mem);
+	if (ret)
+		goto release_io_mem;
+
+	ret = request_resource(&iomem_resource, &pre_mem);
+	if (ret)
+		goto release_non_mem;
+
+	mcs8140_eeprom_emu_init();
+
+	pci_add_resource(&sys->resources, &io_mem);
+	pci_add_resource(&sys->resources, &non_mem);
+	pci_add_resource(&sys->resources, &pre_mem);
+
+	return ret;
+
+release_non_mem:
+	release_resource(&non_mem);
+release_io_mem:
+	release_resource(&io_mem);
+out:
+	return ret;
+}
+
+struct pci_bus *pci_mcs8140_scan_bus(int nr, struct pci_sys_data *sys)
+{
+	return pci_scan_bus(sys->busnr, &pci_mcs8140_ops, sys);
+}
+
+
+int __init pci_mcs8140_setup(int nr, struct pci_sys_data *sys)
+{
+	int ret = 0;
+	u32 val;
+
+	if (nr > 0)
+		return 0;
+
+	sys->mem_offset = MCS8140_PCI_IO_VIRT_BASE - MCS8140_PCI_IO_BASE;
+	sys->io_offset = 0;
+
+	ret = pci_mcs8140_setup_resources(sys);
+	if (ret < 0) {
+		pr_err("unable to setup mcs8140 resources\n");
+		goto out;
+	}
+
+	val = __raw_readl(MCS8140_PCI_CFG_VIRT_BASE);
+	if (val != MCS8140_PCI_DEVICE_ID) {
+		pr_err("cannot find MCS8140 PCI Core: %08x\n", val);
+		ret = -EIO;
+		goto out;
+	}
+
+	pr_info("MCS8140 PCI core found\n");
+
+	val = __raw_readl(MCS8140_PCI_CFG_VIRT_BASE + PCI_COMMAND);
+	/* Added to support wireless cards */
+	__raw_writel(0, MCS8140_PCI_CFG_VIRT_BASE + 0x40);
+	__raw_writel(val | 0x147, MCS8140_PCI_CFG_VIRT_BASE + PCI_COMMAND);
+	val = __raw_readl(MCS8140_PCI_CFG_VIRT_BASE + PCI_COMMAND);
+	ret = 1;
+out:
+	return ret;
+}
+
+
+static int __init mcs8140_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int line = IRQ_PCI_INTA;
+
+	if (pin != 0) {
+		/* IRQ_PCIA - 22 */
+		if (pin == PCI_INTD)
+			line = IRQ_PCI_INTA + pin; /* IRQ_PCIA - 22 */
+		else
+			line = IRQ_PCI_INTA + pin - 1; /* IRQ_PCIA - 22 */
+	}
+
+	pr_info("PCI: Map interrupt slot 0x%02x pin 0x%02x line 0x%02x\n",
+		slot, pin, line);
+
+	return line;
+}
+
+static irqreturn_t mcs8140_pci_abort_interrupt(int irq, void *dummy)
+{
+	u32 word;
+
+	word = __raw_readl(mcs8140_pci_master_base + PCI_IF_CONFIG);
+	if (!(word & (1 << 24)))
+		return IRQ_NONE;
+
+	__raw_writel(word & 0xfffffff0,
+		mcs8140_pci_master_base + PCI_IF_CONFIG);
+	/* flush write */
+	word = __raw_readl(mcs8140_pci_master_base + PCI_IF_CONFIG);
+
+	return IRQ_HANDLED;
+}
+
+static int mcs8140_pci_abort_irq_init(int irq)
+{
+	u32 word;
+
+	/* Enable Interrupt in PCI Master Core */
+	word = __raw_readl(mcs8140_pci_master_base + PCI_IF_CONFIG);
+	word |= (1 << 24);
+	__raw_writel(word, mcs8140_pci_master_base + PCI_IF_CONFIG);
+
+	/* flush write */
+	word = __raw_readl(mcs8140_pci_master_base + PCI_IF_CONFIG);
+
+	return request_irq(irq, mcs8140_pci_abort_interrupt, 0,
+			"PCI abort", NULL);
+}
+
+static int mcs8140_pci_host_abort(unsigned long addr,
+				unsigned int fsr, struct pt_regs *regs)
+{
+	pr_warn("PCI Data abort: address = 0x%08lx fsr = 0x%03x "
+		"PC = 0x%08lx LR = 0x%08lx\n",
+		addr, fsr, regs->ARM_pc, regs->ARM_lr);
+
+	/*
+	 * If it was an imprecise abort, then we need to correct the
+	 * return address to be _after_ the instruction.
+	 */
+	if (fsr & (1 << 10) || mcs8140_pci_host_status())
+		regs->ARM_pc += 4;
+
+	return 0;
+}
+
+static void mcs8140_data_abort_init(void)
+{
+	hook_fault_code(EXTERNAL_ABORT_NON_LINE_FETCH,
+		mcs8140_pci_host_abort, SIGBUS,
+		0, "external abort on non-line fetch");
+}
+
+static struct hw_pci mcs8140_pci __initdata = {
+	.map_irq		= mcs8140_map_irq,
+	.nr_controllers		= 1,
+	.setup			= pci_mcs8140_setup,
+	.scan			= pci_mcs8140_scan_bus,
+};
+
+static struct map_desc mcs8140_pci_io_desc[] __initdata = {
+	{
+		.virtual	= MCS8140_PCI_CFG_VIRT_BASE,
+		.pfn		= __phys_to_pfn(MCS8140_PCI_CFG_BASE),
+		.length		= MCS8140_PCI_CONFIG_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= MCS8140_PCI_IO_VIRT_BASE,
+		.pfn		= __phys_to_pfn(MCS8140_PCI_IO_BASE),
+		.length		= MCS8140_PCI_IOMISC_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+static int __devinit mcs8140_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret, irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get mem resource 0\n");
+		return -ENODEV;
+	}
+
+	mcs8140_pci_master_base = devm_ioremap(&pdev->dev, res->start,
+					resource_size(res));
+	if (!mcs8140_pci_master_base) {
+		dev_err(&pdev->dev, "failed to remap PCI master regs\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get mem resource 1\n");
+		return -ENOMEM;
+	}
+
+	mcs8140_eeprom_emu_base = devm_ioremap(&pdev->dev, res->start,
+					resource_size(res));
+	if (!mcs8140_eeprom_emu_base) {
+		dev_err(&pdev->dev, "failed to remap EEPROM regs\n");
+		return -ENOMEM;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get pci abort irq\n");
+		return -ENODEV;
+	}
+
+	/* Setup static mappins for PCI CFG space */
+	iotable_init(mcs8140_pci_io_desc, ARRAY_SIZE(mcs8140_pci_io_desc));
+
+	pcibios_min_io = MCS8140_PCI_HOST_BASE;
+	pcibios_min_mem = MCS8140_PCI_HOST_BASE + MCS8140_PCI_PRE_BASE;
+
+	mcs8140_data_abort_init();
+	ret = mcs8140_pci_abort_irq_init(irq);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup abort irq\n");
+		return ret;
+	}
+
+	pci_common_init(&mcs8140_pci);
+
+	return 0;
+}
+
+static struct of_device_id mcs8140_of_ids[] __devinitdata = {
+	{ .compatible = "moschip,mcs8140-pci" },
+	{ .compatible = "moschip,mcs814x-pci" },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver mcs8140_pci_driver = {
+	.driver	= {
+		.name	= "mcs8140-pci",
+		.of_match_table = mcs8140_of_ids,
+	},
+	.probe	= mcs8140_pci_probe,
+};
+
+static int __init mcs8140_pci_init(void)
+{
+	return platform_driver_register(&mcs8140_pci_driver);
+}
+subsys_initcall(mcs8140_pci_init);
+
diff --git a/arch/arm/mach-mcs814x/timer.c b/arch/arm/mach-mcs814x/timer.c
new file mode 100644
index 0000000..e8408e4
--- /dev/null
+++ b/arch/arm/mach-mcs814x/timer.c
@@ -0,0 +1,133 @@
+/*
+ * Moschip MCS814x timer routines
+ *
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * Licensed under GPLv2
+ */
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/irq.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/mach/time.h>
+#include <mach/mcs814x.h>
+
+/* Timer block registers */
+#define TIMER_VAL	0x00
+#define TIMER_CTL	0x04
+
+static u32 last_reload;
+static u32 timer_correct;
+static u32 clock_rate;
+static u32 timer_reload_value;
+static void __iomem *mcs814x_timer_base;
+
+static inline unsigned long ticks2usecs(u32 x)
+{
+	return x / (clock_rate / 1000000);
+}
+
+/*
+ * Returns number of ms since last clock interrupt.  Note that interrupts
+ * will have been disabled by do_gettimeoffset()
+ */
+static unsigned long mcs814x_gettimeoffset(void)
+{
+	u32 ticks = __raw_readl(mcs814x_timer_base + TIMER_VAL);
+
+	if (ticks < last_reload)
+		return ticks2usecs(ticks + (u32)(0xffffffff - last_reload));
+	else
+		return ticks2usecs(ticks - last_reload);
+}
+
+
+static irqreturn_t mcs814x_timer_interrupt(int irq, void *dev_id)
+{
+	u32 count = __raw_readl(mcs814x_timer_base + TIMER_VAL);
+
+	/* take into account delay up to this moment */
+	last_reload = count + timer_correct + timer_reload_value;
+
+	if (last_reload < timer_reload_value)
+		last_reload = timer_reload_value;
+	else if (timer_correct == 0)
+		timer_correct = __raw_readl(mcs814x_timer_base + TIMER_VAL) -
+					count;
+
+	__raw_writel(last_reload, mcs814x_timer_base + TIMER_VAL);
+
+	timer_tick();
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction mcs814x_timer_irq = {
+	.name		= "mcs814x-timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= mcs814x_timer_interrupt,
+};
+
+static struct of_device_id mcs814x_timer_ids[] = {
+	{ .compatible = "moschip,mcs814x-timer" },
+	{ /* sentinel */ },
+};
+
+static void __init mcs814x_of_timer_init(void)
+{
+	struct device_node *np;
+	const unsigned int *intspec;
+
+	np = of_find_matching_node(NULL, mcs814x_timer_ids);
+	if (!np)
+		panic("unable to find compatible timer node in dtb");
+
+	mcs814x_timer_base = of_iomap(np, 0);
+	if (!mcs814x_timer_base)
+		panic("unable to remap timer cpu registers");
+
+	intspec = of_get_property(np, "interrupts", NULL);
+	if (!intspec)
+		panic("no interrupts property for timer");
+
+	mcs814x_timer_irq.irq = be32_to_cpup(intspec);
+}
+
+static void __init mcs814x_timer_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_get_sys("timer0", NULL);
+	if (IS_ERR_OR_NULL(clk))
+		panic("unable to get timer0 clock");
+
+	clock_rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	mcs814x_of_timer_init();
+
+	pr_info("Timer frequency: %d (kHz)\n", clock_rate / 1000);
+
+	timer_reload_value = 0xffffffff - (clock_rate / HZ);
+
+	/* disable timer */
+	__raw_writel(0, mcs814x_timer_base + TIMER_CTL);
+	__raw_writel(timer_reload_value, mcs814x_timer_base + TIMER_VAL);
+	last_reload = timer_reload_value;
+
+	setup_irq(mcs814x_timer_irq.irq, &mcs814x_timer_irq);
+	/* enable timer, stop timer in debug mode */
+	__raw_writel(0x03, mcs814x_timer_base + TIMER_CTL);
+}
+
+struct sys_timer mcs814x_timer = {
+	.init	= mcs814x_timer_init,
+	.offset	= mcs814x_gettimeoffset,
+};
-- 
1.7.10.4
