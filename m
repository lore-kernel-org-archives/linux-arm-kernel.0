From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:50 -0400
Subject: [PATCH 07/13] ARM: GIC: function to retrieve the physical address of
 the SGIR
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-8-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to have early assembly code signal other CPUs in the system,
we need to get the physical address for the SGIR register used to
send IPIs.  Because the register will be used with a precomputed CPU
interface ID number, there is no need for any locking in the assembly
code where this register is written to.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/irqchip/irq-gic.c       | 29 +++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6365b59181..09fdf3d574 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -769,6 +769,33 @@ void gic_migrate_target(unsigned int new_cpu_id)
 		}
 	}
 }
+
+/*
+ * gic_get_sgir_physaddr - get the physical address for the SGI register
+ *
+ * REturn the physical address of the SGI register to be used
+ * by some early assembly code when the kernel is not yet available.
+ */
+static unsigned long gic_dist_physaddr;
+
+unsigned long gic_get_sgir_physaddr(void)
+{
+	if (!gic_dist_physaddr)
+		return 0;
+	return gic_dist_physaddr + GIC_DIST_SOFTINT;
+}
+
+void __init gic_init_physaddr(struct device_node *node)
+{
+	struct resource res;
+	if (of_address_to_resource(node, 0, &res) == 0) {
+		gic_dist_physaddr = res.start;
+		pr_info("GIC physical location is %#lx\n", gic_dist_physaddr);
+	}
+}
+
+#else
+#define gic_init_physaddr(node)  do { } while (0)
 #endif
 
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
@@ -952,6 +979,8 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 		percpu_offset = 0;
 
 	gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
+	if (!gic_cnt)
+		gic_init_physaddr(node);
 
 	if (parent) {
 		irq = irq_of_parse_and_map(node, 0);
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 46544e381b..dc30835099 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -78,6 +78,7 @@ static inline void gic_init(unsigned int nr, int start,
 
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
+unsigned long gic_get_sgir_physaddr(void);
 
 #endif /* __ASSEMBLY */
 
-- 
1.8.4.98.gb022869
