From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:10 +0000
Subject: [PATCH v6 19/24] irqchip/gic: Add functions to access irq priorities
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-20-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add accessors to the GIC distributor/redistributors priority registers.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-common.c | 10 ++++++++++
 drivers/irqchip/irq-gic-common.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 01e673c..910746f 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -98,6 +98,16 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	return ret;
 }
 
+void gic_set_irq_prio(unsigned int irq, void __iomem *base, u8 prio)
+{
+	writeb_relaxed(prio, base + GIC_DIST_PRI + irq);
+}
+
+u8 gic_get_irq_prio(unsigned int irq, void __iomem *base)
+{
+	return readb_relaxed(base + GIC_DIST_PRI + irq);
+}
+
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void))
 {
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3919cd7..1586dbd 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -35,6 +35,8 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
+void gic_set_irq_prio(unsigned int irq, void __iomem *base, u8 prio);
+u8 gic_get_irq_prio(unsigned int irq, void __iomem *base);
 
 void gic_set_kvm_info(const struct gic_kvm_info *info);
 
-- 
1.9.1
