From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 24 Feb 2012 14:45:48 +0100
Subject: [PATCH] gic : check if there are pending interrupts
Message-ID: <1330091148-15291-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch checks if there are pending interrupts on the gic.

This function is needed for example for the ux500 cpuidle driver.
When the A9 cores and the gic are decoupled from the PRCMU, the idle
routine has to check if an interrupt is pending on the gic before entering
in retention mode.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/common/gic.c               |   37 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    2 +-
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index aa52699..2528094 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -750,6 +750,43 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 }
 #endif
 
+/*
+ * gic_pending_irq - checks if there are pending interrupts on the gic
+ *
+ * Disabling an interrupt only disables the forwarding of the
+ * interrupt to any CPU interface. It does not prevent the interrupt
+ * from changing state, for example becoming pending, or active and
+ * pending if it is already active. For this reason, we have to check
+ * the interrupt is pending *and* is enabled.
+ *
+ * Returns true if there are pending and enabled interrupts, false
+ * otherwise.
+ */
+bool gic_pending_irq(unsigned int gic_nr)
+{
+	u32 pr; /* Pending register */
+	u32 er; /* Enable register */
+	void __iomem *dist_base;
+	int gic_irqs;
+	int i;
+
+	BUG_ON(gic_nr >= MAX_GIC_NR);
+
+	gic_irqs = gic_data[gic_nr].gic_irqs;
+	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
+
+	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++) {
+
+		pr = readl_relaxed(dist_base + GIC_DIST_PENDING_SET + i * 4);
+		er = readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
+
+		if (pr & er)
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_OF
 static int gic_cnt __initdata = 0;
 
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 4b1ce6c..d198ac0 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -45,7 +45,7 @@ void gic_secondary_init(unsigned int);
 void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
-
+bool gic_pending_irq(unsigned int gic_nr);
 static inline void gic_init(unsigned int nr, int start,
 			    void __iomem *dist , void __iomem *cpu)
 {
-- 
1.7.5.4
