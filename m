From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  1 Sep 2015 10:08:53 +0100
Subject: [PATCH] irqchip/gic: Fix EOImode setting for non-DT/ACPI systems
Message-ID: <1441098533-31523-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-DT/ACPI systems call directly into the GIC driver at init time.
Turns out 0b996fd35957 ("irqchip/GIC: Convert to EOImode == 1")
breaks old non firmware-driven platforms, as the driver only
works out the capability of the platform on the DT/ACPI paths.

Fix this thinko by forcing EOImode==0 on non-DT platforms,
which are not capable of supporting a hypervisor anyway.

Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 72bf81b..e6b7ed5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -993,7 +993,7 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
-void __init gic_init_bases(unsigned int gic_nr, int irq_start,
+static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
 			   u32 percpu_offset, struct device_node *node)
 {
@@ -1103,6 +1103,19 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic_pm_init(gic);
 }
 
+void __init gic_init_bases(unsigned int gic_nr, int irq_start,
+			   void __iomem *dist_base, void __iomem *cpu_base,
+			   u32 percpu_offset, struct device_node *node)
+{
+	/*
+	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
+	 * bother with these...
+	 */
+	static_key_slow_dec(&supports_deactivate);
+	__gic_init_bases(gic_nr, irq_start, dist_base, cpu_base,
+			 percpu_offset, node);
+}
+
 #ifdef CONFIG_OF
 static int gic_cnt __initdata;
 
@@ -1137,7 +1150,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
 		percpu_offset = 0;
 
-	gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
+	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
 	if (!gic_cnt)
 		gic_init_physaddr(node);
 
@@ -1265,7 +1278,7 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
 	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
 	 */
-	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
+	__gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
 	irq_set_default_host(gic_data[0].domain);
 
 	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
-- 
2.1.4
