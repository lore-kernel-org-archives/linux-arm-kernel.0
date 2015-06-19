From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 19 Jun 2015 16:46:12 +0800
Subject: [PATCH v2 9/9] irqchip / GICv3: Add stacked irqdomain support for
 ACPI based init
In-Reply-To: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1434703572-26221-10-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar as stacked domain support for ACPI based GICv2 init, let
acpi_irq_domain point to the core domain of GICv3 and pass the
gsi as the arg to support stacked irqdomain.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d2eef3c..a1c4c74 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -733,15 +733,21 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
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
+	if (domain->of_node) {	/* DT case */
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
@@ -1009,7 +1015,7 @@ gic_v3_acpi_init(struct acpi_table_header *table)
 	if (err)
 		goto out_redist_unmap;
 
-	irq_set_default_host(gic_data.domain);
+	acpi_irq_domain = gic_data.domain;
 	return 0;
 
 out_redist_unmap:
-- 
1.9.1
