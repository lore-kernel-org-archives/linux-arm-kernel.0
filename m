From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:22 +0200
Subject: [PATCH 6/9] ARM i.MX 3ds debugboard: allocate irqs dynamically
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/3ds_debugboard.c |   53 ++++++++++++++++++++---------------
 1 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
index f0ba072..e644cd9 100644
--- a/arch/arm/plat-mxc/3ds_debugboard.c
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -46,18 +46,14 @@
 /* CPU ID and Personality ID */
 #define MCU_BOARD_ID_REG	0x68
 
-#define MXC_IRQ_TO_EXPIO(irq)   ((irq) - MXC_BOARD_IRQ_START)
-#define MXC_IRQ_TO_GPIO(irq)	((irq) - MXC_INTERNAL_IRQS)
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
 
@@ -65,8 +61,6 @@ static struct resource smsc911x_resources[] = {
 	{
 		.flags = IORESOURCE_MEM,
 	} , {
-		.start = EXPIO_INT_ENET,
-		.end = EXPIO_INT_ENET,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -86,6 +80,8 @@ static struct platform_device smsc_lan9217_device = {
 	.resource = smsc911x_resources,
 };
 
+static int mxc_expio_base_irq;
+
 static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	u32 imr_val;
@@ -98,7 +94,7 @@ static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
 	imr_val = __raw_readw(brd_io + INTR_MASK_REG);
 	int_valid = __raw_readw(brd_io + INTR_STATUS_REG) & ~imr_val;
 
-	expio_irq = MXC_BOARD_IRQ_START;
+	expio_irq = mxc_expio_base_irq;
 	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
 		if ((int_valid & 1) == 0)
 			continue;
@@ -116,7 +112,7 @@ static void mxc_expio_irq_handler(u32 irq, struct irq_desc *desc)
 static void expio_mask_irq(struct irq_data *d)
 {
 	u16 reg;
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->irq - mxc_expio_base_irq;
 
 	reg = __raw_readw(brd_io + INTR_MASK_REG);
 	reg |= (1 << expio);
@@ -125,7 +121,7 @@ static void expio_mask_irq(struct irq_data *d)
 
 static void expio_ack_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->irq - mxc_expio_base_irq;
 
 	__raw_writew(1 << expio, brd_io + INTR_RESET_REG);
 	__raw_writew(0, brd_io + INTR_RESET_REG);
@@ -135,7 +131,7 @@ static void expio_ack_irq(struct irq_data *d)
 static void expio_unmask_irq(struct irq_data *d)
 {
 	u16 reg;
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
+	u32 expio = d->irq - mxc_expio_base_irq;
 
 	reg = __raw_readw(brd_io + INTR_MASK_REG);
 	reg &= ~(1 << expio);
@@ -150,7 +146,7 @@ static struct irq_chip expio_irq_chip = {
 
 int __init mxc_expio_init(u32 base, u32 p_irq)
 {
-	int i;
+	int ret, i;
 
 	brd_io = ioremap(BOARD_IO_ADDR(base), SZ_4K);
 	if (brd_io == NULL)
@@ -160,9 +156,8 @@ int __init mxc_expio_init(u32 base, u32 p_irq)
 	    (__raw_readw(brd_io + MAGIC_NUMBER2_REG) != 0x5555) ||
 	    (__raw_readw(brd_io + MAGIC_NUMBER3_REG) != 0xCAFE)) {
 		pr_info("3-Stack Debug board not detected\n");
-		iounmap(brd_io);
-		brd_io = NULL;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	pr_info("3-Stack Debug board detected, rev = 0x%04X\n",
@@ -171,16 +166,23 @@ int __init mxc_expio_init(u32 base, u32 p_irq)
 	/*
 	 * Configure INT line as GPIO input
 	 */
-	gpio_request(MXC_IRQ_TO_GPIO(p_irq), "expio_pirq");
-	gpio_direction_input(MXC_IRQ_TO_GPIO(p_irq));
+	gpio_request(irq_to_gpio(p_irq), "expio_pirq");
+	gpio_direction_input(irq_to_gpio(p_irq));
 
 	/* disable the interrupt and clear the status */
 	__raw_writew(0, brd_io + INTR_MASK_REG);
 	__raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
 	__raw_writew(0, brd_io + INTR_RESET_REG);
 	__raw_writew(0x1F, brd_io + INTR_MASK_REG);
-	for (i = MXC_EXP_IO_BASE;
-	     i < (MXC_EXP_IO_BASE + MXC_MAX_EXP_IO_LINES); i++) {
+
+	mxc_expio_base_irq = irq_alloc_descs(-1, 0, MXC_MAX_EXP_IO_LINES, 0);
+	if (mxc_expio_base_irq < 0) {
+		ret = mxc_expio_base_irq;
+		goto out;
+	}
+
+	for (i = mxc_expio_base_irq;
+	     i < mxc_expio_base_irq + MXC_MAX_EXP_IO_LINES; i++) {
 		irq_set_chip_and_handler(i, &expio_irq_chip, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
@@ -190,7 +192,12 @@ int __init mxc_expio_init(u32 base, u32 p_irq)
 	/* Register Lan device on the debugboard */
 	smsc911x_resources[0].start = LAN9217_BASE_ADDR(base);
 	smsc911x_resources[0].end = LAN9217_BASE_ADDR(base) + 0x100 - 1;
+	smsc911x_resources[1].start = mxc_expio_base_irq + EXPIO_INT_ENET;
+	smsc911x_resources[1].end = mxc_expio_base_irq + EXPIO_INT_ENET;
 	platform_device_register(&smsc_lan9217_device);
 
 	return 0;
+out:
+	iounmap(brd_io);
+	return ret;
 }
-- 
1.7.4.1
