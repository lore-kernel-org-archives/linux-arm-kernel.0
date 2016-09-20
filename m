From: rrichter@cavium.com (Robert Richter)
Date: Tue, 20 Sep 2016 13:34:19 +0200
Subject: [PATCH] irqchip,
 gicv3: Fix out-of-range cpumask access reported by cpumask_check()
Message-ID: <1474371259-18783-1-git-send-email-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting a kernel with DEBUG_PER_CPU_MAPS enabled triggers the follwing
warning:

 WARNING: CPU: 1 PID: 0 at ./include/linux/cpumask.h:121 gic_raise_softirq+0x298/0x308

Reason for this is the code in for_each_cpu() that modifies cpu in
gic_compute_target_list() which may cause cpu set to nr_cpumask_bits
and cpumask_check() (cpumask_next() of for_each_cpu()) throwing the
warning.

Change the code to avoid out-of-range access that stops the warning.

Note: Though cpumask_check() fails, current for_each_cpu()
implementation is save to use cpu out of range. Also, code in
gic_raise_softirq() might be reworked at all in a way that a single
each-cpu loop is used by squashing it with gic_compute_target_list().

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ede5672ab34d..ed46b906cf0a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -615,6 +615,8 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
 		gic_send_sgi(cluster_id, tlist, irq);
+		if (cpu >= nr_cpu_ids)
+			break;
 	}
 
 	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
-- 
2.7.0.rc3
