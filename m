From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Oct 2015 18:36:24 +0100
Subject: [PATCH 11/16] irqchip/gic: Get rid of gic_init_bases()
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444152989-31726-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since nobody is using gic_init_bases anymore outside of the GIC
driver itself, let's do a bit of housekeeping and remove the now
useless entry point.

Only gic_init() is now exposed to the rest of the kernel for the
benefit of legacy systems.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c       | 8 +++-----
 include/linux/irqchip/arm-gic.h | 9 ++-------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b0135be..f1f4ca1 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1112,17 +1112,15 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic_pm_init(gic);
 }
 
-void __init gic_init_bases(unsigned int gic_nr, int irq_start,
-			   void __iomem *dist_base, void __iomem *cpu_base,
-			   u32 percpu_offset, struct device_node *node)
+void __init gic_init(unsigned int gic_nr, int irq_start,
+		     void __iomem *dist_base, void __iomem *cpu_base)
 {
 	/*
 	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
 	 * bother with these...
 	 */
 	static_key_slow_dec(&supports_deactivate);
-	__gic_init_bases(gic_nr, irq_start, dist_base, cpu_base,
-			 percpu_offset, node);
+	__gic_init_bases(gic_nr, irq_start, dist_base, cpu_base, 0, NULL);
 }
 
 #ifdef CONFIG_OF
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index b8901df..bae69e5 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -100,16 +100,11 @@
 
 struct device_node;
 
-void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
-		    u32 offset, struct device_node *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 int gic_cpu_if_down(unsigned int gic_nr);
 
-static inline void gic_init(unsigned int nr, int start,
-			    void __iomem *dist , void __iomem *cpu)
-{
-	gic_init_bases(nr, start, dist, cpu, 0, NULL);
-}
+void gic_init(unsigned int nr, int start,
+	      void __iomem *dist , void __iomem *cpu);
 
 int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
 
-- 
2.1.4
