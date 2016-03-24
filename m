From: julien.grall@arm.com (Julien Grall)
Date: Thu, 24 Mar 2016 17:53:37 +0000
Subject: [PATCH v4 3/9] irqchip/gic-v2: Gather ACPI specific data in a single
 structure
In-Reply-To: <1458842023-31853-1-git-send-email-julien.grall@arm.com>
References: <1458842023-31853-1-git-send-email-julien.grall@arm.com>
Message-ID: <1458842023-31853-4-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACPI code requires to use global variables in order to collect
information from the tables.

For now, a single global variable is used, but more will be added in a
subsequent patch. To make clear they are ACPI specific, gather all the
information in a single structure.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Acked-by: Christofer Dall <christoffer.dall@linaro.org>

---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>

    Changes in v4:
        - Update commit message
        - Rename cpu_phy_base to cpu_phys_base
        - Add Christopher's acked-by

    Changes in v2:
        - Patch added
---
 drivers/irqchip/irq-gic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 282344b..7a73786 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1245,7 +1245,10 @@ IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
 #endif
 
 #ifdef CONFIG_ACPI
-static phys_addr_t cpu_phy_base __initdata;
+static struct
+{
+	phys_addr_t cpu_phys_base;
+} acpi_data __initdata;
 
 static int __init
 gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
@@ -1265,10 +1268,10 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
 	 * All CPU interface addresses have to be the same.
 	 */
 	gic_cpu_base = processor->base_address;
-	if (cpu_base_assigned && gic_cpu_base != cpu_phy_base)
+	if (cpu_base_assigned && gic_cpu_base != acpi_data.cpu_phys_base)
 		return -EINVAL;
 
-	cpu_phy_base = gic_cpu_base;
+	acpi_data.cpu_phys_base = gic_cpu_base;
 	cpu_base_assigned = 1;
 	return 0;
 }
@@ -1316,7 +1319,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 		return -EINVAL;
 	}
 
-	cpu_base = ioremap(cpu_phy_base, ACPI_GIC_CPU_IF_MEM_SIZE);
+	cpu_base = ioremap(acpi_data.cpu_phys_base, ACPI_GIC_CPU_IF_MEM_SIZE);
 	if (!cpu_base) {
 		pr_err("Unable to map GICC registers\n");
 		return -ENOMEM;
-- 
1.9.1
