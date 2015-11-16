From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 19:13:27 +0000
Subject: [PATCH 3/4] irqchip/gic: Clear enable bits before restoring them
In-Reply-To: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
References: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1447701208-18150-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When restoring the GIC state (after a suspend/resume cycle,
for example), the driver directly writes the 'enabled' state
it has saved by accessing GICD_ISENABLERn, which performs
an OR operation between the value present in the register
and the value we write.

If whatever code that has run before we reentered the kernel
has enabled an interrupt that was previously disabled, we won't
restore that disabled state.

Making sure we first clear the register (by writting to
GICD_ICENABLERn) before restoring the enabled state.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 515c823..bc846e7 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -604,9 +604,12 @@ static void gic_dist_restore(unsigned int gic_nr)
 		writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
 			dist_base + GIC_DIST_TARGET + i * 4);
 
-	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
+	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++) {
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			dist_base + GIC_DIST_ENABLE_CLEAR + i * 4);
 		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
 			dist_base + GIC_DIST_ENABLE_SET + i * 4);
+	}
 
 	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
 }
@@ -654,8 +657,11 @@ static void gic_cpu_restore(unsigned int gic_nr)
 		return;
 
 	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
-	for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
+	for (i = 0; i < DIV_ROUND_UP(32, 32); i++) {
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			       dist_base + GIC_DIST_ENABLE_CLEAR + i * 4);
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_ENABLE_SET + i * 4);
+	}
 
 	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
-- 
2.1.4
