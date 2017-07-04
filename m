From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  4 Jul 2017 10:56:35 +0100
Subject: [PATCH 3/3] irq: gic-v3: Honor forced affinity setting
In-Reply-To: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
References: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1499162195-5126-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Honor the 'force' flag for set_affinity, by selecting a CPU
from the given mask (which may not be reported "online" by
the cpu_online_mask). Some drivers, like ARM PMU, rely on it.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ea82342..883597f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -642,11 +642,16 @@ static void gic_smp_init(void)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	unsigned int cpu;
 	void __iomem *reg;
 	int enabled;
 	u64 val;
 
+	if (force)
+		cpu = cpumask_first(mask_val);
+	else
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-- 
2.7.5
