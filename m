From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Feb 2013 14:20:22 +0100
Subject: [PATCH 11/12] ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
In-Reply-To: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
References: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1360502423-2246-12-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the need for an IRQ chip handling PWM timer interrupt chaining is
gone now, this patch removes all the code made unnecessary.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/Kconfig                                   |  1 -
 arch/arm/mach-s3c64xx/common.c                     |  1 -
 arch/arm/plat-samsung/Kconfig                      |  6 --
 arch/arm/plat-samsung/Makefile                     |  1 -
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h | 13 ---
 arch/arm/plat-samsung/irq-vic-timer.c              | 98 ----------------------
 arch/arm/plat-samsung/s5p-irq.c                    |  1 -
 7 files changed, 121 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8b72d23..2c85d52 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -778,7 +778,6 @@ config ARCH_S3C64XX
 	select S3C_GPIO_TRACK
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_GPIOLIB_4BIT
-	select SAMSUNG_IRQ_VIC_TIMER
 	select USB_ARCH_HAS_OHCI
 	help
 	  Samsung S3C64XX series based systems
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 4e1775f..6c71f57 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -41,7 +41,6 @@
 #include <plat/pm.h>
 #include <plat/gpio-cfg.h>
 #include <plat/irq-uart.h>
-#include <plat/irq-vic-timer.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
 #include <linux/samsung-time.h>
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 07ae984..6967144 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -27,7 +27,6 @@ config PLAT_S5P
 	select S5P_GPIO_DRVSTR
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_GPIOLIB_4BIT
-	select SAMSUNG_IRQ_VIC_TIMER
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
@@ -87,11 +86,6 @@ config S5P_CLOCK
 
 # options for IRQ support
 
-config SAMSUNG_IRQ_VIC_TIMER
-       bool
-       help
-         Internal configuration to build the VIC timer interrupt code.
-
 config S5P_IRQ
 	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 87494e1..ae2a0fd 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_SAMSUNG_CLOCK)	+= pwm-clock.o
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 obj-$(CONFIG_S5P_CLOCK)		+= s5p-clock.o
 
-obj-$(CONFIG_SAMSUNG_IRQ_VIC_TIMER) += irq-vic-timer.o
 obj-$(CONFIG_S5P_IRQ)		+= s5p-irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= s5p-irq-eint.o
 obj-$(CONFIG_S5P_GPIO_INT)	+= s5p-irq-gpioint.o
diff --git a/arch/arm/plat-samsung/include/plat/irq-vic-timer.h b/arch/arm/plat-samsung/include/plat/irq-vic-timer.h
deleted file mode 100644
index 5b9c42f..0000000
--- a/arch/arm/plat-samsung/include/plat/irq-vic-timer.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/irq-vic-timer.h
- *
- * Copyright (c) 2010 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for Samsung SoC IRQ VIC timer
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-extern void s3c_init_vic_timer_irq(unsigned int num, unsigned int timer_irq);
diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
deleted file mode 100644
index f980cf3..0000000
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ /dev/null
@@ -1,98 +0,0 @@
-/* arch/arm/plat-samsung/irq-vic-timer.c
- *	originally part of arch/arm/plat-s3c64xx/irq.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C64XX - Interrupt handling
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-
-#include <mach/map.h>
-#include <plat/cpu.h>
-#include <plat/irq-vic-timer.h>
-#include <plat/regs-timer.h>
-
-#include <asm/mach/irq.h>
-
-static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_get_chip(irq);
-	chained_irq_enter(chip, desc);
-	generic_handle_irq((int)desc->irq_data.handler_data);
-	chained_irq_exit(chip, desc);
-}
-
-/* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
-static void s3c_irq_timer_ack(struct irq_data *d)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	u32 mask = (1 << 5) << (d->irq - gc->irq_base);
-
-	irq_reg_writel(mask | gc->mask_cache, gc->reg_base);
-}
-
-/**
- * s3c_init_vic_timer_irq() - initialise timer irq chanined off VIC.\
- * @num: Number of timers to initialize
- * @timer_irq: Base IRQ number to be used for the timers.
- *
- * Register the necessary IRQ chaining and support for the timer IRQs
- * chained of the VIC.
- */
-void __init s3c_init_vic_timer_irq(unsigned int num, unsigned int timer_irq)
-{
-	unsigned int pirq[5] = { IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
-				 IRQ_TIMER3_VIC, IRQ_TIMER4_VIC };
-	struct irq_chip_generic *s3c_tgc;
-	struct irq_chip_type *ct;
-	unsigned int i;
-
-#ifdef CONFIG_ARCH_EXYNOS
-	if (soc_is_exynos5250()) {
-		pirq[0] = EXYNOS5_IRQ_TIMER0_VIC;
-		pirq[1] = EXYNOS5_IRQ_TIMER1_VIC;
-		pirq[2] = EXYNOS5_IRQ_TIMER2_VIC;
-		pirq[3] = EXYNOS5_IRQ_TIMER3_VIC;
-		pirq[4] = EXYNOS5_IRQ_TIMER4_VIC;
-	} else {
-		pirq[0] = EXYNOS4_IRQ_TIMER0_VIC;
-		pirq[1] = EXYNOS4_IRQ_TIMER1_VIC;
-		pirq[2] = EXYNOS4_IRQ_TIMER2_VIC;
-		pirq[3] = EXYNOS4_IRQ_TIMER3_VIC;
-		pirq[4] = EXYNOS4_IRQ_TIMER4_VIC;
-	}
-#endif
-	s3c_tgc = irq_alloc_generic_chip("s3c-timer", 1, timer_irq,
-					 S3C64XX_TINT_CSTAT, handle_level_irq);
-
-	if (!s3c_tgc) {
-		pr_err("%s: irq_alloc_generic_chip for IRQ %d failed\n",
-		       __func__, timer_irq);
-		return;
-	}
-
-	ct = s3c_tgc->chip_types;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
-	ct->chip.irq_ack = s3c_irq_timer_ack;
-	irq_setup_generic_chip(s3c_tgc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
-			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
-	/* Clear the upper bits of the mask_cache*/
-	s3c_tgc->mask_cache &= 0x1f;
-
-	for (i = 0; i < num; i++, timer_irq++) {
-		irq_set_chained_handler(pirq[i], s3c_irq_demux_vic_timer);
-		irq_set_handler_data(pirq[i], (void *)timer_irq);
-	}
-}
diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
index a14d8e9..f6404f7 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -19,7 +19,6 @@
 #include <mach/map.h>
 #include <plat/regs-timer.h>
 #include <plat/cpu.h>
-#include <plat/irq-vic-timer.h>
 
 void __init s5p_init_irq(u32 *vic, u32 num_vic)
 {
-- 
1.8.1.2
