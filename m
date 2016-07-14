From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 13:11:31 +0200
Subject: [PATCH 3/7] ARM: nuc900: use MULTI_IRQ_HANDLER
In-Reply-To: <20160714111135.2476095-1-arnd@arndb.de>
References: <20160714111135.2476095-1-arnd@arndb.de>
Message-ID: <20160714111135.2476095-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To clean up the header files, the inline IRQ entry is being replaced
with a modern handle_irq() function doing the same thing.

This is also required for multiplatform support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                 |  1 +
 arch/arm/mach-w90x900/include/mach/entry-macro.S | 26 ------------------------
 arch/arm/mach-w90x900/irq.c                      | 13 ++++++++++++
 3 files changed, 14 insertions(+), 26 deletions(-)
 delete mode 100644 arch/arm/mach-w90x900/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 36f721c2eb97..908694886088 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -503,6 +503,7 @@ config ARCH_W90X900
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
 	  At present, the w90x900 has been renamed nuc900, regarding
diff --git a/arch/arm/mach-w90x900/include/mach/entry-macro.S b/arch/arm/mach-w90x900/include/mach/entry-macro.S
deleted file mode 100644
index 0ff612ac95ba..000000000000
--- a/arch/arm/mach-w90x900/include/mach/entry-macro.S
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/mach-w90x900/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for W90P910-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- */
-
-#include <mach/hardware.h>
-#include <mach/regs-irq.h>
-
-	.macro  get_irqnr_preamble, base, tmp
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		mov	\base, #AIC_BA
-
-		ldr	\irqnr, [\base, #AIC_IPER]
-		ldr	\irqnr, [\base, #AIC_ISNR]
-		cmp	\irqnr, #0
-
-	.endm
diff --git a/arch/arm/mach-w90x900/irq.c b/arch/arm/mach-w90x900/irq.c
index 491b317daffa..6ef0ae50a23f 100644
--- a/arch/arm/mach-w90x900/irq.c
+++ b/arch/arm/mach-w90x900/irq.c
@@ -22,6 +22,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
+#include <asm/exception.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
@@ -202,10 +203,22 @@ static struct irq_chip nuc900_irq_chip = {
 	.irq_unmask	= nuc900_irq_unmask,
 };
 
+static void __exception_irq_entry nuc900_handle_irq(struct pt_regs *regs)
+{
+	int hwirq;
+
+	(void)readl(REG_AIC_IPER);
+	hwirq = readl(REG_AIC_ISNR);
+
+	handle_IRQ(hwirq, regs);
+}
+
 void __init nuc900_init_irq(void)
 {
 	int irqno;
 
+	set_handle_irq(nuc900_handle_irq);
+
 	__raw_writel(0xFFFFFFFE, REG_AIC_MDCR);
 
 	for (irqno = IRQ_WDT; irqno <= IRQ_ADC; irqno++) {
-- 
2.9.0
