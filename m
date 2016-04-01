From: majun258@huawei.com (MaJun)
Date: Fri, 1 Apr 2016 11:28:11 +0800
Subject: [RFC PATCH] genirq: Change the non-balanced irq to balance irq when
 the cpu of the irq bounded off line
Message-ID: <1459481291-10136-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

When the CPU of a non-balanced irq bounded is off line, the irq will be migrated to other CPUs,
usually the first cpu on-line.

We can suppose the situation if a system has more than one non-balanced irq.
At extreme case, these irqs will be migrated to the same CPU and will cause the 
CPU run with high irq pressure, even make the system die.

So, I think maybe we need to change the non-balanced irq to a irq can be
balanced to avoid the problem descried above.

Maybe this is not a good solution for this problem, please offer me some
suggestion if you have a better one.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 kernel/irq/cpuhotplug.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 011f8c4..80d54a5 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -30,6 +30,8 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 
 	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+		if (irq_settings_has_no_balance_set(desc))
+			irqd_clear(d, IRQD_NO_BALANCING);
 		affinity = cpu_online_mask;
 		ret = true;
 	}
-- 
1.7.1
