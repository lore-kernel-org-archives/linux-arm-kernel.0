From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:33 +0900
Subject: [PATCH 09/12] ARM: EXYNOS: introduce arch/arm/mach-exynos/common.[ch]
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-10-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces common.[ch] which are used only in the
arch/arm/mach-exynos/ directory. The common.c file merges
the cpu.c, init.c, irq-combiner.c and irq-eint.c files which
are used commonly on EXYNOS SoCs and the common.h file replaces
with plat/exynos4.h file.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Makefile                |    9 +-
 arch/arm/mach-exynos/clock-exynos4210.c      |    3 +-
 arch/arm/mach-exynos/clock-exynos4212.c      |    3 +-
 arch/arm/mach-exynos/clock.c                 |    3 +-
 arch/arm/mach-exynos/common.c                |  709 ++++++++++++++++++++++++++
 arch/arm/mach-exynos/common.h                |   39 ++
 arch/arm/mach-exynos/cpu.c                   |  284 ----------
 arch/arm/mach-exynos/include/mach/map.h      |   12 +-
 arch/arm/mach-exynos/init.c                  |   42 --
 arch/arm/mach-exynos/irq-combiner.c          |  124 -----
 arch/arm/mach-exynos/irq-eint.c              |  237 ---------
 arch/arm/mach-exynos/mach-armlex4210.c       |    5 +-
 arch/arm/mach-exynos/mach-nuri.c             |    5 +-
 arch/arm/mach-exynos/mach-origen.c           |    5 +-
 arch/arm/mach-exynos/mach-smdk4x12.c         |    5 +-
 arch/arm/mach-exynos/mach-smdkv310.c         |    5 +-
 arch/arm/mach-exynos/mach-universal_c210.c   |    5 +-
 arch/arm/plat-s5p/Makefile                   |    1 -
 arch/arm/plat-s5p/cpu.c                      |  104 ----
 arch/arm/plat-samsung/include/plat/cpu.h     |    2 -
 arch/arm/plat-samsung/include/plat/exynos4.h |   35 --
 21 files changed, 779 insertions(+), 858 deletions(-)
 create mode 100644 arch/arm/mach-exynos/common.c
 create mode 100644 arch/arm/mach-exynos/common.h
 delete mode 100644 arch/arm/mach-exynos/cpu.c
 delete mode 100644 arch/arm/mach-exynos/init.c
 delete mode 100644 arch/arm/mach-exynos/irq-combiner.c
 delete mode 100644 arch/arm/mach-exynos/irq-eint.c
 delete mode 100644 arch/arm/plat-s5p/cpu.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/exynos4.h

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 59069a3..bcb9efc 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -10,15 +10,17 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-# Core support for EXYNOS4 system
+# Core
 
-obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o setup-i2c0.o
-obj-$(CONFIG_ARCH_EXYNOS4)	+= irq-eint.o dma.o pmu.o
+obj-$(CONFIG_ARCH_EXYNOS4)	+= common.o clock.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
+
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
+obj-$(CONFIG_ARCH_EXYNOS4)	+= dma.o pmu.o
+
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
 obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
@@ -45,6 +47,7 @@ obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
 
+obj-$(CONFIG_ARCH_EXYNOS4)		+= setup-i2c0.o
 obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
 obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
diff --git a/arch/arm/mach-exynos/clock-exynos4210.c b/arch/arm/mach-exynos/clock-exynos4210.c
index b9d5ef6..a5823a7 100644
--- a/arch/arm/mach-exynos/clock-exynos4210.c
+++ b/arch/arm/mach-exynos/clock-exynos4210.c
@@ -23,7 +23,6 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/exynos4.h>
 #include <plat/pm.h>
 
 #include <mach/hardware.h>
@@ -31,6 +30,8 @@
 #include <mach/regs-clock.h>
 #include <mach/exynos4-clock.h>
 
+#include "common.h"
+
 static struct sleep_save exynos4210_clock_save[] = {
 	SAVE_ITEM(S5P_CLKSRC_IMAGE),
 	SAVE_ITEM(S5P_CLKSRC_LCD1),
diff --git a/arch/arm/mach-exynos/clock-exynos4212.c b/arch/arm/mach-exynos/clock-exynos4212.c
index 77d5dec..26a668b 100644
--- a/arch/arm/mach-exynos/clock-exynos4212.c
+++ b/arch/arm/mach-exynos/clock-exynos4212.c
@@ -23,7 +23,6 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/exynos4.h>
 #include <plat/pm.h>
 
 #include <mach/hardware.h>
@@ -31,6 +30,8 @@
 #include <mach/regs-clock.h>
 #include <mach/exynos4-clock.h>
 
+#include "common.h"
+
 static struct sleep_save exynos4212_clock_save[] = {
 	SAVE_ITEM(S5P_CLKSRC_IMAGE),
 	SAVE_ITEM(S5P_CLKDIV_IMAGE),
diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
index 2894f0a..83616a0 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@ -21,7 +21,6 @@
 #include <plat/pll.h>
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
-#include <plat/exynos4.h>
 #include <plat/pm.h>
 
 #include <mach/map.h>
@@ -29,6 +28,8 @@
 #include <mach/sysmmu.h>
 #include <mach/exynos4-clock.h>
 
+#include "common.h"
+
 static struct sleep_save exynos4_clock_save[] = {
 	SAVE_ITEM(S5P_CLKDIV_LEFTBUS),
 	SAVE_ITEM(S5P_CLKGATE_IP_LEFTBUS),
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
new file mode 100644
index 0000000..8eb2293
--- /dev/null
+++ b/arch/arm/mach-exynos/common.c
@@ -0,0 +1,709 @@
+/*
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Codes for EXYNOS
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+#include <linux/gpio.h>
+#include <linux/sched.h>
+#include <linux/serial_core.h>
+
+#include <asm/proc-fns.h>
+#include <asm/exception.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/regs-irq.h>
+#include <mach/regs-pmu.h>
+#include <mach/regs-gpio.h>
+
+#include <plat/cpu.h>
+#include <plat/clock.h>
+#include <plat/devs.h>
+#include <plat/pm.h>
+#include <plat/reset.h>
+#include <plat/sdhci.h>
+#include <plat/gpio-cfg.h>
+#include <plat/adc-core.h>
+#include <plat/fb-core.h>
+#include <plat/fimc-core.h>
+#include <plat/iic-core.h>
+#include <plat/tv-core.h>
+#include <plat/regs-serial.h>
+
+#include "common.h"
+
+static const char name_exynos4210[] = "EXYNOS4210";
+static const char name_exynos4212[] = "EXYNOS4212";
+static const char name_exynos4412[] = "EXYNOS4412";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= EXYNOS4210_CPU_ID,
+		.idmask		= EXYNOS4_CPU_MASK,
+		.map_io		= exynos4_map_io,
+		.init_clocks	= exynos4_init_clocks,
+		.init_uarts	= exynos4_init_uarts,
+		.init		= exynos_init,
+		.name		= name_exynos4210,
+	}, {
+		.idcode		= EXYNOS4212_CPU_ID,
+		.idmask		= EXYNOS4_CPU_MASK,
+		.map_io		= exynos4_map_io,
+		.init_clocks	= exynos4_init_clocks,
+		.init_uarts	= exynos4_init_uarts,
+		.init		= exynos_init,
+		.name		= name_exynos4212,
+	}, {
+		.idcode		= EXYNOS4412_CPU_ID,
+		.idmask		= EXYNOS4_CPU_MASK,
+		.map_io		= exynos4_map_io,
+		.init_clocks	= exynos4_init_clocks,
+		.init_uarts	= exynos4_init_uarts,
+		.init		= exynos_init,
+		.name		= name_exynos4412,
+	},
+};
+
+/* Initial IO mappings */
+
+static struct map_desc exynos_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_CHIPID,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_CHIPID),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_SYS,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSCON),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_TIMER,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_TIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_WATCHDOG),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSTIMER),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_PMU,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_PMU),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_COMBINER),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_CPU),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_DIST),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_UART,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_UART),
+		.length		= SZ_512K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc exynos4_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_CMU,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
+		.length		= SZ_128K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_L2CC,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_L2CC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GPIO1,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO1),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GPIO2,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO2),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GPIO3,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO3),
+		.length		= SZ_256,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_DMC0,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC0),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_HSPHY),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc exynos4_iodesc0[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM0),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc exynos4_iodesc1[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM1),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void exynos_idle(void)
+{
+	if (!need_resched())
+		cpu_do_idle();
+
+	local_irq_enable();
+}
+
+static void exynos4_sw_reset(void)
+{
+	__raw_writel(0x1, S5P_SWRESET);
+}
+
+/*
+ * exynos_map_io
+ *
+ * register the standard cpu IO areas
+ */
+
+void __init exynos_init_io(struct map_desc *mach_desc, int size)
+{
+	/* initialize the io descriptors we need for initialization */
+	iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
+	if (mach_desc)
+		iotable_init(mach_desc, size);
+
+	/* detect cpu id and rev. */
+	s5p_init_cpu(S5P_VA_CHIPID);
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
+
+void __init exynos4_map_io(void)
+{
+	iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
+
+	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0)
+		iotable_init(exynos4_iodesc0, ARRAY_SIZE(exynos4_iodesc0));
+	else
+		iotable_init(exynos4_iodesc1, ARRAY_SIZE(exynos4_iodesc1));
+
+	/* initialize device information early */
+	exynos4_default_sdhci0();
+	exynos4_default_sdhci1();
+	exynos4_default_sdhci2();
+	exynos4_default_sdhci3();
+
+	s3c_adc_setname("samsung-adc-v3");
+
+	s3c_fimc_setname(0, "exynos4-fimc");
+	s3c_fimc_setname(1, "exynos4-fimc");
+	s3c_fimc_setname(2, "exynos4-fimc");
+	s3c_fimc_setname(3, "exynos4-fimc");
+
+	/* The I2C bus controllers are directly compatible with s3c2440 */
+	s3c_i2c0_setname("s3c2440-i2c");
+	s3c_i2c1_setname("s3c2440-i2c");
+	s3c_i2c2_setname("s3c2440-i2c");
+
+	s5p_fb_setname(0, "exynos4-fb");
+	s5p_hdmi_setname("exynos4-hdmi");
+}
+
+void __init exynos4_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+
+	if (soc_is_exynos4210())
+		exynos4210_register_clocks();
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
+		exynos4212_register_clocks();
+
+	exynos4_register_clocks();
+	exynos4_setup_clocks();
+}
+
+#define COMBINER_ENABLE_SET	0x0
+#define COMBINER_ENABLE_CLEAR	0x4
+#define COMBINER_INT_STATUS	0xC
+
+static DEFINE_SPINLOCK(irq_controller_lock);
+
+struct combiner_chip_data {
+	unsigned int irq_offset;
+	unsigned int irq_mask;
+	void __iomem *base;
+};
+
+static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
+
+static inline void __iomem *combiner_base(struct irq_data *data)
+{
+	struct combiner_chip_data *combiner_data =
+		irq_data_get_irq_chip_data(data);
+
+	return combiner_data->base;
+}
+
+static void combiner_mask_irq(struct irq_data *data)
+{
+	u32 mask = 1 << (data->irq % 32);
+
+	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
+}
+
+static void combiner_unmask_irq(struct irq_data *data)
+{
+	u32 mask = 1 << (data->irq % 32);
+
+	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
+}
+
+static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct combiner_chip_data *chip_data = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_get_chip(irq);
+	unsigned int cascade_irq, combiner_irq;
+	unsigned long status;
+
+	chained_irq_enter(chip, desc);
+
+	spin_lock(&irq_controller_lock);
+	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
+	spin_unlock(&irq_controller_lock);
+	status &= chip_data->irq_mask;
+
+	if (status == 0)
+		goto out;
+
+	combiner_irq = __ffs(status);
+
+	cascade_irq = combiner_irq + (chip_data->irq_offset & ~31);
+	if (unlikely(cascade_irq >= NR_IRQS))
+		do_bad_IRQ(cascade_irq, desc);
+	else
+		generic_handle_irq(cascade_irq);
+
+ out:
+	chained_irq_exit(chip, desc);
+}
+
+static struct irq_chip combiner_chip = {
+	.name		= "COMBINER",
+	.irq_mask	= combiner_mask_irq,
+	.irq_unmask	= combiner_unmask_irq,
+};
+
+static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
+{
+	if (combiner_nr >= MAX_COMBINER_NR)
+		BUG();
+	if (irq_set_handler_data(irq, &combiner_data[combiner_nr]) != 0)
+		BUG();
+	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
+}
+
+static void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
+			  unsigned int irq_start)
+{
+	unsigned int i;
+
+	if (combiner_nr >= MAX_COMBINER_NR)
+		BUG();
+
+	combiner_data[combiner_nr].base = base;
+	combiner_data[combiner_nr].irq_offset = irq_start;
+	combiner_data[combiner_nr].irq_mask = 0xff << ((combiner_nr % 4) << 3);
+
+	/* Disable all interrupts */
+
+	__raw_writel(combiner_data[combiner_nr].irq_mask,
+		     base + COMBINER_ENABLE_CLEAR);
+
+	/* Setup the Linux IRQ subsystem */
+
+	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
+				+ MAX_IRQ_IN_COMBINER; i++) {
+		irq_set_chip_and_handler(i, &combiner_chip, handle_level_irq);
+		irq_set_chip_data(i, &combiner_data[combiner_nr]);
+		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+	}
+}
+
+void __init exynos4_init_irq(void)
+{
+	int irq;
+	unsigned int gic_bank_offset;
+
+	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
+
+	gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset);
+
+	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
+
+		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
+				COMBINER_IRQ(irq, 0));
+		combiner_cascade_irq(irq, IRQ_SPI(irq));
+	}
+
+	/*
+	 * The parameters of s5p_init_irq() are for VIC init.
+	 * Theses parameters should be NULL and 0 because EXYNOS4
+	 * uses GIC instead of VIC.
+	 */
+	s5p_init_irq(NULL, 0);
+}
+
+struct sysdev_class exynos4_sysclass = {
+	.name	= "exynos4-core",
+};
+
+static struct sys_device exynos4_sysdev = {
+	.cls	= &exynos4_sysclass,
+};
+
+static int __init exynos4_core_init(void)
+{
+	return sysdev_class_register(&exynos4_sysclass);
+}
+core_initcall(exynos4_core_init);
+
+#ifdef CONFIG_CACHE_L2X0
+static int __init exynos4_l2x0_cache_init(void)
+{
+	/* TAG, Data Latency Control: 2cycle */
+	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
+
+	if (soc_is_exynos4210())
+		__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
+		__raw_writel(0x120, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+
+	/* L2X0 Prefetch Control */
+	__raw_writel(0x30000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
+
+	/* L2X0 Power Control */
+	__raw_writel(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN,
+		     S5P_VA_L2CC + L2X0_POWER_CTRL);
+
+	l2x0_init(S5P_VA_L2CC, 0x7C470001, 0xC200ffff);
+
+	return 0;
+}
+
+early_initcall(exynos4_l2x0_cache_init);
+#endif
+
+int __init exynos_init(void)
+{
+	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
+
+	/* set idle function */
+	pm_idle = exynos_idle;
+
+	/* set sw_reset function */
+	if (soc_is_exynos4210() || soc_is_exynos4212() || soc_is_exynos4412())
+		s5p_reset_hook = exynos4_sw_reset;
+
+	return sysdev_register(&exynos4_sysdev);
+}
+
+static struct s3c24xx_uart_clksrc exynos4_serial_clocks[] = {
+	[0] = {
+		.name		= "uclk1",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+};
+
+/* uart registration process */
+
+void __init exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->has_fracval = 1;
+			tcfg->clocks = exynos4_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(exynos4_serial_clocks);
+		}
+		tcfg->flags |= NO_NEED_CHECK_CLKSRC;
+	}
+
+	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
+}
+
+static DEFINE_SPINLOCK(eint_lock);
+
+static unsigned int eint0_15_data[16];
+
+static unsigned int exynos4_get_irq_nr(unsigned int number)
+{
+	u32 ret = 0;
+
+	switch (number) {
+	case 0 ... 3:
+		ret = (number + IRQ_EINT0);
+		break;
+	case 4 ... 7:
+		ret = (number + (IRQ_EINT4 - 4));
+		break;
+	case 8 ... 15:
+		ret = (number + (IRQ_EINT8 - 8));
+		break;
+	default:
+		printk(KERN_ERR "number available : %d\n", number);
+	}
+
+	return ret;
+}
+
+static inline void exynos4_irq_eint_mask(struct irq_data *data)
+{
+	u32 mask;
+
+	spin_lock(&eint_lock);
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask |= eint_irq_to_bit(data->irq);
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	spin_unlock(&eint_lock);
+}
+
+static void exynos4_irq_eint_unmask(struct irq_data *data)
+{
+	u32 mask;
+
+	spin_lock(&eint_lock);
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask &= ~(eint_irq_to_bit(data->irq));
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	spin_unlock(&eint_lock);
+}
+
+static inline void exynos4_irq_eint_ack(struct irq_data *data)
+{
+	__raw_writel(eint_irq_to_bit(data->irq),
+		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
+}
+
+static void exynos4_irq_eint_maskack(struct irq_data *data)
+{
+	exynos4_irq_eint_mask(data);
+	exynos4_irq_eint_ack(data);
+}
+
+static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
+{
+	int offs = EINT_OFFSET(data->irq);
+	int shift;
+	u32 ctrl, mask;
+	u32 newvalue = 0;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		newvalue = S5P_IRQ_TYPE_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		newvalue = S5P_IRQ_TYPE_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		newvalue = S5P_IRQ_TYPE_EDGE_BOTH;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		newvalue = S5P_IRQ_TYPE_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		newvalue = S5P_IRQ_TYPE_LEVEL_HIGH;
+		break;
+
+	default:
+		printk(KERN_ERR "No such irq type %d", type);
+		return -EINVAL;
+	}
+
+	shift = (offs & 0x7) * 4;
+	mask = 0x7 << shift;
+
+	spin_lock(&eint_lock);
+	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(data->irq)));
+	ctrl &= ~mask;
+	ctrl |= newvalue << shift;
+	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(data->irq)));
+	spin_unlock(&eint_lock);
+
+	switch (offs) {
+	case 0 ... 7:
+		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
+		break;
+	case 8 ... 15:
+		s3c_gpio_cfgpin(EINT_GPIO_1(offs & 0x7), EINT_MODE);
+		break;
+	case 16 ... 23:
+		s3c_gpio_cfgpin(EINT_GPIO_2(offs & 0x7), EINT_MODE);
+		break;
+	case 24 ... 31:
+		s3c_gpio_cfgpin(EINT_GPIO_3(offs & 0x7), EINT_MODE);
+		break;
+	default:
+		printk(KERN_ERR "No such irq number %d", offs);
+	}
+
+	return 0;
+}
+
+static struct irq_chip exynos4_irq_eint = {
+	.name		= "exynos4-eint",
+	.irq_mask	= exynos4_irq_eint_mask,
+	.irq_unmask	= exynos4_irq_eint_unmask,
+	.irq_mask_ack	= exynos4_irq_eint_maskack,
+	.irq_ack	= exynos4_irq_eint_ack,
+	.irq_set_type	= exynos4_irq_eint_set_type,
+#ifdef CONFIG_PM
+	.irq_set_wake	= s3c_irqext_wake,
+#endif
+};
+
+/*
+ * exynos4_irq_demux_eint
+ *
+ * This function demuxes the IRQ from from EINTs 16 to 31.
+ * It is designed to be inlined into the specific handler
+ * s5p_irq_demux_eintX_Y.
+ *
+ * Each EINT pend/mask registers handle eight of them.
+ */
+static inline void exynos4_irq_demux_eint(unsigned int start)
+{
+	unsigned int irq;
+
+	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
+	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
+
+	status &= ~mask;
+	status &= 0xff;
+
+	while (status) {
+		irq = fls(status) - 1;
+		generic_handle_irq(irq + start);
+		status &= ~(1 << irq);
+	}
+}
+
+static void exynos4_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_get_chip(irq);
+	chained_irq_enter(chip, desc);
+	exynos4_irq_demux_eint(IRQ_EINT(16));
+	exynos4_irq_demux_eint(IRQ_EINT(24));
+	chained_irq_exit(chip, desc);
+}
+
+static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
+{
+	u32 *irq_data = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_get_chip(irq);
+
+	chained_irq_enter(chip, desc);
+	chip->irq_mask(&desc->irq_data);
+
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
+	generic_handle_irq(*irq_data);
+
+	chip->irq_unmask(&desc->irq_data);
+	chained_irq_exit(chip, desc);
+}
+
+int __init exynos4_init_irq_eint(void)
+{
+	int irq;
+
+	for (irq = 0 ; irq <= 31 ; irq++) {
+		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos4_irq_eint,
+					 handle_level_irq);
+		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
+	}
+
+	irq_set_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
+
+	for (irq = 0 ; irq <= 15 ; irq++) {
+		eint0_15_data[irq] = IRQ_EINT(irq);
+
+		irq_set_handler_data(exynos4_get_irq_nr(irq),
+				     &eint0_15_data[irq]);
+		irq_set_chained_handler(exynos4_get_irq_nr(irq),
+					exynos4_irq_eint0_15);
+	}
+
+	return 0;
+}
+arch_initcall(exynos4_init_irq_eint);
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
new file mode 100644
index 0000000..0476c5f
--- /dev/null
+++ b/arch/arm/mach-exynos/common.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Header for EXYNOS machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
+#define __ARCH_ARM_MACH_EXYNOS_COMMON_H
+
+void exynos_init_io(struct map_desc *mach_desc, int size);
+void exynos4_init_irq(void);
+
+void exynos4_register_clocks(void);
+void exynos4_setup_clocks(void);
+
+void exynos4210_register_clocks(void);
+void exynos4212_register_clocks(void);
+
+extern struct sys_timer exynos4_timer;
+
+#ifdef CONFIG_ARCH_EXYNOS
+extern  int exynos_init(void);
+extern void exynos4_map_io(void);
+extern void exynos4_init_clocks(int xtal);
+extern void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+#else
+#define exynos4_init_clocks NULL
+#define exynos4_init_uarts NULL
+#define exynos4_map_io NULL
+#define exynos_init NULL
+#endif
+
+#endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
deleted file mode 100644
index 22316cb..0000000
--- a/arch/arm/mach-exynos/cpu.c
+++ /dev/null
@@ -1,284 +0,0 @@
-/* linux/arch/arm/mach-exynos/cpu.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/sched.h>
-#include <linux/sysdev.h>
-
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <asm/proc-fns.h>
-#include <asm/exception.h>
-#include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
-
-#include <plat/cpu.h>
-#include <plat/clock.h>
-#include <plat/devs.h>
-#include <plat/exynos4.h>
-#include <plat/adc-core.h>
-#include <plat/sdhci.h>
-#include <plat/fb-core.h>
-#include <plat/fimc-core.h>
-#include <plat/iic-core.h>
-#include <plat/reset.h>
-#include <plat/tv-core.h>
-
-#include <mach/regs-irq.h>
-#include <mach/regs-pmu.h>
-
-extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
-			 unsigned int irq_start);
-extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
-
-/* Initial IO mappings */
-static struct map_desc exynos_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
-		.pfn		= __phys_to_pfn(EXYNOS_PA_SYSTIMER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_PMU,
-		.pfn		= __phys_to_pfn(EXYNOS_PA_PMU),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
-		.pfn		= __phys_to_pfn(EXYNOS_PA_COMBINER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
-		.pfn		= __phys_to_pfn(EXYNOS_PA_GIC_CPU),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
-		.pfn		= __phys_to_pfn(EXYNOS_PA_GIC_DIST),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_UART,
-		.pfn		= __phys_to_pfn(S3C_PA_UART),
-		.length		= SZ_512K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc exynos4_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_CMU,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
-		.length		= SZ_128K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
-		.length		= SZ_8K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_L2CC,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_L2CC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GPIO1,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO1),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GPIO2,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO2),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GPIO3,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO3),
-		.length		= SZ_256,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_DMC0,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC0),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_SROMC,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_HSPHY),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc exynos4_iodesc0[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSRAM,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM0),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc exynos4_iodesc1[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSRAM,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM1),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static void exynos_idle(void)
-{
-	if (!need_resched())
-		cpu_do_idle();
-
-	local_irq_enable();
-}
-
-static void exynos4_sw_reset(void)
-{
-	__raw_writel(0x1, S5P_SWRESET);
-}
-
-/*
- * exynos_map_io
- *
- * register the standard cpu IO areas
- */
-void __init exynos4_map_io(void)
-{
-	iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
-	iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
-
-	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0)
-		iotable_init(exynos4_iodesc0, ARRAY_SIZE(exynos4_iodesc0));
-	else
-		iotable_init(exynos4_iodesc1, ARRAY_SIZE(exynos4_iodesc1));
-
-	/* initialize device information early */
-	exynos4_default_sdhci0();
-	exynos4_default_sdhci1();
-	exynos4_default_sdhci2();
-	exynos4_default_sdhci3();
-
-	s3c_adc_setname("samsung-adc-v3");
-
-	s3c_fimc_setname(0, "exynos4-fimc");
-	s3c_fimc_setname(1, "exynos4-fimc");
-	s3c_fimc_setname(2, "exynos4-fimc");
-	s3c_fimc_setname(3, "exynos4-fimc");
-
-	/* The I2C bus controllers are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c1_setname("s3c2440-i2c");
-	s3c_i2c2_setname("s3c2440-i2c");
-
-	s5p_fb_setname(0, "exynos4-fb");
-	s5p_hdmi_setname("exynos4-hdmi");
-}
-
-void __init exynos4_init_clocks(int xtal)
-{
-	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
-
-	s3c24xx_register_baseclocks(xtal);
-	s5p_register_clocks(xtal);
-
-	if (soc_is_exynos4210())
-		exynos4210_register_clocks();
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
-		exynos4212_register_clocks();
-
-	exynos4_register_clocks();
-	exynos4_setup_clocks();
-}
-
-void __init exynos4_init_irq(void)
-{
-	int irq;
-	unsigned int gic_bank_offset;
-
-	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
-
-	gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset);
-
-	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
-
-		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
-				COMBINER_IRQ(irq, 0));
-		combiner_cascade_irq(irq, IRQ_SPI(irq));
-	}
-
-	/* The parameters of s5p_init_irq() are for VIC init.
-	 * Theses parameters should be NULL and 0 because EXYNOS4
-	 * uses GIC instead of VIC.
-	 */
-	s5p_init_irq(NULL, 0);
-}
-
-struct sysdev_class exynos4_sysclass = {
-	.name	= "exynos4-core",
-};
-
-static struct sys_device exynos4_sysdev = {
-	.cls	= &exynos4_sysclass,
-};
-
-static int __init exynos4_core_init(void)
-{
-	return sysdev_class_register(&exynos4_sysclass);
-}
-core_initcall(exynos4_core_init);
-
-#ifdef CONFIG_CACHE_L2X0
-static int __init exynos4_l2x0_cache_init(void)
-{
-	/* TAG, Data Latency Control: 2cycle */
-	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
-
-	if (soc_is_exynos4210())
-		__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
-		__raw_writel(0x120, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-
-	/* L2X0 Prefetch Control */
-	__raw_writel(0x30000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
-
-	/* L2X0 Power Control */
-	__raw_writel(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN,
-		     S5P_VA_L2CC + L2X0_POWER_CTRL);
-
-	l2x0_init(S5P_VA_L2CC, 0x7C470001, 0xC200ffff);
-
-	return 0;
-}
-
-early_initcall(exynos4_l2x0_cache_init);
-#endif
-
-int __init exynos_init(void)
-{
-	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
-
-	/* set idle function */
-	pm_idle = exynos_idle;
-
-	/* set sw_reset function */
-	if (soc_is_exynos4210() || soc_is_exynos4212() || soc_is_exynos4412())
-		s5p_reset_hook = exynos4_sw_reset;
-
-	return sysdev_register(&exynos4_sysdev);
-}
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 058541d..d182986 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -149,7 +149,6 @@
 #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
 #define S3C_PA_UART			EXYNOS4_PA_UART
 
-#define S5P_PA_CHIPID			EXYNOS4_PA_CHIPID
 #define S5P_PA_EHCI			EXYNOS4_PA_EHCI
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
 #define S5P_PA_FIMC1			EXYNOS4_PA_FIMC1
@@ -166,26 +165,17 @@
 #define S5P_PA_ONENAND_DMA		EXYNOS4_PA_ONENAND_DMA
 #define S5P_PA_SDO			EXYNOS4_PA_SDO
 #define S5P_PA_SDRAM			EXYNOS4_PA_SDRAM
-#define S5P_PA_SROMC			EXYNOS4_PA_SROMC
-#define S5P_PA_SYSCON			EXYNOS4_PA_SYSCON
-#define S5P_PA_TIMER			EXYNOS4_PA_TIMER
 #define S5P_PA_VP			EXYNOS4_PA_VP
 
 #define SAMSUNG_PA_ADC			EXYNOS4_PA_ADC
 #define SAMSUNG_PA_ADC1			EXYNOS4_PA_ADC1
 #define SAMSUNG_PA_KEYPAD		EXYNOS4_PA_KEYPAD
 
-#define EXYNOS_PA_COMBINER		EXYNOS4_PA_COMBINER
-#define EXYNOS_PA_GIC_CPU		EXYNOS4_PA_GIC_CPU
-#define EXYNOS_PA_GIC_DIST		EXYNOS4_PA_GIC_DIST
-#define EXYNOS_PA_PMU			EXYNOS4_PA_PMU
-#define EXYNOS_PA_SYSTIMER		EXYNOS4_PA_SYSTIMER
-
 /* Compatibility UART */
 
 #define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 
-#define S5P_PA_UART(x)			(S3C_PA_UART + ((x) * S3C_UART_OFFSET))
+#define S5P_PA_UART(x)			(EXYNOS4_PA_UART + ((x) * S3C_UART_OFFSET))
 #define S5P_PA_UART0			S5P_PA_UART(0)
 #define S5P_PA_UART1			S5P_PA_UART(1)
 #define S5P_PA_UART2			S5P_PA_UART(2)
diff --git a/arch/arm/mach-exynos/init.c b/arch/arm/mach-exynos/init.c
deleted file mode 100644
index a8a83e3..0000000
--- a/arch/arm/mach-exynos/init.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/* linux/arch/arm/mach-exynos4/init.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/serial_core.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/regs-serial.h>
-
-static struct s3c24xx_uart_clksrc exynos4_serial_clocks[] = {
-	[0] = {
-		.name		= "uclk1",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
-/* uart registration process */
-void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->has_fracval = 1;
-			tcfg->clocks = exynos4_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(exynos4_serial_clocks);
-		}
-		tcfg->flags |= NO_NEED_CHECK_CLKSRC;
-	}
-
-	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
-}
diff --git a/arch/arm/mach-exynos/irq-combiner.c b/arch/arm/mach-exynos/irq-combiner.c
deleted file mode 100644
index 5a2758a..0000000
--- a/arch/arm/mach-exynos/irq-combiner.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/* linux/arch/arm/mach-exynos4/irq-combiner.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Based on arch/arm/common/gic.c
- *
- * IRQ COMBINER support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/io.h>
-
-#include <asm/mach/irq.h>
-
-#define COMBINER_ENABLE_SET	0x0
-#define COMBINER_ENABLE_CLEAR	0x4
-#define COMBINER_INT_STATUS	0xC
-
-static DEFINE_SPINLOCK(irq_controller_lock);
-
-struct combiner_chip_data {
-	unsigned int irq_offset;
-	unsigned int irq_mask;
-	void __iomem *base;
-};
-
-static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
-
-static inline void __iomem *combiner_base(struct irq_data *data)
-{
-	struct combiner_chip_data *combiner_data =
-		irq_data_get_irq_chip_data(data);
-
-	return combiner_data->base;
-}
-
-static void combiner_mask_irq(struct irq_data *data)
-{
-	u32 mask = 1 << (data->irq % 32);
-
-	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
-}
-
-static void combiner_unmask_irq(struct irq_data *data)
-{
-	u32 mask = 1 << (data->irq % 32);
-
-	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
-}
-
-static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
-{
-	struct combiner_chip_data *chip_data = irq_get_handler_data(irq);
-	struct irq_chip *chip = irq_get_chip(irq);
-	unsigned int cascade_irq, combiner_irq;
-	unsigned long status;
-
-	chained_irq_enter(chip, desc);
-
-	spin_lock(&irq_controller_lock);
-	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
-	spin_unlock(&irq_controller_lock);
-	status &= chip_data->irq_mask;
-
-	if (status == 0)
-		goto out;
-
-	combiner_irq = __ffs(status);
-
-	cascade_irq = combiner_irq + (chip_data->irq_offset & ~31);
-	if (unlikely(cascade_irq >= NR_IRQS))
-		do_bad_IRQ(cascade_irq, desc);
-	else
-		generic_handle_irq(cascade_irq);
-
- out:
-	chained_irq_exit(chip, desc);
-}
-
-static struct irq_chip combiner_chip = {
-	.name		= "COMBINER",
-	.irq_mask	= combiner_mask_irq,
-	.irq_unmask	= combiner_unmask_irq,
-};
-
-void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
-{
-	if (combiner_nr >= MAX_COMBINER_NR)
-		BUG();
-	if (irq_set_handler_data(irq, &combiner_data[combiner_nr]) != 0)
-		BUG();
-	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
-}
-
-void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
-			  unsigned int irq_start)
-{
-	unsigned int i;
-
-	if (combiner_nr >= MAX_COMBINER_NR)
-		BUG();
-
-	combiner_data[combiner_nr].base = base;
-	combiner_data[combiner_nr].irq_offset = irq_start;
-	combiner_data[combiner_nr].irq_mask = 0xff << ((combiner_nr % 4) << 3);
-
-	/* Disable all interrupts */
-
-	__raw_writel(combiner_data[combiner_nr].irq_mask,
-		     base + COMBINER_ENABLE_CLEAR);
-
-	/* Setup the Linux IRQ subsystem */
-
-	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
-				+ MAX_IRQ_IN_COMBINER; i++) {
-		irq_set_chip_and_handler(i, &combiner_chip, handle_level_irq);
-		irq_set_chip_data(i, &combiner_data[combiner_nr]);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-	}
-}
diff --git a/arch/arm/mach-exynos/irq-eint.c b/arch/arm/mach-exynos/irq-eint.c
deleted file mode 100644
index badb8c6..0000000
--- a/arch/arm/mach-exynos/irq-eint.c
+++ /dev/null
@@ -1,237 +0,0 @@
-/* linux/arch/arm/mach-exynos4/irq-eint.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - IRQ EINT support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/sysdev.h>
-#include <linux/gpio.h>
-
-#include <plat/pm.h>
-#include <plat/cpu.h>
-#include <plat/gpio-cfg.h>
-
-#include <mach/regs-gpio.h>
-
-#include <asm/mach/irq.h>
-
-static DEFINE_SPINLOCK(eint_lock);
-
-static unsigned int eint0_15_data[16];
-
-static unsigned int exynos4_get_irq_nr(unsigned int number)
-{
-	u32 ret = 0;
-
-	switch (number) {
-	case 0 ... 3:
-		ret = (number + IRQ_EINT0);
-		break;
-	case 4 ... 7:
-		ret = (number + (IRQ_EINT4 - 4));
-		break;
-	case 8 ... 15:
-		ret = (number + (IRQ_EINT8 - 8));
-		break;
-	default:
-		printk(KERN_ERR "number available : %d\n", number);
-	}
-
-	return ret;
-}
-
-static inline void exynos4_irq_eint_mask(struct irq_data *data)
-{
-	u32 mask;
-
-	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	mask |= eint_irq_to_bit(data->irq);
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	spin_unlock(&eint_lock);
-}
-
-static void exynos4_irq_eint_unmask(struct irq_data *data)
-{
-	u32 mask;
-
-	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	mask &= ~(eint_irq_to_bit(data->irq));
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	spin_unlock(&eint_lock);
-}
-
-static inline void exynos4_irq_eint_ack(struct irq_data *data)
-{
-	__raw_writel(eint_irq_to_bit(data->irq),
-		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
-}
-
-static void exynos4_irq_eint_maskack(struct irq_data *data)
-{
-	exynos4_irq_eint_mask(data);
-	exynos4_irq_eint_ack(data);
-}
-
-static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
-{
-	int offs = EINT_OFFSET(data->irq);
-	int shift;
-	u32 ctrl, mask;
-	u32 newvalue = 0;
-
-	switch (type) {
-	case IRQ_TYPE_EDGE_RISING:
-		newvalue = S5P_IRQ_TYPE_EDGE_RISING;
-		break;
-
-	case IRQ_TYPE_EDGE_FALLING:
-		newvalue = S5P_IRQ_TYPE_EDGE_FALLING;
-		break;
-
-	case IRQ_TYPE_EDGE_BOTH:
-		newvalue = S5P_IRQ_TYPE_EDGE_BOTH;
-		break;
-
-	case IRQ_TYPE_LEVEL_LOW:
-		newvalue = S5P_IRQ_TYPE_LEVEL_LOW;
-		break;
-
-	case IRQ_TYPE_LEVEL_HIGH:
-		newvalue = S5P_IRQ_TYPE_LEVEL_HIGH;
-		break;
-
-	default:
-		printk(KERN_ERR "No such irq type %d", type);
-		return -EINVAL;
-	}
-
-	shift = (offs & 0x7) * 4;
-	mask = 0x7 << shift;
-
-	spin_lock(&eint_lock);
-	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(data->irq)));
-	ctrl &= ~mask;
-	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(data->irq)));
-	spin_unlock(&eint_lock);
-
-	switch (offs) {
-	case 0 ... 7:
-		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
-		break;
-	case 8 ... 15:
-		s3c_gpio_cfgpin(EINT_GPIO_1(offs & 0x7), EINT_MODE);
-		break;
-	case 16 ... 23:
-		s3c_gpio_cfgpin(EINT_GPIO_2(offs & 0x7), EINT_MODE);
-		break;
-	case 24 ... 31:
-		s3c_gpio_cfgpin(EINT_GPIO_3(offs & 0x7), EINT_MODE);
-		break;
-	default:
-		printk(KERN_ERR "No such irq number %d", offs);
-	}
-
-	return 0;
-}
-
-static struct irq_chip exynos4_irq_eint = {
-	.name		= "exynos4-eint",
-	.irq_mask	= exynos4_irq_eint_mask,
-	.irq_unmask	= exynos4_irq_eint_unmask,
-	.irq_mask_ack	= exynos4_irq_eint_maskack,
-	.irq_ack	= exynos4_irq_eint_ack,
-	.irq_set_type	= exynos4_irq_eint_set_type,
-#ifdef CONFIG_PM
-	.irq_set_wake	= s3c_irqext_wake,
-#endif
-};
-
-/* exynos4_irq_demux_eint
- *
- * This function demuxes the IRQ from from EINTs 16 to 31.
- * It is designed to be inlined into the specific handler
- * s5p_irq_demux_eintX_Y.
- *
- * Each EINT pend/mask registers handle eight of them.
- */
-static inline void exynos4_irq_demux_eint(unsigned int start)
-{
-	unsigned int irq;
-
-	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
-	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
-
-	status &= ~mask;
-	status &= 0xff;
-
-	while (status) {
-		irq = fls(status) - 1;
-		generic_handle_irq(irq + start);
-		status &= ~(1 << irq);
-	}
-}
-
-static void exynos4_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_get_chip(irq);
-	chained_irq_enter(chip, desc);
-	exynos4_irq_demux_eint(IRQ_EINT(16));
-	exynos4_irq_demux_eint(IRQ_EINT(24));
-	chained_irq_exit(chip, desc);
-}
-
-static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
-{
-	u32 *irq_data = irq_get_handler_data(irq);
-	struct irq_chip *chip = irq_get_chip(irq);
-
-	chained_irq_enter(chip, desc);
-	chip->irq_mask(&desc->irq_data);
-
-	if (chip->irq_ack)
-		chip->irq_ack(&desc->irq_data);
-
-	generic_handle_irq(*irq_data);
-
-	chip->irq_unmask(&desc->irq_data);
-	chained_irq_exit(chip, desc);
-}
-
-int __init exynos4_init_irq_eint(void)
-{
-	int irq;
-
-	for (irq = 0 ; irq <= 31 ; irq++) {
-		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos4_irq_eint,
-					 handle_level_irq);
-		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
-	}
-
-	irq_set_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
-
-	for (irq = 0 ; irq <= 15 ; irq++) {
-		eint0_15_data[irq] = IRQ_EINT(irq);
-
-		irq_set_handler_data(exynos4_get_irq_nr(irq),
-				     &eint0_15_data[irq]);
-		irq_set_chained_handler(exynos4_get_irq_nr(irq),
-					exynos4_irq_eint0_15);
-	}
-
-	return 0;
-}
-
-arch_initcall(exynos4_init_irq_eint);
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 49da308..b1807c4 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -21,7 +21,6 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
-#include <plat/exynos4.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
@@ -29,6 +28,8 @@
 
 #include <mach/map.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define ARMLEX4210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -188,7 +189,7 @@ static void __init armlex4210_smsc911x_init(void)
 
 static void __init armlex4210_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(armlex4210_uartcfgs,
 			   ARRAY_SIZE(armlex4210_uartcfgs));
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 5acec11..a6ecdbc 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -38,7 +38,6 @@
 #include <plat/adc.h>
 #include <plat/regs-fb-v4.h>
 #include <plat/regs-serial.h>
-#include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
@@ -55,6 +54,8 @@
 
 #include <mach/map.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define NURI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -1284,7 +1285,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 
 static void __init nuri_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(nuri_uartcfgs, ARRAY_SIZE(nuri_uartcfgs));
 }
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 5561b06..ea35806 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -29,7 +29,6 @@
 
 #include <plat/regs-serial.h>
 #include <plat/regs-fb-v4.h>
-#include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
@@ -44,6 +43,8 @@
 
 #include <mach/map.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define ORIGEN_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -639,7 +640,7 @@ static void s5p_tv_setup(void)
 
 static void __init origen_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(origen_uartcfgs, ARRAY_SIZE(origen_uartcfgs));
 }
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index 722d82d..3b1a9f0 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -28,7 +28,6 @@
 #include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
-#include <plat/exynos4.h>
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
 #include <plat/keypad.h>
@@ -37,6 +36,8 @@
 
 #include <mach/map.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDK4X12_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -250,7 +251,7 @@ static void __init smdk4x12_map_io(void)
 {
 	clk_xusbxti.rate = 24000000;
 
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(clk_xusbxti.rate);
 	s3c24xx_init_uarts(smdk4x12_uartcfgs, ARRAY_SIZE(smdk4x12_uartcfgs));
 }
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index edc60b6..c9e331e 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -28,7 +28,6 @@
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
 #include <plat/regs-fb-v4.h>
-#include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
@@ -44,6 +43,8 @@
 
 #include <mach/map.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -333,7 +334,7 @@ static void s5p_tv_setup(void)
 
 static void __init smdkv310_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkv310_uartcfgs, ARRAY_SIZE(smdkv310_uartcfgs));
 }
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index cfc7d50..7066f12 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -28,7 +28,6 @@
 #include <asm/mach-types.h>
 
 #include <plat/regs-serial.h>
-#include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/iic.h>
@@ -48,6 +47,8 @@
 #include <media/s5p_fimc.h>
 #include <media/m5mols.h>
 
+#include "common.h"
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define UNIVERSAL_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -993,7 +994,7 @@ static struct platform_device *universal_devices[] __initdata = {
 
 static void __init universal_map_io(void)
 {
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
 }
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 8763440..30d8c30 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -13,7 +13,6 @@ obj-				:=
 # Core files
 
 obj-y				+= dev-uart.o
-obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
deleted file mode 100644
index 63c3fad..0000000
--- a/arch/arm/plat-s5p/cpu.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/* linux/arch/arm/plat-s5p/cpu.c
- *
- * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5P CPU Support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-
-#include <plat/cpu.h>
-#include <plat/exynos4.h>
-
-/* table of supported CPUs */
-
-static const char name_exynos4210[] = "EXYNOS4210";
-static const char name_exynos4212[] = "EXYNOS4212";
-static const char name_exynos4412[] = "EXYNOS4412";
-
-static struct cpu_table cpu_ids[] __initdata = {
-	{
-		.idcode		= EXYNOS4210_CPU_ID,
-		.idmask		= EXYNOS4_CPU_MASK,
-		.map_io		= exynos4_map_io,
-		.init_clocks	= exynos4_init_clocks,
-		.init_uarts	= exynos4_init_uarts,
-		.init		= exynos_init,
-		.name		= name_exynos4210,
-	}, {
-		.idcode		= EXYNOS4212_CPU_ID,
-		.idmask		= EXYNOS4_CPU_MASK,
-		.map_io		= exynos4_map_io,
-		.init_clocks	= exynos4_init_clocks,
-		.init_uarts	= exynos4_init_uarts,
-		.init		= exynos_init,
-		.name		= name_exynos4212,
-	}, {
-		.idcode		= EXYNOS4412_CPU_ID,
-		.idmask		= EXYNOS4_CPU_MASK,
-		.map_io		= exynos4_map_io,
-		.init_clocks	= exynos4_init_clocks,
-		.init_uarts	= exynos4_init_uarts,
-		.init		= exynos_init,
-		.name		= name_exynos4412,
-	},
-};
-
-/* minimal IO mapping */
-
-static struct map_desc s5p_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_CHIPID,
-		.pfn		= __phys_to_pfn(S5P_PA_CHIPID),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_SYS,
-		.pfn		= __phys_to_pfn(S5P_PA_SYSCON),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_TIMER,
-		.pfn		= __phys_to_pfn(S5P_PA_TIMER),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
-		.pfn		= __phys_to_pfn(S3C_PA_WDT),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_SROMC,
-		.pfn		= __phys_to_pfn(S5P_PA_SROMC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-/* read cpu identification code */
-
-void __init s5p_init_io(struct map_desc *mach_desc,
-			int size, void __iomem *cpuid_addr)
-{
-	/* initialize the io descriptors we need for initialization */
-	iotable_init(s5p_iodesc, ARRAY_SIZE(s5p_iodesc));
-	if (mach_desc)
-		iotable_init(mach_desc, size);
-
-	/* detect cpu id and rev. */
-	s5p_init_cpu(cpuid_addr);
-
-	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
-}
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index abbdadb..258d9d8 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -155,8 +155,6 @@ extern void s3c24xx_init_irq(void);
 extern void s5p_init_irq(u32 *vic, u32 num_vic);
 
 extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
-extern void s5p_init_io(struct map_desc *mach_desc,
-			int size, void __iomem *cpuid_addr);
 
 extern void s3c24xx_init_cpu(void);
 extern void s3c64xx_init_cpu(void);
diff --git a/arch/arm/plat-samsung/include/plat/exynos4.h b/arch/arm/plat-samsung/include/plat/exynos4.h
deleted file mode 100644
index f546e88..0000000
--- a/arch/arm/plat-samsung/include/plat/exynos4.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/exynos4.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Header file for exynos4 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* Common init code for EXYNOS4 related SoCs */
-
-extern void exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void exynos4_register_clocks(void);
-extern void exynos4210_register_clocks(void);
-extern void exynos4212_register_clocks(void);
-extern void exynos4_setup_clocks(void);
-
-#ifdef CONFIG_ARCH_EXYNOS
-extern  int exynos_init(void);
-extern void exynos4_init_irq(void);
-extern void exynos4_map_io(void);
-extern void exynos4_init_clocks(int xtal);
-extern struct sys_timer exynos4_timer;
-
-#define exynos4_init_uarts exynos4_common_init_uarts
-
-#else
-#define exynos4_init_clocks NULL
-#define exynos4_init_uarts NULL
-#define exynos4_map_io NULL
-#define exynos_init NULL
-#endif
-- 
1.7.4.4
