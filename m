From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:49:14 +0100
Subject: [PATCH 2/5] ARM: orion: always use MULTI_IRQ_HANDLER
In-Reply-To: <1448466557-435335-1-git-send-email-arnd@arndb.de>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
Message-ID: <1448466557-435335-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a preparation for multiplatform support, this enables
the MULTI_IRQ_HANDLER code unconditionally on dove and
orion5x, and introduces the respective code on mv78xx0,
which did not have it so far. The classic entry-macro.S
files are removed as they are now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                 |  3 ++
 arch/arm/mach-dove/include/mach/entry-macro.S    | 33 -------------------
 arch/arm/mach-dove/irq.c                         | 12 +------
 arch/arm/mach-mv78xx0/include/mach/entry-macro.S | 41 ------------------------
 arch/arm/mach-mv78xx0/irq.c                      | 33 +++++++++++++++++++
 arch/arm/mach-orion5x/include/mach/entry-macro.S | 25 ---------------
 arch/arm/mach-orion5x/irq.c                      | 11 -------
 7 files changed, 37 insertions(+), 121 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-orion5x/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dd5bedca3840..4a975d83e52f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -468,6 +468,7 @@ config ARCH_DOVE
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
+	select MULTI_IRQ_HANDLER
 	select MVEBU_MBUS
 	select PINCTRL
 	select PINCTRL_DOVE
@@ -481,6 +482,7 @@ config ARCH_MV78XX0
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
 	select MVEBU_MBUS
+	select MULTI_IRQ_HANDLER
 	select PCI
 	select PLAT_ORION_LEGACY
 	help
@@ -494,6 +496,7 @@ config ARCH_ORION5X
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
 	select MVEBU_MBUS
+	select MULTI_IRQ_HANDLER
 	select PCI
 	select PLAT_ORION_LEGACY
 	select MULTI_IRQ_HANDLER
diff --git a/arch/arm/mach-dove/include/mach/entry-macro.S b/arch/arm/mach-dove/include/mach/entry-macro.S
deleted file mode 100644
index 72d622baaad3..000000000000
--- a/arch/arm/mach-dove/include/mach/entry-macro.S
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Marvell Dove platforms
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <mach/bridge-regs.h>
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =IRQ_VIRT_BASE
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	@ check low interrupts
-	ldr	\irqstat, [\base, #IRQ_CAUSE_LOW_OFF]
-	ldr	\tmp, [\base, #IRQ_MASK_LOW_OFF]
-	mov	\irqnr, #31
-	ands	\irqstat, \irqstat, \tmp
-
-	@ if no low interrupts set, check high interrupts
-	ldreq	\irqstat, [\base, #IRQ_CAUSE_HIGH_OFF]
-	ldreq	\tmp, [\base, #IRQ_MASK_HIGH_OFF]
-	moveq	\irqnr, #63
-	andeqs	\irqstat, \irqstat, \tmp
-
-	@ find first active interrupt source
-	clzne	\irqstat, \irqstat
-	subne	\irqnr, \irqnr, \irqstat
-	.endm
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index bfb3703357c5..b1c7cae1486b 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <asm/exception.h>
 #include <asm/mach/arch.h>
 #include <plat/irq.h>
 #include <asm/mach/irq.h>
@@ -109,14 +110,6 @@ static int __initdata gpio2_irqs[4] = {
 	0,
 };
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-/*
- * Compiling with both non-DT and DT support enabled, will
- * break asm irq handler used by non-DT boards. Therefore,
- * we provide a C-style irq handler even for non-DT boards,
- * if MULTI_IRQ_HANDLER is set.
- */
-
 static void __iomem *dove_irq_base = IRQ_VIRT_BASE;
 
 static asmlinkage void
@@ -139,7 +132,6 @@ __exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
 		return;
 	}
 }
-#endif
 
 void __init dove_init_irq(void)
 {
@@ -148,9 +140,7 @@ void __init dove_init_irq(void)
 	orion_irq_init(1, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
 	orion_irq_init(33, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
 	set_handle_irq(dove_legacy_handle_irq);
-#endif
 
 	/*
 	 * Initialize gpiolib for GPIOs 0-71.
diff --git a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S b/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
deleted file mode 100644
index 6b1f088e0597..000000000000
--- a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Marvell MV78xx0 platforms
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <mach/bridge-regs.h>
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =IRQ_VIRT_BASE
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	@ check low interrupts
-	ldr	\irqstat, [\base, #IRQ_CAUSE_LOW_OFF]
-	ldr	\tmp, [\base, #IRQ_MASK_LOW_OFF]
-	mov	\irqnr, #31
-	ands	\irqstat, \irqstat, \tmp
-	bne	1001f
-
-	@ if no low interrupts set, check high interrupts
-	ldr	\irqstat, [\base, #IRQ_CAUSE_HIGH_OFF]
-	ldr	\tmp, [\base, #IRQ_MASK_HIGH_OFF]
-	mov	\irqnr, #63
-	ands	\irqstat, \irqstat, \tmp
-	bne	1001f
-
-	@ if no high interrupts set, check error interrupts
-	ldr	\irqstat, [\base, #IRQ_CAUSE_ERR_OFF]
-	ldr	\tmp, [\base, #IRQ_MASK_ERR_OFF]
-	mov	\irqnr, #95
-	ands	\irqstat, \irqstat, \tmp
-
-	@ find first active interrupt source
-1001:	clzne	\irqstat, \irqstat
-	subne	\irqnr, \irqnr, \irqstat
-	.endm
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index 32073444024b..2453c33faccf 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <asm/exception.h>
 #include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include <plat/irq.h>
@@ -23,12 +24,44 @@ static int __initdata gpio0_irqs[4] = {
 	IRQ_MV78XX0_GPIO_24_31,
 };
 
+static void __iomem *mv78xx0_irq_base = IRQ_VIRT_BASE;
+
+static asmlinkage void
+__exception_irq_entry mv78xx0_legacy_handle_irq(struct pt_regs *regs)
+{
+	u32 stat;
+
+	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_LOW_OFF);
+	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_LOW_OFF);
+	if (stat) {
+		unsigned int hwirq = __fls(stat);
+		handle_IRQ(hwirq, regs);
+		return;
+	}
+	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_HIGH_OFF);
+	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_HIGH_OFF);
+	if (stat) {
+		unsigned int hwirq = 32 + __fls(stat);
+		handle_IRQ(hwirq, regs);
+		return;
+	}
+	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_ERR_OFF);
+	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_ERR_OFF);
+	if (stat) {
+		unsigned int hwirq = 64 + __fls(stat);
+		handle_IRQ(hwirq, regs);
+		return;
+	}
+}
+
 void __init mv78xx0_init_irq(void)
 {
 	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
 	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
 	orion_irq_init(64, IRQ_VIRT_BASE + IRQ_MASK_ERR_OFF);
 
+	set_handle_irq(mv78xx0_legacy_handle_irq);
+
 	/*
 	 * Initialize gpiolib for GPIOs 0-31.  (The GPIO interrupt mask
 	 * registers for core #1 are at an offset of 0x18 from those of
diff --git a/arch/arm/mach-orion5x/include/mach/entry-macro.S b/arch/arm/mach-orion5x/include/mach/entry-macro.S
deleted file mode 100644
index 79eb502a1e64..000000000000
--- a/arch/arm/mach-orion5x/include/mach/entry-macro.S
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Orion platforms
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <mach/bridge-regs.h>
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =MAIN_IRQ_CAUSE
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\irqstat, [\base, #0]		@ main cause
-	ldr	\tmp, [\base, #(MAIN_IRQ_MASK - MAIN_IRQ_CAUSE)] @ main mask
-	mov	\irqnr, #0			@ default irqnr
-	@ find cause bits that are unmasked
-	ands	\irqstat, \irqstat, \tmp	@ clear Z flag if any
-	clzne	\irqnr,	\irqstat		@ calc irqnr
-	rsbne	\irqnr, \irqnr, #31
-	.endm
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 086ecb87d885..8678db1eb1bd 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -26,14 +26,6 @@ static int __initdata gpio0_irqs[4] = {
 	IRQ_ORION5X_GPIO_24_31,
 };
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-/*
- * Compiling with both non-DT and DT support enabled, will
- * break asm irq handler used by non-DT boards. Therefore,
- * we provide a C-style irq handler even for non-DT boards,
- * if MULTI_IRQ_HANDLER is set.
- */
-
 asmlinkage void
 __exception_irq_entry orion5x_legacy_handle_irq(struct pt_regs *regs)
 {
@@ -47,15 +39,12 @@ __exception_irq_entry orion5x_legacy_handle_irq(struct pt_regs *regs)
 		return;
 	}
 }
-#endif
 
 void __init orion5x_init_irq(void)
 {
 	orion_irq_init(1, MAIN_IRQ_MASK);
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
 	set_handle_irq(orion5x_legacy_handle_irq);
-#endif
 
 	/*
 	 * Initialize gpiolib for GPIOs 0-31.
-- 
2.1.0.rc2
