From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:51 -0400
Subject: [PATCH 08/13] ARM: GIC: interface to send a SGI directly
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regular gic_raise_softirq() takes as input a CPU mask which is not
adequate when we need to send an IPI to a CPU which is not represented
in the kernel to GIC mapping.  That is the case with the b.L switcher
when GIC migration to the inbound CPU has not yet occurred.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/irqchip/irq-gic.c       | 14 ++++++++++++++
 include/linux/irqchip/arm-gic.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 09fdf3d574..9031171c14 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -674,6 +674,20 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 #ifdef CONFIG_BL_SWITCHER
 /*
+ * gic_send_sgi - send a SGI directly to given CPU interface number
+ *
+ * cpu_id: the ID for the destination CPU interface
+ * irq: the IPI number to send a SGI for
+ */
+void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
+{
+	BUG_ON(cpu_id >= NR_GIC_CPU_IF);
+	cpu_id = 1 << cpu_id;
+	/* this always happens on GIC0 */
+	writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+}
+
+/*
  * gic_get_cpu_id - get the CPU interface ID for the specified CPU
  *
  * @cpu: the logical CPU number to get the GIC ID for.
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index dc30835099..cac496b1e2 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -76,6 +76,7 @@ static inline void gic_init(unsigned int nr, int start,
 	gic_init_bases(nr, start, dist, cpu, 0, NULL);
 }
 
+void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
 unsigned long gic_get_sgir_physaddr(void);
-- 
1.8.4.98.gb022869
