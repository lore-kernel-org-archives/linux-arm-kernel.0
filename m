From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Oct 2012 18:45:15 +0200
Subject: [PATCH 2/3] arm: bcm2835: convert to the irqchip infrastructure
In-Reply-To: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351356317-16758-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the irq controller driver in the main
drivers/irqchip/irqchip.c file, and make sure that the initialization
function of the driver sets handle_arch_irq() appropriately. This
requires a bit of movement in the driver since the
bcm2835_handle_irq() must move before the armctrl_of_init() function
to avoid a forward declaration.

On the arch/arm side, use irqchip_init() as the ->init_irq() callback,
and remove the definition of ->handle_irq() since this is now done by
the irq controller driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-bcm2835/bcm2835.c |    5 +-
 drivers/irqchip/irq-bcm2835.c   |  110 +++++++++++++++++++--------------------
 drivers/irqchip/irqchip.c       |    3 ++
 drivers/irqchip/irqchip.h       |    2 +
 include/linux/irqchip/bcm2835.h |   29 -----------
 6 files changed, 61 insertions(+), 89 deletions(-)
 delete mode 100644 include/linux/irqchip/bcm2835.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 73067ef..7030500 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -347,6 +347,7 @@ config ARCH_BCM2835
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
+	select USE_IRQCHIP
 	help
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  use in the Raspberry Pi, and Roku 2 devices.
diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index f6fea49..ab1bccd 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -13,10 +13,10 @@
  */
 
 #include <linux/init.h>
-#include <linux/irqchip/bcm2835.h>
 #include <linux/of_platform.h>
 #include <linux/bcm2835_timer.h>
 #include <linux/clk/bcm2835.h>
+#include <linux/irqchip.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -56,8 +56,7 @@ static const char * const bcm2835_compat[] = {
 
 DT_MACHINE_START(BCM2835, "BCM2835")
 	.map_io = bcm2835_map_io,
-	.init_irq = bcm2835_init_irq,
-	.handle_irq = bcm2835_handle_irq,
+	.init_irq = irqchip_init,
 	.init_machine = bcm2835_init,
 	.timer = &bcm2835_timer,
 	.dt_compat = bcm2835_compat
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index dc670cc..6f845c7 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -49,9 +49,11 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/irqchip/bcm2835.h>
 
 #include <asm/exception.h>
+#include <asm/mach/irq.h>
+
+#include "irqchip.h"
 
 /* Put the bank and irq (32 bits) into the hwirq */
 #define MAKE_HWIRQ(b, n)	((b << 5) | (n))
@@ -94,6 +96,52 @@ struct armctrl_ic {
 
 static struct armctrl_ic intc __read_mostly;
 
+/*
+ * Handle each interrupt across the entire interrupt controller.  This reads the
+ * status register before handling each interrupt, which is necessary given that
+ * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
+ */
+
+static void armctrl_handle_bank(int bank, struct pt_regs *regs)
+{
+	u32 stat, irq;
+
+	while ((stat = readl_relaxed(intc.pending[bank]))) {
+		irq = MAKE_HWIRQ(bank, ffs(stat) - 1);
+		handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+	}
+}
+
+static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
+	u32 stat)
+{
+	u32 irq = MAKE_HWIRQ(bank, shortcuts[ffs(stat >> SHORTCUT_SHIFT) - 1]);
+	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+}
+
+static asmlinkage void __exception_irq_entry
+bcm2835_handle_irq(struct pt_regs *regs)
+{
+	u32 stat, irq;
+
+	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
+		if (stat & BANK0_HWIRQ_MASK) {
+			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
+			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+		} else if (stat & SHORTCUT1_MASK) {
+			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
+		} else if (stat & SHORTCUT2_MASK) {
+			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
+		} else if (stat & BANK1_HWIRQ) {
+			armctrl_handle_bank(1, regs);
+		} else if (stat & BANK2_HWIRQ) {
+			armctrl_handle_bank(2, regs);
+		} else {
+			BUG();
+		}
+	}
+}
+
 static void armctrl_mask_irq(struct irq_data *d)
 {
 	writel_relaxed(HWIRQ_BIT(d->hwirq), intc.disable[HWIRQ_BANK(d->hwirq)]);
@@ -135,8 +183,8 @@ static struct irq_domain_ops armctrl_ops = {
 	.xlate = armctrl_xlate
 };
 
-static int __init armctrl_of_init(struct device_node *node,
-	struct device_node *parent)
+int __init armctrl_of_init(struct device_node *node,
+			   struct device_node *parent)
 {
 	void __iomem *base;
 	int irq, b, i;
@@ -164,60 +212,8 @@ static int __init armctrl_of_init(struct device_node *node,
 			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 		}
 	}
-	return 0;
-}
-
-static struct of_device_id irq_of_match[] __initconst = {
-	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init }
-};
-
-void __init bcm2835_init_irq(void)
-{
-	of_irq_init(irq_of_match);
-}
-
-/*
- * Handle each interrupt across the entire interrupt controller.  This reads the
- * status register before handling each interrupt, which is necessary given that
- * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
- */
-
-static void armctrl_handle_bank(int bank, struct pt_regs *regs)
-{
-	u32 stat, irq;
-
-	while ((stat = readl_relaxed(intc.pending[bank]))) {
-		irq = MAKE_HWIRQ(bank, ffs(stat) - 1);
-		handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
-	}
-}
 
-static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
-	u32 stat)
-{
-	u32 irq = MAKE_HWIRQ(bank, shortcuts[ffs(stat >> SHORTCUT_SHIFT) - 1]);
-	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
-}
-
-asmlinkage void __exception_irq_entry bcm2835_handle_irq(
-	struct pt_regs *regs)
-{
-	u32 stat, irq;
+	handle_arch_irq = bcm2835_handle_irq;
 
-	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
-		if (stat & BANK0_HWIRQ_MASK) {
-			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
-			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
-		} else if (stat & SHORTCUT1_MASK) {
-			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
-		} else if (stat & SHORTCUT2_MASK) {
-			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
-		} else if (stat & BANK1_HWIRQ) {
-			armctrl_handle_bank(1, regs);
-		} else if (stat & BANK2_HWIRQ) {
-			armctrl_handle_bank(2, regs);
-		} else {
-			BUG();
-		}
-	}
+	return 0;
 }
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 410f99f..f01cf6e 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -14,6 +14,9 @@
 #include "irqchip.h"
 
 static const struct of_device_id irqchip_of_match[] __initconst = {
+#ifdef CONFIG_ARCH_BCM2835
+	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init },
+#endif
 	{},
 };
 
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
index 1e7a5c2..0e68965 100644
--- a/drivers/irqchip/irqchip.h
+++ b/drivers/irqchip/irqchip.h
@@ -11,4 +11,6 @@
 #ifndef _IRQCHIP_H
 #define _IRQCHIP_H
 
+int armctrl_of_init(struct device_node *node, struct device_node *parent);
+
 #endif
diff --git a/include/linux/irqchip/bcm2835.h b/include/linux/irqchip/bcm2835.h
deleted file mode 100644
index 48a859b..0000000
--- a/include/linux/irqchip/bcm2835.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2010 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __LINUX_IRQCHIP_BCM2835_H_
-#define __LINUX_IRQCHIP_BCM2835_H_
-
-#include <asm/exception.h>
-
-extern void bcm2835_init_irq(void);
-
-extern asmlinkage void __exception_irq_entry bcm2835_handle_irq(
-	struct pt_regs *regs);
-
-#endif
-- 
1.7.9.5
