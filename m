From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 25 Mar 2011 09:28:59 -0600
Subject: [PATCH 6/8] ux500: fixing irq header file dependency.
In-Reply-To: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
References: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1301066941-15877-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../mach-ux500/include/mach/irqs-board-mop500.h    |   44 ++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/irqs.h            |   43 -------------------
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
index 7cdeb2a..2c82c9c 100644
--- a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
+++ b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
@@ -10,6 +10,33 @@
 
 /* Number of AB8500 irqs is taken from header file */
 #include <linux/mfd/ab8500.h>
+#include <mach/irqs-db5500.h>
+#include <mach/irqs-db8500.h>
+
+#define IRQ_LOCALTIMER                  29
+#define IRQ_LOCALWDOG                   30
+
+/* Shared Peripheral Interrupt (SHPI) */
+#define IRQ_SHPI_START                  32
+
+/* Interrupt numbers generic for shared peripheral */
+#define IRQ_MTU0                (IRQ_SHPI_START + 4)
+
+/* There are 128 shared peripheral interrupts assigned to
+ * INTID[160:32]. The first 32 interrupts are reserved.
+ */
+#define DBX500_NR_INTERNAL_IRQS         161
+
+/* After chip-specific IRQ numbers we have the GPIO ones */
+#define NOMADIK_NR_GPIO                 288
+#define NOMADIK_GPIO_TO_IRQ(gpio)       ((gpio) + DBX500_NR_INTERNAL_IRQS)
+#define NOMADIK_IRQ_TO_GPIO(irq)        ((irq) - DBX500_NR_INTERNAL_IRQS)
+#define IRQ_BOARD_START                 NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
+
+/* This will be overridden by board-specific irq headers */
+#define IRQ_BOARD_END                   IRQ_BOARD_START
+
+/*********************************************************************/
 
 #define MOP500_AB8500_IRQ_BASE		IRQ_BOARD_START
 #define MOP500_AB8500_IRQ_END		(MOP500_AB8500_IRQ_BASE \
@@ -44,4 +71,21 @@
 #define IRQ_BOARD_END	MOP500_IRQ_END
 #endif
 
+/*********************************************************************/
+
+/*
+ * After the board specific IRQ:s we reserve a range of IRQ:s in which virtual
+ * IRQ:s representing modem IRQ:s can be allocated
+ */
+#define IRQ_MODEM_EVENTS_BASE (IRQ_BOARD_END + 1)
+#define IRQ_MODEM_EVENTS_NBR 72
+#define IRQ_MODEM_EVENTS_END (IRQ_MODEM_EVENTS_BASE + IRQ_MODEM_EVENTS_NBR)
+
+/* List of virtual IRQ:s that are allocated from the range above */
+#define MBOX_PAIR0_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 43)
+#define MBOX_PAIR1_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 45)
+#define MBOX_PAIR2_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 41)
+
+#define NR_IRQS                         IRQ_MODEM_EVENTS_END
+
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index ba1294c..ccc2ba0 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -10,49 +10,6 @@
 #ifndef ASM_ARCH_IRQS_H
 #define ASM_ARCH_IRQS_H
 
-#include <mach/irqs-db5500.h>
-#include <mach/irqs-db8500.h>
-
-#define IRQ_LOCALTIMER                  29
-#define IRQ_LOCALWDOG                   30
-
-/* Shared Peripheral Interrupt (SHPI) */
-#define IRQ_SHPI_START			32
-
-/* Interrupt numbers generic for shared peripheral */
-#define IRQ_MTU0		(IRQ_SHPI_START + 4)
-
-/* There are 128 shared peripheral interrupts assigned to
- * INTID[160:32]. The first 32 interrupts are reserved.
- */
-#define DBX500_NR_INTERNAL_IRQS		161
-
-/* After chip-specific IRQ numbers we have the GPIO ones */
-#define NOMADIK_NR_GPIO			288
-#define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + DBX500_NR_INTERNAL_IRQS)
-#define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - DBX500_NR_INTERNAL_IRQS)
-#define IRQ_BOARD_START			NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
-
-/* This will be overridden by board-specific irq headers */
-#define IRQ_BOARD_END			IRQ_BOARD_START
-
-#ifdef CONFIG_MACH_U8500
 #include <mach/irqs-board-mop500.h>
-#endif
-
-/*
- * After the board specific IRQ:s we reserve a range of IRQ:s in which virtual
- * IRQ:s representing modem IRQ:s can be allocated
- */
-#define IRQ_MODEM_EVENTS_BASE (IRQ_BOARD_END + 1)
-#define IRQ_MODEM_EVENTS_NBR 72
-#define IRQ_MODEM_EVENTS_END (IRQ_MODEM_EVENTS_BASE + IRQ_MODEM_EVENTS_NBR)
-
-/* List of virtual IRQ:s that are allocated from the range above */
-#define MBOX_PAIR0_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 43)
-#define MBOX_PAIR1_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 45)
-#define MBOX_PAIR2_VIRT_IRQ (IRQ_MODEM_EVENTS_BASE + 41)
-
-#define NR_IRQS				IRQ_MODEM_EVENTS_END
 
 #endif /* ASM_ARCH_IRQS_H */
-- 
1.7.1
