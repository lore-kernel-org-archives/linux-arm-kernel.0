From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 16 Dec 2015 17:08:06 +0000
Subject: [PATCH 2/2] irqchip/gic: Identify and report any reserved SGI IDs
In-Reply-To: <1450285686-844-1-git-send-email-daniel.thompson@linaro.org>
References: <1450285686-844-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1450285686-844-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible for the secure world to reserve certain SGI IDs for itself.
Currently we have limited visibility of which IDs are safe to use for IPIs.

Modify the GIC initialization code to actively search for reserved SGI IDs
and report if any are found. Warn even more loudly if the reserved SGIs
overlap with the normal IPI range.

When run on an Inforce IFC6410 (Snapdragon 600) this code produces the
following messages:
~~~ cut here ~~~
CPU0: Detected reserved SGI IDs: 14-15
CPU1: Detected reserved SGI IDs: 15
CPU2: Detected reserved SGI IDs: 15
CPU3: Detected reserved SGI IDs: 15
~~~ cut here ~~~

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/irqchip/irq-gic.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index abf2ffaed392..541622da7049 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -490,6 +490,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	void __iomem *base = gic_data_cpu_base(gic);
 	unsigned int cpu_mask, cpu = smp_processor_id();
 	int i;
+	DECLARE_BITMAP(sgi_mask, 16);
 
 	/*
 	 * Setting up the CPU map is only relevant for the primary GIC
@@ -511,6 +512,58 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 		for (i = 0; i < NR_GIC_CPU_IF; i++)
 			if (i != cpu)
 				gic_cpu_map[i] &= ~cpu_mask;
+
+		/*
+		 * Fiddle with the SGI set/clear registers to try identify
+		 * any IPIs that are reserved for secure world.
+		 */
+		bitmap_fill(sgi_mask, 16);
+
+		for (i = 0; i < 16; i++) {
+			void __iomem *set_reg =
+			    dist_base + GIC_DIST_SGI_PENDING_SET + (i & ~3);
+			void __iomem *clear_reg =
+			    dist_base + GIC_DIST_SGI_PENDING_CLEAR + (i & ~3);
+			unsigned long mask = cpu_mask << (8*(i%4));
+			unsigned long flags, pending, after_clear, after_set;
+
+			local_irq_save(flags);
+
+			/* record original value */
+			pending = readl_relaxed(set_reg);
+
+			/* clear, test, set, and test again */
+			writel_relaxed(mask, clear_reg);
+			after_clear = readl_relaxed(set_reg);
+			writel_relaxed(mask, set_reg);
+			after_set = readl_relaxed(set_reg);
+
+			/* restore original value */
+			writel_relaxed(mask & ~pending, clear_reg);
+
+			local_irq_restore(flags);
+
+			if (mask & ~after_clear && mask & after_set)
+				clear_bit(i, sgi_mask);
+		}
+
+		/*
+		 * Show the SGI mask if it is "interesting". Here interesting
+		 * means that the set/clear register is implemented
+		 * (mask is not full) and it tells us that the secure world
+		 * has reserved some SGIs (mask is not empty).
+		 */
+		if (!bitmap_full(sgi_mask, 16) && !bitmap_empty(sgi_mask, 16))
+			pr_info("CPU%d: Detected reserved SGI IDs: %*pbl\n",
+				cpu, 16, sgi_mask);
+
+		/*
+		 * Yell if the reserved IDs make the system unviable.
+		 */
+		if (!bitmap_full(sgi_mask, 16) &&
+		    find_first_bit(sgi_mask, 16) < NR_IPI)
+			pr_crit("CPU%d: Not enough SGI IDs; expect failure\n",
+				cpu);
 	}
 
 	gic_cpu_config(dist_base, NULL);
-- 
2.5.0
