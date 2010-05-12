From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:57 +0100
Subject: [PATCH 06/15] ARM: S3C2416: Add arch support
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

Add arch/arm/mach-s3c2416 for support of the Samsung S3C2416 SoC.

This patch adds support of the S3C2416 SoC, clocks, timers,
and initial IRQ support (without support of secondary set of registers).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
[ben-linux at fluff.org: removed files to be reworked, fixed conflicts]
[ben-linux at fluff.org: use s3c2443 reset instead of specific reset code]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig                             |    3 +-
 arch/arm/Makefile                            |    2 +-
 arch/arm/mach-s3c2412/Kconfig                |    3 +-
 arch/arm/mach-s3c2416/Kconfig                |   25 +++
 arch/arm/mach-s3c2416/Makefile               |   18 ++
 arch/arm/mach-s3c2416/irq.c                  |  254 ++++++++++++++++++++++++++
 arch/arm/mach-s3c2416/s3c2416.c              |  115 ++++++++++++
 arch/arm/plat-s3c24xx/cpu.c                  |   13 ++
 arch/arm/plat-s3c24xx/include/plat/s3c2416.h |   31 +++
 arch/arm/plat-samsung/include/plat/cpu.h     |    1 +
 10 files changed, 462 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-s3c2416/Kconfig
 create mode 100644 arch/arm/mach-s3c2416/Makefile
 create mode 100644 arch/arm/mach-s3c2416/irq.c
 create mode 100644 arch/arm/mach-s3c2416/s3c2416.c
 create mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2416.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92622eb..6785c33 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -647,7 +647,7 @@ config ARCH_SA1100
 	  Support for StrongARM 11x0 based boards.
 
 config ARCH_S3C2410
-	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2440, S3C2442, S3C2443"
+	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443"
 	select GENERIC_GPIO
 	select ARCH_HAS_CPUFREQ
 	select HAVE_CLK
@@ -892,6 +892,7 @@ if ARCH_S3C2410
 source "arch/arm/mach-s3c2400/Kconfig"
 source "arch/arm/mach-s3c2410/Kconfig"
 source "arch/arm/mach-s3c2412/Kconfig"
+source "arch/arm/mach-s3c2416/Kconfig"
 source "arch/arm/mach-s3c2440/Kconfig"
 source "arch/arm/mach-s3c2443/Kconfig"
 endif
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ed820e7..1594739 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -160,7 +160,7 @@ machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
-machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2443
+machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2416 s3c2440 s3c2443
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index 9a8c065..cef6a65 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -16,7 +16,8 @@ config CPU_S3C2412
 config CPU_S3C2412_ONLY
 	bool
 	depends on ARCH_S3C2410 && !CPU_S3C2400 && !CPU_S3C2410 && \
-		   !CPU_S3C2440 && !CPU_S3C2442 && !CPU_S3C2443 && CPU_S3C2412
+		   !CPU_2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
+		   !CPU_S3C2443 && CPU_S3C2412
 	default y if CPU_S3C2412
 
 config S3C2412_DMA
diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
new file mode 100644
index 0000000..cc320f6
--- /dev/null
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -0,0 +1,25 @@
+# arch/arm/mach-s3c2416/Kconfig
+#
+# Copyright 2009 Yauhen Kharuzhy <jekhor@gmail.com>
+#
+# Licensed under GPLv2
+
+config CPU_S3C2416
+	bool
+	depends on ARCH_S3C2410
+	select CPU_ARM926T
+	select S3C2416_DMA if S3C2410_DMA
+	select CPU_LLSERIAL_S3C2440
+	help
+	  Support for the S3C2416 SoC from the S3C24XX line
+
+config S3C2416_DMA
+	bool
+	depends on CPU_S3C2416
+	help
+	  Internal config node for S3C2416 DMA support
+
+menu "S3C2416 Machines"
+
+
+endmenu
diff --git a/arch/arm/mach-s3c2416/Makefile b/arch/arm/mach-s3c2416/Makefile
new file mode 100644
index 0000000..34bb70d
--- /dev/null
+++ b/arch/arm/mach-s3c2416/Makefile
@@ -0,0 +1,18 @@
+# arch/arm/mach-s3c2416/Makefile
+#
+# Copyright 2009 Yauhen Kharuzhy <jekhor@gmail.com>
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o
+obj-$(CONFIG_CPU_S3C2416)	+= irq.o
+
+#obj-$(CONFIG_S3C2416_DMA)	+= dma.o
+
+# Machine support
+
diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
new file mode 100644
index 0000000..89f521d
--- /dev/null
+++ b/arch/arm/mach-s3c2416/irq.c
@@ -0,0 +1,254 @@
+/* linux/arch/arm/mach-s3c2416/irq.c
+ *
+ * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
+ *	as part of OpenInkpot project
+ * Copyright (c) 2009 Promwad Innovation Company
+ *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
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
+ *
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <asm/irq.h>
+
+#include <asm/mach/irq.h>
+
+#include <mach/regs-irq.h>
+#include <mach/regs-gpio.h>
+
+#include <plat/cpu.h>
+#include <plat/pm.h>
+#include <plat/irq.h>
+
+#define INTMSK(start, end) ((1 << ((end) + 1 - (start))) - 1)
+
+static inline void s3c2416_irq_demux(unsigned int irq, unsigned int len)
+{
+	unsigned int subsrc, submsk;
+	unsigned int end;
+
+	/* read the current pending interrupts, and the mask
+	 * for what it is available */
+
+	subsrc = __raw_readl(S3C2410_SUBSRCPND);
+	submsk = __raw_readl(S3C2410_INTSUBMSK);
+
+	subsrc  &= ~submsk;
+	subsrc >>= (irq - S3C2410_IRQSUB(0));
+	subsrc  &= (1 << len)-1;
+
+	end = len + irq;
+
+	for (; irq < end && subsrc; irq++) {
+		if (subsrc & 1)
+			generic_handle_irq(irq);
+
+		subsrc >>= 1;
+	}
+}
+
+/* WDT/AC97 sub interrupts */
+
+static void s3c2416_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_WDT, 4);
+}
+
+#define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
+#define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
+
+static void s3c2416_irq_wdtac97_mask(unsigned int irqno)
+{
+	s3c_irqsub_mask(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+}
+
+static void s3c2416_irq_wdtac97_unmask(unsigned int irqno)
+{
+	s3c_irqsub_unmask(irqno, INTMSK_WDTAC97);
+}
+
+static void s3c2416_irq_wdtac97_ack(unsigned int irqno)
+{
+	s3c_irqsub_maskack(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+}
+
+static struct irq_chip s3c2416_irq_wdtac97 = {
+	.mask	    = s3c2416_irq_wdtac97_mask,
+	.unmask	    = s3c2416_irq_wdtac97_unmask,
+	.ack	    = s3c2416_irq_wdtac97_ack,
+};
+
+
+/* LCD sub interrupts */
+
+static void s3c2416_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_LCD1, 4);
+}
+
+#define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
+#define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
+
+static void s3c2416_irq_lcd_mask(unsigned int irqno)
+{
+	s3c_irqsub_mask(irqno, INTMSK_LCD, SUBMSK_LCD);
+}
+
+static void s3c2416_irq_lcd_unmask(unsigned int irqno)
+{
+	s3c_irqsub_unmask(irqno, INTMSK_LCD);
+}
+
+static void s3c2416_irq_lcd_ack(unsigned int irqno)
+{
+	s3c_irqsub_maskack(irqno, INTMSK_LCD, SUBMSK_LCD);
+}
+
+static struct irq_chip s3c2416_irq_lcd = {
+	.mask	    = s3c2416_irq_lcd_mask,
+	.unmask	    = s3c2416_irq_lcd_unmask,
+	.ack	    = s3c2416_irq_lcd_ack,
+};
+
+
+/* DMA sub interrupts */
+
+static void s3c2416_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_DMA0, 6);
+}
+
+#define INTMSK_DMA	(1UL << (IRQ_S3C2443_DMA - IRQ_EINT0))
+#define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
+
+
+static void s3c2416_irq_dma_mask(unsigned int irqno)
+{
+	s3c_irqsub_mask(irqno, INTMSK_DMA, SUBMSK_DMA);
+}
+
+static void s3c2416_irq_dma_unmask(unsigned int irqno)
+{
+	s3c_irqsub_unmask(irqno, INTMSK_DMA);
+}
+
+static void s3c2416_irq_dma_ack(unsigned int irqno)
+{
+	s3c_irqsub_maskack(irqno, INTMSK_DMA, SUBMSK_DMA);
+}
+
+static struct irq_chip s3c2416_irq_dma = {
+	.mask	    = s3c2416_irq_dma_mask,
+	.unmask	    = s3c2416_irq_dma_unmask,
+	.ack	    = s3c2416_irq_dma_ack,
+};
+
+
+/* UART3 sub interrupts */
+
+static void s3c2416_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_UART3, 3);
+}
+
+#define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
+#define SUBMSK_UART3	(0xf << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
+
+
+static void s3c2416_irq_uart3_mask(unsigned int irqno)
+{
+	s3c_irqsub_mask(irqno, INTMSK_UART3, SUBMSK_UART3);
+}
+
+static void s3c2416_irq_uart3_unmask(unsigned int irqno)
+{
+	s3c_irqsub_unmask(irqno, INTMSK_UART3);
+}
+
+static void s3c2416_irq_uart3_ack(unsigned int irqno)
+{
+	s3c_irqsub_maskack(irqno, INTMSK_UART3, SUBMSK_UART3);
+}
+
+static struct irq_chip s3c2416_irq_uart3 = {
+	.mask	    = s3c2416_irq_uart3_mask,
+	.unmask	    = s3c2416_irq_uart3_unmask,
+	.ack	    = s3c2416_irq_uart3_ack,
+};
+
+
+/* IRQ initialisation code */
+
+static int __init s3c2416_add_sub(unsigned int base,
+				   void (*demux)(unsigned int,
+						 struct irq_desc *),
+				   struct irq_chip *chip,
+				   unsigned int start, unsigned int end)
+{
+	unsigned int irqno;
+
+	set_irq_chip(base, &s3c_irq_level_chip);
+	set_irq_handler(base, handle_level_irq);
+	set_irq_chained_handler(base, demux);
+
+	for (irqno = start; irqno <= end; irqno++) {
+		set_irq_chip(irqno, chip);
+		set_irq_handler(irqno, handle_level_irq);
+		set_irq_flags(irqno, IRQF_VALID);
+	}
+
+	return 0;
+}
+
+static int __init s3c2416_irq_add(struct sys_device *sysdev)
+{
+	printk(KERN_INFO "S3C2416: IRQ Support\n");
+
+	s3c2416_add_sub(IRQ_LCD, s3c2416_irq_demux_lcd, &s3c2416_irq_lcd,
+			IRQ_S3C2443_LCD2, IRQ_S3C2443_LCD4);
+
+	s3c2416_add_sub(IRQ_S3C2443_DMA, s3c2416_irq_demux_dma,
+			&s3c2416_irq_dma, IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5);
+
+	s3c2416_add_sub(IRQ_S3C2443_UART3, s3c2416_irq_demux_uart3,
+			&s3c2416_irq_uart3,
+			IRQ_S3C2443_RX3, IRQ_S3C2443_ERR3);
+
+	s3c2416_add_sub(IRQ_WDT, s3c2416_irq_demux_wdtac97,
+			&s3c2416_irq_wdtac97,
+			IRQ_S3C2443_WDT, IRQ_S3C2443_AC97);
+
+	return 0;
+}
+
+static struct sysdev_driver s3c2416_irq_driver = {
+	.add		= s3c2416_irq_add,
+};
+
+static int __init s3c2416_irq_init(void)
+{
+	return sysdev_driver_register(&s3c2416_sysclass, &s3c2416_irq_driver);
+}
+
+arch_initcall(s3c2416_irq_init);
+
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
new file mode 100644
index 0000000..6165dc7
--- /dev/null
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -0,0 +1,115 @@
+/* linux/arch/arm/mach-s3c2416/s3c2416.c
+ *
+ * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
+ *	as part of OpenInkpot project
+ * Copyright (c) 2009 Promwad Innovation Company
+ *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
+ *
+ * Samsung S3C2416 Mobile CPU support
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
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+#include <linux/sysdev.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <asm/proc-fns.h>
+#include <asm/irq.h>
+
+#include <mach/reset.h>
+#include <mach/idle.h>
+#include <mach/regs-s3c2443-clock.h>
+
+#include <plat/s3c2416.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+static struct map_desc s3c2416_iodesc[] __initdata = {
+	IODESC_ENT(WATCHDOG),
+	IODESC_ENT(CLKPWR),
+	IODESC_ENT(TIMER),
+};
+
+struct sysdev_class s3c2416_sysclass = {
+	.name = "s3c2416-core",
+};
+
+static struct sys_device s3c2416_sysdev = {
+	.cls		= &s3c2416_sysclass,
+};
+
+static void s3c2416_hard_reset(void)
+{
+	__raw_writel(S3C2443_SWRST_RESET, S3C2443_SWRST);
+}
+
+int __init s3c2416_init(void)
+{
+	printk(KERN_INFO "S3C2416: Initializing architecture\n");
+
+	s3c24xx_reset_hook = s3c2416_hard_reset;
+	/* s3c24xx_idle = s3c2416_idle;	*/
+
+	/* change WDT IRQ number */
+	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
+	s3c_device_wdt.resource[1].end   = IRQ_S3C2443_WDT;
+
+	return sysdev_register(&s3c2416_sysdev);
+}
+
+void __init s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	s3c24xx_init_uartdevs("s3c2440-uart", s3c2410_uart_resources, cfg, no);
+
+	s3c_device_nand.name = "s3c2416-nand";
+}
+
+/* s3c2416_map_io
+ *
+ * register the standard cpu IO areas, and any passed in from the
+ * machine specific initialisation.
+ */
+
+void __init s3c2416_map_io(void)
+{
+	iotable_init(s3c2416_iodesc, ARRAY_SIZE(s3c2416_iodesc));
+}
+
+/* need to register class before we actually register the device, and
+ * we also need to ensure that it has been initialised before any of the
+ * drivers even try to use it (even if not on an s3c2416 based system)
+ * as a driver which may support both 2443 and 2440 may try and use it.
+*/
+
+static int __init s3c2416_core_init(void)
+{
+	return sysdev_class_register(&s3c2416_sysclass);
+}
+
+core_initcall(s3c2416_core_init);
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 9ca64df..494f4f3 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -49,6 +49,7 @@
 #include <plat/s3c2400.h>
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
+#include <plat/s3c2416.h>
 #include <plat/s3c244x.h>
 #include <plat/s3c2443.h>
 
@@ -57,6 +58,7 @@
 static const char name_s3c2400[]  = "S3C2400";
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2412[]  = "S3C2412";
+static const char name_s3c2416[]  = "S3C2416";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2442[]  = "S3C2442";
 static const char name_s3c2442b[]  = "S3C2442B";
@@ -137,6 +139,15 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s3c2412_init,
 		.name		= name_s3c2412,
 	},
+	{			/* a strange version of the s3c2416 */
+		.idcode		= 0x32450003,
+		.idmask		= 0xffffffff,
+		.map_io		= s3c2416_map_io,
+		.init_clocks	= s3c2416_init_clocks,
+		.init_uarts	= s3c2416_init_uarts,
+		.init		= s3c2416_init,
+		.name		= name_s3c2416,
+	},
 	{
 		.idcode		= 0x32443001,
 		.idmask		= 0xffffffff,
@@ -172,6 +183,8 @@ static unsigned long s3c24xx_read_idcode_v5(void)
 {
 #if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
 	return __raw_readl(S3C2412_GSTATUS1);
+#elif defined(CONFIG_CPU_S3C2416)
+	return __raw_readl(S3C24XX_GSTATUS1);
 #else
 	return 1UL;	/* don't look like an 2400 */
 #endif
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2416.h b/arch/arm/plat-s3c24xx/include/plat/s3c2416.h
new file mode 100644
index 0000000..dc3c090
--- /dev/null
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c2416.h
@@ -0,0 +1,31 @@
+/* linux/include/asm-arm/plat-s3c24xx/s3c2443.h
+ *
+ * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>
+ *
+ * Header file for s3c2416 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifdef CONFIG_CPU_S3C2416
+
+struct s3c2410_uartcfg;
+
+extern  int s3c2416_init(void);
+
+extern void s3c2416_map_io(void);
+
+extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2416_init_clocks(int xtal);
+
+extern  int s3c2416_baseclk_add(void);
+
+#else
+#define s3c2416_init_clocks NULL
+#define s3c2416_init_uarts NULL
+#define s3c2416_map_io NULL
+#define s3c2416_init NULL
+#endif
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index d316b4a..5dbeb79 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -73,6 +73,7 @@ extern struct sys_timer s3c24xx_timer;
 extern struct sysdev_class s3c2410_sysclass;
 extern struct sysdev_class s3c2410a_sysclass;
 extern struct sysdev_class s3c2412_sysclass;
+extern struct sysdev_class s3c2416_sysclass;
 extern struct sysdev_class s3c2440_sysclass;
 extern struct sysdev_class s3c2442_sysclass;
 extern struct sysdev_class s3c2443_sysclass;
-- 
1.6.3.3
