From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:48:29 +0000
Subject: [PATCH 08/11] ARM: integrator/versatile: consolidate FPGA IRQ
	handling code
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSD7-0003pL-11@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consolidate the FPGA IRQ handling code.  Integrator/AP and Versatile
have one FPGA-based IRQ handler each.  Integrator/CP has three.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                                |    2 +
 arch/arm/mach-integrator/integrator_ap.c        |   41 ++-----
 arch/arm/mach-integrator/integrator_cp.c        |  142 +++++------------------
 arch/arm/mach-versatile/core.c                  |   57 +--------
 arch/arm/mach-versatile/include/mach/hardware.h |    2 +-
 arch/arm/plat-versatile/Kconfig                 |    3 +
 arch/arm/plat-versatile/Makefile                |    1 +
 arch/arm/plat-versatile/fpga-irq.c              |   72 ++++++++++++
 arch/arm/plat-versatile/include/plat/fpga-irq.h |   12 ++
 9 files changed, 140 insertions(+), 192 deletions(-)
 create mode 100644 arch/arm/plat-versatile/fpga-irq.c
 create mode 100644 arch/arm/plat-versatile/include/plat/fpga-irq.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe8d6fa..a6ccef6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -229,6 +229,7 @@ config ARCH_INTEGRATOR
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_FPGA_IRQ
 	help
 	  Support for ARM's Integrator platform.
 
@@ -256,6 +257,7 @@ config ARCH_VERSATILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select PLAT_VERSATILE_FPGA_IRQ
 	select ARM_TIMER_SP804
 	help
 	  This enables support for ARM Ltd Versatile board.
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 4f06b5d..980803f 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -48,6 +48,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
+#include <plat/fpga-irq.h>
+
 #include "common.h"
 
 /* 
@@ -57,10 +59,10 @@
  * Setup a VA for the Integrator interrupt controller (for header #0,
  * just for now).
  */
-#define VA_IC_BASE	IO_ADDRESS(INTEGRATOR_IC_BASE) 
-#define VA_SC_BASE	IO_ADDRESS(INTEGRATOR_SC_BASE)
-#define VA_EBI_BASE	IO_ADDRESS(INTEGRATOR_EBI_BASE)
-#define VA_CMIC_BASE	IO_ADDRESS(INTEGRATOR_HDR_IC)
+#define VA_IC_BASE	__io_address(INTEGRATOR_IC_BASE)
+#define VA_SC_BASE	__io_address(INTEGRATOR_SC_BASE)
+#define VA_EBI_BASE	__io_address(INTEGRATOR_EBI_BASE)
+#define VA_CMIC_BASE	__io_address(INTEGRATOR_HDR_IC)
 
 /*
  * Logical      Physical
@@ -156,27 +158,14 @@ static void __init ap_map_io(void)
 
 #define INTEGRATOR_SC_VALID_INT	0x003fffff
 
-static void sc_mask_irq(struct irq_data *d)
-{
-	writel(1 << d->irq, VA_IC_BASE + IRQ_ENABLE_CLEAR);
-}
-
-static void sc_unmask_irq(struct irq_data *d)
-{
-	writel(1 << d->irq, VA_IC_BASE + IRQ_ENABLE_SET);
-}
-
-static struct irq_chip sc_chip = {
-	.name		= "SC",
-	.irq_ack	= sc_mask_irq,
-	.irq_mask	= sc_mask_irq,
-	.irq_unmask	= sc_unmask_irq,
+static struct fpga_irq_data sc_irq_data = {
+	.base		= VA_IC_BASE,
+	.irq_start	= 0,
+	.chip.name	= "SC",
 };
 
 static void __init ap_init_irq(void)
 {
-	unsigned int i;
-
 	/* Disable all interrupts initially. */
 	/* Do the core module ones */
 	writel(-1, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
@@ -185,13 +174,7 @@ static void __init ap_init_irq(void)
 	writel(-1, VA_IC_BASE + IRQ_ENABLE_CLEAR);
 	writel(-1, VA_IC_BASE + FIQ_ENABLE_CLEAR);
 
-	for (i = 0; i < NR_IRQS; i++) {
-		if (((1 << i) & INTEGRATOR_SC_VALID_INT) != 0) {
-			set_irq_chip(i, &sc_chip);
-			set_irq_handler(i, handle_level_irq);
-			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-		}
-	}
+	fpga_irq_init(-1, INTEGRATOR_SC_VALID_INT, &sc_irq_data);
 }
 
 #ifdef CONFIG_PM
@@ -282,7 +265,7 @@ static void ap_flash_exit(void)
 
 static void ap_flash_set_vpp(int on)
 {
-	unsigned long reg = on ? SC_CTRLS : SC_CTRLC;
+	void __iomem *reg = on ? SC_CTRLS : SC_CTRLC;
 
 	writel(INTEGRATOR_SC_CTRL_nFLVPPEN, reg);
 }
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index e6700aa..05da36f 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -43,6 +43,7 @@
 #include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
+#include <plat/fpga-irq.h>
 
 #include "common.h"
 
@@ -51,9 +52,9 @@
 
 #define INTCP_PA_CLCD_BASE		0xc0000000
 
-#define INTCP_VA_CIC_BASE		IO_ADDRESS(INTEGRATOR_HDR_BASE + 0x40)
-#define INTCP_VA_PIC_BASE		IO_ADDRESS(INTEGRATOR_IC_BASE)
-#define INTCP_VA_SIC_BASE		IO_ADDRESS(INTEGRATOR_CP_SIC_BASE)
+#define INTCP_VA_CIC_BASE		__io_address(INTEGRATOR_HDR_BASE + 0x40)
+#define INTCP_VA_PIC_BASE		__io_address(INTEGRATOR_IC_BASE)
+#define INTCP_VA_SIC_BASE		__io_address(INTEGRATOR_CP_SIC_BASE)
 
 #define INTCP_ETH_SIZE			0x10
 
@@ -141,129 +142,48 @@ static void __init intcp_map_io(void)
 	iotable_init(intcp_io_desc, ARRAY_SIZE(intcp_io_desc));
 }
 
-#define cic_writel	__raw_writel
-#define cic_readl	__raw_readl
-#define pic_writel	__raw_writel
-#define pic_readl	__raw_readl
-#define sic_writel	__raw_writel
-#define sic_readl	__raw_readl
-
-static void cic_mask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_CIC_START;
-	cic_writel(1 << irq, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
-}
-
-static void cic_unmask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_CIC_START;
-	cic_writel(1 << irq, INTCP_VA_CIC_BASE + IRQ_ENABLE_SET);
-}
-
-static struct irq_chip cic_chip = {
-	.name		= "CIC",
-	.irq_ack	= cic_mask_irq,
-	.irq_mask	= cic_mask_irq,
-	.irq_unmask	= cic_unmask_irq,
+static struct fpga_irq_data cic_irq_data = {
+	.base		= INTCP_VA_CIC_BASE,
+	.irq_start	= IRQ_CIC_START,
+	.chip.name	= "CIC",
 };
 
-static void pic_mask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_PIC_START;
-	pic_writel(1 << irq, INTCP_VA_PIC_BASE + IRQ_ENABLE_CLEAR);
-}
-
-static void pic_unmask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_PIC_START;
-	pic_writel(1 << irq, INTCP_VA_PIC_BASE + IRQ_ENABLE_SET);
-}
-
-static struct irq_chip pic_chip = {
-	.name		= "PIC",
-	.irq_ack	= pic_mask_irq,
-	.irq_mask	= pic_mask_irq,
-	.irq_unmask	= pic_unmask_irq,
+static struct fpga_irq_data pic_irq_data = {
+	.base		= INTCP_VA_PIC_BASE,
+	.irq_start	= IRQ_PIC_START,
+	.chip.name	= "PIC",
 };
 
-static void sic_mask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_SIC_START;
-	sic_writel(1 << irq, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
-}
-
-static void sic_unmask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_SIC_START;
-	sic_writel(1 << irq, INTCP_VA_SIC_BASE + IRQ_ENABLE_SET);
-}
-
-static struct irq_chip sic_chip = {
-	.name		= "SIC",
-	.irq_ack	= sic_mask_irq,
-	.irq_mask	= sic_mask_irq,
-	.irq_unmask	= sic_unmask_irq,
+static struct fpga_irq_data sic_irq_data = {
+	.base		= INTCP_VA_SIC_BASE,
+	.irq_start	= IRQ_SIC_START,
+	.chip.name	= "SIC",
 };
 
-static void
-sic_handle_irq(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long status = sic_readl(INTCP_VA_SIC_BASE + IRQ_STATUS);
-
-	if (status == 0) {
-		do_bad_IRQ(irq, desc);
-		return;
-	}
-
-	do {
-		irq = ffs(status) - 1;
-		status &= ~(1 << irq);
-
-		irq += IRQ_SIC_START;
-
-		generic_handle_irq(irq);
-	} while (status);
-}
-
 static void __init intcp_init_irq(void)
 {
-	unsigned int i;
+	u32 pic_mask, sic_mask;
+
+	pic_mask = ~((~0u) << (11 - IRQ_PIC_START));
+	pic_mask |= (~((~0u) << (29 - 22))) << 22;
+	sic_mask = ~((~0u) << (1 + IRQ_SIC_END - IRQ_SIC_START));
 
 	/*
 	 * Disable all interrupt sources
 	 */
-	pic_writel(0xffffffff, INTCP_VA_PIC_BASE + IRQ_ENABLE_CLEAR);
-	pic_writel(0xffffffff, INTCP_VA_PIC_BASE + FIQ_ENABLE_CLEAR);
-
-	for (i = IRQ_PIC_START; i <= IRQ_PIC_END; i++) {
-		if (i == 11)
-			i = 22;
-		if (i == 29)
-			break;
-		set_irq_chip(i, &pic_chip);
-		set_irq_handler(i, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-	}
+	writel(0xffffffff, INTCP_VA_PIC_BASE + IRQ_ENABLE_CLEAR);
+	writel(0xffffffff, INTCP_VA_PIC_BASE + FIQ_ENABLE_CLEAR);
+	writel(0xffffffff, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
+	writel(0xffffffff, INTCP_VA_CIC_BASE + FIQ_ENABLE_CLEAR);
+	writel(sic_mask, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
+	writel(sic_mask, INTCP_VA_SIC_BASE + FIQ_ENABLE_CLEAR);
 
-	cic_writel(0xffffffff, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
-	cic_writel(0xffffffff, INTCP_VA_CIC_BASE + FIQ_ENABLE_CLEAR);
+	fpga_irq_init(-1, pic_mask, &pic_irq_data);
 
-	for (i = IRQ_CIC_START; i <= IRQ_CIC_END; i++) {
-		set_irq_chip(i, &cic_chip);
-		set_irq_handler(i, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-	}
-
-	sic_writel(0x00000fff, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
-	sic_writel(0x00000fff, INTCP_VA_SIC_BASE + FIQ_ENABLE_CLEAR);
-
-	for (i = IRQ_SIC_START; i <= IRQ_SIC_END; i++) {
-		set_irq_chip(i, &sic_chip);
-		set_irq_handler(i, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-	}
+	fpga_irq_init(-1, ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START)),
+		&cic_irq_data);
 
-	set_irq_chained_handler(IRQ_CP_CPPLDINT, sic_handle_irq);
+	fpga_irq_init(IRQ_CP_CPPLDINT, sic_mask, &sic_irq_data);
 }
 
 /*
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 630a1c9..eb7ffa0 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -51,6 +51,7 @@
 #include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
+#include <plat/fpga-irq.h>
 #include <plat/sched_clock.h>
 
 #include "core.h"
@@ -64,47 +65,12 @@
 #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
 #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
 
-static void sic_mask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_SIC_START;
-
-	writel(1 << irq, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
-}
-
-static void sic_unmask_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq - IRQ_SIC_START;
-
-	writel(1 << irq, VA_SIC_BASE + SIC_IRQ_ENABLE_SET);
-}
-
-static struct irq_chip sic_chip = {
-	.name		= "SIC",
-	.irq_ack	= sic_mask_irq,
-	.irq_mask	= sic_mask_irq,
-	.irq_unmask	= sic_unmask_irq,
+static struct fpga_irq_data sic_irq = {
+	.base		= VA_SIC_BASE,
+	.irq_start	= IRQ_SIC_START,
+	.chip.name	= "SIC",
 };
 
-static void
-sic_handle_irq(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long status = readl(VA_SIC_BASE + SIC_IRQ_STATUS);
-
-	if (status == 0) {
-		do_bad_IRQ(irq, desc);
-		return;
-	}
-
-	do {
-		irq = ffs(status) - 1;
-		status &= ~(1 << irq);
-
-		irq += IRQ_SIC_START;
-
-		generic_handle_irq(irq);
-	} while (status);
-}
-
 #if 1
 #define IRQ_MMCI0A	IRQ_VICSOURCE22
 #define IRQ_AACI	IRQ_VICSOURCE24
@@ -119,22 +85,11 @@ sic_handle_irq(unsigned int irq, struct irq_desc *desc)
 
 void __init versatile_init_irq(void)
 {
-	unsigned int i;
-
 	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0, 0);
 
-	set_irq_chained_handler(IRQ_VICSOURCE31, sic_handle_irq);
-
-	/* Do second interrupt controller */
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
 
-	for (i = IRQ_SIC_START; i <= IRQ_SIC_END; i++) {
-		if ((PIC_MASK & (1 << (i - IRQ_SIC_START))) == 0) {
-			set_irq_chip(i, &sic_chip);
-			set_irq_handler(i, handle_level_irq);
-			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-		}
-	}
+	fpga_irq_init(IRQ_VICSOURCE31, ~PIC_MASK, &sic_irq);
 
 	/*
 	 * Interrupts on secondary controller from 0 to 8 are routed to
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index b5e75bb..6911e1f 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -39,6 +39,6 @@
 /* macro to get@IO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
 
-#define __io_address(n)		__io(IO_ADDRESS(n))
+#define __io_address(n)		((void __iomem __force *)IO_ADDRESS(n))
 
 #endif
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index c5e2cd0..0b27500 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -3,6 +3,9 @@ if PLAT_VERSATILE
 config PLAT_VERSATILE_CLCD
 	bool
 
+config PLAT_VERSATILE_FPGA_IRQ
+	bool
+
 config PLAT_VERSATILE_LEDS
 	def_bool y if LEDS_CLASS
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index de6f42f..41f57f4 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,5 +1,6 @@
 obj-y	:= clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
+obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
 
diff --git a/arch/arm/plat-versatile/fpga-irq.c b/arch/arm/plat-versatile/fpga-irq.c
new file mode 100644
index 0000000..31d945d
--- /dev/null
+++ b/arch/arm/plat-versatile/fpga-irq.c
@@ -0,0 +1,72 @@
+/*
+ *  Support for Versatile FPGA-based IRQ controllers
+ */
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <asm/mach/irq.h>
+#include <plat/fpga-irq.h>
+
+#define IRQ_STATUS		0x00
+#define IRQ_RAW_STATUS		0x04
+#define IRQ_ENABLE_SET		0x08
+#define IRQ_ENABLE_CLEAR	0x0c
+
+static void fpga_irq_mask(struct irq_data *d)
+{
+	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
+	u32 mask = 1 << (d->irq - f->irq_start);
+
+	writel(mask, f->base + IRQ_ENABLE_CLEAR);
+}
+
+static void fpga_irq_unmask(struct irq_data *d)
+{
+	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
+	u32 mask = 1 << (d->irq - f->irq_start);
+
+	writel(mask, f->base + IRQ_ENABLE_SET);
+}
+
+static void fpga_irq_handle(unsigned int irq, struct irq_desc *desc)
+{
+	struct fpga_irq_data *f = get_irq_desc_data(desc);
+	u32 status = readl(f->base + IRQ_STATUS);
+
+	if (status == 0) {
+		do_bad_IRQ(irq, desc);
+		return;
+	}
+
+	do {
+		irq = ffs(status) - 1;
+		status &= ~(1 << irq);
+
+		generic_handle_irq(irq + f->irq_start);
+	} while (status);
+}
+
+void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
+{
+	unsigned int i;
+
+	f->chip.irq_ack = fpga_irq_mask;
+	f->chip.irq_mask = fpga_irq_mask;
+	f->chip.irq_unmask = fpga_irq_unmask;
+
+	if (parent_irq != -1) {
+		set_irq_data(parent_irq, f);
+		set_irq_chained_handler(parent_irq, fpga_irq_handle);
+	}
+
+	for (i = 0; i < 32; i++) {
+		if (valid & (1 << i)) {
+			unsigned int irq = f->irq_start + i;
+
+			set_irq_chip_data(irq, f);
+			set_irq_chip(irq, &f->chip);
+			set_irq_handler(irq, handle_level_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		}
+	}
+}
diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/arch/arm/plat-versatile/include/plat/fpga-irq.h
new file mode 100644
index 0000000..627fafd
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/fpga-irq.h
@@ -0,0 +1,12 @@
+#ifndef PLAT_FPGA_IRQ_H
+#define PLAT_FPGA_IRQ_H
+
+struct fpga_irq_data {
+	void __iomem *base;
+	unsigned int irq_start;
+	struct irq_chip chip;
+};
+
+void fpga_irq_init(int, u32, struct fpga_irq_data *);
+
+#endif
-- 
1.6.2.5
