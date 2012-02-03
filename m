From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:34:52 +0000
Subject: [PATCH 11/17] ARM: sa11x0: neponset: implement support for sparse IRQs
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOuK-0001CG-2U@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the necessary allocation/freeing functionality to support
sparse IRQs with the Neponset device.  On non-sparse IRQ platforms,
this allows us to dynamically allocate from within the available IRQ
number space.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/irqs.h |    8 --
 arch/arm/mach-sa1100/neponset.c          |  111 ++++++++++++++++-------------
 2 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index d18f21a..9e07634 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -82,11 +82,3 @@
 #else
 #define NR_IRQS			(IRQ_BOARD_START)
 #endif
-
-/*
- * Board specific IRQs.  Define them here.
- * Do not surround them with ifdefs.
- */
-#define IRQ_NEPONSET_SMC9196	(IRQ_BOARD_START + 0)
-#define IRQ_NEPONSET_USAR	(IRQ_BOARD_START + 1)
-#define IRQ_NEPONSET_SA1111	(IRQ_BOARD_START + 2)
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 164bc98..4768196 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -11,9 +12,7 @@
 #include <linux/slab.h>
 
 #include <asm/mach-types.h>
-#include <asm/irq.h>
 #include <asm/mach/map.h>
-#include <asm/mach/irq.h>
 #include <asm/mach/serial_sa1100.h>
 #include <asm/hardware/sa1111.h>
 #include <asm/sizes.h>
@@ -22,9 +21,15 @@
 #include <mach/assabet.h>
 #include <mach/neponset.h>
 
+#define NEP_IRQ_SMC91X	0
+#define NEP_IRQ_USAR	1
+#define NEP_IRQ_SA1111	2
+#define NEP_IRQ_NR	3
+
 struct neponset_drvdata {
 	struct platform_device *sa1111;
 	struct platform_device *smc91x;
+	unsigned irq_base;
 #ifdef CONFIG_PM_SLEEP
 	u32 ncr0;
 	u32 mdm_ctl_0;
@@ -104,9 +109,9 @@ static struct sa1100_port_fns neponset_port_fns __devinitdata = {
  * ensure that the IRQ signal is deasserted before returning.  This
  * is rather unfortunate.
  */
-static void
-neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct neponset_drvdata *d = irq_desc_get_handler_data(desc);
 	unsigned int irr;
 
 	while (1) {
@@ -141,26 +146,21 @@ neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 */
 			desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-			if (irr & IRR_ETHERNET) {
-				generic_handle_irq(IRQ_NEPONSET_SMC9196);
-			}
+			if (irr & IRR_ETHERNET)
+				generic_handle_irq(d->irq_base + NEP_IRQ_SMC91X);
 
-			if (irr & IRR_USAR) {
-				generic_handle_irq(IRQ_NEPONSET_USAR);
-			}
+			if (irr & IRR_USAR)
+				generic_handle_irq(d->irq_base + NEP_IRQ_USAR);
 
 			desc->irq_data.chip->irq_unmask(&desc->irq_data);
 		}
 
-		if (irr & IRR_SA1111) {
-			generic_handle_irq(IRQ_NEPONSET_SA1111);
-		}
+		if (irr & IRR_SA1111)
+			generic_handle_irq(d->irq_base + NEP_IRQ_SA1111);
 	}
 }
 
-/*
- * Yes, we really do not have any kind of masking or unmasking
- */
+/* Yes, we really do not have any kind of masking or unmasking */
 static void nochip_noop(struct irq_data *irq)
 {
 }
@@ -172,25 +172,17 @@ static struct irq_chip nochip = {
 	.irq_unmask = nochip_noop,
 };
 
-static struct resource sa1111_resources[] = {
-	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
-	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SA1111),
-};
-
 static struct sa1111_platform_data sa1111_info = {
 	.irq_base	= IRQ_BOARD_END,
 };
 
-static struct resource smc91x_resources[] = {
-	[0] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS, 0x02000000, "smc91x-regs"),
-	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SMC9196),
-	[2] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS + 0x02000000,
-			0x02000000, "smc91x-attrib"),
-};
-
 static int __devinit neponset_probe(struct platform_device *dev)
 {
 	struct neponset_drvdata *d;
+	struct resource sa1111_resources[] = {
+		DEFINE_RES_MEM(0x40000000, SZ_8K),
+		{ .flags = IORESOURCE_IRQ },
+	};
 	struct platform_device_info sa1111_devinfo = {
 		.parent = &dev->dev,
 		.name = "sa1111",
@@ -201,6 +193,13 @@ static int __devinit neponset_probe(struct platform_device *dev)
 		.size_data = sizeof(sa1111_info),
 		.dma_mask = 0xffffffffUL,
 	};
+	struct resource smc91x_resources[] = {
+		DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS,
+			0x02000000, "smc91x-regs"),
+		DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS + 0x02000000,
+			0x02000000, "smc91x-attrib"),
+		{ .flags = IORESOURCE_IRQ },
+	};
 	struct platform_device_info smc91x_devinfo = {
 		.parent = &dev->dev,
 		.name = "smc91x",
@@ -216,47 +215,59 @@ static int __devinit neponset_probe(struct platform_device *dev)
 		goto err_alloc;
 	}
 
-	sa1100_register_uart_fns(&neponset_port_fns);
+	ret = irq_alloc_descs(-1, IRQ_BOARD_START, NEP_IRQ_NR, -1);
+	if (ret <= 0) {
+		dev_err(&dev->dev, "unable to allocate %u irqs: %d\n",
+			NEP_IRQ_NR, ret);
+		if (ret == 0)
+			ret = -ENOMEM;
+		goto err_irq_alloc;
+	}
+
+	d->irq_base = ret;
+
+	irq_set_chip_and_handler(d->irq_base + NEP_IRQ_SMC91X, &nochip,
+		handle_simple_irq);
+	set_irq_flags(d->irq_base + NEP_IRQ_SMC91X, IRQF_VALID | IRQF_PROBE);
+	irq_set_chip_and_handler(d->irq_base + NEP_IRQ_USAR, &nochip,
+		handle_simple_irq);
+	set_irq_flags(d->irq_base + NEP_IRQ_USAR, IRQF_VALID | IRQF_PROBE);
+	irq_set_chip(d->irq_base + NEP_IRQ_SA1111, &nochip);
 
-	/*
-	 * Install handler for GPIO25.
-	 */
 	irq_set_irq_type(IRQ_GPIO25, IRQ_TYPE_EDGE_RISING);
+	irq_set_handler_data(IRQ_GPIO25, d);
 	irq_set_chained_handler(IRQ_GPIO25, neponset_irq_handler);
 
 	/*
-	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but
-	 * unfortunately something on the Neponset activates
-	 * this IRQ on sleep (ethernet?)
+	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but unfortunately
+	 * something on the Neponset activates this IRQ on sleep (eth?)
 	 */
 #if 0
 	enable_irq_wake(IRQ_GPIO25);
 #endif
 
-	/*
-	 * Setup other Neponset IRQs.  SA1111 will be done by the
-	 * generic SA1111 code.
-	 */
-	irq_set_chip_and_handler(IRQ_NEPONSET_SMC9196, &nochip,
-		handle_simple_irq);
-	set_irq_flags(IRQ_NEPONSET_SMC9196, IRQF_VALID | IRQF_PROBE);
-	irq_set_chip_and_handler(IRQ_NEPONSET_USAR, &nochip,
-		handle_simple_irq);
-	set_irq_flags(IRQ_NEPONSET_USAR, IRQF_VALID | IRQF_PROBE);
-	irq_set_chip(IRQ_NEPONSET_SA1111, &nochip);
+	dev_info(&dev->dev, "Neponset daughter board, providing IRQ%u-%u\n",
+		 d->irq_base, d->irq_base + NEP_IRQ_NR - 1);
 
-	/*
-	 * Disable GPIO 0/1 drivers so the buttons work on the module.
-	 */
+	sa1100_register_uart_fns(&neponset_port_fns);
+
+	/* Disable GPIO 0/1 drivers so the buttons work on the Assabet */
 	NCR_0 = NCR_GP01_OFF;
 
+	sa1111_resources[1].start = d->irq_base + NEP_IRQ_SA1111;
+	sa1111_resources[1].end = d->irq_base + NEP_IRQ_SA1111;
 	d->sa1111 = platform_device_register_full(&sa1111_devinfo);
+
+	smc91x_resources[2].start = d->irq_base + NEP_IRQ_SMC91X;
+	smc91x_resources[2].end = d->irq_base + NEP_IRQ_SMC91X;
 	d->smc91x = platform_device_register_full(&smc91x_devinfo);
 
 	platform_set_drvdata(dev, d);
 
 	return 0;
 
+ err_irq_alloc:
+	kfree(d);
  err_alloc:
 	return ret;
 }
@@ -270,7 +281,7 @@ static int __devexit neponset_remove(struct platform_device *dev)
 	if (!IS_ERR(d->smc91x))
 		platform_device_unregister(d->smc91x);
 	irq_set_chained_handler(IRQ_GPIO25, NULL);
-
+	irq_free_descs(d->irq_base, NEP_IRQ_NR);
 	kfree(d);
 
 	return 0;
-- 
1.7.4.4
