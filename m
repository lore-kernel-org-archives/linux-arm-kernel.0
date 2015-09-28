From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 15:49:13 +0100
Subject: [PATCH v3 2/7] irqchip/acpi: Add probing infrastructure for
 ACPI-based irqchips
In-Reply-To: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT enjoys a rather nice probing infrastructure for irqchips, while
ACPI is so far stuck into a very distant past.

This patch introduces a declarative API, allowing irqchips to be
self-contained and be called when a particular entry is matched
in the MADT table.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/irq.h      | 11 -----------
 drivers/irqchip/irqchip.c         |  8 +++++---
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/acpi_irq.h          | 10 ----------
 include/linux/irqchip.h           | 17 +++++++++++++++++
 5 files changed, 23 insertions(+), 24 deletions(-)
 delete mode 100644 include/linux/acpi_irq.h

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bbb251b..1a1037a 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -10,15 +10,4 @@ struct pt_regs;
 extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
-static inline void acpi_irq_init(void)
-{
-	/*
-	 * Hardcode ACPI IRQ chip initialization to GICv2 for now.
-	 * Proper irqchip infrastructure will be implemented along with
-	 * incoming  GICv2m|GICv3|ITS bits.
-	 */
-	acpi_gic_init();
-}
-#define acpi_irq_init acpi_irq_init
-
 #endif
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index afd1af3..1ee773e 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -8,7 +8,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/acpi_irq.h>
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
@@ -27,6 +27,8 @@ extern struct of_device_id __irqchip_of_table[];
 void __init irqchip_init(void)
 {
 	of_irq_init(__irqchip_of_table);
-
-	acpi_irq_init();
+#if defined(CONFIG_ARM64) && defined(CONFIG_ACPI)
+	acpi_gic_init();	/* Temporary hack */
+#endif
+	acpi_probe_device_table(irqchip);
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index efd7ed1..cd836cd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -524,6 +524,7 @@
 	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
+	ACPI_PROBE_TABLE(irqchip)					\
 	EARLYCON_TABLE()						\
 	EARLYCON_OF_TABLES()
 
diff --git a/include/linux/acpi_irq.h b/include/linux/acpi_irq.h
deleted file mode 100644
index f10c872..0000000
--- a/include/linux/acpi_irq.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _LINUX_ACPI_IRQ_H
-#define _LINUX_ACPI_IRQ_H
-
-#include <linux/irq.h>
-
-#ifndef acpi_irq_init
-static inline void acpi_irq_init(void) { }
-#endif
-
-#endif /* _LINUX_ACPI_IRQ_H */
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 6388873..89c34b2 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_IRQCHIP_H
 #define _LINUX_IRQCHIP_H
 
+#include <linux/acpi.h>
 #include <linux/of.h>
 
 /*
@@ -25,6 +26,22 @@
  */
 #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
 
+/*
+ * This macro must be used by the different irqchip drivers to declare
+ * the association between their version and their initialization function.
+ *
+ * @name: name that must be unique accross all IRQCHIP_ACPI_DECLARE of the
+ * same file.
+ * @subtable: Subtable to be identified in MADT
+ * @validate: Function to be called on that subtable to check its validity.
+ *            Can be NULL.
+ * @data: data to be checked by the validate function.
+ * @fn: initialization function
+ */
+#define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
+	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
+				 subtable, validate, data, fn)
+
 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
 #else
-- 
2.1.4
