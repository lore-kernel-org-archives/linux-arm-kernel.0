From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 18 May 2015 20:59:14 +0800
Subject: [PATCH 04/11] irqchip / GIC / ACPI: Use IRQCHIP_ACPI_DECLARE to
 simplify GICv2 init code
In-Reply-To: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1431953961-22706-5-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the ACPI self-probe infrastructure for irqchip is ready,
we use the infrastructure and the GIC version to simplify
GICv2 init code.

>From now on, GIC init calls reside in theirs drivers only.
This means the code becomes cleaner and it is not spread
outside irqchip driver.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/irq.h         | 13 -------------
 arch/arm64/kernel/acpi.c             | 25 -------------------------
 drivers/acpi/irq.c                   |  2 +-
 drivers/irqchip/irq-gic-acpi.c       |  5 +++++
 drivers/irqchip/irq-gic.c            |  6 +++++-
 include/linux/acpi_irq.h             |  4 +++-
 include/linux/irqchip/arm-gic-acpi.h | 10 ++--------
 7 files changed, 16 insertions(+), 49 deletions(-)

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
index 8b83955..69809e7 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -318,28 +318,3 @@ void __init acpi_boot_table_init(void)
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
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 855ead9..7bd1ef6 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -25,7 +25,7 @@ irqchip_acpi_match_end __used __section(__irqchip_acpi_table_end);
 
 extern struct acpi_table_id __irqchip_acpi_table[];
 
-void __init acpi_irqchip_init(void)
+void __init acpi_irq_init(void)
 {
 	struct acpi_table_id *id;
 
diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
index 53a86ef..1388d9e 100644
--- a/drivers/irqchip/irq-gic-acpi.c
+++ b/drivers/irqchip/irq-gic-acpi.c
@@ -21,6 +21,11 @@ static u8 gic_version __initdata = ACPI_MADT_GIC_VER_UNKNOWN;
 
 static phys_addr_t dist_phy_base __initdata;
 
+u8 __init acpi_gic_version(void)
+{
+	return gic_version;
+}
+
 static int __init
 acpi_gic_parse_distributor(struct acpi_subtable_header *header,
 				const unsigned long end)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 01999d7..fefbcb5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1085,12 +1085,15 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
 	return 0;
 }
 
-int __init
+static int __init
 gic_v2_acpi_init(struct acpi_table_header *table)
 {
 	void __iomem *cpu_base, *dist_base;
 	int count;
 
+	if (acpi_gic_version() >= ACPI_MADT_GIC_VER_V3)
+		return -ENODEV;
+
 	/* Collect CPU base addresses */
 	count = acpi_parse_entries(ACPI_SIG_MADT,
 				   sizeof(struct acpi_table_madt),
@@ -1141,4 +1144,5 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 	return 0;
 }
+IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_SIG_MADT, gic_v2_acpi_init);
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
index 0d5f204..021e8e8 100644
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -21,13 +21,7 @@
 #define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
 #define ACPI_GICV3_DIST_MEM_SIZE	(SZ_64K)
 
-struct acpi_table_header;
-
-int gic_v2_acpi_init(struct acpi_table_header *table);
-void acpi_gic_init(void);
 int acpi_gic_version_init(void);
-#else
-static inline void acpi_gic_init(void) { }
-#endif
-
+u8 acpi_gic_version(void);
+#endif /* CONFIG_ACPI */
 #endif /* ARM_GIC_ACPI_H_ */
-- 
1.9.1
