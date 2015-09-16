From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 16 Sep 2015 11:58:25 +0800
Subject: [RFC PATCH v3 1/3] genirq: introduce CONFIG_GENERIC_IRQ_MIGRATION
In-Reply-To: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
References: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442375907-11496-2-git-send-email-yangyingliang@huawei.com>
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
 arch/arc/Kconfig       | 1 +
 arch/hexagon/Kconfig   | 1 +
 arch/ia64/Kconfig      | 1 +
 arch/tile/Kconfig      | 1 +
 arch/x86/Kconfig       | 1 +
 kernel/irq/Kconfig     | 4 ++++
 kernel/irq/Makefile    | 2 +-
 kernel/irq/migration.c | 2 ++
 8 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 78c0621..4133070 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -20,6 +20,7 @@ config ARC
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 4dc89d1..18d3255 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -12,6 +12,7 @@ config HEXAGON
 	# select ARCH_REQUIRE_GPIOLIB
 	# select HAVE_CLK
 	# select GENERIC_PENDING_IRQ if SMP
+	# select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index eb0249e..e48c2c8 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -37,6 +37,7 @@ config IA64
 	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_LEGACY
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 106c21b..bf8b059 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -14,6 +14,7 @@ config TILE
 	select HAVE_DEBUG_KMEMLEAK
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_IRQ_SHOW
 	select HAVE_DEBUG_BUGVERBOSE
 	select VIRT_TO_BUS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7aef2d5..a217a23 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -68,6 +68,7 @@ config X86
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ		if SMP
+	select GENERIC_IRQ_MIGRATION		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 9a76e3b..530c54a 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -30,6 +30,10 @@ config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 config GENERIC_PENDING_IRQ
 	bool
 
+# Support for generic irq migration
+config GENERIC_IRQ_MIGRATION
+	bool
+
 # Alpha specific irq affinity mechanism
 config AUTO_IRQ_AFFINITY
        bool
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
