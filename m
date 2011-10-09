From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:05 +0200
Subject: [PATCH 2/9] ARM: SPMP8000: Add machine base files
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-3-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the files for the basic support of the SPMP8000 SoC

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/Makefile                   |   11 ++
 arch/arm/mach-spmp8000/Makefile.boot              |    1 +
 arch/arm/mach-spmp8000/core.c                     |  103 +++++++++++++
 arch/arm/mach-spmp8000/include/mach/core.h        |   29 ++++
 arch/arm/mach-spmp8000/include/mach/debug-macro.S |   19 +++
 arch/arm/mach-spmp8000/include/mach/dma.h         |   45 ++++++
 arch/arm/mach-spmp8000/include/mach/entry-macro.S |   14 ++
 arch/arm/mach-spmp8000/include/mach/gpio.h        |   21 +++
 arch/arm/mach-spmp8000/include/mach/hardware.h    |   27 ++++
 arch/arm/mach-spmp8000/include/mach/io.h          |   20 +++
 arch/arm/mach-spmp8000/include/mach/irqs.h        |   21 +++
 arch/arm/mach-spmp8000/include/mach/memory.h      |   16 ++
 arch/arm/mach-spmp8000/include/mach/regs-timer.h  |   32 ++++
 arch/arm/mach-spmp8000/include/mach/scu.h         |  146 +++++++++++++++++++
 arch/arm/mach-spmp8000/include/mach/system.h      |   45 ++++++
 arch/arm/mach-spmp8000/include/mach/timex.h       |   17 +++
 arch/arm/mach-spmp8000/include/mach/uncompress.h  |   37 +++++
 arch/arm/mach-spmp8000/include/mach/vmalloc.h     |   16 ++
 arch/arm/mach-spmp8000/timer.c                    |  160 +++++++++++++++++++++
 19 files changed, 780 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/Makefile
 create mode 100644 arch/arm/mach-spmp8000/Makefile.boot
 create mode 100644 arch/arm/mach-spmp8000/core.c
 create mode 100644 arch/arm/mach-spmp8000/include/mach/core.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spmp8000/include/mach/dma.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spmp8000/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/io.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/memory.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/regs-timer.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/scu.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/system.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/timex.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spmp8000/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-spmp8000/timer.c

diff --git a/arch/arm/mach-spmp8000/Makefile b/arch/arm/mach-spmp8000/Makefile
new file mode 100644
index 0000000..9d35cca
--- /dev/null
+++ b/arch/arm/mach-spmp8000/Makefile
@@ -0,0 +1,11 @@
+#
+# Makefile for the linux kernel.
+#
+obj-y 			:= core.o
+obj-y			+= timer.o
+obj-y			+= pinmux.o
+obj-y			+= clock.o
+obj-y			+= clkdev.o
+obj-y			+= board_letcool.o
+obj-y			+= adc.o
+obj-y			+= pwm.o
diff --git a/arch/arm/mach-spmp8000/Makefile.boot b/arch/arm/mach-spmp8000/Makefile.boot
new file mode 100644
index 0000000..dae9661
--- /dev/null
+++ b/arch/arm/mach-spmp8000/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-spmp8000/core.c b/arch/arm/mach-spmp8000/core.c
new file mode 100644
index 0000000..ba05614
--- /dev/null
+++ b/arch/arm/mach-spmp8000/core.c
@@ -0,0 +1,103 @@
+/*
+ * SPMP8000 machines core functions
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <asm/mach/map.h>
+#include <asm/hardware/vic.h>
+#include <mach/hardware.h>
+#include <mach/scu.h>
+
+/* Static mappings:
+ * SCU: timer needs clk support which is inited in init_early
+ * UART: needed for earlyprintk
+ */
+static struct map_desc io_desc[] __initdata = {
+	{
+		.virtual	= IO_ADDRESS(SPMP8000_SCU_A_BASE),
+		.pfn		= __phys_to_pfn(SPMP8000_SCU_A_BASE),
+		.length		= SPMP8000_SCU_A_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SPMP8000_SCU_B_BASE),
+		.pfn		= __phys_to_pfn(SPMP8000_SCU_B_BASE),
+		.length		= SPMP8000_SCU_B_SIZE,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= IO_ADDRESS(SPMP8000_SCU_C_BASE),
+		.pfn		= __phys_to_pfn(SPMP8000_SCU_C_BASE),
+		.length		= SPMP8000_SCU_C_SIZE,
+		.type		= MT_DEVICE,
+	},
+#ifdef CONFIG_DEBUG_LL
+	{
+		.virtual	= IO_ADDRESS(SPMP8000_UARTC0_BASE),
+		.pfn		= __phys_to_pfn(SPMP8000_UARTC0_BASE),
+		.length		= SPMP8000_UARTC0_SIZE,
+		.type		= MT_DEVICE,
+	},
+#endif
+};
+
+#define IO_PTR(x)	((void __iomem *)IO_ADDRESS(x))
+/* Make the lookup of SCU base and clk enable registers easy for the clk
+ * code, as they are not at the same offset in each controller */
+struct scu_reg_t scu_regs[3] = {
+	{	/* SCU_A */
+		.base = IO_PTR(SPMP8000_SCU_A_BASE),
+		.clken = IO_PTR(SPMP8000_SCU_A_BASE) + SCU_A_PERI_CLKEN,
+	},
+	{	/* SCU_B */
+		.base = IO_PTR(SPMP8000_SCU_B_BASE),
+		.clken = IO_PTR(SPMP8000_SCU_B_BASE) + SCU_B_PERI_CLKEN,
+	},
+	{	/* SCU_C */
+		.base = IO_PTR(SPMP8000_SCU_C_BASE),
+		.clken = IO_PTR(SPMP8000_SCU_C_BASE) + SCU_C_PERI_CLKEN,
+	},
+};
+
+/* DMA controller names to be used for the filter
+ * function of the DMA-Engine API. */
+char *spmp8000_dma_controller_names[] = {
+	"93010000.dma",		/* APBDMA_A */
+	"92b00000.dma",		/* APBDMA_C */
+};
+
+void __init spmp8000_map_io(void)
+{
+	iotable_init(io_desc, ARRAY_SIZE(io_desc));
+}
+
+void __init spmp8000_init_irq(void)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl192");
+	if (!np)
+		panic("Can't find VIC0 interrupt controller\n");
+
+	ret = vic_of_init(np, NULL);
+	if (ret)
+		panic("Can't init VIC0 interrupt controller\n");
+
+	np = of_find_compatible_node(np, NULL, "arm,pl192");
+	if (!np)
+		panic("Can't find VIC1 interrupt controller\n");
+
+	ret = vic_of_init(np, NULL);
+	if (ret)
+		panic("Can't init VIC1 interrupt controller\n");
+
+	of_node_put(np);
+}
diff --git a/arch/arm/mach-spmp8000/include/mach/core.h b/arch/arm/mach-spmp8000/include/mach/core.h
new file mode 100644
index 0000000..fa1d522
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/core.h
@@ -0,0 +1,29 @@
+/*
+ * SPMP8000 generic includes
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_GENERIC_H__
+#define __MACH_SPMP8000_GENERIC_H__
+
+/* core.c */
+extern void __init spmp8000_map_io(void);
+extern void __init spmp8000_init_irq(void);
+extern struct sys_timer spmp8000_sys_timer;
+
+/* clkdev.c */
+extern void __init spmp8000_init_clkdev(void);
+extern void spmp8000_update_arm_freqs(void); /* For cpufreq driver */
+
+/* pinmux.c */
+extern void spmp8000_pinmux_pgc_set(int pc, unsigned int conf);
+extern unsigned int spmp8000_pinmux_pgc_get(int pc);
+extern void spmp8000_pinmux_pgs_set(unsigned int pg, unsigned int func);
+extern int spmp8000_pinmux_pgs_get(int pg);
+
+#endif /* __MACH_SPMP8000_GENERIC_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/debug-macro.S b/arch/arm/mach-spmp8000/include/mach/debug-macro.S
new file mode 100644
index 0000000..698c37e
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/debug-macro.S
@@ -0,0 +1,19 @@
+/*
+ * SPMP8000 debug-macro.S
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+	.macro  addruart, rp, rv
+	mov     \rp, #0x92000000
+	add	\rp, #0x00B00000
+	add	\rp, #0x00004000
+	orr	\rv, \rp, #0xF0000000
+	.endm
+
+#define UART_SHIFT 2
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-spmp8000/include/mach/dma.h b/arch/arm/mach-spmp8000/include/mach/dma.h
new file mode 100644
index 0000000..44bc9f2
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/dma.h
@@ -0,0 +1,45 @@
+/*
+ * SPMP8000 dma.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/module.h>
+#include <linux/dmaengine.h>
+
+#ifndef __MACH_SPMP8000_DMA_H__
+#define __MACH_SPMP8000_DMA_H__
+
+enum spmp8000_dma_controller {
+	SPMP8000_APBDMA_A	= 0,
+	SPMP8000_APBDMA_C,
+};
+
+extern char *spmp8000_dma_controller_names[];
+
+struct spmp8000_dma_params {
+	char				*dma_controller;
+	dma_addr_t			dma_address;
+	enum dma_slave_buswidth		dma_width;
+	int				maxburst;
+};
+
+/* Driver parameters */
+#define SPMP8000_APBDMA_MAX_PERIODS	64
+
+static bool spmp8000_dma_filter(struct dma_chan *chan, const char *name)
+{
+	int ret;
+
+	ret = strcmp(dev_name(chan->device->dev), name);
+
+	if (ret)
+		return false;
+
+	return true;
+}
+
+#endif /* __MACH_SPMP8000_DMA_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/entry-macro.S b/arch/arm/mach-spmp8000/include/mach/entry-macro.S
new file mode 100644
index 0000000..3d26088
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/entry-macro.S
@@ -0,0 +1,14 @@
+/*
+ * SPMP8000 entry-macro.S
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+	.macro  disable_fiq
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
diff --git a/arch/arm/mach-spmp8000/include/mach/gpio.h b/arch/arm/mach-spmp8000/include/mach/gpio.h
new file mode 100644
index 0000000..3eafac2
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/gpio.h
@@ -0,0 +1,21 @@
+/*
+ * SPMP8000 machines gpio support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_GPIO_H__
+#define __MACH_SPMP8000_GPIO_H__
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value		__gpio_get_value
+#define gpio_set_value		__gpio_set_value
+#define gpio_cansleep		__gpio_cansleep
+#define gpio_to_irq		__gpio_to_irq
+
+#endif /* __MACH_SPMP8000_GPIO_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/hardware.h b/arch/arm/mach-spmp8000/include/mach/hardware.h
new file mode 100644
index 0000000..998a184
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/hardware.h
@@ -0,0 +1,27 @@
+/*
+ * SPMP8000 hardware.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_HARDWARE_H__
+#define __MACH_SPMP8000_HARDWARE_H__
+
+/* Vitual to physical translation of statically mapped space */
+#define IO_ADDRESS(x)		((x) | 0xF0000000)
+
+/* Needed for the static mappings and uncompress.h */
+#define SPMP8000_UARTC0_BASE	0x92B04000
+#define SPMP8000_UARTC0_SIZE	SZ_4K
+#define SPMP8000_SCU_C_BASE	0x92005000
+#define SPMP8000_SCU_C_SIZE	SZ_4K
+#define SPMP8000_SCU_A_BASE	0x93007000
+#define SPMP8000_SCU_A_SIZE	SZ_4K
+#define SPMP8000_SCU_B_BASE	0x90005000
+#define SPMP8000_SCU_B_SIZE	SZ_4K
+
+#endif /* __MACH_SPMP8000_HARDWARE_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/io.h b/arch/arm/mach-spmp8000/include/mach/io.h
new file mode 100644
index 0000000..a8ea8f0
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/io.h
@@ -0,0 +1,20 @@
+/*
+ * SPMP8000 io.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_IO_H__
+#define __MACH_SPMP8000_IO_H__
+
+/* FIXME This should go away */
+#define IO_SPACE_LIMIT  0
+
+#define __mem_pci(a)    (a)
+#define __io(a)         __typesafe_io(a)
+
+#endif /* __MACH_SPMP8000_IO_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/irqs.h b/arch/arm/mach-spmp8000/include/mach/irqs.h
new file mode 100644
index 0000000..7f305d3
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/irqs.h
@@ -0,0 +1,21 @@
+/*
+ * SPMP8000 irqs.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_IRQS_H__
+#define __MACH_SPMP8000_IRQS_H__
+
+#define SPMP8000_HW_IRQS		64
+#define SPMP8000_GPIO_IRQS_START	SPMP8000_HW_IRQS
+#define SPMP8000_GPIO_IRQS		(16 + 32)
+#define SPMP8000_TOTAL_IRQS		(SPMP8000_HW_IRQS + SPMP8000_GPIO_IRQS)
+
+#define NR_IRQS				SPMP8000_TOTAL_IRQS
+
+#endif /* __MACH_SPMP8000_IRQS_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/memory.h b/arch/arm/mach-spmp8000/include/mach/memory.h
new file mode 100644
index 0000000..d2f1089
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/memory.h
@@ -0,0 +1,16 @@
+/*
+ * SPMP8000 memory.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_MEMORY_H__
+#define __MACH_SPMP8000_MEMORY_H__
+
+#define PLAT_PHYS_OFFSET	UL(0x00000000)
+
+#endif /* __MACH_SPMP8000_MEMORY_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/regs-timer.h b/arch/arm/mach-spmp8000/include/mach/regs-timer.h
new file mode 100644
index 0000000..90735df
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/regs-timer.h
@@ -0,0 +1,32 @@
+/*
+ * SPMP8000 timer support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * These timer reg definitions are used by the timer and pwm drivers
+ */
+#ifndef __MACH_SPMP8000_REGS_TIMER_H__
+#define __MACH_SPMP8000_REGS_TIMER_H__
+
+#define SPMP8000_TMRB(tnum)	(tnum * 0x20)
+#define SPMP8000_TMRB_CTR	0x00
+#define SPMP8000_TMRB_CTR_TE	BIT(0)
+#define SPMP8000_TMRB_CTR_IE	BIT(1)
+#define SPMP8000_TMRB_CTR_OE	BIT(2)
+#define SPMP8000_TMRB_CTR_PWMON	BIT(3)
+#define SPMP8000_TMRB_CTR_UD	BIT(4)
+#define SPMP8000_TMRB_CTR_UDS	BIT(5)
+#define SPMP8000_TMRB_CTR_OM	BIT(6)
+#define SPMP8000_TMRB_CTR_ES_SH	8
+#define SPMP8000_TMRB_CTR_M_SH	10
+#define SPMP8000_TMRB_PSR	0x04
+#define SPMP8000_TMRB_LDR	0x08
+#define SPMP8000_TMRB_VLR	0x08
+#define SPMP8000_TMRB_ISR	0x0C
+#define SPMP8000_TMRB_CMP	0x10
+
+#endif /* __MACH_SPMP8000_REGS_TIMER_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/scu.h b/arch/arm/mach-spmp8000/include/mach/scu.h
new file mode 100644
index 0000000..e3a98d4
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/scu.h
@@ -0,0 +1,146 @@
+/*
+ * SPMP8000 System Control Unit register definitions
+ * SCUs are a random collection of reset, clock, gpio, pinmux, etc. controllers
+ * so that these definitions are needed at several places.
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/bitops.h>
+#include <mach/hardware.h>
+
+#ifndef __MACH_SPMP8000_SCU_H__
+#define __MACH_SPMP8000_SCU_H__
+
+/* Used by to the clock code to directly access the SCU base and clock
+ * enabling registers, without looking up the according registers first.
+ */
+struct scu_reg_t {
+	void *base;
+	void *clken;
+};
+
+extern struct scu_reg_t scu_regs[];
+
+#define REG_SCU_BASE(x)		scu_regs[x].base
+#define REG_SCU_CLKEN(x)	scu_regs[x].clken
+#define REG_SCU_A_ID		0
+#define REG_SCU_B_ID		1
+#define REG_SCU_C_ID		2
+#define REG_SCU_A(x)		(scu_regs[REG_SCU_A_ID].base + x)
+#define REG_SCU_B(x)		(scu_regs[REG_SCU_B_ID].base + x)
+#define REG_SCU_C(x)		(scu_regs[REG_SCU_C_ID].base + x)
+
+#define SCU_A_PERI_RST		0x00
+#define SCU_A_PERI_CLKEN	0x04
+#define SCU_A_PERI_DGCLKEN	0x0C
+
+#define SCU_A_APLL_CFG		0x44
+#define APLL_CFG_P		BIT(0)
+#define APLL_CFG_S		BIT(1)
+#define APLL_CFG_F		BIT(2)
+#define APLL_CFG_E		BIT(3)
+#define APLL_CFG_AS_MASK	0x3F0
+#define APLL_CFG_AS_SHIFT	4
+#define APLL_CFG_AS_MAGIC	0x12
+#define APLL_CFG_C		BIT(10)
+#define APLL_CFG_R		BIT(11)
+#define APLL_CFG_DAR_SHIFT	16
+#define APLL_CFG_DAR_MASK	(7 << APLL_CFG_DAR_SHIFT)
+#define APLL_CFG_DS		BIT(19)
+#define APLL_CFG_ADR_SHIFT	24
+#define APLL_CFG_ADR_MASK	(7 << APLL_CFG_ADR_SHIFT)
+#define APLL_CFG_AS		BIT(27)
+
+#define SCU_A_LCD_CLK_CFG	0x80
+#define LCD_CLK_CFG_RATIO_MASK	0xFF
+#define LCD_CLK_CFG_EN		BIT(8)
+#define SCU_A_CSI_CLK_CFG	0x84
+#define CSI_CLK_CFG_RATIO_MASK	0xFF
+#define CSI_CLK_CFG_EN		BIT(8)
+#define SCU_A_I2S_BCK_CFG	0x90
+#define I2S_BCK_CFG_RATIO_MASK	0xFF
+#define I2S_BCK_CFG_EN		BIT(8)
+#define SCU_A_UART_CFG		0x94
+#define UART_CFG_RATIO_MASK	0xFF
+#define UART_CFG_EN		BIT(8)
+#define DIVIDER_ENABLE_BIT	BIT(8)
+
+#define SCU_A_CODEC_CFG		0xB0
+#define SCU_A_CODEC_CFG_VAL	0x5A
+
+#define SCU_A_SAR_GPIO_CTRL	0xE0
+#define SCU_A_SAR_GPIO_OEN	0xE4
+#define SCU_A_SAR_GPIO_O	0xE8
+#define SCU_A_SAR_GPIO_I	0xEC
+
+#define SCU_B_PERI_RST		0x00
+#define SCU_B_PERI_CLKEN	0x20
+#define SCU_B_PERI_DGCLKEN	0x24
+#define SCU_B_UPDATE_ARM_RATIO	0x28
+
+#define SCU_B_SPLL_CFG		0x04
+#define SPLL_CFG_R_MASK		3
+#define SPLL_CFG_R_SHIFT	0
+#define SPLL_CFG_F_MASK		0xFC
+#define SPLL_CFG_F_SHIFT	2
+#define SPLL_CFG_BS		BIT(8)
+#define SPLL_CFG_OD		BIT(9)
+#define SPLL_CFG_BP		BIT(10)
+#define SPLL_CFG_PD		BIT(11)
+#define SPLL_CFG_CSEL_MASK	(BIT(13) | BIT(12))
+#define SPLL_CFG_CSEL_SHIFT	12
+#define SPLL_CFG_ASEL_MASK	(BIT(15) | BIT(14))
+#define SPLL_CFG_ASEL_SHIFT	14
+#define SPLL_CFG_SE		BIT(17)
+#define SPLL_CFG_XE		BIT(18)
+#define SPLL_CFG_AE		BIT(19)
+#define SPLL_CFG_XR		BIT(20)
+#define SPLL_CFG_PL		BIT(31)
+
+#define SCU_B_GPIO3_I		0x70
+#define SCU_B_GPIO3_O		0x74
+#define SCU_B_GPIO3_E		0x78
+
+#define SCU_B_PGS0		0x80
+#define SCU_B_PGS1		0x84
+#define SCU_B_PGS2		0x88
+#define SCU_B_PGS3		0x8C
+#define SCU_B_PGC0		0x90
+#define SCU_B_PGC1		0x94
+#define SCU_B_PGC2		0x98
+#define SCU_B_PGC3		0x9C
+
+#define SCU_B_ARM_RATIO		0xD0
+#define SCU_B_ARM_AHB_RATIO	0xD4
+#define SCU_B_ARM_APB_RATIO	0xD8
+#define SCU_B_SYS_CNT_EN	0xDC
+#define SYS_CNT_EN_SYS		BIT(0)
+#define SYS_CNT_EN_SYS_RT	BIT(1)
+#define SYS_CNT_EN_SYS_AHB	BIT(2)
+#define SYS_CNT_EN_SYS_APB	BIT(3)
+#define SYS_CNT_EN_SYS_CHECK	BIT(31)
+
+#define SCU_C_PERI_RST		0x00
+#define SCU_C_PERI_CLKEN	0x04
+#define SCU_C_PERI_DGCLKEN	0x08
+
+#define SCU_C_UPDATE_SYS_RATIO	0x28
+#define SCU_C_SYS_RATIO		0x100
+#define SCU_C_SYS_RT_RATIO	0x104
+#define SCU_C_SYS_AHB_RATIO	0x108
+#define SCU_C_SYS_APB_RATIO	0x10C
+#define SCU_C_CEVA_RATIO	0x110
+#define SCU_C_CEVA_AHB_RATIO	0x114
+#define SCU_C_CEVA_APB_RATIO	0x118
+#define SCU_C_CEVA_CNT_EN	0x11C
+#define CEVA_CNT_EN_CEVA	BIT(0)
+#define CEVA_CNT_EN_CEVA_AHB	BIT(1)
+#define CEVA_CNT_EN_CEVA_APB	BIT(2)
+#define CEVA_CNT_EN_CEVA_CHECK	BIT(31)
+
+#endif /* __MACH_SPMP8000_SCU_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/system.h b/arch/arm/mach-spmp8000/include/mach/system.h
new file mode 100644
index 0000000..be53ff3
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/system.h
@@ -0,0 +1,45 @@
+/*
+ * SPMP8000 system.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_SYSTEM_H__
+#define __MACH_SPMP8000_SYSTEM_H__
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#define SPMP8000_WDT_BASE	0x90001000
+#define SPMP8000_WDT_SIZE	0x1000
+
+#define SPMP8000_WDT_CTR	0x00
+#define SPMP8000_WDT_CTR_TE	BIT(0)
+#define SPMP8000_WDT_CTR_RE	BIT(3)
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	void *base;
+
+	base = ioremap(SPMP8000_WDT_BASE, SPMP8000_WDT_SIZE);
+	if (!base) {
+		pr_err("spmp8000: Can't ioremap watchdog regs for reset. "
+			"Halt.");
+		while (1);
+	}
+
+	/* Trigger a watchdog reset */
+	writel(SPMP8000_WDT_CTR_RE | SPMP8000_WDT_CTR_TE,
+			base + SPMP8000_WDT_CTR);
+}
+
+#endif /* __MACH_SPMP8000_SYSTEM_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/timex.h b/arch/arm/mach-spmp8000/include/mach/timex.h
new file mode 100644
index 0000000..77069c2
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/timex.h
@@ -0,0 +1,17 @@
+/*
+ * SPMP8000 timex.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_TIMEX_H__
+#define __MACH_SPMP8000_TIMEX_H__
+
+/* TODO this should go away */
+#define CLOCK_TICK_RATE		(100 * HZ)
+
+#endif /* __MACH_SPMP8000_TIMEX_H__ */
diff --git a/arch/arm/mach-spmp8000/include/mach/uncompress.h b/arch/arm/mach-spmp8000/include/mach/uncompress.h
new file mode 100644
index 0000000..105778b
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/uncompress.h
@@ -0,0 +1,37 @@
+/*
+ * SPMP8000 uncompress.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * Based on the mach-kirkwood implementation
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/serial_reg.h>
+#include <mach/hardware.h>
+
+#define SERIAL_BASE	((volatile unsigned char *)SPMP8000_UARTC0_BASE)
+
+static void putc(const char c)
+{
+	volatile unsigned char *base = SERIAL_BASE;
+	int i;
+
+	for (i = 0; i < 0x1000; i++) {
+		if (base[UART_LSR << 2] & UART_LSR_THRE)
+			break;
+		barrier();
+	}
+
+	base[UART_TX << 2] = c;
+}
+
+static void flush(void)
+{
+}
+
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-spmp8000/include/mach/vmalloc.h b/arch/arm/mach-spmp8000/include/mach/vmalloc.h
new file mode 100644
index 0000000..ff40d1c
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/vmalloc.h
@@ -0,0 +1,16 @@
+/*
+ * SPMP8000 vmalloc.h
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_VMALLOC_H__
+#define __MACH_SPMP8000_VMALLOC_H__
+
+#define VMALLOC_END	0xF0000000UL
+
+#endif /* __MACH_SPMP8000_VMALLOC_H__ */
diff --git a/arch/arm/mach-spmp8000/timer.c b/arch/arm/mach-spmp8000/timer.c
new file mode 100644
index 0000000..7d5d0eb
--- /dev/null
+++ b/arch/arm/mach-spmp8000/timer.c
@@ -0,0 +1,160 @@
+/*
+ * SPMP8000 machines timer functions
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <asm/mach/time.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <mach/hardware.h>
+#include <mach/regs-timer.h>
+#include <mach/irqs.h>
+
+static unsigned long clkrate;
+static const unsigned int tickrate = 1012500;
+
+/* The TIMER_B block is used as system timer
+ * T2: Clocksource
+ * T1: Clockevent
+ * T0: PWM for LCD backlight
+ * T3,4: Could be used as additional clockevent devices
+ * Timer constraints:
+ * - WDT: Can't clear the irq directly, only by resetting the whole counter
+ *   in the ISR, which means that IRQs will jitter
+ * - Timer_B: Can't reset the timer value, so at start, the first IRQ
+ *   will happen at some random time.
+ */
+#define		CS_TIMER	2
+#define		CE_TIMER	1
+static void __iomem *cs_base;
+static void __iomem *ce_base;
+
+static void tmrb_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *dev)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		writel((tickrate / HZ), ce_base + SPMP8000_TMRB_LDR);
+		/* Configure as periodic, down counter, IEN, enable timer */
+		writel(SPMP8000_TMRB_CTR_TE | SPMP8000_TMRB_CTR_IE |
+				(1 << SPMP8000_TMRB_CTR_M_SH),
+				ce_base + SPMP8000_TMRB_CTR);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		BUG();
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		/* Disable timer */
+		writel(0, ce_base + SPMP8000_TMRB_CTR);
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		BUG();
+		break;
+	}
+}
+
+static struct clock_event_device tmrb1_clkevt = {
+	.name		= "tmrb1",
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.rating		= 200,
+	.set_mode	= tmrb_set_mode,
+};
+
+static irqreturn_t tmrb1_isr(int irq, void *dev_id)
+{
+	tmrb1_clkevt.event_handler(&tmrb1_clkevt);
+
+	/* Clear IRQ */
+	writel(0, ce_base + SPMP8000_TMRB_ISR);
+
+	return IRQ_HANDLED;
+};
+
+static struct irqaction tmrb1_irq = {
+	.name		= "tmrb1_irq",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= tmrb1_isr,
+};
+
+static void __init spmp8000_sys_timer_init(void)
+{
+	struct device_node *np;
+	unsigned int irq;
+	struct clk *clk;
+	void *tmrb_base;
+
+	np = of_find_compatible_node(NULL, NULL, "sunplus,spmp8000-timer");
+	if (!np)
+		panic("spmp8000: unable to find timer node in dtb\n");
+
+	tmrb_base = of_iomap(np, 0);
+	if (!tmrb_base)
+		panic("spmp8000: unable to map timer cpu registers\n");
+
+	irq = of_irq_to_resource(np, CE_TIMER, NULL);
+	if (irq == NO_IRQ)
+		panic("spmp8000: unable to get interrupts of timer\n");
+
+	of_node_put(np);
+
+	cs_base = tmrb_base + SPMP8000_TMRB(CS_TIMER);
+	ce_base = tmrb_base + SPMP8000_TMRB(CE_TIMER);
+
+	clk = clk_get(NULL, "arm_apb");
+	if (IS_ERR_OR_NULL(clk))
+		panic("spmp8000: Can't get clock for timer device");
+
+	clk_enable(clk);
+	clkrate = clk_get_rate(clk);
+
+	/* Clocksource */
+	/* Disable timer */
+	writel(0, cs_base + SPMP8000_TMRB_CTR);
+
+	/* Reset counter value
+	 * Not really possible unless setting end-1 LDR value and waiting
+	 * until the counter reaches that */
+
+	/* Prescale timer */
+	writel((clkrate / tickrate) - 1, cs_base + SPMP8000_TMRB_PSR);
+
+	/* Register the clocksource */
+	clocksource_mmio_init(cs_base + SPMP8000_TMRB_VLR, "tmrb2",
+				tickrate, 200, 16, clocksource_mmio_readl_up);
+
+	/* Configure as free running (0 - 0xFFFF), up counter, enable timer */
+	writel(SPMP8000_TMRB_CTR_TE | SPMP8000_TMRB_CTR_UD,
+		cs_base + SPMP8000_TMRB_CTR);
+
+	/* Clockevent */
+	setup_irq(irq, &tmrb1_irq);
+
+	/* Disable timer */
+	writel(0, ce_base + SPMP8000_TMRB_CTR);
+
+	/* Prescale timer */
+	writel((clkrate / tickrate) - 1, ce_base + SPMP8000_TMRB_PSR);
+
+	clockevents_register_device(&tmrb1_clkevt);
+}
+
+struct sys_timer spmp8000_sys_timer = {
+	.init		= spmp8000_sys_timer_init,
+};
-- 
1.7.4.1
