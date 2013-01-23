From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Jan 2013 17:59:32 +0000
Subject: [PATCH 2/4] arm: Move chained_irq_(enter|exit) to a generic file
In-Reply-To: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1358963974-5496-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions have been introduced by commit 10a8c383 (irq: introduce
entry and exit functions for chained handlers) in asm/mach/irq.h. This
patch moves them to linux/irqchip/chained_irq.h so that generic irqchip
drivers do not rely on architecture specific header files.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/mach/irq.h         | 31 --------------------
 arch/arm/mach-at91/gpio.c               |  3 +-
 arch/arm/mach-exynos/common.c           |  1 +
 arch/arm/plat-samsung/irq-vic-timer.c   |  3 +-
 arch/arm/plat-samsung/s5p-irq-gpioint.c |  3 +-
 drivers/irqchip/irq-gic.c               |  2 +-
 include/linux/irqchip/chained_irq.h     | 52 +++++++++++++++++++++++++++++++++
 7 files changed, 57 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/irqchip/chained_irq.h

diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index 749d505..2092ee1 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -30,35 +30,4 @@ do {							\
 	raw_spin_unlock(&desc->lock);			\
 } while(0)
 
-#ifndef __ASSEMBLY__
-/*
- * Entry/exit functions for chained handlers where the primary IRQ chip
- * may implement either fasteoi or level-trigger flow control.
- */
-static inline void chained_irq_enter(struct irq_chip *chip,
-				     struct irq_desc *desc)
-{
-	/* FastEOI controllers require no action on entry. */
-	if (chip->irq_eoi)
-		return;
-
-	if (chip->irq_mask_ack) {
-		chip->irq_mask_ack(&desc->irq_data);
-	} else {
-		chip->irq_mask(&desc->irq_data);
-		if (chip->irq_ack)
-			chip->irq_ack(&desc->irq_data);
-	}
-}
-
-static inline void chained_irq_exit(struct irq_chip *chip,
-				    struct irq_desc *desc)
-{
-	if (chip->irq_eoi)
-		chip->irq_eoi(&desc->irq_data);
-	else
-		chip->irq_unmask(&desc->irq_data);
-}
-#endif
-
 #endif
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index c5d7e1e..e3a64cf 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -23,8 +23,7 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
-
-#include <asm/mach/irq.h>
+#include <linux/irqchip/chained_irq.h>
 
 #include <mach/hardware.h>
 #include <mach/at91_pio.h>
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 7f01a92..60dad95 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -25,6 +25,7 @@
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/chained_irq.h>
 
 #include <asm/proc-fns.h>
 #include <asm/exception.h>
diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index f980cf3..047a2f8 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -17,14 +17,13 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
 
 #include <mach/map.h>
 #include <plat/cpu.h>
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-timer.h>
 
-#include <asm/mach/irq.h>
-
 static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
diff --git a/arch/arm/plat-samsung/s5p-irq-gpioint.c b/arch/arm/plat-samsung/s5p-irq-gpioint.c
index bae5613..d450671 100644
--- a/arch/arm/plat-samsung/s5p-irq-gpioint.c
+++ b/arch/arm/plat-samsung/s5p-irq-gpioint.c
@@ -17,13 +17,12 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
+#include <linux/irqchip/chained_irq.h>
 
 #include <mach/map.h>
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 
-#include <asm/mach/irq.h>
-
 #define GPIO_BASE(chip)		((void __iomem *)((unsigned long)((chip)->base) & 0xFFFFF000u))
 
 #define CON_OFFSET		0x700
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 69d9a39..54b86f0 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -38,12 +38,12 @@
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
 
 #include <asm/irq.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
-#include <asm/mach/irq.h>
 
 #include "irqchip.h"
 
diff --git a/include/linux/irqchip/chained_irq.h b/include/linux/irqchip/chained_irq.h
new file mode 100644
index 0000000..adf4c30
--- /dev/null
+++ b/include/linux/irqchip/chained_irq.h
@@ -0,0 +1,52 @@
+/*
+ * Chained IRQ handlers support.
+ *
+ * Copyright (C) 2011 ARM Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __IRQCHIP_CHAINED_IRQ_H
+#define __IRQCHIP_CHAINED_IRQ_H
+
+#include <linux/irq.h>
+
+/*
+ * Entry/exit functions for chained handlers where the primary IRQ chip
+ * may implement either fasteoi or level-trigger flow control.
+ */
+static inline void chained_irq_enter(struct irq_chip *chip,
+				     struct irq_desc *desc)
+{
+	/* FastEOI controllers require no action on entry. */
+	if (chip->irq_eoi)
+		return;
+
+	if (chip->irq_mask_ack) {
+		chip->irq_mask_ack(&desc->irq_data);
+	} else {
+		chip->irq_mask(&desc->irq_data);
+		if (chip->irq_ack)
+			chip->irq_ack(&desc->irq_data);
+	}
+}
+
+static inline void chained_irq_exit(struct irq_chip *chip,
+				    struct irq_desc *desc)
+{
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+	else
+		chip->irq_unmask(&desc->irq_data);
+}
+
+#endif /* __IRQCHIP_CHAINED_IRQ_H */
