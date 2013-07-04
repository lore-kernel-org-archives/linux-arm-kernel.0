From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 05 Jul 2013 00:31:36 +0800
Subject: [PATCH] irqchip: bcm2835: Convert to use IRQCHIP_DECLARE macro
Message-ID: <1372955496.9018.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts irq-bcm2835 driver to use the new IRQCHIP_DECLARE and
irqchip_init.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/mach-bcm2835/bcm2835.c |  5 ++---
 drivers/irqchip/irq-bcm2835.c   | 22 ++++++++++------------
 include/linux/irqchip/bcm2835.h | 29 -----------------------------
 3 files changed, 12 insertions(+), 44 deletions(-)
 delete mode 100644 include/linux/irqchip/bcm2835.h

diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index 40686d7..a4abd85 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -14,7 +14,7 @@
 
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/irqchip/bcm2835.h>
+#include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/clk/bcm2835.h>
@@ -131,8 +131,7 @@ static const char * const bcm2835_compat[] = {
 
 DT_MACHINE_START(BCM2835, "BCM2835")
 	.map_io = bcm2835_map_io,
-	.init_irq = bcm2835_init_irq,
-	.handle_irq = bcm2835_handle_irq,
+	.init_irq = irqchip_init,
 	.init_machine = bcm2835_init,
 	.init_time = clocksource_of_init,
 	.restart = bcm2835_restart,
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 16c78f1..c29408e 100644
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
@@ -93,6 +95,8 @@ struct armctrl_ic {
 };
 
 static struct armctrl_ic intc __read_mostly;
+static asmlinkage void __exception_irq_entry bcm2835_handle_irq(
+	struct pt_regs *regs);
 
 static void armctrl_mask_irq(struct irq_data *d)
 {
@@ -164,17 +168,9 @@ static int __init armctrl_of_init(struct device_node *node,
 			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 		}
 	}
-	return 0;
-}
-
-static struct of_device_id irq_of_match[] __initconst = {
-	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init },
-	{ }
-};
 
-void __init bcm2835_init_irq(void)
-{
-	of_irq_init(irq_of_match);
+	set_handle_irq(bcm2835_handle_irq);
+	return 0;
 }
 
 /*
@@ -200,7 +196,7 @@ static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
 	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
 }
 
-asmlinkage void __exception_irq_entry bcm2835_handle_irq(
+static asmlinkage void __exception_irq_entry bcm2835_handle_irq(
 	struct pt_regs *regs)
 {
 	u32 stat, irq;
@@ -222,3 +218,5 @@ asmlinkage void __exception_irq_entry bcm2835_handle_irq(
 		}
 	}
 }
+
+IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic", armctrl_of_init);
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
1.8.1.2
