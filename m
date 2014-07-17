From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Jul 2014 17:23:44 +0200
Subject: [PATCH] irqchip: gic: Fix core ID calculation when topology is read
 from DT
Message-ID: <1405610624-18722-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain GIC implementation, namely those found on earlier, single
cluster, Exynos SoCs, have registers mapped without per-CPU banking,
which means that the driver needs to use different offset for each CPU.

Currently the driver calculates the offset by multiplying value returned
by cpu_logical_map() by CPU offset parsed from DT. This is correct when
CPU topology is not specified in DT and aforementioned function returns
core ID alone. However when DT contains CPU topology, the function
changes to return cluster ID as well, which is non-zero on mentioned
SoCs and so breaks the calculation in GIC driver.

This patch fixes this by masking out cluster ID in CPU offset
calculation so that only core ID is considered. Multi-cluster Exynos
SoCs already have banked GIC implementations, so this simple fix should
be enough.

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/irqchip/irq-gic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ddee133..5c15a09 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -40,6 +40,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
 
+#include <asm/cputype.h>
 #include <asm/irq.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
@@ -901,7 +902,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		}
 
 		for_each_possible_cpu(cpu) {
-			unsigned long offset = percpu_offset * cpu_logical_map(cpu);
+			u32 mpidr = cpu_logical_map(cpu);
+			u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+			unsigned long offset = percpu_offset * core_id;
 			*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
 			*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
 		}
-- 
1.9.3
