From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 18:11:10 +0200
Subject: [PATCH] irqchip: gic: Allow setting affinity to offline CPUs
Message-ID: <1377015070-26320-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes it is necessary to fix interrupt affinity to an offline CPU,
for example in initialization of local timers. This patch modifies
.set_affinity() operation of irq-gic driver to fall back to any possible
CPU if no online CPU can be found in requested CPU mask.

This fixes broken Exynos4210 support since commit
	ee98d27df6 ARM: EXYNOS4: Divorce mct from local timer API
caused by timer initialization code unable to set affinity for local
timer interrupts.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/irqchip/irq-gic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ee7c503..5f0797e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -250,6 +250,15 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
 	u32 val, mask, bit;
 
+	/*
+	 * If no online CPU could be found, fall back to any possible CPU.
+	 *
+	 * This is to allow setting affinity of some interrupts to a CPU
+	 * before it is marked as online, i.e. local timer initialization.
+	 */
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_any_and(mask_val, cpu_possible_mask);
+
 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-- 
1.8.3.2
