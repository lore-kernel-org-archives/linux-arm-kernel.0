From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Thu, 17 Dec 2009 11:13:41 +0100
Subject: [PATCH 2/3] nhk8815: add port expander to NR_IRQS
In-Reply-To: <cover.1261044597.git.rubini@unipv.it>
References: <cover.1261044597.git.rubini@unipv.it>
Message-ID: <5d6e0905ad6825f82f5ea3c3ea79794c749b05eb.1261044597.git.rubini@unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

The board has several devices connected to the stmpe2401 expanders,
so this patch adds their interrupts to machine ones. In this was normal
driver (like touchscreen controller) can work on the nhk without
special casing the connection to i2c-driven gpio bits.

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 arch/arm/mach-nomadik/include/mach/irqs.h |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-nomadik/include/mach/irqs.h b/arch/arm/mach-nomadik/include/mach/irqs.h
index 8faabc5..97e1201 100644
--- a/arch/arm/mach-nomadik/include/mach/irqs.h
+++ b/arch/arm/mach-nomadik/include/mach/irqs.h
@@ -21,6 +21,7 @@
 #define __ASM_ARCH_IRQS_H
 
 #include <mach/hardware.h>
+#include <linux/i2c/stmpe2401.h>
 
 #define IRQ_VIC_START		0	/* first VIC interrupt is 0 */
 
@@ -72,11 +73,35 @@
 #define NOMADIK_NR_GPIO			128 /* last 4 not wired to pins */
 #define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + NOMADIK_SOC_NR_IRQS)
 #define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - NOMADIK_SOC_NR_IRQS)
-#define NR_IRQS				NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
+#define IRQ_BOARD_START 		NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
+#define NR_IRQS				IRQ_BOARD_START
 
 /* Following two are used by entry_macro.S, to access our dual-vic */
 #define VIC_REG_IRQSR0		0
 #define VIC_REG_IRQSR1		0x20
 
+/***************************************************************************
+ * Board specific IRQs.  Define them here. Do not surround them with ifdefs.
+ * NR_IRQS is undefined and redefined to be the max possibile value.
+ * (This approach is taken from mach-pxa).
+ */
+
+/*
+ * nhk8815: we have 2 STMPE2401, called EGPIO throughout board docs.
+ * Please note that the 32 interrupts are 8 functions + 24 gpio bits:
+ * pdata should use irq NHK8815_EGPIO0_IRQ(STMPE2401_IRQ_GPIO(chip_gpionr))
+ */
+#define NHK8815_EGPIO0_IRQ(x)		(IRQ_BOARD_START + (x))
+#define NHK8815_EGPIO1_IRQ(x)		(IRQ_BOARD_START + STMPE2401_NIRQ + (x))
+#define NHK8815_NR_IRQS			(IRQ_BOARD_START + 2 * STMPE2401_NIRQ)
+#if NHK8815_NR_IRQS > NR_IRQS
+#  undef NR_IRQS
+#  define NR_IRQS NHK8815_NR_IRQS
+#endif
+
+/*
+ * Other boards definining interrupts should define theme here below
+ */
+
 #endif /* __ASM_ARCH_IRQS_H */
 
-- 
1.6.0.2
