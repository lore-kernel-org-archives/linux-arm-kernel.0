From: rric@kernel.org (Robert Richter)
Date: Thu, 13 Aug 2015 16:47:54 +0200
Subject: [PATCH v2 2/5] irqchip,
 gicv3: Add HW revision detection and configuration
In-Reply-To: <1439477277-6157-1-git-send-email-rric@kernel.org>
References: <1439477277-6157-1-git-send-email-rric@kernel.org>
Message-ID: <1439477277-6157-3-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Some GIC revisions require an individual configuration to esp. add
workarounds for HW bugs. This patch implements generic code to parse
the hw revision provided by an IIDR register value and runs specific
code if hw matches. There are functions that read the IIDR registers
for GICV3 and ITS (GICD_IIDR/GITS_IIDR) and then go through a list of
init functions to be called for specific versions.

A MIDR register value may also be used, this is especially useful for
hw detection from a guest.

The patch is needed to implement workarounds for HW errata in Cavium's
ThunderX GICV3.

V2:
 * adding MIDR check

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-common.c | 13 +++++++++++++
 drivers/irqchip/irq-gic-common.h | 11 +++++++++++
 drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v3.c     | 14 ++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9448e391cb71..886c09e645bf 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -21,6 +21,19 @@
 
 #include "irq-gic-common.h"
 
+void gic_check_capabilities(u32 iidr, const struct gic_capabilities *cap,
+			void *data)
+{
+	for (; cap->desc; cap++) {
+		if (cap->midr != (cap->midr_mask & read_cpuid_id()))
+			continue;
+		if (cap->iidr != (cap->iidr_mask & iidr))
+			continue;
+		cap->init(data);
+		pr_info("%s\n", cap->desc);
+	}
+}
+
 int gic_configure_irq(unsigned int irq, unsigned int type,
 		       void __iomem *base, void (*sync_access)(void))
 {
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 35a9884778bd..e9a3e2800005 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -20,10 +20,21 @@
 #include <linux/of.h>
 #include <linux/irqdomain.h>
 
+struct gic_capabilities {
+	const char *desc;
+	void (*init)(void *data);
+	u32 iidr;
+	u32 iidr_mask;
+	u32 midr;
+	u32 midr_mask;
+};
+
 int gic_configure_irq(unsigned int irq, unsigned int type,
                        void __iomem *base, void (*sync_access)(void));
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void));
 void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
+void gic_check_capabilities(u32 iidr, const struct gic_capabilities *cap,
+			void *data);
 
 #endif /* _IRQ_GIC_COMMON_H */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 466edf8a7477..105674037618 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -36,6 +36,7 @@
 #include <asm/cputype.h>
 #include <asm/exception.h>
 
+#include "irq-gic-common.h"
 #include "irqchip.h"
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1 << 0)
@@ -1391,6 +1392,18 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
+static const struct gic_capabilities its_errata[] = {
+	{
+	}
+};
+
+static void its_check_capabilities(struct its_node *its)
+{
+	u32 iidr = readl_relaxed(its->base + GITS_IIDR);
+
+	gic_check_capabilities(iidr, its_errata, its);
+}
+
 static int its_probe(struct device_node *node, struct irq_domain *parent)
 {
 	struct resource res;
@@ -1449,6 +1462,8 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	}
 	its->cmd_write = its->cmd_base;
 
+	its_check_capabilities(its);
+
 	err = its_alloc_tables(its);
 	if (err)
 		goto out_free_cmd;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c52f7ba205b4..1a91902be0b1 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -766,6 +766,18 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.free = gic_irq_domain_free,
 };
 
+static const struct gic_capabilities gicv3_errata[] = {
+	{
+	}
+};
+
+static void gicv3_check_capabilities(void)
+{
+	u32 iidr = readl_relaxed(gic_data.dist_base + GICD_IIDR);
+
+	gic_check_capabilities(iidr, gicv3_errata, NULL);
+}
+
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
@@ -825,6 +837,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	gic_data.nr_redist_regions = nr_redist_regions;
 	gic_data.redist_stride = redist_stride;
 
+	gicv3_check_capabilities();
+
 	/*
 	 * Find out how many interrupts are supported.
 	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
-- 
2.1.1
