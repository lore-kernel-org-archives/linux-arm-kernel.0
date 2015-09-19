From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 19 Sep 2015 11:05:56 +0800
Subject: [RFC PATCH v5 1/4] genirq: introduce CONFIG_GENERIC_IRQ_MIGRATION
In-Reply-To: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442631959-10228-2-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a more general config for compile kernel/irq/migration.c.
Move the CONFIG_GENERIC_PENDING_IRQ into migration.c. So we can
move other migration interrupts code into migration.c without
select CONFIG_GENERIC_PENDING_IRQ.

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/irq/Kconfig     | 5 +++++
 kernel/irq/Makefile    | 2 +-
 kernel/irq/migration.c | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 9a76e3b..1ac0647 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -29,6 +29,11 @@ config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 # Support for delayed migration from interrupt context
 config GENERIC_PENDING_IRQ
 	bool
+	select GENERIC_IRQ_MIGRATION
+
+# Support for generic irq migration
+config GENERIC_IRQ_MIGRATION
+	bool
 
 # Alpha specific irq affinity mechanism
 config AUTO_IRQ_AFFINITY
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index d121235..bdd31b7 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -4,6 +4,6 @@ obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_PROC_FS) += proc.o
-obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
+obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += migration.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 37ddb7b..1ff2b77 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -4,6 +4,7 @@
 
 #include "internals.h"
 
+#ifdef CONFIG_GENERIC_PENDING_IRQ
 void irq_move_masked_irq(struct irq_data *idata)
 {
 	struct irq_desc *desc = irq_data_to_desc(idata);
@@ -77,3 +78,4 @@ void irq_move_irq(struct irq_data *idata)
 	if (!masked)
 		idata->chip->irq_unmask(idata);
 }
+#endif
-- 
2.5.0
