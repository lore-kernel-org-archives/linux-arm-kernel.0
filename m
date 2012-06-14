From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:42 +0800
Subject: [PATCH 11/16] ARM: imx: add a legacy irqdomain for mx31ads
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call irq_alloc_descs to get the irq_base for mx31ads, and add a legacy
irqdomain using the irq_base, so that the mapping between mx31ads
hardware irq and Linux irq number can be dynamically handled by
irqdomain.  As the result, the use of MXC_BOARD_IRQ_START can be
completely removed from mach-mx31ads.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-mx31ads.c |   48 ++++++++++++++++++++++++-------------
 1 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index a27a854..d37f480 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -63,18 +64,17 @@
 #define PBC_INTMASK_SET_REG	(PBC_INTMASK_SET + PBC_BASE_ADDRESS)
 #define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
 
-#define MXC_EXP_IO_BASE		MXC_BOARD_IRQ_START
-#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
-
-#define EXPIO_INT_XUART_INTA	(MXC_EXP_IO_BASE + 10)
-#define EXPIO_INT_XUART_INTB	(MXC_EXP_IO_BASE + 11)
+#define EXPIO_INT_XUART_INTA	10
+#define EXPIO_INT_XUART_INTB	11
 
 #define MXC_MAX_EXP_IO_LINES	16
 
 /* CS8900 */
-#define EXPIO_INT_ENET_INT	(MXC_EXP_IO_BASE + 8)
+#define EXPIO_INT_ENET_INT	8
 #define CS4_CS8900_MMIO_START	0x20000
 
+static struct irq_domain *domain;
+
 /*
  * The serial port definition structure.
  */
@@ -82,7 +82,6 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.membase  = (void *)(PBC_BASE_ADDRESS + PBC_SC16C652_UARTA),
 		.mapbase  = (unsigned long)(MX31_CS4_BASE_ADDR + PBC_SC16C652_UARTA),
-		.irq      = EXPIO_INT_XUART_INTA,
 		.uartclk  = 14745600,
 		.regshift = 0,
 		.iotype   = UPIO_MEM,
@@ -90,7 +89,6 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	}, {
 		.membase  = (void *)(PBC_BASE_ADDRESS + PBC_SC16C652_UARTB),
 		.mapbase  = (unsigned long)(MX31_CS4_BASE_ADDR + PBC_SC16C652_UARTB),
-		.irq      = EXPIO_INT_XUART_INTB,
 		.uartclk  = 14745600,
 		.regshift = 0,
 		.iotype   = UPIO_MEM,
@@ -107,9 +105,9 @@ static struct platform_device serial_device = {
 	},
 };
 
-static const struct resource mx31ads_cs8900_resources[] __initconst = {
+static struct resource mx31ads_cs8900_resources[] __initdata = {
 	DEFINE_RES_MEM(MX31_CS4_BASE_ADDR + CS4_CS8900_MMIO_START, SZ_64K),
-	DEFINE_RES_IRQ(EXPIO_INT_ENET_INT),
+	DEFINE_RES_IRQ(-1),
 };
 
 static const struct platform_device_info mx31ads_cs8900_devinfo __initconst = {
@@ -121,11 +119,19 @@ static const struct platform_device_info mx31ads_cs8900_devinfo __initconst = {
 
 static int __init mxc_init_extuart(void)
 {
+	serial_platform_data[0].irq = irq_find_mapping(domain,
+						       EXPIO_INT_XUART_INTA);
+	serial_platform_data[1].irq = irq_find_mapping(domain,
+						       EXPIO_INT_XUART_INTB);
 	return platform_device_register(&serial_device);
 }
 
 static void __init mxc_init_ext_ethernet(void)
 {
+	mx31ads_cs8900_resources[1].start =
+			irq_find_mapping(domain, EXPIO_INT_ENET_INT);
+	mx31ads_cs8900_resources[1].end =
+			irq_find_mapping(domain, EXPIO_INT_ENET_INT);
 	platform_device_register_full(
 		(struct platform_device_info *)&mx31ads_cs8900_devinfo);
 }
@@ -156,12 +162,12 @@ static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
 	imr_val = __raw_readw(PBC_INTMASK_SET_REG);
 	int_valid = __raw_readw(PBC_INTSTATUS_REG) & imr_val;
 
-	expio_irq = MXC_EXP_IO_BASE;
+	expio_irq = 0;
 	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
 		if ((int_valid & 1) == 0)
 			continue;
 
-		generic_handle_irq(expio_irq);
+		generic_handle_irq(irq_find_mapping(domain, expio_irq));
 	}
 }
 
@@ -171,7 +177,7 @@ static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
  */
 static void expio_mask_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->hwirq;
 	/* mask the interrupt */
 	__raw_writew(1 << expio, PBC_INTMASK_CLEAR_REG);
 	__raw_readw(PBC_INTMASK_CLEAR_REG);
@@ -183,7 +189,7 @@ static void expio_mask_irq(struct irq_data *d)
  */
 static void expio_ack_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->hwirq;
 	/* clear the interrupt status */
 	__raw_writew(1 << expio, PBC_INTSTATUS_REG);
 }
@@ -194,7 +200,7 @@ static void expio_ack_irq(struct irq_data *d)
  */
 static void expio_unmask_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->hwirq;
 	/* unmask the interrupt */
 	__raw_writew(1 << expio, PBC_INTMASK_SET_REG);
 }
@@ -208,6 +214,7 @@ static struct irq_chip expio_irq_chip = {
 
 static void __init mx31ads_init_expio(void)
 {
+	int irq_base;
 	int i, irq;
 
 	printk(KERN_INFO "MX31ADS EXPIO(CPLD) hardware\n");
@@ -220,8 +227,15 @@ static void __init mx31ads_init_expio(void)
 	/* disable the interrupt and clear the status */
 	__raw_writew(0xFFFF, PBC_INTMASK_CLEAR_REG);
 	__raw_writew(0xFFFF, PBC_INTSTATUS_REG);
-	for (i = MXC_EXP_IO_BASE; i < (MXC_EXP_IO_BASE + MXC_MAX_EXP_IO_LINES);
-	     i++) {
+
+	irq_base = irq_alloc_descs(-1, 0, MXC_MAX_EXP_IO_LINES, numa_node_id());
+	WARN_ON(irq_base < 0);
+
+	domain = irq_domain_add_legacy(NULL, MXC_MAX_EXP_IO_LINES, irq_base, 0,
+				       &irq_domain_simple_ops, NULL);
+	WARN_ON(!domain);
+
+	for (i = irq_base; i < irq_base + MXC_MAX_EXP_IO_LINES; i++) {
 		irq_set_chip_and_handler(i, &expio_irq_chip, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
-- 
1.7.5.4
