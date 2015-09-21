From: rric@kernel.org (Robert Richter)
Date: Mon, 21 Sep 2015 22:58:37 +0200
Subject: [PATCH v5 4/6] irqchip,
 gicv3-its: Add HW revision detection and configuration
In-Reply-To: <1442869119-1814-1-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
Message-ID: <1442869119-1814-5-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Some GIC revisions require an individual configuration to esp. add
workarounds for HW bugs. This patch implements generic code to parse
the hw revision provided by an IIDR register value and runs specific
code if hw matches. A function is added that reads the IIDR registers
for ITS (GITS_IIDR) and then goes through a list of init functions to
be called for specific versions. Same could be done for GICV3
(GICD_IIDR), but there are no users yet for it.

The patch is needed to implement workarounds for HW errata in Cavium's
ThunderX GICV3 ITS.

v5:
 * renamed caps names to quirk

v4:
 * only enable hw detection for its in its_enable_quirks()
 * removed gicv3_check_capabilities()

v3:
 * use arm64 errata framework for midr check

v2:
 * adding MIDR check

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-common.c | 11 +++++++++++
 drivers/irqchip/irq-gic-common.h |  9 +++++++++
 drivers/irqchip/irq-gic-v3-its.c | 16 ++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9448e391cb71..44a077f3a4a2 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -21,6 +21,17 @@
 
 #include "irq-gic-common.h"
 
+void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
+		void *data)
+{
+	for (; quirks->desc; quirks++) {
+		if (quirks->iidr != (quirks->mask & iidr))
+			continue;
+		quirks->init(data);
+		pr_info("GIC: enabling workaround for %s\n", quirks->desc);
+	}
+}
+
 int gic_configure_irq(unsigned int irq, unsigned int type,
 		       void __iomem *base, void (*sync_access)(void))
 {
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 35a9884778bd..fff697db8e22 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -20,10 +20,19 @@
 #include <linux/of.h>
 #include <linux/irqdomain.h>
 
+struct gic_quirk {
+	const char *desc;
+	void (*init)(void *data);
+	u32 iidr;
+	u32 mask;
+};
+
 int gic_configure_irq(unsigned int irq, unsigned int type,
                        void __iomem *base, void (*sync_access)(void));
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void));
 void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
+void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
+		void *data);
 
 #endif /* _IRQ_GIC_COMMON_H */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b073f28ea00d..5c6023e80f6d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -37,6 +37,8 @@
 #include <asm/cputype.h>
 #include <asm/exception.h>
 
+#include "irq-gic-common.h"
+
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1 << 0)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
@@ -1371,6 +1373,18 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
+static const struct gic_quirk its_quirks[] = {
+	{
+	}
+};
+
+static void its_enable_quirks(struct its_node *its)
+{
+	u32 iidr = readl_relaxed(its->base + GITS_IIDR);
+
+	gic_enable_quirks(iidr, its_quirks, its);
+}
+
 static int its_probe(struct device_node *node, struct irq_domain *parent)
 {
 	struct resource res;
@@ -1429,6 +1443,8 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	}
 	its->cmd_write = its->cmd_base;
 
+	its_enable_quirks(its);
+
 	err = its_alloc_tables(node->full_name, its);
 	if (err)
 		goto out_free_cmd;
-- 
2.1.1
