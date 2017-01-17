From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Jan 2017 10:20:54 +0000
Subject: [RFC PATCH 33/33] irqchip/gic-v4: Enable low-level GICv4 operations
In-Reply-To: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1484648454-21216-34-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get the show on the road...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/Makefile           |  2 +-
 drivers/irqchip/irq-gic-v3-its.c   |  2 +-
 drivers/irqchip/irq-gic-v4.c       | 11 +++++++++++
 include/linux/irqchip/arm-gic-v4.h |  2 ++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0e55d94..d57e03f 100644
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
index 3787579..5658dd8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2824,7 +2824,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		has_v4 |= its->is_v4;
 
 	if (has_v4 & rdists->has_vlpis)
-		its_init_vpe_domain();
+		its_init_v4(its_init_vpe_domain());
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 8b2d9ee..38ce6f0 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -228,3 +228,14 @@ int its_prop_update_vlpi(int irq, u8 config)
 
 	return irq_set_vcpu_affinity(irq, &info);
 }
+
+void its_init_v4(struct irq_domain *domain)
+{
+	if (domain) {
+		pr_info("ITS: Enabling GICv4 support\n");
+		its_vpe_domain = domain;
+		return;
+	}
+
+	pr_err("ITS: No GICv4 VPE domain allocated\n");
+}
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index f85a929..b87c54f 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -97,4 +97,6 @@ int its_map_vlpi(int irq, struct its_vlpi_map *map);
 int its_unmap_vlpi(int irq);
 int its_prop_update_vlpi(int irq, u8 config);
 
+void its_init_v4(struct irq_domain *domain);
+
 #endif
-- 
2.1.4
