From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:26:12 +0100
Subject: [PATCH v3 34/59] irqchip/gic-v4: Enable low-level GICv4 operations
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-35-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get the show on the road...

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/Makefile           |  2 +-
 drivers/irqchip/irq-gic-v3-its.c   |  3 ++-
 drivers/irqchip/irq-gic-v4.c       | 13 +++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e88d856cc09c..7dd05ad6bcfb 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a5b1317d89eb..9f32cd42238f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3109,7 +3109,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		has_v4 |= its->is_v4;
 
 	if (has_v4 & rdists->has_vlpis) {
-		if (its_init_vpe_domain()) {
+		if (its_init_vpe_domain() ||
+		    its_init_v4(parent_domain, &its_vpe_domain_ops)) {
 			rdists->has_vlpis = false;
 			pr_err("ITS: Disabling GICv4 support\n");
 		}
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index d10d73477d01..400d9bbb0e56 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -209,3 +209,16 @@ int its_prop_update_vlpi(int irq, u8 config, bool inv)
 
 	return irq_set_vcpu_affinity(irq, &info);
 }
+
+int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops *ops)
+{
+	if (domain) {
+		pr_info("ITS: Enabling GICv4 support\n");
+		gic_domain = domain;
+		vpe_domain_ops = ops;
+		return 0;
+	}
+
+	pr_err("ITS: No GICv4 VPE domain allocated\n");
+	return -ENODEV;
+}
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index f495d4d1f7d7..3cf72af2c796 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -98,4 +98,6 @@ int its_get_vlpi(int irq, struct its_vlpi_map *map);
 int its_unmap_vlpi(int irq);
 int its_prop_update_vlpi(int irq, u8 config, bool inv);
 
+int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops *ops);
+
 #endif
-- 
2.11.0
