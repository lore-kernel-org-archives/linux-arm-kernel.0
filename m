From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:27 +0900
Subject: [PATCH 03/12] ARM: S5P64X0: introduce
 arch/arm/mach-s5p64x0/common.[ch]
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces common.[ch] which are used only in the
arch/arm/mach-s5p64x0/ directory. The common.c file merges
the cpu.c, init.c and irq-eint.c files which are used commonly
on S5P64X0 SoCs and the common.h local header file replaces
with plat/s5p6440.h and plat/s5p6450.h files.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/Makefile               |    9 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c        |    3 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c        |    3 +-
 arch/arm/mach-s5p64x0/clock.c                |    4 +-
 arch/arm/mach-s5p64x0/common.c               |  459 ++++++++++++++++++++++++++
 arch/arm/mach-s5p64x0/common.h               |   55 +++
 arch/arm/mach-s5p64x0/cpu.c                  |  215 ------------
 arch/arm/mach-s5p64x0/init.c                 |   73 ----
 arch/arm/mach-s5p64x0/irq-eint.c             |  155 ---------
 arch/arm/mach-s5p64x0/mach-smdk6440.c        |    5 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c        |    5 +-
 arch/arm/plat-s5p/cpu.c                      |   20 --
 arch/arm/plat-samsung/include/plat/s5p6440.h |   36 --
 arch/arm/plat-samsung/include/plat/s5p6450.h |   36 --
 14 files changed, 532 insertions(+), 546 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/common.c
 create mode 100644 arch/arm/mach-s5p64x0/common.h
 delete mode 100644 arch/arm/mach-s5p64x0/cpu.c
 delete mode 100644 arch/arm/mach-s5p64x0/init.c
 delete mode 100644 arch/arm/mach-s5p64x0/irq-eint.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5p6440.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5p6450.h

diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index a1324d8..d3f7409 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -10,14 +10,16 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-# Core support for S5P64X0 system
+# Core
 
-obj-$(CONFIG_ARCH_S5P64X0)	+= cpu.o init.o clock.o dma.o
-obj-$(CONFIG_ARCH_S5P64X0)	+= setup-i2c0.o irq-eint.o
+obj-y				+= common.o clock.o
 obj-$(CONFIG_CPU_S5P6440)	+= clock-s5p6440.o
 obj-$(CONFIG_CPU_S5P6450)	+= clock-s5p6450.o
+
 obj-$(CONFIG_PM)		+= pm.o irq-pm.o
 
+obj-y				+= dma.o
+
 # machine support
 
 obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
@@ -28,5 +30,6 @@ obj-$(CONFIG_MACH_SMDK6450)	+= mach-smdk6450.o
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
+obj-y					+= setup-i2c0.o
 obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5P64X0_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index c54c65d..dd2b8da 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -31,7 +31,8 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/s5p6440.h>
+
+#include "common.h"
 
 static u32 epll_div[][5] = {
 	{ 36000000,	0,	48, 1, 4 },
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 2d04abf..328a224 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -31,7 +31,8 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/s5p6450.h>
+
+#include "common.h"
 
 static struct clksrc_clk clk_mout_dpll = {
 	.clk	= {
diff --git a/arch/arm/mach-s5p64x0/clock.c b/arch/arm/mach-s5p64x0/clock.c
index b52c6e2..b289b72 100644
--- a/arch/arm/mach-s5p64x0/clock.c
+++ b/arch/arm/mach-s5p64x0/clock.c
@@ -30,8 +30,8 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/s5p6440.h>
-#include <plat/s5p6450.h>
+
+#include "common.h"
 
 struct clksrc_clk clk_mout_apll = {
 	.clk	= {
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
new file mode 100644
index 0000000..af02dc3
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -0,0 +1,459 @@
+/*
+ * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Codes for S5P64X0 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+
+#include <asm/irq.h>
+#include <asm/proc-fns.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/map.h>
+#include <mach/hardware.h>
+#include <mach/regs-clock.h>
+#include <mach/regs-gpio.h>
+
+#include <plat/cpu.h>
+#include <plat/clock.h>
+#include <plat/devs.h>
+#include <plat/pm.h>
+#include <plat/adc-core.h>
+#include <plat/fb-core.h>
+#include <plat/gpio-cfg.h>
+#include <plat/regs-irqtype.h>
+#include <plat/regs-serial.h>
+
+#include "common.h"
+
+static const char name_s5p6440[] = "S5P6440";
+static const char name_s5p6450[] = "S5P6450";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= S5P6440_CPU_ID,
+		.idmask		= S5P64XX_CPU_MASK,
+		.map_io		= s5p6440_map_io,
+		.init_clocks	= s5p6440_init_clocks,
+		.init_uarts	= s5p6440_init_uarts,
+		.init		= s5p64x0_init,
+		.name		= name_s5p6440,
+	}, {
+		.idcode		= S5P6450_CPU_ID,
+		.idmask		= S5P64XX_CPU_MASK,
+		.map_io		= s5p6450_map_io,
+		.init_clocks	= s5p6450_init_clocks,
+		.init_uarts	= s5p6450_init_uarts,
+		.init		= s5p64x0_init,
+		.name		= name_s5p6450,
+	},
+};
+
+/* Initial IO mappings */
+
+static struct map_desc s5p64x0_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_CHIPID,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_CHIPID),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_SYS,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_SYSCON),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_TIMER,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_TIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_WDT),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GPIO,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_GPIO),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC0,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_VIC0),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC1,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_VIC1),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc s5p6440_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S3C_VA_UART,
+		.pfn		= __phys_to_pfn(S5P6440_PA_UART(0)),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc s5p6450_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S3C_VA_UART,
+		.pfn		= __phys_to_pfn(S5P6450_PA_UART(0)),
+		.length		= SZ_512K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_UART + SZ_512K,
+		.pfn		= __phys_to_pfn(S5P6450_PA_UART(5)),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void s5p64x0_idle(void)
+{
+	unsigned long val;
+
+	if (!need_resched()) {
+		val = __raw_readl(S5P64X0_PWR_CFG);
+		val &= ~(0x3 << 5);
+		val |= (0x1 << 5);
+		__raw_writel(val, S5P64X0_PWR_CFG);
+
+		cpu_do_idle();
+	}
+	local_irq_enable();
+}
+
+/*
+ * s5p64x0_map_io
+ *
+ * register the standard CPU IO areas
+ */
+
+void __init s5p64x0_init_io(struct map_desc *mach_desc, int size)
+{
+	/* initialize the io descriptors we need for initialization */
+	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
+	if (mach_desc)
+		iotable_init(mach_desc, size);
+
+	/* detect cpu id and rev. */
+	s5p_init_cpu(S5P64X0_SYS_ID);
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
+
+void __init s5p6440_map_io(void)
+{
+	/* initialize any device information early */
+	s3c_adc_setname("s3c64xx-adc");
+	s3c_fb_setname("s5p64x0-fb");
+
+	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
+	init_consistent_dma_size(SZ_8M);
+}
+
+void __init s5p6450_map_io(void)
+{
+	/* initialize any device information early */
+	s3c_adc_setname("s3c64xx-adc");
+	s3c_fb_setname("s5p64x0-fb");
+
+	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
+	init_consistent_dma_size(SZ_8M);
+}
+
+/*
+ * s5p64x0_init_clocks
+ *
+ * register and setup the CPU clocks
+ */
+
+void __init s5p6440_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+	s5p6440_register_clocks();
+	s5p6440_setup_clocks();
+}
+
+void __init s5p6450_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+	s5p6450_register_clocks();
+	s5p6450_setup_clocks();
+}
+
+/*
+ * s5p64x0_init_irq
+ *
+ * register the CPU interrupts
+ */
+
+void __init s5p6440_init_irq(void)
+{
+	/* S5P6440 supports 2 VIC */
+	u32 vic[2];
+
+	/*
+	 * VIC0 is missing IRQ_VIC0[3, 4, 8, 10, (12-22)]
+	 * VIC1 is missing IRQ VIC1[1, 3, 4, 10, 11, 12, 14, 15, 22]
+	 */
+	vic[0] = 0xff800ae7;
+	vic[1] = 0xffbf23e5;
+
+	s5p_init_irq(vic, ARRAY_SIZE(vic));
+}
+
+void __init s5p6450_init_irq(void)
+{
+	/* S5P6450 supports only 2 VIC */
+	u32 vic[2];
+
+	/*
+	 * VIC0 is missing IRQ_VIC0[(13-15), (21-22)]
+	 * VIC1 is missing IRQ VIC1[12, 14, 23]
+	 */
+	vic[0] = 0xff9f1fff;
+	vic[1] = 0xff7fafff;
+
+	s5p_init_irq(vic, ARRAY_SIZE(vic));
+}
+
+struct sysdev_class s5p64x0_sysclass = {
+	.name	= "s5p64x0-core",
+};
+
+static struct sys_device s5p64x0_sysdev = {
+	.cls	= &s5p64x0_sysclass,
+};
+
+static int __init s5p64x0_core_init(void)
+{
+	return sysdev_class_register(&s5p64x0_sysclass);
+}
+core_initcall(s5p64x0_core_init);
+
+int __init s5p64x0_init(void)
+{
+	printk(KERN_INFO "S5P64X0(S5P6440/S5P6450): Initializing architecture\n");
+
+	/* set idle function */
+	pm_idle = s5p64x0_idle;
+
+	return sysdev_register(&s5p64x0_sysdev);
+}
+
+static struct s3c24xx_uart_clksrc s5p64x0_serial_clocks[] = {
+	[0] = {
+		.name		= "pclk_low",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+	[1] = {
+		.name		= "uclk1",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+};
+
+/* uart registration process */
+
+void __init s5p64x0_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->clocks = s5p64x0_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(s5p64x0_serial_clocks);
+		}
+	}
+}
+
+void __init s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	int uart;
+
+	for (uart = 0; uart < no; uart++) {
+		s5p_uart_resources[uart].resources->start = S5P6440_PA_UART(uart);
+		s5p_uart_resources[uart].resources->end = S5P6440_PA_UART(uart) + S5P_SZ_UART;
+	}
+
+	s5p64x0_common_init_uarts(cfg, no);
+	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
+}
+
+void __init s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	s5p64x0_common_init_uarts(cfg, no);
+	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
+}
+
+#define eint_offset(irq)	((irq) - IRQ_EINT(0))
+
+static int s5p64x0_irq_eint_set_type(struct irq_data *data, unsigned int type)
+{
+	int offs = eint_offset(data->irq);
+	int shift;
+	u32 ctrl, mask;
+	u32 newvalue = 0;
+
+	if (offs > 15)
+		return -EINVAL;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		printk(KERN_WARNING "No edge setting!\n");
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		newvalue = S3C2410_EXTINT_RISEEDGE;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		newvalue = S3C2410_EXTINT_FALLEDGE;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		newvalue = S3C2410_EXTINT_BOTHEDGE;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		newvalue = S3C2410_EXTINT_LOWLEV;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		newvalue = S3C2410_EXTINT_HILEV;
+		break;
+	default:
+		printk(KERN_ERR "No such irq type %d", type);
+		return -EINVAL;
+	}
+
+	shift = (offs / 2) * 4;
+	mask = 0x7 << shift;
+
+	ctrl = __raw_readl(S5P64X0_EINT0CON0) & ~mask;
+	ctrl |= newvalue << shift;
+	__raw_writel(ctrl, S5P64X0_EINT0CON0);
+
+	/* Configure the GPIO pin for 6450 or 6440 based on CPU ID */
+	if (soc_is_s5p6450())
+		s3c_gpio_cfgpin(S5P6450_GPN(offs), S3C_GPIO_SFN(2));
+	else
+		s3c_gpio_cfgpin(S5P6440_GPN(offs), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+/*
+ * s5p64x0_irq_demux_eint
+ *
+ * This function demuxes the IRQ from the group0 external interrupts,
+ * from IRQ_EINT(0) to IRQ_EINT(15). It is designed to be inlined into
+ * the specific handlers s5p64x0_irq_demux_eintX_Y.
+ */
+static inline void s5p64x0_irq_demux_eint(unsigned int start, unsigned int end)
+{
+	u32 status = __raw_readl(S5P64X0_EINT0PEND);
+	u32 mask = __raw_readl(S5P64X0_EINT0MASK);
+	unsigned int irq;
+
+	status &= ~mask;
+	status >>= start;
+	status &= (1 << (end - start + 1)) - 1;
+
+	for (irq = IRQ_EINT(start); irq <= IRQ_EINT(end); irq++) {
+		if (status & 1)
+			generic_handle_irq(irq);
+		status >>= 1;
+	}
+}
+
+static void s5p64x0_irq_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
+{
+	s5p64x0_irq_demux_eint(0, 3);
+}
+
+static void s5p64x0_irq_demux_eint4_11(unsigned int irq, struct irq_desc *desc)
+{
+	s5p64x0_irq_demux_eint(4, 11);
+}
+
+static void s5p64x0_irq_demux_eint12_15(unsigned int irq,
+					struct irq_desc *desc)
+{
+	s5p64x0_irq_demux_eint(12, 15);
+}
+
+static int s5p64x0_alloc_gc(void)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("s5p64x0-eint", 1, S5P_IRQ_EINT_BASE,
+				    S5P_VA_GPIO, handle_level_irq);
+	if (!gc) {
+		printk(KERN_ERR "%s: irq_alloc_generic_chip for group 0"
+			"external interrupts failed\n", __func__);
+		return -EINVAL;
+	}
+
+	ct = gc->chip_types;
+	ct->chip.irq_ack = irq_gc_ack_set_bit;
+	ct->chip.irq_mask = irq_gc_mask_set_bit;
+	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
+	ct->chip.irq_set_type = s5p64x0_irq_eint_set_type;
+	ct->chip.irq_set_wake = s3c_irqext_wake;
+	ct->regs.ack = EINT0PEND_OFFSET;
+	ct->regs.mask = EINT0MASK_OFFSET;
+	irq_setup_generic_chip(gc, IRQ_MSK(16), IRQ_GC_INIT_MASK_CACHE,
+			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+	return 0;
+}
+
+static int __init s5p64x0_init_irq_eint(void)
+{
+	int ret = s5p64x0_alloc_gc();
+	irq_set_chained_handler(IRQ_EINT0_3, s5p64x0_irq_demux_eint0_3);
+	irq_set_chained_handler(IRQ_EINT4_11, s5p64x0_irq_demux_eint4_11);
+	irq_set_chained_handler(IRQ_EINT12_15, s5p64x0_irq_demux_eint12_15);
+
+	return ret;
+}
+arch_initcall(s5p64x0_init_irq_eint);
diff --git a/arch/arm/mach-s5p64x0/common.h b/arch/arm/mach-s5p64x0/common.h
new file mode 100644
index 0000000..8a1eca5
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/common.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for S5P64X0 machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S5P64X0_COMMON_H
+#define __ARCH_ARM_MACH_S5P64X0_COMMON_H
+
+void s5p6440_init_irq(void);
+void s5p6450_init_irq(void);
+void s5p64x0_init_io(struct map_desc *mach_desc, int size);
+
+void s5p6440_register_clocks(void);
+void s5p6440_setup_clocks(void);
+
+void s5p6450_register_clocks(void);
+void s5p6450_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5P6440
+
+extern  int s5p64x0_init(void);
+extern void s5p6440_map_io(void);
+extern void s5p6440_init_clocks(int xtal);
+
+extern void s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+#else
+#define s5p6440_init_clocks NULL
+#define s5p6440_init_uarts NULL
+#define s5p6440_map_io NULL
+#define s5p64x0_init NULL
+#endif
+
+#ifdef CONFIG_CPU_S5P6450
+
+extern  int s5p64x0_init(void);
+extern void s5p6450_map_io(void);
+extern void s5p6450_init_clocks(int xtal);
+
+extern void s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+#else
+#define s5p6450_init_clocks NULL
+#define s5p6450_init_uarts NULL
+#define s5p6450_map_io NULL
+#define s5p64x0_init NULL
+#endif
+
+#endif /* __ARCH_ARM_MACH_S5P64X0_COMMON_H */
diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
deleted file mode 100644
index ecab40c..0000000
--- a/arch/arm/mach-s5p64x0/cpu.c
+++ /dev/null
@@ -1,215 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/cpu.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/timer.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/sysdev.h>
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-#include <linux/sched.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-#include <asm/proc-fns.h>
-#include <asm/irq.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-
-#include <plat/regs-serial.h>
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/clock.h>
-#include <plat/s5p6440.h>
-#include <plat/s5p6450.h>
-#include <plat/adc-core.h>
-#include <plat/fb-core.h>
-
-/* Initial IO mappings */
-
-static struct map_desc s5p64x0_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_GPIO,
-		.pfn		= __phys_to_pfn(S5P64X0_PA_GPIO),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC0,
-		.pfn		= __phys_to_pfn(S5P64X0_PA_VIC0),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC1,
-		.pfn		= __phys_to_pfn(S5P64X0_PA_VIC1),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc s5p6440_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S3C_VA_UART,
-		.pfn		= __phys_to_pfn(S5P6440_PA_UART(0)),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc s5p6450_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S3C_VA_UART,
-		.pfn		= __phys_to_pfn(S5P6450_PA_UART(0)),
-		.length		= SZ_512K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_UART + SZ_512K,
-		.pfn		= __phys_to_pfn(S5P6450_PA_UART(5)),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static void s5p64x0_idle(void)
-{
-	unsigned long val;
-
-	if (!need_resched()) {
-		val = __raw_readl(S5P64X0_PWR_CFG);
-		val &= ~(0x3 << 5);
-		val |= (0x1 << 5);
-		__raw_writel(val, S5P64X0_PWR_CFG);
-
-		cpu_do_idle();
-	}
-	local_irq_enable();
-}
-
-/*
- * s5p64x0_map_io
- *
- * register the standard CPU IO areas
- */
-
-void __init s5p6440_map_io(void)
-{
-	/* initialize any device information early */
-	s3c_adc_setname("s3c64xx-adc");
-	s3c_fb_setname("s5p64x0-fb");
-
-	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
-	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
-	init_consistent_dma_size(SZ_8M);
-}
-
-void __init s5p6450_map_io(void)
-{
-	/* initialize any device information early */
-	s3c_adc_setname("s3c64xx-adc");
-	s3c_fb_setname("s5p64x0-fb");
-
-	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
-	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
-	init_consistent_dma_size(SZ_8M);
-}
-
-/*
- * s5p64x0_init_clocks
- *
- * register and setup the CPU clocks
- */
-
-void __init s5p6440_init_clocks(int xtal)
-{
-	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
-
-	s3c24xx_register_baseclocks(xtal);
-	s5p_register_clocks(xtal);
-	s5p6440_register_clocks();
-	s5p6440_setup_clocks();
-}
-
-void __init s5p6450_init_clocks(int xtal)
-{
-	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
-
-	s3c24xx_register_baseclocks(xtal);
-	s5p_register_clocks(xtal);
-	s5p6450_register_clocks();
-	s5p6450_setup_clocks();
-}
-
-/*
- * s5p64x0_init_irq
- *
- * register the CPU interrupts
- */
-
-void __init s5p6440_init_irq(void)
-{
-	/* S5P6440 supports 2 VIC */
-	u32 vic[2];
-
-	/*
-	 * VIC0 is missing IRQ_VIC0[3, 4, 8, 10, (12-22)]
-	 * VIC1 is missing IRQ VIC1[1, 3, 4, 10, 11, 12, 14, 15, 22]
-	 */
-	vic[0] = 0xff800ae7;
-	vic[1] = 0xffbf23e5;
-
-	s5p_init_irq(vic, ARRAY_SIZE(vic));
-}
-
-void __init s5p6450_init_irq(void)
-{
-	/* S5P6450 supports only 2 VIC */
-	u32 vic[2];
-
-	/*
-	 * VIC0 is missing IRQ_VIC0[(13-15), (21-22)]
-	 * VIC1 is missing IRQ VIC1[12, 14, 23]
-	 */
-	vic[0] = 0xff9f1fff;
-	vic[1] = 0xff7fafff;
-
-	s5p_init_irq(vic, ARRAY_SIZE(vic));
-}
-
-struct sysdev_class s5p64x0_sysclass = {
-	.name	= "s5p64x0-core",
-};
-
-static struct sys_device s5p64x0_sysdev = {
-	.cls	= &s5p64x0_sysclass,
-};
-
-static int __init s5p64x0_core_init(void)
-{
-	return sysdev_class_register(&s5p64x0_sysclass);
-}
-core_initcall(s5p64x0_core_init);
-
-int __init s5p64x0_init(void)
-{
-	printk(KERN_INFO "S5P64X0(S5P6440/S5P6450): Initializing architecture\n");
-
-	/* set idle function */
-	pm_idle = s5p64x0_idle;
-
-	return sysdev_register(&s5p64x0_sysdev);
-}
diff --git a/arch/arm/mach-s5p64x0/init.c b/arch/arm/mach-s5p64x0/init.c
deleted file mode 100644
index 79833ca..0000000
--- a/arch/arm/mach-s5p64x0/init.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/init.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5P64X0 - Init support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-
-#include <mach/map.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/s5p6440.h>
-#include <plat/s5p6450.h>
-#include <plat/regs-serial.h>
-
-static struct s3c24xx_uart_clksrc s5p64x0_serial_clocks[] = {
-	[0] = {
-		.name		= "pclk_low",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "uclk1",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
-/* uart registration process */
-
-void __init s5p64x0_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->clocks = s5p64x0_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5p64x0_serial_clocks);
-		}
-	}
-}
-
-void __init s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	int uart;
-
-	for (uart = 0; uart < no; uart++) {
-		s5p_uart_resources[uart].resources->start = S5P6440_PA_UART(uart);
-		s5p_uart_resources[uart].resources->end = S5P6440_PA_UART(uart) + S5P_SZ_UART;
-	}
-
-	s5p64x0_common_init_uarts(cfg, no);
-	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
-}
-
-void __init s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	s5p64x0_common_init_uarts(cfg, no);
-	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
-}
diff --git a/arch/arm/mach-s5p64x0/irq-eint.c b/arch/arm/mach-s5p64x0/irq-eint.c
deleted file mode 100644
index 275dc74..0000000
--- a/arch/arm/mach-s5p64x0/irq-eint.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/* arch/arm/mach-s5p64x0/irq-eint.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd
- *		http://www.samsung.com/
- *
- * Based on linux/arch/arm/mach-s3c64xx/irq-eint.c
- *
- * S5P64X0 - Interrupt handling for External Interrupts.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-
-#include <plat/cpu.h>
-#include <plat/regs-irqtype.h>
-#include <plat/gpio-cfg.h>
-#include <plat/pm.h>
-
-#include <mach/regs-gpio.h>
-#include <mach/regs-clock.h>
-
-#define eint_offset(irq)	((irq) - IRQ_EINT(0))
-
-static int s5p64x0_irq_eint_set_type(struct irq_data *data, unsigned int type)
-{
-	int offs = eint_offset(data->irq);
-	int shift;
-	u32 ctrl, mask;
-	u32 newvalue = 0;
-
-	if (offs > 15)
-		return -EINVAL;
-
-	switch (type) {
-	case IRQ_TYPE_NONE:
-		printk(KERN_WARNING "No edge setting!\n");
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		newvalue = S3C2410_EXTINT_RISEEDGE;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		newvalue = S3C2410_EXTINT_FALLEDGE;
-		break;
-	case IRQ_TYPE_EDGE_BOTH:
-		newvalue = S3C2410_EXTINT_BOTHEDGE;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		newvalue = S3C2410_EXTINT_LOWLEV;
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		newvalue = S3C2410_EXTINT_HILEV;
-		break;
-	default:
-		printk(KERN_ERR "No such irq type %d", type);
-		return -EINVAL;
-	}
-
-	shift = (offs / 2) * 4;
-	mask = 0x7 << shift;
-
-	ctrl = __raw_readl(S5P64X0_EINT0CON0) & ~mask;
-	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, S5P64X0_EINT0CON0);
-
-	/* Configure the GPIO pin for 6450 or 6440 based on CPU ID */
-	if (soc_is_s5p6450())
-		s3c_gpio_cfgpin(S5P6450_GPN(offs), S3C_GPIO_SFN(2));
-	else
-		s3c_gpio_cfgpin(S5P6440_GPN(offs), S3C_GPIO_SFN(2));
-
-	return 0;
-}
-
-/*
- * s5p64x0_irq_demux_eint
- *
- * This function demuxes the IRQ from the group0 external interrupts,
- * from IRQ_EINT(0) to IRQ_EINT(15). It is designed to be inlined into
- * the specific handlers s5p64x0_irq_demux_eintX_Y.
- */
-static inline void s5p64x0_irq_demux_eint(unsigned int start, unsigned int end)
-{
-	u32 status = __raw_readl(S5P64X0_EINT0PEND);
-	u32 mask = __raw_readl(S5P64X0_EINT0MASK);
-	unsigned int irq;
-
-	status &= ~mask;
-	status >>= start;
-	status &= (1 << (end - start + 1)) - 1;
-
-	for (irq = IRQ_EINT(start); irq <= IRQ_EINT(end); irq++) {
-		if (status & 1)
-			generic_handle_irq(irq);
-		status >>= 1;
-	}
-}
-
-static void s5p64x0_irq_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
-{
-	s5p64x0_irq_demux_eint(0, 3);
-}
-
-static void s5p64x0_irq_demux_eint4_11(unsigned int irq, struct irq_desc *desc)
-{
-	s5p64x0_irq_demux_eint(4, 11);
-}
-
-static void s5p64x0_irq_demux_eint12_15(unsigned int irq,
-					struct irq_desc *desc)
-{
-	s5p64x0_irq_demux_eint(12, 15);
-}
-
-static int s5p64x0_alloc_gc(void)
-{
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-
-	gc = irq_alloc_generic_chip("s5p64x0-eint", 1, S5P_IRQ_EINT_BASE,
-				    S5P_VA_GPIO, handle_level_irq);
-	if (!gc) {
-		printk(KERN_ERR "%s: irq_alloc_generic_chip for group 0"
-			"external interrupts failed\n", __func__);
-		return -EINVAL;
-	}
-
-	ct = gc->chip_types;
-	ct->chip.irq_ack = irq_gc_ack_set_bit;
-	ct->chip.irq_mask = irq_gc_mask_set_bit;
-	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
-	ct->chip.irq_set_type = s5p64x0_irq_eint_set_type;
-	ct->chip.irq_set_wake = s3c_irqext_wake;
-	ct->regs.ack = EINT0PEND_OFFSET;
-	ct->regs.mask = EINT0MASK_OFFSET;
-	irq_setup_generic_chip(gc, IRQ_MSK(16), IRQ_GC_INIT_MASK_CACHE,
-			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
-	return 0;
-}
-
-static int __init s5p64x0_init_irq_eint(void)
-{
-	int ret = s5p64x0_alloc_gc();
-	irq_set_chained_handler(IRQ_EINT0_3, s5p64x0_irq_demux_eint0_3);
-	irq_set_chained_handler(IRQ_EINT4_11, s5p64x0_irq_demux_eint4_11);
-	irq_set_chained_handler(IRQ_EINT12_15, s5p64x0_irq_demux_eint12_15);
-
-	return ret;
-}
-arch_initcall(s5p64x0_init_irq_eint);
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index c272c3f..74f3f02 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -41,7 +41,6 @@
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
-#include <plat/s5p6440.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -54,6 +53,8 @@
 #include <plat/fb.h>
 #include <plat/regs-fb.h>
 
+#include "common.h"
+
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
 				S3C2410_UCON_TXIRQMODE |	\
@@ -202,7 +203,7 @@ static struct platform_pwm_backlight_data smdk6440_bl_data = {
 
 static void __init smdk6440_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P64X0_SYS_ID);
+	s5p64x0_init_io(NULL, 0);
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk6440_uartcfgs, ARRAY_SIZE(smdk6440_uartcfgs));
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 7a47009..193ed2d 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -41,7 +41,6 @@
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
-#include <plat/s5p6450.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -54,6 +53,8 @@
 #include <plat/fb.h>
 #include <plat/regs-fb.h>
 
+#include "common.h"
+
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
 				S3C2410_UCON_TXIRQMODE |	\
@@ -222,7 +223,7 @@ static struct platform_pwm_backlight_data smdk6450_bl_data = {
 
 static void __init smdk6450_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P64X0_SYS_ID);
+	s5p64x0_init_io(NULL, 0);
 	s3c24xx_init_clocks(19200000);
 	s3c24xx_init_uarts(smdk6450_uartcfgs, ARRAY_SIZE(smdk6450_uartcfgs));
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index a56959e..2fb9a9c 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -20,16 +20,12 @@
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
-#include <plat/s5p6440.h>
-#include <plat/s5p6450.h>
 #include <plat/s5pc100.h>
 #include <plat/s5pv210.h>
 #include <plat/exynos4.h>
 
 /* table of supported CPUs */
 
-static const char name_s5p6440[] = "S5P6440";
-static const char name_s5p6450[] = "S5P6450";
 static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
 static const char name_exynos4210[] = "EXYNOS4210";
@@ -38,22 +34,6 @@ static const char name_exynos4412[] = "EXYNOS4412";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
-		.idcode		= S5P6440_CPU_ID,
-		.idmask		= S5P64XX_CPU_MASK,
-		.map_io		= s5p6440_map_io,
-		.init_clocks	= s5p6440_init_clocks,
-		.init_uarts	= s5p6440_init_uarts,
-		.init		= s5p64x0_init,
-		.name		= name_s5p6440,
-	}, {
-		.idcode		= S5P6450_CPU_ID,
-		.idmask		= S5P64XX_CPU_MASK,
-		.map_io		= s5p6450_map_io,
-		.init_clocks	= s5p6450_init_clocks,
-		.init_uarts	= s5p6450_init_uarts,
-		.init		= s5p64x0_init,
-		.name		= name_s5p6450,
-	}, {
 		.idcode		= S5PC100_CPU_ID,
 		.idmask		= S5PC100_CPU_MASK,
 		.map_io		= s5pc100_map_io,
diff --git a/arch/arm/plat-samsung/include/plat/s5p6440.h b/arch/arm/plat-samsung/include/plat/s5p6440.h
deleted file mode 100644
index bf85ebb..0000000
--- a/arch/arm/plat-samsung/include/plat/s5p6440.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s5p6440.h
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Header file for s5p6440 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
- /* Common init code for S5P6440 related SoCs */
-
-extern void s5p6440_register_clocks(void);
-extern void s5p6440_setup_clocks(void);
-
-#ifdef CONFIG_CPU_S5P6440
-
-extern  int s5p64x0_init(void);
-extern void s5p6440_init_irq(void);
-extern void s5p6440_map_io(void);
-extern void s5p6440_init_clocks(int xtal);
-
-extern void s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-#else
-#define s5p6440_init_clocks NULL
-#define s5p6440_init_uarts NULL
-#define s5p6440_map_io NULL
-#define s5p64x0_init NULL
-#endif
-
-/* S5P6440 timer */
-
-extern struct sys_timer s5p6440_timer;
diff --git a/arch/arm/plat-samsung/include/plat/s5p6450.h b/arch/arm/plat-samsung/include/plat/s5p6450.h
deleted file mode 100644
index da25f9a..0000000
--- a/arch/arm/plat-samsung/include/plat/s5p6450.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s5p6450.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Header file for s5p6450 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* Common init code for S5P6450 related SoCs */
-
-extern void s5p6450_register_clocks(void);
-extern void s5p6450_setup_clocks(void);
-
-#ifdef CONFIG_CPU_S5P6450
-
-extern  int s5p64x0_init(void);
-extern void s5p6450_init_irq(void);
-extern void s5p6450_map_io(void);
-extern void s5p6450_init_clocks(int xtal);
-
-extern void s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-#else
-#define s5p6450_init_clocks NULL
-#define s5p6450_init_uarts NULL
-#define s5p6450_map_io NULL
-#define s5p64x0_init NULL
-#endif
-
-/* S5P6450 timer */
-
-extern struct sys_timer s5p6450_timer;
-- 
1.7.4.4
