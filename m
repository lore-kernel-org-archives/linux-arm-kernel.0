From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Nov 2014 20:29:50 +0000
Subject: [PATCH 2/8] ARM: use pr_warn_ratelimited() when migrating IRQs
In-Reply-To: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
Message-ID: <E1XqSvm-0002EJ-7S@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than open coding the printk_ratelimit() check with pr_warn(), use
pr_warn_ratelimited() instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index f2fea6831cd5..ad857bada96c 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -31,6 +31,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
+#include <linux/ratelimit.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/kallsyms.h>
@@ -135,7 +136,6 @@ int __init arch_probe_nr_irqs(void)
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
-
 static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
@@ -187,8 +187,8 @@ void migrate_irqs(void)
 		affinity_broken = migrate_one_irq(desc);
 		raw_spin_unlock(&desc->lock);
 
-		if (affinity_broken && printk_ratelimit())
-			pr_warn("IRQ%u no longer affine to CPU%u\n",
+		if (affinity_broken)
+			pr_warn_ratelimited("IRQ%u no longer affine to CPU%u\n",
 				i, smp_processor_id());
 	}
 
-- 
1.8.3.1
