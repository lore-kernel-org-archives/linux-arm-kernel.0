From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:25:41 +0100
Subject: [PATCH v3 03/59] irqchip/gic-v3: Add VLPI/DirectLPI discovery
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper functions that probe for VLPI and DirectLPI properties.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c       | 24 +++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 640f621c7f75..17f0ad41864f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013, 2014 ARM Limited, All Rights Reserved.
+ * Copyright (C) 2013-2017 ARM Limited, All Rights Reserved.
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -504,6 +504,24 @@ static int gic_populate_rdist(void)
 	return -ENODEV;
 }
 
+static int __gic_update_vlpi_properties(struct redist_region *region,
+					void __iomem *ptr)
+{
+	u64 typer = gic_read_typer(ptr + GICR_TYPER);
+	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
+	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
+
+	return 1;
+}
+
+static void gic_update_vlpi_properties(void)
+{
+	gic_iterate_rdists(__gic_update_vlpi_properties);
+	pr_info("%sVLPI support, %sdirect LPI support\n",
+		!gic_data.rdists.has_vlpis ? "no " : "",
+		!gic_data.rdists.has_direct_lpi ? "no " : "");
+}
+
 static void gic_cpu_sys_reg_init(void)
 {
 	/*
@@ -968,6 +986,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
+	gic_data.rdists.has_vlpis = true;
+	gic_data.rdists.has_direct_lpi = true;
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err = -ENOMEM;
@@ -976,6 +996,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
+	gic_update_vlpi_properties();
+
 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 6a1f87ff94e2..20a553423ac7 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -204,6 +204,7 @@
 
 #define GICR_TYPER_PLPIS		(1U << 0)
 #define GICR_TYPER_VLPIS		(1U << 1)
+#define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
 
 #define GIC_V3_REDIST_SIZE		0x20000
@@ -487,6 +488,8 @@ struct rdists {
 	struct page		*prop_page;
 	int			id_bits;
 	u64			flags;
+	bool			has_vlpis;
+	bool			has_direct_lpi;
 };
 
 struct irq_domain;
-- 
2.11.0
