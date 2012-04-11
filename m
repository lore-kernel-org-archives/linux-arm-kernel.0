From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2012 00:44:00 +0200
Subject: [PATCH 2/3] plat-versatile: modernize FPGA IRQ controller
Message-ID: <1334184240-18898-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This does two things to the FPGA IRQ controller in the versatile
family:

- Convert to MULTI_IRQ_HANDLER so we can drop the entry macro
  from the Integrator.
- Convert to using IRQ domains so we can get rid of the NO_IRQ
  mess and proceed with device tree and such stuff.

I was unable to split this patch in two. The main reason is the
half-done conversion to device tree in Versatile.

Tested on Integrator/AP and Integrator/CP.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                   |    1 +
 .../arm/mach-integrator/include/mach/entry-macro.S |   39 -----------
 arch/arm/mach-integrator/integrator_ap.c           |    9 +--
 arch/arm/mach-integrator/integrator_cp.c           |   28 ++------
 arch/arm/mach-versatile/core.c                     |   13 ++--
 arch/arm/plat-versatile/Kconfig                    |    6 ++
 arch/arm/plat-versatile/fpga-irq.c                 |   71 ++++++++++++++++++--
 arch/arm/plat-versatile/include/plat/fpga-irq.h    |    8 ++-
 8 files changed, 94 insertions(+), 81 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf006d4..2f67f6c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -280,6 +280,7 @@ config ARCH_INTEGRATOR
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for ARM's Integrator platform.
 
diff --git a/arch/arm/mach-integrator/include/mach/entry-macro.S b/arch/arm/mach-integrator/include/mach/entry-macro.S
deleted file mode 100644
index 5cc7b85..0000000
--- a/arch/arm/mach-integrator/include/mach/entry-macro.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * arch/arm/mach-integrator/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Integrator platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <mach/hardware.h>
-#include <mach/platform.h>
-#include <mach/irqs.h>
-
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-/* FIXME: should not be using soo many LDRs here */
-		ldr	\base, =IO_ADDRESS(INTEGRATOR_IC_BASE)
-		mov	\irqnr, #IRQ_PIC_START
-		ldr	\irqstat, [\base, #IRQ_STATUS]		@ get masked status
-		ldr	\base, =IO_ADDRESS(INTEGRATOR_HDR_BASE)
-		teq	\irqstat, #0
-		ldreq	\irqstat, [\base, #(INTEGRATOR_HDR_IC_OFFSET+IRQ_STATUS)]
-		moveq	\irqnr, #IRQ_CIC_START
-
-1001:		tst	\irqstat, #15
-		bne	1002f
-		add	\irqnr, \irqnr, #4
-		movs	\irqstat, \irqstat, lsr #4
-		bne	1001b
-1002:		tst	\irqstat, #1
-		bne	1003f
-		add	\irqnr, \irqnr, #1
-		movs	\irqstat, \irqstat, lsr #1
-		bne	1002b
-1003:		/* EQ will be set if no irqs pending */
-		.endm
-
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 871f148..acba6bf 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -162,12 +162,6 @@ static void __init ap_map_io(void)
 
 #define INTEGRATOR_SC_VALID_INT	0x003fffff
 
-static struct fpga_irq_data sc_irq_data = {
-	.base		= VA_IC_BASE,
-	.irq_start	= 0,
-	.chip.name	= "SC",
-};
-
 static void __init ap_init_irq(void)
 {
 	/* Disable all interrupts initially. */
@@ -178,7 +172,7 @@ static void __init ap_init_irq(void)
 	writel(-1, VA_IC_BASE + IRQ_ENABLE_CLEAR);
 	writel(-1, VA_IC_BASE + FIQ_ENABLE_CLEAR);
 
-	fpga_irq_init(-1, INTEGRATOR_SC_VALID_INT, &sc_irq_data);
+	fpga_irq_init(VA_IC_BASE, "SC", 0, -1, INTEGRATOR_SC_VALID_INT, NULL);
 }
 
 #ifdef CONFIG_PM
@@ -478,6 +472,7 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	.nr_irqs	= NR_IRQS_INTEGRATOR_AP,
 	.init_early	= integrator_init_early,
 	.init_irq	= ap_init_irq,
+	.handle_irq	= fpga_handle_irq,
 	.timer		= &ap_timer,
 	.init_machine	= ap_init,
 	.restart	= integrator_restart,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2172f4c..98666fc 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -143,24 +143,6 @@ static void __init intcp_map_io(void)
 	iotable_init(intcp_io_desc, ARRAY_SIZE(intcp_io_desc));
 }
 
-static struct fpga_irq_data cic_irq_data = {
-	.base		= INTCP_VA_CIC_BASE,
-	.irq_start	= IRQ_CIC_START,
-	.chip.name	= "CIC",
-};
-
-static struct fpga_irq_data pic_irq_data = {
-	.base		= INTCP_VA_PIC_BASE,
-	.irq_start	= IRQ_PIC_START,
-	.chip.name	= "PIC",
-};
-
-static struct fpga_irq_data sic_irq_data = {
-	.base		= INTCP_VA_SIC_BASE,
-	.irq_start	= IRQ_SIC_START,
-	.chip.name	= "SIC",
-};
-
 static void __init intcp_init_irq(void)
 {
 	u32 pic_mask, cic_mask, sic_mask;
@@ -179,11 +161,14 @@ static void __init intcp_init_irq(void)
 	writel(sic_mask, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
 	writel(sic_mask, INTCP_VA_SIC_BASE + FIQ_ENABLE_CLEAR);
 
-	fpga_irq_init(-1, pic_mask, &pic_irq_data);
+	fpga_irq_init(INTCP_VA_PIC_BASE, "PIC", IRQ_PIC_START,
+		      -1, pic_mask, NULL);
 
-	fpga_irq_init(-1, cic_mask, &cic_irq_data);
+	fpga_irq_init(INTCP_VA_CIC_BASE, "CIC", IRQ_CIC_START,
+		      -1, cic_mask, NULL);
 
-	fpga_irq_init(IRQ_CP_CPPLDINT, sic_mask, &sic_irq_data);
+	fpga_irq_init(INTCP_VA_SIC_BASE, "SIC", IRQ_SIC_START,
+		      IRQ_CP_CPPLDINT, sic_mask, NULL);
 }
 
 /*
@@ -466,6 +451,7 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	.nr_irqs	= NR_IRQS_INTEGRATOR_CP,
 	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq,
+	.handle_irq	= fpga_handle_irq,
 	.timer		= &cp_timer,
 	.init_machine	= intcp_init,
 	.restart	= integrator_restart,
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 6bbd74e..6f5fb46 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -66,12 +66,6 @@
 #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
 #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
 
-static struct fpga_irq_data sic_irq = {
-	.base		= VA_SIC_BASE,
-	.irq_start	= IRQ_SIC_START,
-	.chip.name	= "SIC",
-};
-
 #if 1
 #define IRQ_MMCI0A	IRQ_VICSOURCE22
 #define IRQ_AACI	IRQ_VICSOURCE24
@@ -105,8 +99,11 @@ void __init versatile_init_irq(void)
 
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
 
-	fpga_irq_init(IRQ_VICSOURCE31, ~PIC_MASK, &sic_irq);
-	irq_domain_generate_simple(sic_of_match, VERSATILE_SIC_BASE, IRQ_SIC_START);
+	np = of_find_matching_node_by_address(NULL, sic_of_match,
+					      VERSATILE_SIC_BASE);
+
+	fpga_irq_init(VA_SIC_BASE, "SIC", IRQ_SIC_START,
+		IRQ_VICSOURCE31, ~PIC_MASK, np);
 
 	/*
 	 * Interrupts on secondary controller from 0 to 8 are routed to
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 043f7b0..81ee7cc 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -5,6 +5,12 @@ config PLAT_VERSATILE_CLCD
 
 config PLAT_VERSATILE_FPGA_IRQ
 	bool
+	select IRQ_DOMAIN
+
+config PLAT_VERSATILE_FPGA_IRQ_NR
+       int
+       default 4
+       depends on PLAT_VERSATILE_FPGA_IRQ
 
 config PLAT_VERSATILE_LEDS
 	def_bool y if LEDS_CLASS
diff --git a/arch/arm/plat-versatile/fpga-irq.c b/arch/arm/plat-versatile/fpga-irq.c
index f0cc8e1..b7e06ea 100644
--- a/arch/arm/plat-versatile/fpga-irq.c
+++ b/arch/arm/plat-versatile/fpga-irq.c
@@ -3,7 +3,10 @@
  */
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
 
+#include <asm/exception.h>
 #include <asm/mach/irq.h>
 #include <plat/fpga-irq.h>
 
@@ -12,10 +15,14 @@
 #define IRQ_ENABLE_SET		0x08
 #define IRQ_ENABLE_CLEAR	0x0c
 
+/* we cannot allocate memory when VICs are initially registered */
+static struct fpga_irq_data fpga_irq_devices[CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR];
+static int fpga_irq_id;
+
 static void fpga_irq_mask(struct irq_data *d)
 {
 	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
-	u32 mask = 1 << (d->irq - f->irq_start);
+	u32 mask = (1 << d->hwirq);
 
 	writel(mask, f->base + IRQ_ENABLE_CLEAR);
 }
@@ -23,7 +30,7 @@ static void fpga_irq_mask(struct irq_data *d)
 static void fpga_irq_unmask(struct irq_data *d)
 {
 	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
-	u32 mask = 1 << (d->irq - f->irq_start);
+	u32 mask = (1 << d->hwirq);
 
 	writel(mask, f->base + IRQ_ENABLE_SET);
 }
@@ -41,15 +48,63 @@ static void fpga_irq_handle(unsigned int irq, struct irq_desc *desc)
 	do {
 		irq = ffs(status) - 1;
 		status &= ~(1 << irq);
-
-		generic_handle_irq(irq + f->irq_start);
+		generic_handle_irq(irq_find_mapping(f->domain, irq));
 	} while (status);
 }
 
-void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
+/*
+ * Handle each interrupt in a single FPGA IRQ controller.  Returns non-zero
+ * if we've handled at least one interrupt.  This does a single read of the
+ * status register and handles all interrupts in order from LSB first.
+ */
+static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
 {
+	int handled = 0;
+	int irq;
+	u32 status = readl(f->base + IRQ_STATUS);
+
+	while (status) {
+		irq = ffs(status) - 1;
+		handle_IRQ(irq_find_mapping(f->domain, irq), regs);
+		status &= ~(1 << irq);
+		handled = 1;
+	}
+
+	return handled;
+}
+
+/*
+ * Keep iterating over all registered FPGA IRQ controllers until there are
+ * no pending interrupts.
+ */
+asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
+{
+	int i, handled;
+
+	do {
+		for (i = 0, handled = 0; i < fpga_irq_id; ++i)
+			handled |= handle_one_fpga(&fpga_irq_devices[i], regs);
+	} while (handled);
+}
+
+
+
+void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
+			  int parent_irq, u32 valid, struct device_node *node)
+{
+	struct fpga_irq_data *f;
 	unsigned int i;
+	unsigned int used_irqs = 0;
+
+	if (fpga_irq_id >= ARRAY_SIZE(fpga_irq_devices)) {
+		printk(KERN_ERR "%s: too few FPGA IRQ controllers, increase CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR\n", __func__);
+		return;
+	}
 
+	f = &fpga_irq_devices[fpga_irq_id];
+	f->base = base;
+	f->irq_start = irq_start;
+	f->chip.name = name;
 	f->chip.irq_ack = fpga_irq_mask;
 	f->chip.irq_mask = fpga_irq_mask;
 	f->chip.irq_unmask = fpga_irq_unmask;
@@ -67,6 +122,12 @@ void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
 			irq_set_chip_and_handler(irq, &f->chip,
 						 handle_level_irq);
 			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			used_irqs++;
 		}
 	}
+	pr_info("FPGA IRQ chip %d @ %p, %u irqs\n",
+		fpga_irq_id, base, used_irqs);
+	f->domain = irq_domain_add_legacy(node, used_irqs, f->irq_start, 0,
+					  &irq_domain_simple_ops, f);
+	fpga_irq_id++;
 }
diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/arch/arm/plat-versatile/include/plat/fpga-irq.h
index 627fafd..7f8009a 100644
--- a/arch/arm/plat-versatile/include/plat/fpga-irq.h
+++ b/arch/arm/plat-versatile/include/plat/fpga-irq.h
@@ -5,8 +5,14 @@ struct fpga_irq_data {
 	void __iomem *base;
 	unsigned int irq_start;
 	struct irq_chip chip;
+	struct irq_domain *domain;
 };
 
-void fpga_irq_init(int, u32, struct fpga_irq_data *);
+struct device_node;
+struct pt_regs;
+
+void fpga_handle_irq(struct pt_regs *regs);
+void fpga_irq_init(void __iomem *, const char *, int, int, u32,
+		struct device_node *node);
 
 #endif
-- 
1.7.7.6
