From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 25 Apr 2015 23:13:22 +0200
Subject: [PATCH v5 2/3] ARM: pxa: mainstone: use new pxa_cplds driver
In-Reply-To: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
References: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1429996403-13644-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the interrupt handling was transferred to the pxa_cplds driver,
make the switch in mainstone platform code.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/include/mach/mainstone.h |   6 +-
 arch/arm/mach-pxa/mainstone.c              | 115 +++++++----------------------
 2 files changed, 31 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h b/arch/arm/mach-pxa/include/mach/mainstone.h
index 1bfc4e8..e82a7d3 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/include/mach/mainstone.h
@@ -120,7 +120,9 @@
 #define MST_PCMCIA_PWR_VCC_50   0x4	   /* voltage VCC = 5.0V */
 
 /* board specific IRQs */
-#define MAINSTONE_IRQ(x)	(IRQ_BOARD_START + (x))
+#define MAINSTONE_NR_IRQS	IRQ_BOARD_START
+
+#define MAINSTONE_IRQ(x)	(MAINSTONE_NR_IRQS + (x))
 #define MAINSTONE_MMC_IRQ	MAINSTONE_IRQ(0)
 #define MAINSTONE_USIM_IRQ	MAINSTONE_IRQ(1)
 #define MAINSTONE_USBC_IRQ	MAINSTONE_IRQ(2)
@@ -136,6 +138,4 @@
 #define MAINSTONE_S1_STSCHG_IRQ	MAINSTONE_IRQ(14)
 #define MAINSTONE_S1_IRQ	MAINSTONE_IRQ(15)
 
-#define MAINSTONE_NR_IRQS	(IRQ_BOARD_START + 16)
-
 #endif
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 78b84c0..2c0658c 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -13,6 +13,7 @@
  *  published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
@@ -122,92 +123,6 @@ static unsigned long mainstone_pin_config[] = {
 	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
 };
 
-static unsigned long mainstone_irq_enabled;
-
-static void mainstone_mask_irq(struct irq_data *d)
-{
-	int mainstone_irq = (d->irq - MAINSTONE_IRQ(0));
-	MST_INTMSKENA = (mainstone_irq_enabled &= ~(1 << mainstone_irq));
-}
-
-static void mainstone_unmask_irq(struct irq_data *d)
-{
-	int mainstone_irq = (d->irq - MAINSTONE_IRQ(0));
-	/* the irq can be acknowledged only if deasserted, so it's done here */
-	MST_INTSETCLR &= ~(1 << mainstone_irq);
-	MST_INTMSKENA = (mainstone_irq_enabled |= (1 << mainstone_irq));
-}
-
-static struct irq_chip mainstone_irq_chip = {
-	.name		= "FPGA",
-	.irq_ack	= mainstone_mask_irq,
-	.irq_mask	= mainstone_mask_irq,
-	.irq_unmask	= mainstone_unmask_irq,
-};
-
-static void mainstone_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long pending = MST_INTSETCLR & mainstone_irq_enabled;
-	do {
-		/* clear useless edge notification */
-		desc->irq_data.chip->irq_ack(&desc->irq_data);
-		if (likely(pending)) {
-			irq = MAINSTONE_IRQ(0) + __ffs(pending);
-			generic_handle_irq(irq);
-		}
-		pending = MST_INTSETCLR & mainstone_irq_enabled;
-	} while (pending);
-}
-
-static void __init mainstone_init_irq(void)
-{
-	int irq;
-
-	pxa27x_init_irq();
-
-	/* setup extra Mainstone irqs */
-	for(irq = MAINSTONE_IRQ(0); irq <= MAINSTONE_IRQ(15); irq++) {
-		irq_set_chip_and_handler(irq, &mainstone_irq_chip,
-					 handle_level_irq);
-		if (irq == MAINSTONE_IRQ(10) || irq == MAINSTONE_IRQ(14))
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE | IRQF_NOAUTOEN);
-		else
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-	set_irq_flags(MAINSTONE_IRQ(8), 0);
-	set_irq_flags(MAINSTONE_IRQ(12), 0);
-
-	MST_INTMSKENA = 0;
-	MST_INTSETCLR = 0;
-
-	irq_set_chained_handler(PXA_GPIO_TO_IRQ(0), mainstone_irq_handler);
-	irq_set_irq_type(PXA_GPIO_TO_IRQ(0), IRQ_TYPE_EDGE_FALLING);
-}
-
-#ifdef CONFIG_PM
-
-static void mainstone_irq_resume(void)
-{
-	MST_INTMSKENA = mainstone_irq_enabled;
-}
-
-static struct syscore_ops mainstone_irq_syscore_ops = {
-	.resume = mainstone_irq_resume,
-};
-
-static int __init mainstone_irq_device_init(void)
-{
-	if (machine_is_mainstone())
-		register_syscore_ops(&mainstone_irq_syscore_ops);
-
-	return 0;
-}
-
-device_initcall(mainstone_irq_device_init);
-
-#endif
-
-
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.start	= (MST_ETH_PHYS + 0x300),
@@ -487,11 +402,37 @@ static struct platform_device mst_gpio_keys_device = {
 	},
 };
 
+static struct resource mst_cplds_resources[] = {
+	[0] = {
+		.start	= MST_FPGA_PHYS + 0xc0,
+		.end	= MST_FPGA_PHYS + 0xe0 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= PXA_GPIO_TO_IRQ(0),
+		.end	= PXA_GPIO_TO_IRQ(0),
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
+	},
+	[2] = {
+		.start	= MAINSTONE_IRQ(0),
+		.end	= MAINSTONE_IRQ(15),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mst_cplds_device = {
+	.name		= "pxa_cplds_irqs",
+	.id		= -1,
+	.resource	= &mst_cplds_resources[0],
+	.num_resources	= 3,
+};
+
 static struct platform_device *platform_devices[] __initdata = {
 	&smc91x_device,
 	&mst_flash_device[0],
 	&mst_flash_device[1],
 	&mst_gpio_keys_device,
+	&mst_cplds_device,
 };
 
 static struct pxaohci_platform_data mainstone_ohci_platform_data = {
@@ -718,7 +659,7 @@ MACHINE_START(MAINSTONE, "Intel HCDDBBVA0 Development Platform (aka Mainstone)")
 	.atag_offset	= 0x100,	/* BLOB boot parameter setting */
 	.map_io		= mainstone_map_io,
 	.nr_irqs	= MAINSTONE_NR_IRQS,
-	.init_irq	= mainstone_init_irq,
+	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.init_time	= pxa_timer_init,
 	.init_machine	= mainstone_init,
-- 
2.1.4
