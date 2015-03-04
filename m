From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:09 +0100
Subject: [RFC PATCH 15/18] ARM: msm: clean up irq handling
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a preparation for multiplatform support, we need to
enable SPARSE_IRQ and MULTI_IRQ_HANDLER, as well as removing
the shared mach/irqs.h file.

This replaces all uses of the irqs.h header with proper
soc-specific versions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                             |  2 ++
 arch/arm/mach-msm/board-halibut.c            |  7 +++---
 arch/arm/mach-msm/board-msm7x30.c            |  5 +++-
 arch/arm/mach-msm/board-qsd8x50.c            |  5 ++--
 arch/arm/mach-msm/board-trout-gpio.c         |  7 +++---
 arch/arm/mach-msm/board-trout-mmc.c          |  1 +
 arch/arm/mach-msm/board-trout.c              |  2 ++
 arch/arm/mach-msm/devices-msm7x00.c          |  2 +-
 arch/arm/mach-msm/devices-msm7x30.c          |  2 +-
 arch/arm/mach-msm/devices-qsd8x50.c          |  2 +-
 arch/arm/mach-msm/include/mach/entry-macro.S | 36 ---------------------------
 arch/arm/mach-msm/include/mach/irqs-7x00.h   |  3 +++
 arch/arm/mach-msm/include/mach/irqs-7x30.h   |  2 ++
 arch/arm/mach-msm/include/mach/irqs-8x50.h   |  2 ++
 arch/arm/mach-msm/include/mach/irqs.h        | 37 ----------------------------
 arch/arm/mach-msm/irq-vic.c                  | 24 ++++++++++++++++++
 arch/arm/mach-msm/irq.c                      | 25 +++++++++++++++++++
 17 files changed, 79 insertions(+), 85 deletions(-)
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 78f561c32eab..ef94bccbe137 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -559,6 +559,8 @@ config ARCH_MSM
 	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 	help
 	  Support for Qualcomm MSM/QSD based systems.  This runs on the
 	  apps processor of the MSM/QSD and depends on a shared memory
diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 106a2fd23017..15fd63e88018 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -28,7 +28,7 @@
 #include <asm/mach/flash.h>
 #include <asm/setup.h>
 
-#include <mach/irqs.h>
+#include <mach/irqs-7x00.h>
 #include <mach/msm_iomap-7x00.h>
 
 #include <linux/mtd/nand.h>
@@ -44,8 +44,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= MSM_GPIO_TO_INT(49),
-		.end	= MSM_GPIO_TO_INT(49),
+		.start	= MSM7X00_GPIO_TO_INT(49),
+		.end	= MSM7X00_GPIO_TO_INT(49),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -90,6 +90,7 @@ static void __init halibut_map_io(void)
 
 MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
 	.atag_offset	= 0x100,
+	.nr_irqs	= MSM7X00_NR_IRQS,
 	.map_io		= halibut_map_io,
 	.init_early	= halibut_init_early,
 	.init_irq	= halibut_init_irq,
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 95e0cdde23a7..e0eb8cf9c53c 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -134,7 +134,7 @@ static struct platform_device *devices[] __initdata = {
 };
 
 #define SMSM_FAKE_IRQ (0xff)
-static uint8_t msm_irq_to_smsm[NR_IRQS] = {
+static uint8_t msm_irq_to_smsm[MSM7X30_NR_IRQS] = {
 	[INT_MDDI_EXT] = 1,
 	[INT_MDDI_PRI] = 2,
 	[INT_MDDI_CLIENT] = 3,
@@ -208,6 +208,7 @@ static void __init msm7x30_map_io(void)
 
 MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 	.atag_offset = 0x100,
+	.nr_irqs = MSM7X30_NR_IRQS,
 	.fixup = msm7x30_fixup,
 	.reserve = msm7x30_reserve,
 	.map_io = msm7x30_map_io,
@@ -218,6 +219,7 @@ MACHINE_END
 
 MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
 	.atag_offset = 0x100,
+	.nr_irqs = MSM7X30_NR_IRQS,
 	.fixup = msm7x30_fixup,
 	.reserve = msm7x30_reserve,
 	.map_io = msm7x30_map_io,
@@ -228,6 +230,7 @@ MACHINE_END
 
 MACHINE_START(MSM7X30_FLUID, "QCT MSM7X30 FLUID")
 	.atag_offset = 0x100,
+	.nr_irqs = MSM7X30_NR_IRQS,
 	.fixup = msm7x30_fixup,
 	.reserve = msm7x30_reserve,
 	.map_io = msm7x30_map_io,
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 9b7cd93541f9..14c3c240fc44 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -28,7 +28,7 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
-#include <mach/irqs.h>
+#include <mach/irqs-8x50.h>
 #include <mach/sirc.h>
 #include <mach/vreg.h>
 #include <mach/clk.h>
@@ -222,7 +222,7 @@ static void __init qsd8x50_init_mmc(void)
 }
 
 #define SMSM_FAKE_IRQ (0xff)
-static uint8_t msm_irq_to_smsm[NR_IRQS] = {
+static uint8_t msm_irq_to_smsm[QSD8X50_NR_IRQS] = {
 	[INT_MDDI_EXT] = 1,
 	[INT_MDDI_PRI] = 2,
 	[INT_MDDI_CLIENT] = 3,
@@ -310,6 +310,7 @@ static void __init qsd8x50_init_irq_rev_a(void)
 
 MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
 	.atag_offset = 0x100,
+	.nr_irqs = QSD8X50_NR_IRQS,
 	.map_io = msm_map_qsd8x50_io_rev_a,
 	.init_irq = qsd8x50_init_irq_rev_a,
 	.init_machine = qsd8x50_init,
diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
index 722ad63b7edc..4daf7816c736 100644
--- a/arch/arm/mach-msm/board-trout-gpio.c
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 
+#include <mach/irqs-7x00.h>
 #include "board-trout.h"
 
 static uint8_t trout_int_mask[2] = {
@@ -222,9 +223,9 @@ int __init trout_init_gpio(void)
 	for (i = 0; i < ARRAY_SIZE(msm_gpio_banks); i++)
 		gpiochip_add(&msm_gpio_banks[i].chip);
 
-	irq_set_irq_type(MSM_GPIO_TO_INT(17), IRQF_TRIGGER_HIGH);
-	irq_set_chained_handler(MSM_GPIO_TO_INT(17), trout_gpio_irq_handler);
-	irq_set_irq_wake(MSM_GPIO_TO_INT(17), 1);
+	irq_set_irq_type(MSM7X00_GPIO_TO_INT(17), IRQF_TRIGGER_HIGH);
+	irq_set_chained_handler(MSM7X00_GPIO_TO_INT(17), trout_gpio_irq_handler);
+	irq_set_irq_wake(MSM7X00_GPIO_TO_INT(17), 1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-msm/board-trout-mmc.c b/arch/arm/mach-msm/board-trout-mmc.c
index 608d86b171c4..334de79de87e 100644
--- a/arch/arm/mach-msm/board-trout-mmc.c
+++ b/arch/arm/mach-msm/board-trout-mmc.c
@@ -16,6 +16,7 @@
 
 #include <mach/vreg.h>
 #include <mach/clk.h>
+#include <mach/irqs-7x00.h>
 
 #include <linux/platform_data/mmc-msm_sdcc.h>
 
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 9737e43a2887..16a2f8912d3b 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs-7x00.h>
 #include <mach/msm_iomap-7x00.h>
 
 #include "devices.h"
@@ -96,6 +97,7 @@ static void __init trout_map_io(void)
 
 MACHINE_START(TROUT, "HTC Dream")
 	.atag_offset	= 0x100,
+	.nr_irqs	= MSM7X00_NR_IRQS,
 	.fixup		= trout_fixup,
 	.map_io		= trout_map_io,
 	.init_early	= trout_init_early,
diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index 38c16313f433..84bd323aff5e 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -18,7 +18,7 @@
 #include <linux/clkdev.h>
 #include <asm/mach/map.h>
 
-#include <mach/irqs.h>
+#include <mach/irqs-7x00.h>
 #include <mach/msm_iomap.h>
 #include <mach/msm_iomap-7x00.h>
 #include "devices.h"
diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
index 197d2b8afa20..0094278f24d2 100644
--- a/arch/arm/mach-msm/devices-msm7x30.c
+++ b/arch/arm/mach-msm/devices-msm7x30.c
@@ -19,7 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/clkdev.h>
 #include <asm/mach/map.h>
-#include <mach/irqs.h>
+#include <mach/irqs-7x30.h>
 #include <mach/msm_iomap-7x30.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index 3fd28b702591..e96c1e6a36e3 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -19,7 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/mach/map.h>
 
-#include <mach/irqs.h>
+#include <mach/irqs-8x50.h>
 #include <mach/msm_iomap.h>
 #include <mach/msm_iomap-8x50.h>
 
diff --git a/arch/arm/mach-msm/include/mach/entry-macro.S b/arch/arm/mach-msm/include/mach/entry-macro.S
deleted file mode 100644
index f2ae9087f654..000000000000
--- a/arch/arm/mach-msm/include/mach/entry-macro.S
+++ /dev/null
@@ -1,36 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- *
- */
-
-#if !defined(CONFIG_ARM_GIC)
-#include <mach/msm_iomap.h>
-
-	.macro	get_irqnr_preamble, base, tmp
-	@ enable imprecise aborts
-	cpsie	a
-	mov	\base, #MSM_VIC_BASE
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	@ 0xD0 has irq# or old irq# if the irq has been handled
-	@ 0xD4 has irq# or -1 if none pending *but* if you just
-	@ read 0xD4 you never get the first irq for some reason
-	ldr	\irqnr, [\base, #0xD0]
-	ldr	\irqnr, [\base, #0xD4]
-	cmp	\irqnr, #0xffffffff
-	.endm
-#endif
diff --git a/arch/arm/mach-msm/include/mach/irqs-7x00.h b/arch/arm/mach-msm/include/mach/irqs-7x00.h
index f1fe70612fe9..43effda6d46d 100644
--- a/arch/arm/mach-msm/include/mach/irqs-7x00.h
+++ b/arch/arm/mach-msm/include/mach/irqs-7x00.h
@@ -71,5 +71,8 @@
 #define NR_MSM_IRQS 64
 #define NR_GPIO_IRQS 122
 #define NR_BOARD_IRQS 64
+#define MSM7X00_NR_IRQS (NR_MSM_IRQS + NR_GPIO_IRQS + NR_BOARD_IRQS)
+
+#define MSM7X00_GPIO_TO_INT(n) (NR_MSM_IRQS + (n))
 
 #endif
diff --git a/arch/arm/mach-msm/include/mach/irqs-7x30.h b/arch/arm/mach-msm/include/mach/irqs-7x30.h
index 1f15902655fd..d2d9febf6d64 100644
--- a/arch/arm/mach-msm/include/mach/irqs-7x30.h
+++ b/arch/arm/mach-msm/include/mach/irqs-7x30.h
@@ -150,4 +150,6 @@
 				NR_PMIC8058_MISC_IRQS)
 #define NR_BOARD_IRQS		NR_PMIC8058_IRQS
 
+#define MSM7X30_NR_IRQS (NR_MSM_IRQS + NR_GPIO_IRQS + NR_BOARD_IRQS)
+
 #endif /* __ASM_ARCH_MSM_IRQS_7X30_H */
diff --git a/arch/arm/mach-msm/include/mach/irqs-8x50.h b/arch/arm/mach-msm/include/mach/irqs-8x50.h
index 9a6036119a8d..2761ecb86aab 100644
--- a/arch/arm/mach-msm/include/mach/irqs-8x50.h
+++ b/arch/arm/mach-msm/include/mach/irqs-8x50.h
@@ -85,6 +85,8 @@
 #define NR_MSM_IRQS 64
 #define NR_BOARD_IRQS 64
 
+#define QSD8X50_NR_IRQS (NR_MSM_IRQS + NR_GPIO_IRQS + NR_BOARD_IRQS)
+
 /*
  * Secondary interrupt controller interrupts
  */
diff --git a/arch/arm/mach-msm/include/mach/irqs.h b/arch/arm/mach-msm/include/mach/irqs.h
deleted file mode 100644
index 164d355c96ea..000000000000
--- a/arch/arm/mach-msm/include/mach/irqs.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2007 Google, Inc.
- * Copyright (c) 2008-2010, Code Aurora Forum. All rights reserved.
- * Author: Brian Swetland <swetland@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __ASM_ARCH_MSM_IRQS_H
-#define __ASM_ARCH_MSM_IRQS_H
-
-#define MSM_IRQ_BIT(irq)     (1 << ((irq) & 31))
-
-#if defined(CONFIG_ARCH_MSM7X30)
-#include "irqs-7x30.h"
-#elif defined(CONFIG_ARCH_QSD8X50)
-#include "irqs-8x50.h"
-#include "sirc.h"
-#elif defined(CONFIG_ARCH_MSM_ARM11)
-#include "irqs-7x00.h"
-#else
-#error "Unknown architecture specification"
-#endif
-
-#define NR_IRQS (NR_MSM_IRQS + NR_GPIO_IRQS + NR_BOARD_IRQS)
-#define MSM_GPIO_TO_INT(n) (NR_MSM_IRQS + (n))
-#define MSM_INT_TO_REG(base, irq) (base + irq / 32)
-
-#endif
diff --git a/arch/arm/mach-msm/irq-vic.c b/arch/arm/mach-msm/irq-vic.c
index 33a52f570dae..55a39cdaf3f8 100644
--- a/arch/arm/mach-msm/irq-vic.c
+++ b/arch/arm/mach-msm/irq-vic.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <asm/exception.h>
 #include <asm/cacheflush.h>
 
 #include <mach/hardware.h>
@@ -242,11 +243,34 @@ static struct irq_chip msm_irq_chip = {
 	.irq_set_type  = msm_irq_set_type,
 };
 
+static void __exception_irq_entry msm_vic_handle_irq(struct pt_regs *regs)
+{
+	int irq;
+
+	do {
+		/*
+		 * 0xD0 has irq# or old irq# if the irq has been handled
+		 * 0xD4 has irq# or -1 if none pending *but* if you just
+		 * read 0xD4 you never get the first irq for some reason
+		 */
+		irq = readl(VIC_IRQ_VEC_RD);
+		irq = readl(VIC_IRQ_VEC_PEND_RD);
+
+		if (irq == -1)
+			break;
+
+		generic_handle_irq(irq);
+	} while (1);
+}
+
 void __init msm_init_vic(uint8_t *irq_to_smsm, int nr)
 {
 	unsigned n;
 	msm_irq_to_smsm = irq_to_smsm;
 
+	/* set entry point */
+	set_handle_irq(msm_vic_handle_irq);
+
 	/* select level interrupts */
 	msm_irq_write_all_regs(VIC_INT_TYPE0, 0, nr / 32);
 
diff --git a/arch/arm/mach-msm/irq.c b/arch/arm/mach-msm/irq.c
index ea514be390c6..6b1a918c7592 100644
--- a/arch/arm/mach-msm/irq.c
+++ b/arch/arm/mach-msm/irq.c
@@ -21,7 +21,9 @@
 #include <linux/timer.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <asm/exception.h>
 
+#include <mach/irqs-7x00.h>
 #include <mach/hardware.h>
 
 #include <mach/msm_iomap.h>
@@ -118,10 +120,33 @@ static struct irq_chip msm_irq_chip = {
 	.irq_set_type  = msm_irq_set_type,
 };
 
+static void __exception_irq_entry msm_handle_irq(struct pt_regs *regs)
+{
+	int irq;
+
+	do {
+		/*
+		 * 0xD0 has irq# or old irq# if the irq has been handled
+		 * 0xD4 has irq# or -1 if none pending *but* if you just
+		 * read 0xD4 you never get the first irq for some reason
+		 */
+		irq = readl(VIC_IRQ_VEC_RD);
+		irq = readl(VIC_IRQ_VEC_PEND_RD);
+
+		if (irq == -1)
+			break;
+
+		generic_handle_irq(irq);
+	} while (1);
+}
+
 void __init msm_init_irq(void)
 {
 	unsigned n;
 
+	/* set entry point */
+	set_handle_irq(msm_handle_irq);
+
 	/* select level interrupts */
 	writel(0, VIC_INT_TYPE0);
 	writel(0, VIC_INT_TYPE1);
-- 
2.1.0.rc2
