From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 14 Sep 2015 17:29:04 +0800
Subject: [RFC PATCH v2 2/3] genirq: rename config GENERIC_PENDING_IRQ to
 GENERIC_IRQ_MIGRATION
In-Reply-To: <1442222945-10628-1-git-send-email-yangyingliang@huawei.com>
References: <1442222945-10628-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442222945-10628-3-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the config name more general for moving other migration
interrupts code into kernel/irq/migration.c

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arc/Kconfig               | 2 +-
 arch/hexagon/Kconfig           | 2 +-
 arch/ia64/Kconfig              | 2 +-
 arch/tile/Kconfig              | 2 +-
 arch/x86/Kconfig               | 2 +-
 arch/x86/kernel/apic/io_apic.c | 2 +-
 include/linux/irq.h            | 4 +++-
 include/linux/irqdesc.h        | 2 +-
 kernel/irq/Kconfig             | 4 ++--
 kernel/irq/Makefile            | 2 +-
 kernel/irq/irqdesc.c           | 6 +++---
 kernel/irq/manage.c            | 2 +-
 kernel/irq/proc.c              | 2 +-
 13 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 78c0621..5d11976 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -19,7 +19,7 @@ config ARC
 	select GENERIC_FIND_FIRST_BIT
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
-	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 4dc89d1..ffee613 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -11,7 +11,7 @@ config HEXAGON
 	# select ARCH_WANT_OPTIONAL_GPIOLIB
 	# select ARCH_REQUIRE_GPIOLIB
 	# select HAVE_CLK
-	# select GENERIC_PENDING_IRQ if SMP
+	# select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index eb0249e..56e1d17 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -36,7 +36,7 @@ config IA64
 	select VIRT_TO_BUS
 	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_IRQ_PROBE
-	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_LEGACY
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 106c21b..841102c 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -13,7 +13,7 @@ config TILE
 	select CC_OPTIMIZE_FOR_SIZE
 	select HAVE_DEBUG_KMEMLEAK
 	select GENERIC_IRQ_PROBE
-	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_IRQ_MIGRATION if SMP
 	select GENERIC_IRQ_SHOW
 	select HAVE_DEBUG_BUGVERBOSE
 	select VIRT_TO_BUS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7aef2d5..9c07c63 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -67,7 +67,7 @@ config X86
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
-	select GENERIC_PENDING_IRQ		if SMP
+	select GENERIC_IRQ_MIGRATION		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 38a76f8..a1203d5 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1684,7 +1684,7 @@ static unsigned int startup_ioapic_irq(struct irq_data *data)
 
 atomic_t irq_mis_count;
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_GENERIC_IRQ_MIGRATION
 static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 {
 	struct irq_pin_list *entry;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 6f8b340..43053ea 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -438,12 +438,14 @@ extern int irq_set_affinity_locked(struct irq_data *data,
 				   const struct cpumask *cpumask, bool force);
 extern int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
+#if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_IRQ_MIGRATION)
 void irq_move_irq(struct irq_data *data);
 void irq_move_masked_irq(struct irq_data *data);
+void migrate_irqs(void);
 #else
 static inline void irq_move_irq(struct irq_data *data) { }
 static inline void irq_move_masked_irq(struct irq_data *data) { }
+static inline void migrate_irqs(void) { }
 #endif
 
 extern int no_irq_affinity;
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 5acfa26..1ec727d 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -66,7 +66,7 @@ struct irq_desc {
 #ifdef CONFIG_SMP
 	const struct cpumask	*affinity_hint;
 	struct irq_affinity_notify *affinity_notify;
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_GENERIC_IRQ_MIGRATION
 	cpumask_var_t		pending_mask;
 #endif
 #endif
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 9a76e3b..4350358 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -26,8 +26,8 @@ config GENERIC_IRQ_SHOW_LEVEL
 config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
        bool
 
-# Support for delayed migration from interrupt context
-config GENERIC_PENDING_IRQ
+# Support for generic irq migration
+config GENERIC_IRQ_MIGRATION
 	bool
 
 # Alpha specific irq affinity mechanism
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
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0a2a4b6..9514e56 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -41,7 +41,7 @@ static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
 	if (!zalloc_cpumask_var_node(&desc->irq_data.affinity, gfp, node))
 		return -ENOMEM;
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_GENERIC_IRQ_MIGRATION
 	if (!zalloc_cpumask_var_node(&desc->pending_mask, gfp, node)) {
 		free_cpumask_var(desc->irq_data.affinity);
 		return -ENOMEM;
@@ -54,7 +54,7 @@ static void desc_smp_init(struct irq_desc *desc, int node)
 {
 	desc->irq_data.node = node;
 	cpumask_copy(desc->irq_data.affinity, irq_default_affinity);
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_GENERIC_IRQ_MIGRATION
 	cpumask_clear(desc->pending_mask);
 #endif
 }
@@ -118,7 +118,7 @@ static void delete_irq_desc(unsigned int irq)
 #ifdef CONFIG_SMP
 static void free_masks(struct irq_desc *desc)
 {
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_GENERIC_IRQ_MIGRATION
 	free_cpumask_var(desc->pending_mask);
 #endif
 	free_cpumask_var(desc->irq_data.affinity);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ad1b064..6207deb 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -153,7 +153,7 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 	}
 }
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_GENERIC_IRQ_MIGRATION
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
 {
 	return irqd_can_move_in_process_context(data);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 0e97c14..c070fa6 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -41,7 +41,7 @@ static int show_irq_affinity(int type, struct seq_file *m, void *v)
 	struct irq_desc *desc = irq_to_desc((long)m->private);
 	const struct cpumask *mask = desc->irq_data.affinity;
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_GENERIC_IRQ_MIGRATION
 	if (irqd_is_setaffinity_pending(&desc->irq_data))
 		mask = desc->pending_mask;
 #endif
-- 
2.5.0
