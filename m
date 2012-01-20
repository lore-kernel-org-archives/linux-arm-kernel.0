From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:04 -0600
Subject: [PATCH v2 06/13] sh: intc: unify evt2irq/irq2evt macros for sh and arm
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move evt2irq and irq2evt macros definitions out of sh and arm includes
into a common location.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-shmobile/Kconfig             |    4 ++++
 arch/arm/mach-shmobile/include/mach/irqs.h |    6 ++----
 arch/sh/include/asm/irq.h                  |   11 -----------
 include/linux/sh_intc.h                    |   11 +++++++++++
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 060e564..34560ca 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -100,6 +100,10 @@ config MACH_MARZEN
 
 comment "SH-Mobile System Configuration"
 
+config CPU_HAS_INTEVT
+        bool
+	default y
+
 menu "Memory configuration"
 
 config MEMORY_START
diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index dcb714f..828807d 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -1,15 +1,13 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
+#include <linux/sh_intc.h>
+
 #define NR_IRQS         1024
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
 
-/* INTCA */
-#define evt2irq(evt)		(((evt) >> 5) - 16)
-#define irq2evt(irq)		(((irq) + 16) << 5)
-
 /* INTCS */
 #define INTCS_VECT_BASE		0x2200
 #define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 45d08b6..2a62017 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -21,17 +21,6 @@
 #define NO_IRQ_IGNORE		((unsigned int)-1)
 
 /*
- * Convert back and forth between INTEVT and IRQ values.
- */
-#ifdef CONFIG_CPU_HAS_INTEVT
-#define evt2irq(evt)		(((evt) >> 5) - 16)
-#define irq2evt(irq)		(((irq) + 16) << 5)
-#else
-#define evt2irq(evt)		(evt)
-#define irq2evt(irq)		(irq)
-#endif
-
-/*
  * Simple Mask Register Support
  */
 extern void make_maskreg_irq(unsigned int irq);
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index b160645..e1a2ac5 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -3,6 +3,17 @@
 
 #include <linux/ioport.h>
 
+/*
+ * Convert back and forth between INTEVT and IRQ values.
+ */
+#ifdef CONFIG_CPU_HAS_INTEVT
+#define evt2irq(evt)		(((evt) >> 5) - 16)
+#define irq2evt(irq)		(((irq) + 16) << 5)
+#else
+#define evt2irq(evt)		(evt)
+#define irq2evt(irq)		(irq)
+#endif
+
 typedef unsigned char intc_enum;
 
 struct intc_vect {
-- 
1.7.5.4
