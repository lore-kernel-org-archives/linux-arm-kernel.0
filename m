From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 22 May 2010 12:24:23 +0800
Subject: [RFC PATCH 2/2] pxa: preliminary support for MULTI_IRQ_HANDLER
Message-ID: <AANLkTini_6iqbWX0vVtNdrnq8BdQQYaprc5yqJey99G8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 4cbce4923d528c9de8556bad8b935efe6170842b
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Sat May 22 12:22:52 2010 +0800

    [ARM] pxa: preliminary support for MULTI_IRQ_HANDLER

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 3b51741..bec042d 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -470,6 +470,7 @@ config MACH_CORGI
 	depends on PXA_SHARPSL
 	select PXA25x
 	select PXA_SHARP_C7xx
+	select MULTI_IRQ_HANDLER

 config MACH_SHEPHERD
 	bool "Enable Sharp SL-C750 (Shepherd) Support"
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 3d1dcb9..c910d2b 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -729,6 +729,7 @@ MACHINE_START(CORGI, "SHARP Corgi")
 	.fixup		= fixup_corgi,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
+	.handle_irq	= pxa25x_handle_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -741,6 +742,7 @@ MACHINE_START(SHEPHERD, "SHARP Shepherd")
 	.fixup		= fixup_corgi,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
+	.handle_irq	= pxa25x_handle_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -753,6 +755,7 @@ MACHINE_START(HUSKY, "SHARP Husky")
 	.fixup		= fixup_corgi,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
+	.handle_irq	= pxa25x_handle_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 890fb90..437e9a3 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -22,6 +22,9 @@ extern void __init pxa27x_init_irq(void);
 extern void __init pxa3xx_init_irq(void);
 extern void __init pxa_map_io(void);

+extern void pxa25x_handle_irq(struct pt_regs *);
+extern void pxa27x_handle_irq(struct pt_regs *);
+
 extern unsigned int get_clk_frequency_khz(int info);

 #define SET_BANK(__nr,__start,__size) \
diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S
b/arch/arm/mach-pxa/include/mach/entry-macro.S
index a73bc86..1ee5368 100644
--- a/arch/arm/mach-pxa/include/mach/entry-macro.S
+++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
@@ -13,10 +13,11 @@
 		.macro	disable_fiq
 		.endm

-		.macro  get_irqnr_preamble, base, tmp
+		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm

-		.macro  arch_ret_to_user, tmp1, tmp2
+#ifndef CONFIG_MULTI_IRQ_HANDLER
+		.macro  get_irqnr_preamble, base, tmp
 		.endm

 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
@@ -49,3 +50,4 @@
 		add	\irqnr, \irqnr, #(PXA_IRQ(0))
 1001:
 		.endm
+#endif
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index a9396a9..24934de 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -37,6 +37,7 @@
 #define IPR(i)		(((i) < 32) ? (0x01c + ((i) << 2)) :		\
 			 ((i) < 64) ? (0x0b0 + (((i) - 32) << 2)) :	\
 				      (0x144 + (((i) - 64) << 2)))
+#define ICHP_VAL_IRQ	(1 << 31)
 #define IPR_VALID	(1 << 31)

 #define MAX_INTERNAL_IRQS	128
@@ -75,6 +76,7 @@ static struct irq_chip pxa_internal_irq_chip = {
 	.name		= "SC",
 	.ack		= pxa_mask_irq,
 	.mask		= pxa_mask_irq,
+	.mask_ack	= pxa_mask_irq,
 	.unmask		= pxa_unmask_irq,
 };

@@ -148,6 +150,44 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
 	pxa_low_gpio_chip.set_wake = fn;
 }

+#ifdef CONFIG_PXA25x
+asmlinkage void pxa25x_handle_irq(struct pt_regs *reg)
+{
+	uint32_t icip, icmr, mask;
+	unsigned int irq;
+
+	do {
+		icip = __raw_readl(IRQ_BASE + ICIP);
+		icmr = __raw_readl(IRQ_BASE + ICMR);
+		mask = icip & icmr;
+
+		if (mask == 0)
+			break;
+
+		irq = fls(mask) - 1;
+		asm_do_IRQ(irq, reg);
+	} while (1);
+}
+#endif
+
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
+asmlinkage void pxa27x_handle_irq(struct pt_regs *reg)
+{
+	uint32_t ichp;
+	unsigned int irq;
+
+	do {
+		__asm__ __volatile__("mrc p6, 0, %0, c5, c0, 0\n": "=r"(ichp));
+
+		if ((ichp & ICHP_VAL_IRQ) == 0)
+			break;
+
+		irq = PXA_IRQ((ichp & ~ICHP_VAL_IRQ) >> 16);
+		asm_do_IRQ(irq, reg);
+	} while (1);
+}
+#endif
+
 static inline void __iomem *irq_base(int i)
 {
 	static unsigned long phys_base[] = {
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 4d2413e..e8bdf16 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -855,6 +855,7 @@ MACHINE_START(SPITZ, "SHARP Spitz")
 	.fixup		= fixup_spitz,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
+	.handle_irq	= pxa27x_handle_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -867,6 +868,7 @@ MACHINE_START(BORZOI, "SHARP Borzoi")
 	.fixup		= fixup_spitz,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
+	.handle_irq	= pxa27x_handle_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -879,6 +881,7 @@ MACHINE_START(AKITA, "SHARP Akita")
 	.fixup		= fixup_spitz,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
+	.handle_irq	= pxa27x_handle_irq,
 	.init_machine	= akita_init,
 	.timer		= &pxa_timer,
 MACHINE_END
