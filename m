From: bs14@csr.com (Barry Song)
Date: Mon, 20 Jun 2011 00:53:22 -0700
Subject: [PATCH] ARM: CSR: Adding CSR SiRFprimaII board support
Message-ID: <1308556402-10955-1-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Binghua Duan <binghua.duan@csr.com>

SiRFprimaII is the latest generation application processor from CSR?s
Multifunction SoC product family. Designed around an ARM cortex A9 core,
high-speed memory bus, advanced 3D accelerator and full-HD multi-format
video decoder, SiRFprimaII is able to meet the needs of complicated
applications for modern multifunction devices that require heavy concurrent
applications and fluid user experience. Integrated with GPS baseband,
analog and PMU, this new platform is designed to provide a cost effective
solution for Automotive and Consumer markets.

This patch adds the basic support for this SoC and EVB board based on device
tree. It is following the ZYNQ of Grant Likely in some degree.

Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
Signed-off-by: Rongjun Ying <Binghua.Duan@csr.com>
Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Huayi Li <Huayi.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig                                |   13 +
 arch/arm/Makefile                               |    1 +
 arch/arm/boot/dts/prima2-cb.dts                 |   44 +++
 arch/arm/mach-prima2/Makefile                   |    1 +
 arch/arm/mach-prima2/Makefile.boot              |    3 +
 arch/arm/mach-prima2/board_dt.c                 |   28 ++
 arch/arm/mach-prima2/clock.c                    |  474 +++++++++++++++++++++++
 arch/arm/mach-prima2/common.c                   |   81 ++++
 arch/arm/mach-prima2/common.h                   |   23 ++
 arch/arm/mach-prima2/include/mach/clkdev.h      |   15 +
 arch/arm/mach-prima2/include/mach/debug-macro.S |   29 ++
 arch/arm/mach-prima2/include/mach/entry-macro.S |   28 ++
 arch/arm/mach-prima2/include/mach/hardware.h    |   15 +
 arch/arm/mach-prima2/include/mach/io.h          |   17 +
 arch/arm/mach-prima2/include/mach/irqs.h        |   17 +
 arch/arm/mach-prima2/include/mach/isa-dma.h     |   14 +
 arch/arm/mach-prima2/include/mach/map.h         |   49 +++
 arch/arm/mach-prima2/include/mach/memory.h      |   21 +
 arch/arm/mach-prima2/include/mach/system.h      |   27 ++
 arch/arm/mach-prima2/include/mach/timex.h       |   14 +
 arch/arm/mach-prima2/include/mach/uart.h        |   18 +
 arch/arm/mach-prima2/include/mach/uncompress.h  |   42 ++
 arch/arm/mach-prima2/include/mach/vmalloc.h     |   14 +
 arch/arm/mach-prima2/irq.c                      |   81 ++++
 arch/arm/mach-prima2/timer.c                    |  181 +++++++++
 arch/arm/mm/Kconfig                             |    2 +-
 26 files changed, 1251 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/prima2-cb.dts
 create mode 100644 arch/arm/mach-prima2/Makefile
 create mode 100644 arch/arm/mach-prima2/Makefile.boot
 create mode 100644 arch/arm/mach-prima2/board_dt.c
 create mode 100644 arch/arm/mach-prima2/clock.c
 create mode 100644 arch/arm/mach-prima2/common.c
 create mode 100644 arch/arm/mach-prima2/common.h
 create mode 100644 arch/arm/mach-prima2/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-prima2/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-prima2/include/mach/io.h
 create mode 100644 arch/arm/mach-prima2/include/mach/irqs.h
 create mode 100644 arch/arm/mach-prima2/include/mach/isa-dma.h
 create mode 100644 arch/arm/mach-prima2/include/mach/map.h
 create mode 100644 arch/arm/mach-prima2/include/mach/memory.h
 create mode 100644 arch/arm/mach-prima2/include/mach/system.h
 create mode 100644 arch/arm/mach-prima2/include/mach/timex.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uart.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-prima2/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-prima2/irq.c
 create mode 100644 arch/arm/mach-prima2/timer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..7a0ce78 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -879,6 +879,19 @@ config ARCH_VT8500
 	select HAVE_PWM
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
+
+config ARCH_PRIMA2
+	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
+	select CPU_V7
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select USE_OF
+	select ISA_DMA_API
+	select ZONE_DMA
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
+
 endchoice
 
 #
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f5b2b39..79e6edf 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -191,6 +191,7 @@ machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
 machine-$(CONFIG_ARCH_VT8500)		:= vt8500
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
+machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
new file mode 100644
index 0000000..6e8b17c
--- /dev/null
+++ b/arch/arm/boot/dts/prima2-cb.dts
@@ -0,0 +1,44 @@
+/dts-v1/;
+/ {
+        model = "SIRF Prima2 EVB";
+        compatible = "sirf,prima2-cb", "sirf,prima2";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+        memory {
+                reg = <0x00000000 0x20000000>;
+        };
+
+	chosen {
+		bootargs = "mem=512M real_root=/dev/mmcblk0p2 console=ttyS1 earlyprintk";
+		linux,stdout-path = &uart1;
+	};
+
+	amba {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		intc: interrupt-controller at 0x80020000 {
+                         interrupt-controller;
+                         compatible = "arm,sirfsoc";
+                         reg = <0x80020000 0x1000>;
+                         #interrupt-cells = <1>;
+		};
+
+		uart0: uart at 0xb0050000 {
+			       compatible = "sirf,uart";
+			       reg = <0xb0050000 0x1000>;
+			       interrupts = <17>;
+		};
+
+		uart1: uart at 0xb0060000 {
+			       compatible = "sirf,uart";
+			       reg = <0xb0060000 0x1000>;
+			       interrupts = <18>;
+		};
+	};
+};
+
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
new file mode 100644
index 0000000..c51d60d
--- /dev/null
+++ b/arch/arm/mach-prima2/Makefile
@@ -0,0 +1 @@
+obj-y := timer.o irq.o clock.o common.o board_dt.o
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-prima2/Makefile.boot
new file mode 100644
index 0000000..d023db3
--- /dev/null
+++ b/arch/arm/mach-prima2/Makefile.boot
@@ -0,0 +1,3 @@
+zreladdr-y		:= 0x00008000
+params_phys-y		:= 0x00000100
+initrd_phys-y		:= 0x00800000
diff --git a/arch/arm/mach-prima2/board_dt.c b/arch/arm/mach-prima2/board_dt.c
new file mode 100644
index 0000000..0994287
--- /dev/null
+++ b/arch/arm/mach-prima2/board_dt.c
@@ -0,0 +1,28 @@
+/*
+ * This file contains code for boards with device tree support.
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/of.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include "common.h"
+
+static const char *prima2cb_dt_match[] __initdata = {
+       "sirf,prima2-cb",
+       NULL
+};
+
+MACHINE_START(PRIMA2_EVB, "prima2cb")
+	.boot_params	= SIRFSOC_SDRAM_PA + 0x100,
+	.init_early     = sirfsoc_init_clk,
+	.map_io		= sirfsoc_map_io,
+	.init_irq	= sirfsoc_init_irq,
+	.timer		= &sirfsoc_timer,
+	.init_machine	= sirfsoc_mach_init,
+	.dt_compat      = prima2cb_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
new file mode 100644
index 0000000..a879fbf
--- /dev/null
+++ b/arch/arm/mach-prima2/clock.c
@@ -0,0 +1,474 @@
+/*
+ * Clock tree for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/clkdev.h>
+#include <linux/clk.h>
+#include <linux/spinlock.h>
+#include <mach/map.h>
+
+#define SIRFSOC_CLKC_CLK_EN0    0x0000
+#define SIRFSOC_CLKC_CLK_EN1    0x0004
+#define SIRFSOC_CLKC_REF_CFG    0x0014
+#define SIRFSOC_CLKC_CPU_CFG    0x0018
+#define SIRFSOC_CLKC_MEM_CFG    0x001c
+#define SIRFSOC_CLKC_SYS_CFG    0x0020
+#define SIRFSOC_CLKC_IO_CFG     0x0024
+#define SIRFSOC_CLKC_DSP_CFG    0x0028
+#define SIRFSOC_CLKC_GFX_CFG    0x002c
+#define SIRFSOC_CLKC_MM_CFG     0x0030
+#define SIRFSOC_LKC_LCD_CFG     0x0034
+#define SIRFSOC_CLKC_MMC_CFG    0x0038
+#define SIRFSOC_CLKC_PLL1_CFG0  0x0040
+#define SIRFSOC_CLKC_PLL2_CFG0  0x0044
+#define SIRFSOC_CLKC_PLL3_CFG0  0x0048
+#define SIRFSOC_CLKC_PLL1_CFG1  0x004c
+#define SIRFSOC_CLKC_PLL2_CFG1  0x0050
+#define SIRFSOC_CLKC_PLL3_CFG1  0x0054
+#define SIRFSOC_CLKC_PLL1_CFG2  0x0058
+#define SIRFSOC_CLKC_PLL2_CFG2  0x005c
+#define SIRFSOC_CLKC_PLL3_CFG2  0x0060
+
+#define KHZ     1000
+#define MHZ     (KHZ * KHZ)
+
+struct clk_ops {
+        unsigned long (*get_rate)(struct clk *clk);
+        long (*round_rate)(struct clk *clk, unsigned long rate);
+        int (*set_rate)(struct clk *clk, unsigned long rate);
+        int (*enable)(struct clk *clk);
+        int (*disable)(struct clk *clk);
+        struct clk *(*get_parent)(struct clk *clk);
+        int (*set_parent)(struct clk *clk, struct clk *parent);
+};
+
+struct clk {
+        struct clk *parent;     /* parent clk */
+        unsigned long rate;     /* clock rate in Hz */
+        signed char usage;      /* clock enable count */
+        signed char enable_bit; /* enable bit: 0 ~ 63 */
+        unsigned short regofs;  /* register offset */
+        struct clk_ops *ops;    /* clock operation */
+};
+
+static DEFINE_SPINLOCK(clocks_lock);
+
+static inline unsigned long clkc_readl(unsigned reg)
+{
+	return readl(SIRFSOC_CLOCK_VA_BASE + reg);
+}
+
+static inline void clkc_writel(u32 val, unsigned reg)
+{
+	writel(val, SIRFSOC_CLOCK_VA_BASE + reg);
+}
+
+/*
+ * osc_rtc - real time oscillator - 32.768KHz
+ * osc_sys - high speed oscillator - 26MHz
+ */
+
+static struct clk clk_rtc = {
+	.rate = 32768,
+};
+
+static struct clk clk_osc = {
+	.rate = 26 * MHZ,
+};
+
+/*
+ * std pll
+ */
+static unsigned long std_pll_get_rate(struct clk *clk)
+{
+	unsigned long fin = clk_get_rate(clk->parent);
+	u32 regcfg2 = clk->regofs + SIRFSOC_CLKC_PLL1_CFG2 - SIRFSOC_CLKC_PLL1_CFG0;
+
+	if (clkc_readl(regcfg2) & BIT(2)) {
+		/* pll bypass mode */
+		clk->rate = fin;
+	} else {
+		/* fout = fin * nf / nr / od */
+		u32 cfg0 = clkc_readl(clk->regofs);
+		u32 nf = (cfg0 & (BIT(13) - 1)) + 1;
+		u32 nr = ((cfg0 >> 13) & (BIT(6) - 1)) + 1;
+		u32 od = ((cfg0 >> 19) & (BIT(4) - 1)) + 1;
+		WARN_ON(fin % MHZ);
+		clk->rate = fin / MHZ * nf / nr / od * MHZ;
+	}
+
+	return clk->rate;
+}
+
+static int std_pll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long fin, nf, nr, od, reg;
+
+	/*
+	 * fout = fin * nf / (nr * od);
+	 * set od = 1, nr = fin/MHz, so fout = nf * MHz
+	 */
+
+	nf = rate / MHZ;
+	if (unlikely((rate % MHZ) || nf > BIT(13) || nf < 1))
+		return -EINVAL;
+
+	fin = clk_get_rate(clk->parent);
+	BUG_ON(fin < MHZ);
+
+	nr = fin / MHZ;
+	BUG_ON((fin % MHZ) || nr > BIT(6));
+
+	od = 1;
+
+	reg = (nf - 1) | ((nr - 1) << 13) | ((od - 1) << 19);
+	clkc_writel(reg, clk->regofs);
+
+	reg = clk->regofs + SIRFSOC_CLKC_PLL1_CFG1 - SIRFSOC_CLKC_PLL1_CFG0;
+	clkc_writel((nf >> 1) - 1, reg);
+
+	reg = clk->regofs + SIRFSOC_CLKC_PLL1_CFG2 - SIRFSOC_CLKC_PLL1_CFG0;
+	while (!(clkc_readl(reg) & BIT(6)))
+		cpu_relax();
+
+	clk->rate = 0; /* set to zero will force recalculation */
+	return 0;
+}
+
+static struct clk_ops std_pll_ops = {
+	.get_rate = std_pll_get_rate,
+	.set_rate = std_pll_set_rate,
+};
+
+static struct clk clk_pll1 = {
+	.parent = &clk_osc,
+	.regofs = SIRFSOC_CLKC_PLL1_CFG0,
+	.ops = &std_pll_ops,
+};
+
+static struct clk clk_pll2 = {
+	.parent = &clk_osc,
+	.regofs = SIRFSOC_CLKC_PLL2_CFG0,
+	.ops = &std_pll_ops,
+};
+
+static struct clk clk_pll3 = {
+	.parent = &clk_osc,
+	.regofs = SIRFSOC_CLKC_PLL3_CFG0,
+	.ops = &std_pll_ops,
+};
+
+/*
+ * clock domains - cpu, mem, sys/io
+ */
+
+static struct clk clk_mem;
+
+static struct clk *dmn_get_parent(struct clk *clk)
+{
+	struct clk *clks[] = {
+		&clk_osc, &clk_rtc, &clk_pll1, &clk_pll2, &clk_pll3
+	};
+	u32 cfg = clkc_readl(clk->regofs);
+	WARN_ON((cfg & (BIT(3) - 1)) > 4);
+	return clks[cfg & (BIT(3) - 1)];
+}
+
+static int dmn_set_parent(struct clk *clk, struct clk *parent)
+{
+	const struct clk *clks[] = {
+		&clk_osc, &clk_rtc, &clk_pll1, &clk_pll2, &clk_pll3
+	};
+	u32 cfg = clkc_readl(clk->regofs);
+	int i;
+	for (i = 0; i < ARRAY_SIZE(clks); i++) {
+		if (clks[i] == parent) {
+			cfg &= ~(BIT(3) - 1);
+			clkc_writel(cfg | i, clk->regofs);
+			/* BIT(3) - switching status: 1 - busy, 0 - done */
+			while (clkc_readl(clk->regofs) & BIT(3))
+				cpu_relax();
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static unsigned long dmn_get_rate(struct clk *clk)
+{
+	unsigned long fin = clk_get_rate(clk->parent);
+	u32 cfg = clkc_readl(clk->regofs);
+	if (cfg & BIT(24)) {
+		/* fcd bypass mode */
+		clk->rate = fin;
+	} else {
+		/*
+		 * wait count: bit[19:16], hold count: bit[23:20]
+		 */
+		u32 wait = (cfg >> 16) & (BIT(4) - 1);
+		u32 hold = (cfg >> 20) & (BIT(4) - 1);
+
+		clk->rate = fin / (wait + hold + 2);
+	}
+
+	return clk->rate;
+}
+
+static int dmn_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long fin;
+	unsigned ratio, wait, hold, reg;
+	unsigned bits = (clk == &clk_mem) ? 3 : 4;
+
+	fin = clk_get_rate(clk->parent);
+	ratio = fin / rate;
+
+	if (unlikely(ratio < 2 || ratio > BIT(bits + 1)))
+		return -EINVAL;
+
+	WARN_ON(fin % rate);
+
+	wait = (ratio >> 1) - 1;
+	hold = ratio - wait - 2;
+
+	reg = clkc_readl(clk->regofs);
+	reg &= ~(((BIT(bits) - 1) << 16) | ((BIT(bits) - 1) << 20));
+	reg |= (wait << 16) | (hold << 20) | BIT(25);
+	clkc_writel(reg, clk->regofs);
+
+	/* waiting FCD been effective */
+	while (clkc_readl(clk->regofs) & BIT(25))
+		cpu_relax();
+
+	clk->rate = 0; /* set to zero will force recalculation */
+
+	return 0;
+}
+
+/*
+ * cpu clock has no FCD register in Prima2, can only change pll
+ */
+static int cpu_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret1, ret2;
+	struct clk *cur_parent, *tmp_parent;
+
+	cur_parent = dmn_get_parent(clk);
+	BUG_ON(cur_parent == NULL || cur_parent->usage > 1);
+
+	/* switch to tmp pll before setting parent clock's rate */
+	tmp_parent = cur_parent == &clk_pll1 ? &clk_pll2 : &clk_pll1;
+	ret1 = dmn_set_parent(clk, tmp_parent);
+	BUG_ON(ret1);
+
+	ret2 = clk_set_rate(cur_parent, rate);
+
+	ret1 = dmn_set_parent(clk, cur_parent);
+
+	clk->rate = 0; /* set to zero will force recalculation */
+
+	return ret2 ? ret2 : ret1;
+}
+
+static struct clk_ops cpu_ops = {
+	.get_parent = dmn_get_parent,
+	.set_parent = dmn_set_parent,
+	.set_rate = cpu_set_rate,
+};
+
+static struct clk clk_cpu = {
+	.parent = &clk_pll1,
+	.regofs = SIRFSOC_CLKC_CPU_CFG,
+	.ops = &cpu_ops,
+};
+
+
+static struct clk_ops msi_ops = {
+	.set_rate = dmn_set_rate,
+	.get_rate = dmn_get_rate,
+	.set_parent = dmn_set_parent,
+	.get_parent = dmn_get_parent,
+};
+
+static struct clk clk_mem = {
+	.parent = &clk_pll2,
+	.regofs = SIRFSOC_CLKC_MEM_CFG,
+	.ops = &msi_ops,
+};
+
+static struct clk clk_sys = {
+	.parent = &clk_pll3,
+	.regofs = SIRFSOC_CLKC_SYS_CFG,
+	.ops = &msi_ops,
+};
+
+static struct clk clk_io = {
+	.parent = &clk_pll3,
+	.regofs = SIRFSOC_CLKC_IO_CFG,
+	.ops = &msi_ops,
+};
+
+/*
+ * on-chip clock sets
+ */
+static struct clk_lookup onchip_clks[] = {
+	{
+		.con_id = "rtc",
+		.clk = &clk_rtc,
+	}, {
+		.con_id = "osc",
+		.clk = &clk_osc,
+	}, {
+		.con_id = "pll1",
+		.clk = &clk_pll1,
+	}, {
+		.con_id = "pll2",
+		.clk = &clk_pll2,
+	}, {
+		.con_id = "pll3",
+		.clk = &clk_pll3,
+	}, {
+		.con_id = "cpu",
+		.clk = &clk_cpu,
+	}, {
+		.con_id = "mem",
+		.clk = &clk_mem,
+	}, {
+		.con_id = "sys",
+		.clk = &clk_sys,
+	}, {
+		.con_id = "io",
+		.clk = &clk_io,
+	},
+};
+
+int clk_enable(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return -EINVAL;
+
+	if (clk->parent)
+		clk_enable(clk->parent);
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	if (!clk->usage++ && clk->ops && clk->ops->enable)
+		clk->ops->enable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return;
+
+	WARN_ON(!clk->usage);
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	if (--clk->usage == 0 && clk->ops && clk->ops->disable)
+		clk->ops->disable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+
+	if (clk->parent)
+		clk_disable(clk->parent);
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
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return 0;
+
+	if (clk->ops && clk->ops->round_rate)
+		return clk->ops->round_rate(clk, rate);
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return -EINVAL;
+
+	if (!clk->ops || !clk->ops->set_rate)
+		return -EINVAL;
+
+	return clk->ops->set_rate(clk, rate);
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret;
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return -EINVAL;
+
+	if (!clk->ops || !clk->ops->set_parent)
+		return -EINVAL;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	ret = clk->ops->set_parent(clk, parent);
+	if (!ret) {
+		parent->usage += clk->usage;
+		clk->parent->usage -= clk->usage;
+		BUG_ON(clk->parent->usage < 0);
+		clk->parent = parent;
+	}
+	spin_unlock_irqrestore(&clocks_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_parent);
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
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+void __init sirfsoc_init_clk(void)
+{
+	clkdev_add_table(onchip_clks, ARRAY_SIZE(onchip_clks));
+}
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
new file mode 100644
index 0000000..fd35ff0
--- /dev/null
+++ b/arch/arm/mach-prima2/common.c
@@ -0,0 +1,81 @@
+/*
+ * This file contains common code that is intended to be used across
+ * boards so that it's not replicated.
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/mach/map.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <mach/hardware.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include "common.h"
+
+static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+void __init sirfsoc_mach_init(void)
+{
+	of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
+}
+
+
+#define IOTABLE_ENTRY(region) {\
+	.virtual 	= SIRFSOC_##region##_VA_BASE, \
+	.pfn	 	= __phys_to_pfn(SIRFSOC_##region##_PA_BASE),\
+	.length		= SIRFSOC_##region##_SIZE, \
+	.type 		= MT_DEVICE, \
+}
+
+static struct map_desc sirfsoc_iodesc[] __initdata = {
+        IOTABLE_ENTRY(INTR),
+        IOTABLE_ENTRY(UART1),
+        IOTABLE_ENTRY(TIMER),
+        IOTABLE_ENTRY(CLOCK),
+#ifdef CONFIG_CACHE_L2X0
+	IOTABLE_ENTRY(L2CC),
+#endif
+};
+
+void __init sirfsoc_map_io(void)
+{
+	iotable_init(sirfsoc_iodesc, ARRAY_SIZE(sirfsoc_iodesc));
+}
+
+#define L2X0_ADDR_FILTERING_START       0xC00
+#define L2X0_ADDR_FILTERING_END         0xC04
+
+static int __init sirfsoc_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	if (!(readl_relaxed(SIRFSOC_L2CC_VA_BASE + L2X0_CTRL) & 1)) {
+		/*
+		 * set the physical memory windows L2 cache will cover
+		 */
+		writel_relaxed(PHYS_OFFSET + 1024 * 1024 * 1024,
+			SIRFSOC_L2CC_VA_BASE + L2X0_ADDR_FILTERING_END);
+		writel_relaxed(PHYS_OFFSET | 0x1,
+			SIRFSOC_L2CC_VA_BASE + L2X0_ADDR_FILTERING_START);
+
+		writel_relaxed(0,
+			SIRFSOC_L2CC_VA_BASE + L2X0_TAG_LATENCY_CTRL);
+		writel_relaxed(0,
+			SIRFSOC_L2CC_VA_BASE + L2X0_DATA_LATENCY_CTRL);
+	}
+	l2x0_init((void __iomem *)SIRFSOC_L2CC_VA_BASE, 0x00040000,
+		0x00000000);
+#endif
+
+	return 0;
+}
+arch_initcall(sirfsoc_init);
+
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
new file mode 100644
index 0000000..5386cc5
--- /dev/null
+++ b/arch/arm/mach-prima2/common.h
@@ -0,0 +1,23 @@
+/*
+ * This file contains common function prototypes to avoid externs in the c files.
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_COMMON_H__
+#define __MACH_PRIMA2_COMMON_H__
+
+#include <linux/init.h>
+#include <asm/mach/time.h>
+
+extern struct sys_timer sirfsoc_timer;
+
+extern void __init sirfsoc_init_io(void);
+extern void __init sirfsoc_map_io(void);
+extern void __init sirfsoc_mach_init(void);
+extern void sirfsoc_init_irq(void);
+extern void __init sirfsoc_init_clk(void);
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/clkdev.h b/arch/arm/mach-prima2/include/mach/clkdev.h
new file mode 100644
index 0000000..6693251
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/clkdev.h
@@ -0,0 +1,15 @@
+/*
+ * arch/arm/mach-prima2/include/mach/clkdev.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_CLKDEV_H
+#define __MACH_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/debug-macro.S b/arch/arm/mach-prima2/include/mach/debug-macro.S
new file mode 100644
index 0000000..bf75106
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/debug-macro.S
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-prima2/include/mach/debug-macro.S
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <mach/hardware.h>
+#include <mach/uart.h>
+
+	.macro	addruart, rp, rv
+	ldr	\rp, =SIRFSOC_UART1_PA_BASE		@ physical
+	ldr	\rv, =SIRFSOC_UART1_VA_BASE		@ virtual
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #SIRFSOC_UART_TXFIFO_DATA]
+	.endm
+
+	.macro	busyuart,rd,rx
+	.endm
+
+	.macro	waituart,rd,rx
+1001:	ldr	\rd, [\rx, #SIRFSOC_UART_TXFIFO_STATUS]
+	tst	\rd, #SIRFSOC_UART1_TXFIFO_EMPTY
+	beq	1001b
+	.endm
+
diff --git a/arch/arm/mach-prima2/include/mach/entry-macro.S b/arch/arm/mach-prima2/include/mach/entry-macro.S
new file mode 100644
index 0000000..af5611b
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/entry-macro.S
@@ -0,0 +1,28 @@
+/*
+ * arch/arm/mach-prima2/include/mach/entry-macro.S
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <mach/hardware.h>
+
+#define SIRFSOC_INT_ID 0x38
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+        ldr \base, =SIRFSOC_INTR_VA_BASE
+        ldr \irqnr, [\base, #SIRFSOC_INT_ID]	@ Get the highest priority irq
+	cmp \irqnr, #0x40			@ the irq num can't be larger than 0x3f
+	movges \irqnr, #0
+	.endm
+
+	.macro  disable_fiq
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
diff --git a/arch/arm/mach-prima2/include/mach/hardware.h b/arch/arm/mach-prima2/include/mach/hardware.h
new file mode 100644
index 0000000..105b969
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/hardware.h
@@ -0,0 +1,15 @@
+/*
+ * arch/arm/mach-prima2/include/mach/hardware.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_HARDWARE_H__
+#define __MACH_HARDWARE_H__
+
+#include <asm/sizes.h>
+#include <mach/map.h>
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/io.h b/arch/arm/mach-prima2/include/mach/io.h
new file mode 100644
index 0000000..1ac0a5c
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/io.h
@@ -0,0 +1,17 @@
+/*
+ * arch/arm/mach-prima2/include/mach/io.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_IO_H
+#define __MACH_PRIMA2_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+#define __mem_pci(x)   (x)
+#define __io(a)        ((void __iomem *)(a))
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/irqs.h b/arch/arm/mach-prima2/include/mach/irqs.h
new file mode 100644
index 0000000..bb354f9
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/irqs.h
@@ -0,0 +1,17 @@
+/*
+ * arch/arm/mach-prima2/include/mach/irqs.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H
+
+#define SIRFSOC_INTENAL_IRQ_START  0
+#define SIRFSOC_INTENAL_IRQ_END    59
+
+#define NR_IRQS	220
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/isa-dma.h b/arch/arm/mach-prima2/include/mach/isa-dma.h
new file mode 100644
index 0000000..f07e264
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/isa-dma.h
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/mach-prima2/include/mach/io.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_ISADMA_H
+#define __MACH_PRIMA2_ISADMA_H
+
+#define MAX_DMA_CHANNELS 32
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/map.h b/arch/arm/mach-prima2/include/mach/map.h
new file mode 100644
index 0000000..9a3ad94
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/map.h
@@ -0,0 +1,49 @@
+/*
+ * memory & I/O static mapping definitions for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_MAP_H__
+#define __MACH_PRIMA2_MAP_H__
+
+#include <mach/vmalloc.h>
+
+#define SIRFSOC_VA(x)			(VMALLOC_END + ((x) & 0x00FFF000))
+
+/* INTR */
+#define SIRFSOC_INTR_PA_BASE		0x80020000
+#define SIRFSOC_INTR_VA_BASE		SIRFSOC_VA(0x002000)
+#define SIRFSOC_INTR_SIZE		SZ_4K
+
+/* L2 CACHE */
+#define SIRFSOC_L2CC_PA_BASE		0x80040000
+#define SIRFSOC_L2CC_VA_BASE		SIRFSOC_VA(0x004000)
+#define SIRFSOC_L2CC_SIZE		SZ_4K
+
+/* CLOCK */
+#define SIRFSOC_CLOCK_PA_BASE		0x88000000
+#define SIRFSOC_CLOCK_VA_BASE		SIRFSOC_VA(0x005000)
+#define SIRFSOC_CLOCK_SIZE		SZ_4K
+
+/* RESET CONTROLLER */
+#define SIRFSOC_RSTC_PA_BASE		0x88010000
+#define SIRFSOC_RSTC_VA_BASE		SIRFSOC_VA(0x006000)
+#define SIRFSOC_RSTC_SIZE		SZ_4K
+
+/* OS TIMER */
+#define SIRFSOC_TIMER_PA_BASE		0xb0020000
+#define SIRFSOC_TIMER_VA_BASE		SIRFSOC_VA(0x00c000)
+#define SIRFSOC_TIMER_SIZE		SZ_4K
+
+/* UART-1: used as serial debug port */
+#define SIRFSOC_UART1_PA_BASE		0xb0060000
+#define SIRFSOC_UART1_VA_BASE		SIRFSOC_VA(0x060000)
+#define SIRFSOC_UART1_SIZE		SZ_4K
+
+/* RAM BASE*/
+#define SIRFSOC_SDRAM_PA		0x00000000
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/memory.h b/arch/arm/mach-prima2/include/mach/memory.h
new file mode 100644
index 0000000..368cd5a
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/memory.h
@@ -0,0 +1,21 @@
+/*
+ * arch/arm/mach-prima2/include/mach/memory.h
+ *
+ * Copyright (c) 2010 ? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+#define PLAT_PHYS_OFFSET        UL(0x00000000)
+
+/*
+ * Restrict DMA-able region to workaround silicon limitation.
+ * The limitation restricts buffers available for DMA to SD/MMC
+ * hardware to be below 256MB
+ */
+#define ARM_DMA_ZONE_SIZE	(SZ_256M)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/system.h b/arch/arm/mach-prima2/include/mach/system.h
new file mode 100644
index 0000000..a84e91f
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/system.h
@@ -0,0 +1,27 @@
+/*
+ * arch/arm/mach-prima2/include/mach/system.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_SYSTEM_H__
+#define __MACH_SYSTEM_H__
+
+#include <linux/bitops.h>
+#include <mach/hardware.h>
+
+#define SIRFSOC_SYS_RST_BIT  BIT(31)
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	writel(SIRFSOC_SYS_RST_BIT, SIRFSOC_RSTC_VA_BASE);
+}
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/timex.h b/arch/arm/mach-prima2/include/mach/timex.h
new file mode 100644
index 0000000..d89223f
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/timex.h
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/mach-prima2/include/mach/timex.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_TIMEX_H__
+#define __MACH_TIMEX_H__
+
+#define CLOCK_TICK_RATE  (100 * HZ)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/uart.h b/arch/arm/mach-prima2/include/mach/uart.h
new file mode 100644
index 0000000..53cf17a
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/uart.h
@@ -0,0 +1,18 @@
+/*
+ * arch/arm/mach-prima2/include/mach/uart.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_SIRFSOC_UART_H
+#define __MACH_PRIMA2_SIRFSOC_UART_H
+
+#define SIRFSOC_UART_TXFIFO_STATUS	0x0114
+#define SIRFSOC_UART_TXFIFO_DATA	0x0118
+
+#define SIRFSOC_UART1_TXFIFO_FULL                       (1 << 5)
+#define SIRFSOC_UART1_TXFIFO_EMPTY			(1 << 6)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
new file mode 100644
index 0000000..e08d7b8
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -0,0 +1,42 @@
+/*
+ * arch/arm/mach-prima2/include/mach/uncompress.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H
+
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <asm/processor.h>
+#include <mach/hardware.h>
+#include <mach/uart.h>
+
+void arch_decomp_setup(void)
+{
+}
+
+#define arch_decomp_wdog()
+
+static __inline__ void putc(char c)
+{
+	/*
+	 * during kernel decompression, all mappings are flat:
+	 *  virt_addr == phys_addr
+	 */
+	while (__raw_readl(SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_STATUS)
+		& SIRFSOC_UART1_TXFIFO_FULL)
+		cpu_relax();
+
+	__raw_writel(c, SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_DATA);
+}
+
+static inline void flush(void)
+{
+}
+
+#endif
+
diff --git a/arch/arm/mach-prima2/include/mach/vmalloc.h b/arch/arm/mach-prima2/include/mach/vmalloc.h
new file mode 100644
index 0000000..116d0a5
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/vmalloc.h
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/ach-prima2/include/mach/vmalloc.h
+ *
+ * Copyright (c) 2010 ? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_VMALLOC_H
+#define __MACH_VMALLOC_H
+
+#define VMALLOC_END	0xFEC00000
+
+#endif
diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
new file mode 100644
index 0000000..af65481
--- /dev/null
+++ b/arch/arm/mach-prima2/irq.c
@@ -0,0 +1,81 @@
+/*
+ * interrupt controller support for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <asm/mach/irq.h>
+
+#define SIRFSOC_INT_PENDING0            0x0000
+#define SIRFSOC_INT_PENDING1            0x0004
+#define SIRFSOC_INT_IRQ_PENDING0        0x0008
+#define SIRFSOC_INT_IRQ_PENDING1        0x000C
+#define SIRFSOC_INT_FIQ_PENDING0        0x0010
+#define SIRFSOC_INT_FIQ_PENDING1        0x0014
+#define SIRFSOC_INT_RISC_MASK0          0x0018
+#define SIRFSOC_INT_RISC_MASK1          0x001C
+#define SIRFSOC_INT_RISC_LEVEL0         0x0020
+#define SIRFSOC_INT_RISC_LEVEL1         0x0024
+
+static void sirfsoc_irq_ack(struct irq_data *d)
+{
+}
+
+static void sirfsoc_irq_mask(struct irq_data *d)
+{
+	unsigned long mask;
+
+	mask = __raw_readl(SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4) &
+		~(1 << ( d->irq % 32));
+	__raw_writel(mask, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4);
+}
+
+static void sirfsoc_irq_unmask(struct irq_data *d)
+{
+	unsigned long mask;
+
+	mask = __raw_readl(SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4) |
+		(1 << ( d->irq % 32));
+	__raw_writel(mask, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4);
+}
+
+int sirfsoc_irq_settype(struct irq_data *d, unsigned int type)
+{
+	/*
+	 * Interrupt handler doesnt support setting trigger type
+	 */
+	if (type == IRQ_TYPE_NONE)
+		return 0;
+
+	return -EINVAL;
+}
+
+static struct irq_chip sirfsoc_irq_chip = {
+	.name = "SiRF SoC",
+	.irq_ack = sirfsoc_irq_ack,
+	.irq_mask = sirfsoc_irq_mask,
+	.irq_unmask = sirfsoc_irq_unmask,
+	.irq_set_type = sirfsoc_irq_settype,
+};
+
+void sirfsoc_init_irq(void)
+{
+	int irq;
+
+	for (irq = SIRFSOC_INTENAL_IRQ_START; irq <= SIRFSOC_INTENAL_IRQ_END; irq++) {
+		irq_set_chip(irq, &sirfsoc_irq_chip);
+		irq_set_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+	__raw_writel(0, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_LEVEL0);
+	__raw_writel(0, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_LEVEL1);
+
+	__raw_writel(0, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0);
+	__raw_writel(0, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK1);
+}
diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
new file mode 100644
index 0000000..f73928f
--- /dev/null
+++ b/arch/arm/mach-prima2/timer.c
@@ -0,0 +1,181 @@
+/*
+ * System timer for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <mach/map.h>
+#include <asm/mach/time.h>
+
+#define SIRFSOC_TIMER_COUNTER_LO	0x0000
+#define SIRFSOC_TIMER_COUNTER_HI	0x0004
+#define SIRFSOC_TIMER_MATCH_0		0x0008
+#define SIRFSOC_TIMER_MATCH_1		0x000C
+#define SIRFSOC_TIMER_MATCH_2		0x0010
+#define SIRFSOC_TIMER_MATCH_3		0x0014
+#define SIRFSOC_TIMER_MATCH_4		0x0018
+#define SIRFSOC_TIMER_MATCH_5		0x001C
+#define SIRFSOC_TIMER_STATUS		0x0020
+#define SIRFSOC_TIMER_INT_EN		0x0024
+#define SIRFSOC_TIMER_WATCHDOG_EN	0x0028
+#define SIRFSOC_TIMER_DIV		0x002C
+#define SIRFSOC_TIMER_LATCH		0x0030
+#define SIRFSOC_TIMER_LATCHED_LO	0x0034
+#define SIRFSOC_TIMER_LATCHED_HI	0x0038
+
+#define SIRFSOC_TIMER_WDT_INDEX		5
+
+#define SIRFSOC_TIMER_LATCH_BIT	 BIT(0)
+
+/* timer0 interrupt handler */
+static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *ce = dev_id;
+
+	WARN_ON(!(__raw_readl(SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_STATUS) & BIT(0)));
+
+	/* clear timer0 interrupt */
+	__raw_writel(BIT(0), SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_STATUS);
+
+	ce->event_handler(ce);
+
+	return IRQ_HANDLED;
+}
+
+/* read 64-bit timer counter */
+static cycle_t sirfsoc_timer_read(struct clocksource *cs)
+{
+	u64 cycles;
+
+	/* latch the 64-bit timer counter */
+	__raw_writel(SIRFSOC_TIMER_LATCH_BIT, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_LATCH);
+	cycles = __raw_readl(SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_LATCHED_HI);
+	cycles = (cycles << 32) | __raw_readl(SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_LATCHED_LO);
+
+	return cycles;
+}
+
+static int sirfsoc_timer_set_next_event(unsigned long delta,
+					struct clock_event_device *ce)
+{
+	unsigned long now, next;
+
+	__raw_writel(SIRFSOC_TIMER_LATCH_BIT, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_LATCH);
+	now = __raw_readl(SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_LATCHED_LO);
+	do {
+		next = now + delta;
+		__raw_writel(next, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_MATCH_0);
+		__raw_writel(SIRFSOC_TIMER_LATCH_BIT, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_LATCH);
+		now = __raw_readl(SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_LATCHED_LO);
+	} while ((next - now) > delta);
+
+	return 0;
+}
+
+static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *ce)
+{
+	u32 val = __raw_readl(SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_INT_EN);
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		WARN_ON(1);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		__raw_writel(val | BIT(0), SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_INT_EN);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		__raw_writel(val & ~BIT(0), SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_INT_EN);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device sirfsoc_clockevent = {
+	.name = "sirfsoc_clockevent",
+	.rating = 200,
+	.features = CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode = sirfsoc_timer_set_mode,
+	.set_next_event = sirfsoc_timer_set_next_event,
+};
+
+static struct clocksource sirfsoc_clocksource = {
+	.name = "sirfsoc_clocksource",
+	.rating = 200,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.read = sirfsoc_timer_read,
+};
+
+static struct irqaction sirfsoc_timer_irq = {
+	.name = "sirfsoc_timer0",
+	.flags = IRQF_TIMER,
+	.irq = 0,
+	.handler = sirfsoc_timer_interrupt,
+	.dev_id = &sirfsoc_clockevent,
+};
+
+/* Overwrite weak default sched_clock with more precise one */
+unsigned long long notrace sched_clock(void)
+{
+	BUG_ON(NSEC_PER_SEC % CLOCK_TICK_RATE);
+	return sirfsoc_timer_read(NULL) * (NSEC_PER_SEC / CLOCK_TICK_RATE);
+}
+
+static void __init sirfsoc_clockevent_init(void)
+{
+	clockevents_calc_mult_shift(&sirfsoc_clockevent, CLOCK_TICK_RATE, 60);
+
+	sirfsoc_clockevent.max_delta_ns =
+		clockevent_delta2ns(-2, &sirfsoc_clockevent);
+	sirfsoc_clockevent.min_delta_ns =
+		clockevent_delta2ns(2, &sirfsoc_clockevent);
+
+	sirfsoc_clockevent.cpumask = cpumask_of(0);
+	clockevents_register_device(&sirfsoc_clockevent);
+}
+
+/* initialize the kernel jiffy timer source */
+static void __init sirfsoc_timer_init(void)
+{
+	unsigned long rate;
+	/* timer's input clock is io clock */
+	struct clk *clk = clk_get(NULL, "io");
+
+	BUG_ON(IS_ERR_OR_NULL(clk));
+
+	rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	BUG_ON(rate < CLOCK_TICK_RATE);
+	BUG_ON(rate % CLOCK_TICK_RATE);
+
+	__raw_writel(rate / CLOCK_TICK_RATE / 2 - 1, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_DIV);
+	__raw_writel(0, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_COUNTER_LO);
+	__raw_writel(0, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_COUNTER_HI);
+	__raw_writel(BIT(0), SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_STATUS);
+
+	if (clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE))
+		BUG();
+
+	if (setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq))
+		BUG();
+
+	sirfsoc_clockevent_init();
+}
+
+struct sys_timer sirfsoc_timer = {
+	.init = sirfsoc_timer_init,
+};
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 0074b8d..edf0681 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -821,7 +821,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
+		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || ARCH_PRIMA2
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog@www.csr.com/blog
