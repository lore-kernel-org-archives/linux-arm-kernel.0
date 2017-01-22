From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:15:24 +0100
Subject: [PATCH 01/22] ARM: gemini: convert to MULTI_IRQ_HANDLER
Message-ID: <20170122121524.10048-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to enable device tree boot on this machine we must first
convert it to runtime-manage its irq handler, so do this.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                |  1 +
 arch/arm/mach-gemini/include/mach/entry-macro.S | 33 -------------------------
 arch/arm/mach-gemini/irq.c                      | 15 +++++++++++
 3 files changed, 16 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/mach-gemini/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5fab553fd03a..63e61bf5aab0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -359,6 +359,7 @@ config ARCH_GEMINI
 	select CPU_FA526
 	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
diff --git a/arch/arm/mach-gemini/include/mach/entry-macro.S b/arch/arm/mach-gemini/include/mach/entry-macro.S
deleted file mode 100644
index f044e430bfa4..000000000000
--- a/arch/arm/mach-gemini/include/mach/entry-macro.S
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Low-level IRQ helper macros for Gemini platform.
- *
- *  Copyright (C) 2001-2006 Storlink, Corp.
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <mach/hardware.h>
-
-#define IRQ_STATUS	0x14
-
-	.macro  get_irqnr_preamble, base, tmp
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr     \irqstat, =IO_ADDRESS(GEMINI_INTERRUPT_BASE + IRQ_STATUS)
-	ldr     \irqnr, [\irqstat]
-	cmp     \irqnr, #0
-	beq     2313f
-	mov     \tmp, \irqnr
-	mov     \irqnr, #0
-2312:
-	tst     \tmp, #1
-	bne     2313f
-	add     \irqnr, \irqnr, #1
-	mov     \tmp, \tmp, lsr #1
-	cmp     \irqnr, #31
-	bcc     2312b
-2313:
-	.endm
diff --git a/arch/arm/mach-gemini/irq.c b/arch/arm/mach-gemini/irq.c
index d929b3ff18fd..37d52e372456 100644
--- a/arch/arm/mach-gemini/irq.c
+++ b/arch/arm/mach-gemini/irq.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/cpu.h>
 
+#include <asm/exception.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/system_misc.h>
@@ -65,6 +66,18 @@ static struct irq_chip gemini_irq_chip = {
 	.irq_unmask	= gemini_unmask_irq,
 };
 
+
+asmlinkage void __exception_irq_entry gemini_handle_irq(struct pt_regs *regs)
+{
+	int irq;
+	unsigned status;
+
+	while ((status = __raw_readl(IRQ_STATUS(IO_ADDRESS(GEMINI_INTERRUPT_BASE))))) {
+		irq = ffs(status) - 1;
+		handle_domain_irq(NULL, irq, regs);
+	}
+}
+
 static struct resource irq_resource = {
 	.name	= "irq_handler",
 	.start	= GEMINI_INTERRUPT_BASE,
@@ -102,4 +115,6 @@ void __init gemini_init_irq(void)
 	/* Set interrupt mode */
 	__raw_writel(mode, IRQ_TMODE(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
 	__raw_writel(level, IRQ_TLEVEL(IO_ADDRESS(GEMINI_INTERRUPT_BASE)));
+
+	set_handle_irq(gemini_handle_irq);
 }
-- 
2.9.3
