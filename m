From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 11 Oct 2017 14:01:00 +0100
Subject: [RFC 5/7] irqchip/gic: Add functions to access irq priorities
In-Reply-To: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
References: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1507726862-11944-6-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-common.c | 10 ++++++++++
 drivers/irqchip/irq-gic-common.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9ae7180..06ec1f2 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -90,6 +90,16 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
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
index 205e5fd..1c02518 100644
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
