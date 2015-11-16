From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 19:13:28 +0000
Subject: [PATCH 4/4] irqchip/gic: Add save/restore of the active state
In-Reply-To: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
References: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1447701208-18150-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using EOImode==1, we may mark interrupts as being forwarded
to a virtual machine. In that case, the interrupt is left active
while being passed to the VM.

If we suspend the system before the VM has deactivated the interrupt,
the active state will be lost (which may be very annoying, as this
may result in spurious interrupts and a confused guest).

To avoid this, save and restore the active state together with the
rest of the GIC registers.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index bc846e7..abf2ffa 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -73,9 +73,11 @@ struct gic_chip_data {
 	union gic_base cpu_base;
 #ifdef CONFIG_CPU_PM
 	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
+	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
 	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
 	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
 	u32 __percpu *saved_ppi_enable;
+	u32 __percpu *saved_ppi_active;
 	u32 __percpu *saved_ppi_conf;
 #endif
 	struct irq_domain *domain;
@@ -566,6 +568,10 @@ static void gic_dist_save(unsigned int gic_nr)
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
 		gic_data[gic_nr].saved_spi_enable[i] =
 			readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
+
+	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
+		gic_data[gic_nr].saved_spi_active[i] =
+			readl_relaxed(dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 }
 
 /*
@@ -611,6 +617,13 @@ static void gic_dist_restore(unsigned int gic_nr)
 			dist_base + GIC_DIST_ENABLE_SET + i * 4);
 	}
 
+	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++) {
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			dist_base + GIC_DIST_ACTIVE_CLEAR + i * 4);
+		writel_relaxed(gic_data[gic_nr].saved_spi_active[i],
+			dist_base + GIC_DIST_ACTIVE_SET + i * 4);
+	}
+
 	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
 }
 
@@ -634,6 +647,10 @@ static void gic_cpu_save(unsigned int gic_nr)
 	for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
+	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_active);
+	for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
+		ptr[i] = readl_relaxed(dist_base + GIC_DIST_ACTIVE_SET + i * 4);
+
 	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
@@ -663,6 +680,13 @@ static void gic_cpu_restore(unsigned int gic_nr)
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_ENABLE_SET + i * 4);
 	}
 
+	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_active);
+	for (i = 0; i < DIV_ROUND_UP(32, 32); i++) {
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			       dist_base + GIC_DIST_ACTIVE_CLEAR + i * 4);
+		writel_relaxed(ptr[i], dist_base + GIC_DIST_ACTIVE_SET + i * 4);
+	}
+
 	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_CONFIG + i * 4);
@@ -716,6 +740,10 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 		sizeof(u32));
 	BUG_ON(!gic->saved_ppi_enable);
 
+	gic->saved_ppi_active = __alloc_percpu(DIV_ROUND_UP(32, 32) * 4,
+		sizeof(u32));
+	BUG_ON(!gic->saved_ppi_active);
+
 	gic->saved_ppi_conf = __alloc_percpu(DIV_ROUND_UP(32, 16) * 4,
 		sizeof(u32));
 	BUG_ON(!gic->saved_ppi_conf);
-- 
2.1.4
