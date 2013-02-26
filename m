From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 27 Feb 2013 00:00:48 +0100
Subject: [PATCH 5/5] ARM: S3C24XX: add handle_irq function
In-Reply-To: <201302262357.24544.heiko@sntech.de>
References: <201302262357.24544.heiko@sntech.de>
Message-ID: <201302270000.48423.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the dependency on static irq mappings for basic irq handling
and makes the s3c24xx entry-macro.S obsolete.

Also the interrupts of the second full interrupt controller on the s3c2416
are really handled now, which was forgotten when adding them.

The handling itself does the same as the previous assembler-code in that
it tries to get the interrupt offset from the offset register first and
if that produces wrong results manually searches for the interrupt bit
in the pending register value. It also saves the historic comment which
explains the reason behind this.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig                                 |    1 +
 arch/arm/mach-s3c24xx/include/mach/entry-macro.S |   70 ----------------------
 arch/arm/mach-s3c24xx/irq.c                      |   58 ++++++++++++++++++
 3 files changed, 59 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aacea44..23e894e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -777,6 +777,7 @@ config ARCH_S3C24XX
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	help
diff --git a/arch/arm/mach-s3c24xx/include/mach/entry-macro.S b/arch/arm/mach-s3c24xx/include/mach/entry-macro.S
deleted file mode 100644
index 6a21bee..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * arch/arm/mach-s3c2410/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for S3C2410-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
-*/
-
-/* We have a problem that the INTOFFSET register does not always
- * show one interrupt. Occasionally we get two interrupts through
- * the prioritiser, and this causes the INTOFFSET register to show
- * what looks like the logical-or of the two interrupt numbers.
- *
- * Thanks to Klaus, Shannon, et al for helping to debug this problem
-*/
-
-#define INTPND		(0x10)
-#define INTOFFSET	(0x14)
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-	.macro  get_irqnr_preamble, base, tmp
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		mov	\base, #S3C24XX_VA_IRQ
-
-		@@ try the interrupt offset register, since it is there
-
-		ldr	\irqstat, [\base, #INTPND ]
-		teq	\irqstat, #0
-		beq	1002f
-		ldr	\irqnr, [\base, #INTOFFSET ]
-		mov	\tmp, #1
-		tst	\irqstat, \tmp, lsl \irqnr
-		bne	1001f
-
-		@@ the number specified is not a valid irq, so try
-		@@ and work it out for ourselves
-
-		mov	\irqnr, #0		@@ start here
-
-		@@ work out which irq (if any) we got
-
-		movs	\tmp, \irqstat, lsl#16
-		addeq	\irqnr, \irqnr, #16
-		moveq	\irqstat, \irqstat, lsr#16
-		tst	\irqstat, #0xff
-		addeq	\irqnr, \irqnr, #8
-		moveq	\irqstat, \irqstat, lsr#8
-		tst	\irqstat, #0xf
-		addeq	\irqnr, \irqnr, #4
-		moveq	\irqstat, \irqstat, lsr#4
-		tst	\irqstat, #0x3
-		addeq	\irqnr, \irqnr, #2
-		moveq	\irqstat, \irqstat, lsr#2
-		tst	\irqstat, #0x1
-		addeq	\irqnr, \irqnr, #1
-
-		@@ we have the value
-1001:
-		adds	\irqnr, \irqnr, #IRQ_EINT0
-1002:
-		@@ exit here, Z flag unset if IRQ
-
-	.endm
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 8bc2931..5c9f8b7 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/irqdomain.h>
 
+#include <asm/exception.h>
 #include <asm/mach/irq.h>
 
 #include <mach/regs-irq.h>
@@ -282,6 +283,56 @@ static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static struct s3c_irq_intc *main_intc;
+static struct s3c_irq_intc *main_intc2;
+
+static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
+				      struct pt_regs *regs)
+{
+	int pnd;
+	int offset;
+	int irq;
+
+	pnd = __raw_readl(intc->reg_intpnd);
+	if (!pnd)
+		return false;
+
+	/* We have a problem that the INTOFFSET register does not always
+	 * show one interrupt. Occasionally we get two interrupts through
+	 * the prioritiser, and this causes the INTOFFSET register to show
+	 * what looks like the logical-or of the two interrupt numbers.
+	 *
+	 * Thanks to Klaus, Shannon, et al for helping to debug this problem
+	 */
+	offset = __raw_readl(intc->reg_intpnd + 4);
+
+	/* Find the bit manually, when the offset is wrong.
+	 * The pending register only ever contains the one bit of the next
+	 * interrupt to handle.
+	 */
+	if (!(pnd & (1 << offset)))
+		offset =  __ffs(pnd);
+
+	irq = irq_find_mapping(intc->domain, offset);
+	handle_IRQ(irq, regs);
+	return true;
+}
+
+asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
+{
+	do {
+		if (likely(main_intc))
+			if (s3c24xx_handle_intc(main_intc, regs))
+				continue;
+
+		if (main_intc2)
+			if (s3c24xx_handle_intc(main_intc2, regs))
+				continue;
+
+		break;
+	} while (1);
+}
+
 #ifdef CONFIG_FIQ
 /**
  * s3c24xx_set_fiq - set the FIQ routing
@@ -502,6 +553,13 @@ static struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
 		goto err;
 	}
 
+	if (address == 0x4a000000)
+		main_intc = intc;
+	else if (address == 0x4a000040)
+		main_intc2 = intc;
+
+	set_handle_irq(s3c24xx_handle_irq);
+
 	return intc;
 
 err:
-- 
1.7.2.3
