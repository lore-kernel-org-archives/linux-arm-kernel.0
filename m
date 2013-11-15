From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:47:54 +0400
Subject: [PATCH 3/9] ARM: sa1100: switch to MULTI_IRQ_HANDLER
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sa1100_handle_irq implementating handle_irq for sa1100 platform.
Install this irq handler from sa1100_init_irq(). Also drop now unused
entry-macro.S

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig                                |  1 +
 arch/arm/mach-sa1100/include/mach/entry-macro.S | 41 -------------------------
 arch/arm/mach-sa1100/irq.c                      | 20 ++++++++++++
 3 files changed, 21 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6a1d2b4..2e6521927 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -719,6 +719,7 @@ config ARCH_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
 	select ISA
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-sa1100/include/mach/entry-macro.S b/arch/arm/mach-sa1100/include/mach/entry-macro.S
deleted file mode 100644
index 8cf7630..0000000
--- a/arch/arm/mach-sa1100/include/mach/entry-macro.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for SA1100-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro  get_irqnr_preamble, base, tmp
-		mov	\base, #0xfa000000		@ ICIP = 0xfa050000
-		add	\base, \base, #0x00050000
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqstat, [\base]		@ get irqs
-		ldr	\irqnr, [\base, #4]		@ ICMR = 0xfa050004
-		ands	\irqstat, \irqstat, \irqnr
-		mov	\irqnr, #0
-		beq	1001f
-		tst	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tsteq	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tsteq	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tst	\irqstat, #0x0f
-		moveq	\irqstat, \irqstat, lsr #4
-		addeq	\irqnr, \irqnr, #4
-		tst	\irqstat, #0x03
-		moveq	\irqstat, \irqstat, lsr #2
-		addeq	\irqnr, \irqnr, #2
-		tst	\irqstat, #0x01
-		addeqs	\irqnr, \irqnr, #1
-1001:
-		.endm
-
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 2124f1fc..68e8f9d 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -20,6 +20,7 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 
 #include "generic.h"
 
@@ -291,6 +292,23 @@ static int __init sa1100irq_init_devicefs(void)
 
 device_initcall(sa1100irq_init_devicefs);
 
+static asmlinkage void __exception_irq_entry
+sa1100_handle_irq(struct pt_regs *regs)
+{
+	uint32_t icip, icmr, mask;
+
+	do {
+		icip = (ICIP);
+		icmr = (ICMR);
+		mask = icip & icmr;
+
+		if (mask == 0)
+			break;
+
+		handle_IRQ(fls(mask) - 1, regs);
+	} while (1);
+}
+
 void __init sa1100_init_irq(void)
 {
 	unsigned int irq;
@@ -338,5 +356,7 @@ void __init sa1100_init_irq(void)
 	irq_set_chip(IRQ_GPIO11_27, &sa1100_normal_chip);
 	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
 
+	set_handle_irq(sa1100_handle_irq);
+
 	sa1100_init_gpio();
 }
-- 
1.8.4.2
