From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:13 +0800
Subject: [PATCH v3 7/8] irqchip / GICv3: Add stacked irqdomain support for
 ACPI based init
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-8-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar as stacked domain support for ACPI based GICv2 init, let
acpi_irq_domain point to the core domain of GICv3 and pass the
gsi as the arg to support stacked irqdomain.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7b5bde3..91d2f9a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -734,15 +734,21 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
-	int i, ret;
+	int i;
 	irq_hw_number_t hwirq;
-	unsigned int type = IRQ_TYPE_NONE;
-	struct of_phandle_args *irq_data = arg;
 
-	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
-				   irq_data->args_count, &hwirq, &type);
-	if (ret)
-		return ret;
+	if (acpi_disabled) {	/* DT case */
+		int ret;
+		unsigned int type = IRQ_TYPE_NONE;
+		struct of_phandle_args *irq_data = arg;
+
+		ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
+					   irq_data->args_count, &hwirq, &type);
+		if (ret)
+			return ret;
+	} else {	/* ACPI case */
+		hwirq = (irq_hw_number_t)*(u32 *)arg;
+	}
 
 	for (i = 0; i < nr_irqs; i++)
 		gic_irq_domain_map(domain, virq + i, hwirq + i);
@@ -904,6 +910,7 @@ IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
 static struct redist_region *redist_regs __initdata;
 static u32 nr_redist_regions __initdata;
 static phys_addr_t dist_phy_base __initdata;
+static u32 gsi_base __initdata;
 
 static int __init
 gic_acpi_register_redist(u64 phys_base, u64 size)
@@ -961,6 +968,7 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
 		return -EINVAL;
 
 	dist_phy_base = dist->base_address;
+	gsi_base = dist->global_irq_base;
 	return 0;
 }
 
@@ -1010,7 +1018,7 @@ gic_acpi_init(struct acpi_table_header *table)
 	if (err)
 		goto out_redist_unmap;
 
-	irq_set_default_host(gic_data.domain);
+	gsi_cfg_data_add(gic_data.domain, gsi_base, gsi_base + gic_data.irq_nr);
 	return 0;
 
 out_redist_unmap:
-- 
1.9.1
