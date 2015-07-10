From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:09 +0800
Subject: [PATCH v3 3/8] irqchip / GIC / ACPI: Use IRQCHIP_ACPI_DECLARE to
 simplify GICv2 init code
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-4-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the ACPI self-probe infrastructure for irqchip is ready,
we use the infrastructure to simplify GICv2 init code.

acpi_irqchip_init() is renamed as acpi_irq_init() to replace
the previous hardcode version of acpi_irq_init() in asm/irq.h,
also cleanup the code which previously calling the GIC driver
manually in arch/arm64/kernel/acpi.c.

>From now on, GIC init calls reside in theirs drivers only.
This means the code becomes cleaner and it is not spread
outside irqchip driver.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h        |  1 -
 arch/arm64/include/asm/irq.h         | 13 -------------
 arch/arm64/kernel/acpi.c             | 25 -------------------------
 drivers/irqchip/irq-gic-acpi.c       |  2 +-
 drivers/irqchip/irq-gic.c            |  3 ++-
 include/linux/acpi_irq.h             |  4 +++-
 include/linux/irqchip/arm-gic-acpi.h |  9 +--------
 7 files changed, 7 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index ed7e212..05656fc 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -12,7 +12,6 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
-#include <linux/irqchip/arm-gic-acpi.h>
 #include <linux/mm.h>
 #include <linux/psci.h>
 
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bbb251b..94c5367 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_IRQ_H
 #define __ASM_IRQ_H
 
-#include <linux/irqchip/arm-gic-acpi.h>
-
 #include <asm-generic/irq.h>
 
 struct pt_regs;
@@ -10,15 +8,4 @@ struct pt_regs;
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
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 19de753..d6463bb 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -205,28 +205,3 @@ void __init acpi_boot_table_init(void)
 			disable_acpi();
 	}
 }
-
-void __init acpi_gic_init(void)
-{
-	struct acpi_table_header *table;
-	acpi_status status;
-	acpi_size tbl_size;
-	int err;
-
-	if (acpi_disabled)
-		return;
-
-	status = acpi_get_table_with_size(ACPI_SIG_MADT, 0, &table, &tbl_size);
-	if (ACPI_FAILURE(status)) {
-		const char *msg = acpi_format_exception(status);
-
-		pr_err("Failed to get MADT table, %s\n", msg);
-		return;
-	}
-
-	err = gic_v2_acpi_init(table);
-	if (err)
-		pr_err("Failed to initialize GIC IRQ controller");
-
-	early_acpi_os_unmap_memory((char *)table, tbl_size);
-}
diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
index e003a89..b87a581 100644
--- a/drivers/irqchip/irq-gic-acpi.c
+++ b/drivers/irqchip/irq-gic-acpi.c
@@ -119,7 +119,7 @@ irqchip_acpi_match_end __used __section(__irqchip_acpi_table_end);
 
 extern struct acpi_table_id __irqchip_acpi_table[];
 
-void __init acpi_irqchip_init(void)
+void __init acpi_irq_init(void)
 {
 	struct acpi_table_id *id;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8d7e1c8..58a7112 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1086,7 +1086,7 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
 	return 0;
 }
 
-int __init
+static int __init
 gic_v2_acpi_init(struct acpi_table_header *table)
 {
 	void __iomem *cpu_base, *dist_base;
@@ -1142,4 +1142,5 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 	return 0;
 }
+IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_GIC_VERSION_V2, gic_v2_acpi_init);
 #endif
diff --git a/include/linux/acpi_irq.h b/include/linux/acpi_irq.h
index f10c872..4c0e108 100644
--- a/include/linux/acpi_irq.h
+++ b/include/linux/acpi_irq.h
@@ -3,7 +3,9 @@
 
 #include <linux/irq.h>
 
-#ifndef acpi_irq_init
+#ifdef CONFIG_ACPI
+void acpi_irq_init(void);
+#else
 static inline void acpi_irq_init(void) { }
 #endif
 
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
index 13bc676..56cd82c 100644
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -21,12 +21,5 @@
 #define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
 #define ACPI_GICV3_DIST_MEM_SIZE	(SZ_64K)
 
-struct acpi_table_header;
-
-int gic_v2_acpi_init(struct acpi_table_header *table);
-void acpi_gic_init(void);
-#else
-static inline void acpi_gic_init(void) { }
-#endif
-
+#endif /* CONFIG_ACPI */
 #endif /* ARM_GIC_ACPI_H_ */
-- 
1.9.1
