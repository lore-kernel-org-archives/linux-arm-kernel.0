From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:41 +0800
Subject: [PATCH 10/16] ARM: imx: add a legacy irqdomain for 3ds_debugboard
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call irq_alloc_descs to get the irq_base for 3ds_debugboard, and add
a legacy irqdomain using the irq_base, so that the mapping between
3ds_debugboard hardware irq and Linux irq number can be dynamically
handled by irqdomain.  As the result, the use of MXC_BOARD_IRQ_START
can be completely removed from 3ds_debugboard.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/3ds_debugboard.c |   42 +++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
index 3b48a08..5c10ad0 100644
--- a/arch/arm/plat-mxc/3ds_debugboard.c
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -12,9 +12,11 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/module.h>
 #include <linux/smsc911x.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
@@ -48,26 +50,22 @@
 /* CPU ID and Personality ID */
 #define MCU_BOARD_ID_REG	0x68
 
-#define MXC_IRQ_TO_EXPIO(irq)   ((irq) - MXC_BOARD_IRQ_START)
-
-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
 #define MXC_MAX_EXP_IO_LINES	16
 
 /* interrupts like external uart , external ethernet etc*/
-#define EXPIO_INT_ENET		(MXC_BOARD_IRQ_START + 0)
-#define EXPIO_INT_XUART_A	(MXC_BOARD_IRQ_START + 1)
-#define EXPIO_INT_XUART_B	(MXC_BOARD_IRQ_START + 2)
-#define EXPIO_INT_BUTTON_A	(MXC_BOARD_IRQ_START + 3)
-#define EXPIO_INT_BUTTON_B	(MXC_BOARD_IRQ_START + 4)
+#define EXPIO_INT_ENET		0
+#define EXPIO_INT_XUART_A	1
+#define EXPIO_INT_XUART_B	2
+#define EXPIO_INT_BUTTON_A	3
+#define EXPIO_INT_BUTTON_B	4
 
 static void __iomem *brd_io;
+static struct irq_domain *domain;
 
 static struct resource smsc911x_resources[] = {
 	{
 		.flags = IORESOURCE_MEM,
 	} , {
-		.start = EXPIO_INT_ENET,
-		.end = EXPIO_INT_ENET,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -99,11 +97,11 @@ static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
 	imr_val = __raw_readw(brd_io + INTR_MASK_REG);
 	int_valid = __raw_readw(brd_io + INTR_STATUS_REG) & ~imr_val;
 
-	expio_irq = MXC_BOARD_IRQ_START;
+	expio_irq = 0;
 	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
 		if ((int_valid & 1) == 0)
 			continue;
-		generic_handle_irq(expio_irq);
+		generic_handle_irq(irq_find_mapping(domain, expio_irq));
 	}
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
@@ -117,7 +115,7 @@ static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
 static void expio_mask_irq(struct irq_data *d)
 {
 	u16 reg;
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->hwirq;
 
 	reg = __raw_readw(brd_io + INTR_MASK_REG);
 	reg |= (1 << expio);
@@ -126,7 +124,7 @@ static void expio_mask_irq(struct irq_data *d)
 
 static void expio_ack_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->hwirq;
 
 	__raw_writew(1 << expio, brd_io + INTR_RESET_REG);
 	__raw_writew(0, brd_io + INTR_RESET_REG);
@@ -136,7 +134,7 @@ static void expio_ack_irq(struct irq_data *d)
 static void expio_unmask_irq(struct irq_data *d)
 {
 	u16 reg;
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->hwirq;
 
 	reg = __raw_readw(brd_io + INTR_MASK_REG);
 	reg &= ~(1 << expio);
@@ -157,6 +155,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 int __init mxc_expio_init(u32 base, u32 intr_gpio)
 {
 	u32 p_irq = gpio_to_irq(intr_gpio);
+	int irq_base;
 	int i;
 
 	brd_io = ioremap(BOARD_IO_ADDR(base), SZ_4K);
@@ -186,8 +185,15 @@ int __init mxc_expio_init(u32 base, u32 intr_gpio)
 	__raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
 	__raw_writew(0, brd_io + INTR_RESET_REG);
 	__raw_writew(0x1F, brd_io + INTR_MASK_REG);
-	for (i = MXC_EXP_IO_BASE;
-	     i < (MXC_EXP_IO_BASE + MXC_MAX_EXP_IO_LINES); i++) {
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
@@ -199,6 +205,8 @@ int __init mxc_expio_init(u32 base, u32 intr_gpio)
 
 	smsc911x_resources[0].start = LAN9217_BASE_ADDR(base);
 	smsc911x_resources[0].end = LAN9217_BASE_ADDR(base) + 0x100 - 1;
+	smsc911x_resources[1].start = irq_find_mapping(domain, EXPIO_INT_ENET);
+	smsc911x_resources[1].end = irq_find_mapping(domain, EXPIO_INT_ENET);
 	platform_device_register(&smsc_lan9217_device);
 
 	return 0;
-- 
1.7.5.4
