From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Mar 2017 17:53:26 +0100
Subject: [PATCH 4/4 v2] irqchip: replace moxa with ftintc010
In-Reply-To: <20170318165326.20450-1-linus.walleij@linaro.org>
References: <20170318165326.20450-1-linus.walleij@linaro.org>
Message-ID: <20170318165326.20450-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Moxa Art interrupt controller is very very likely just an instance
of the Faraday FTINTC010 interrupt controller from Faraday Technology.
An indication would be its close association with the FA526 ARM core
and the fact that the register layout is the same.

The implementation in irq-moxart.c can probably be right off replaced
with the irq-ftintc010.c driver by adding a compatible string, selecting
this irqchip from the machine and run.

As a bonus we have an irqchip driver supporting high/low and
rising/falling edges for the Moxa Art, and shared code with the Gemini
platform.

Acked-by: Olof Johansson <olof@lixom.net>
Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No longer a RFT patch, Jonas has successfully tested this on
  the Moxart board.
- Add Olof's ACK so it can be applied to the irqchip tree.
---
 arch/arm/mach-moxart/Kconfig    |   2 +-
 drivers/irqchip/Makefile        |   1 -
 drivers/irqchip/irq-ftintc010.c |   2 +
 drivers/irqchip/irq-moxart.c    | 116 ----------------------------------------
 4 files changed, 3 insertions(+), 118 deletions(-)
 delete mode 100644 drivers/irqchip/irq-moxart.c

diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index f69e28b85e88..70db2abf6163 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -3,8 +3,8 @@ menuconfig ARCH_MOXART
 	depends on ARCH_MULTI_V4
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
+	select FARADAY_FTINTC010
 	select MOXART_TIMER
-	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select PHYLIB if NETDEVICES
 	help
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index cdf3474d3851..d80bc3e9d511 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
 obj-$(CONFIG_METAG)			+= irq-metag-ext.o
 obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
-obj-$(CONFIG_ARCH_MOXART)		+= irq-moxart.o
 obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 0cc81df6f743..cd2dc8bbbe9c 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -190,3 +190,5 @@ IRQCHIP_DECLARE(faraday, "faraday,ftintc010",
 		ft010_of_init_irq);
 IRQCHIP_DECLARE(gemini, "cortina,gemini-interrupt-controller",
 		ft010_of_init_irq);
+IRQCHIP_DECLARE(moxa, "moxa,moxart-ic",
+		ft010_of_init_irq);
diff --git a/drivers/irqchip/irq-moxart.c b/drivers/irqchip/irq-moxart.c
deleted file mode 100644
index a24b06a1718b..000000000000
--- a/drivers/irqchip/irq-moxart.c
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * MOXA ART SoCs IRQ chip driver.
- *
- * Copyright (C) 2013 Jonas Jensen
- *
- * Jonas Jensen <jonas.jensen@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/irqdomain.h>
-
-#include <asm/exception.h>
-
-#define IRQ_SOURCE_REG		0
-#define IRQ_MASK_REG		0x04
-#define IRQ_CLEAR_REG		0x08
-#define IRQ_MODE_REG		0x0c
-#define IRQ_LEVEL_REG		0x10
-#define IRQ_STATUS_REG		0x14
-
-#define FIQ_SOURCE_REG		0x20
-#define FIQ_MASK_REG		0x24
-#define FIQ_CLEAR_REG		0x28
-#define FIQ_MODE_REG		0x2c
-#define FIQ_LEVEL_REG		0x30
-#define FIQ_STATUS_REG		0x34
-
-
-struct moxart_irq_data {
-	void __iomem *base;
-	struct irq_domain *domain;
-	unsigned int interrupt_mask;
-};
-
-static struct moxart_irq_data intc;
-
-static void __exception_irq_entry handle_irq(struct pt_regs *regs)
-{
-	u32 irqstat;
-	int hwirq;
-
-	irqstat = readl(intc.base + IRQ_STATUS_REG);
-
-	while (irqstat) {
-		hwirq = ffs(irqstat) - 1;
-		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
-		irqstat &= ~(1 << hwirq);
-	}
-}
-
-static int __init moxart_of_intc_init(struct device_node *node,
-				      struct device_node *parent)
-{
-	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	int ret;
-	struct irq_chip_generic *gc;
-
-	intc.base = of_iomap(node, 0);
-	if (!intc.base) {
-		pr_err("%s: unable to map IC registers\n",
-		       node->full_name);
-		return -EINVAL;
-	}
-
-	intc.domain = irq_domain_add_linear(node, 32, &irq_generic_chip_ops,
-					    intc.base);
-	if (!intc.domain) {
-		pr_err("%s: unable to create IRQ domain\n", node->full_name);
-		return -EINVAL;
-	}
-
-	ret = irq_alloc_domain_generic_chips(intc.domain, 32, 1,
-					     "MOXARTINTC", handle_edge_irq,
-					     clr, 0, IRQ_GC_INIT_MASK_CACHE);
-	if (ret) {
-		pr_err("%s: could not allocate generic chip\n",
-		       node->full_name);
-		irq_domain_remove(intc.domain);
-		return -EINVAL;
-	}
-
-	ret = of_property_read_u32(node, "interrupt-mask",
-				   &intc.interrupt_mask);
-	if (ret)
-		pr_err("%s: could not read interrupt-mask DT property\n",
-		       node->full_name);
-
-	gc = irq_get_domain_generic_chip(intc.domain, 0);
-
-	gc->reg_base = intc.base;
-	gc->chip_types[0].regs.mask = IRQ_MASK_REG;
-	gc->chip_types[0].regs.ack = IRQ_CLEAR_REG;
-	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
-	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
-	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
-
-	writel(0, intc.base + IRQ_MASK_REG);
-	writel(0xffffffff, intc.base + IRQ_CLEAR_REG);
-
-	writel(intc.interrupt_mask, intc.base + IRQ_MODE_REG);
-	writel(intc.interrupt_mask, intc.base + IRQ_LEVEL_REG);
-
-	set_handle_irq(handle_irq);
-
-	return 0;
-}
-IRQCHIP_DECLARE(moxa_moxart_ic, "moxa,moxart-ic", moxart_of_intc_init);
-- 
2.9.3
