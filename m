From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:00:54 +0100
Subject: [PATCH 03/16] arm: bcm2835: convert to the irqchip infrastructure
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-4-git-send-email-thomas.petazzoni@free-electrons.com>
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
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-bcm2835/bcm2835.c |    5 ++---
 drivers/irqchip/irq-bcm2835.c   |   27 ++++++++++++++-------------
 include/linux/irqchip/bcm2835.h |   29 -----------------------------
 3 files changed, 16 insertions(+), 45 deletions(-)
 delete mode 100644 include/linux/irqchip/bcm2835.h

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
index dc670cc..c2ca9b0 100644
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
@@ -135,8 +137,10 @@ static struct irq_domain_ops armctrl_ops = {
 	.xlate = armctrl_xlate
 };
 
-static int __init armctrl_of_init(struct device_node *node,
-	struct device_node *parent)
+static asmlinkage void bcm2835_handle_irq(struct pt_regs *regs);
+
+static int __init bcm2835_irqchip_init(struct device_node *node,
+				       struct device_node *parent)
 {
 	void __iomem *base;
 	int irq, b, i;
@@ -164,16 +168,10 @@ static int __init armctrl_of_init(struct device_node *node,
 			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 		}
 	}
-	return 0;
-}
 
-static struct of_device_id irq_of_match[] __initconst = {
-	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init }
-};
+	set_handle_irq(bcm2835_handle_irq);
 
-void __init bcm2835_init_irq(void)
-{
-	of_irq_init(irq_of_match);
+	return 0;
 }
 
 /*
@@ -199,8 +197,8 @@ static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
 	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
 }
 
-asmlinkage void __exception_irq_entry bcm2835_handle_irq(
-	struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry
+bcm2835_handle_irq(struct pt_regs *regs)
 {
 	u32 stat, irq;
 
@@ -221,3 +219,6 @@ asmlinkage void __exception_irq_entry bcm2835_handle_irq(
 		}
 	}
 }
+
+IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic",
+		bcm2835_irqchip_init);
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
