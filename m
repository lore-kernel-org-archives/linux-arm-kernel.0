From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 11 Dec 2014 14:23:06 +0000
Subject: [PATCH 2/4] arm64: GICv3: change unsigned types for AArch32
 compatibility
In-Reply-To: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <1418307788-17977-3-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does a few simple compatibility-related changes:
- change the system register access prototypes to their actual size,
- homogenise mpidr accesses with unsigned long,
- force the 64bit register values to unsigned long long.

Note: the list registers are 64bit on GICv3, but the AArch32 vGIC driver
will need to split their values into two 32bit registers: LRn and LRCn.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 31 ++++++++++++++++++-------------
 drivers/irqchip/irq-gic-v3.c        | 25 ++++++++++++-------------
 include/linux/irqchip/arm-gic-v3.h  | 18 +++++++++---------
 3 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 28482d0..a0ea9de 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -77,15 +77,20 @@
 
 #include <linux/stringify.h>
 
-/* Low level accessors */
+/*
+ * Low-level accessors
+ *
+ * These system registers are 32 bits, but we make sure that the compiler
+ * sets the GP register's most significant bits to 0 with an explicit cast.
+ */
 
-static inline void gic_write_eoir(u64 irq)
+static inline void gic_write_eoir(u32 irq)
 {
-	asm volatile("msr_s " __stringify(ICC_EOIR1_EL1) ", %0" : : "r" (irq));
+	asm volatile("msr_s " __stringify(ICC_EOIR1_EL1) ", %0" : : "r" ((u64)irq));
 	isb();
 }
 
-static inline u64 __maybe_unused gic_read_iar(void)
+static inline u32 __maybe_unused gic_read_iar(void)
 {
 	u64 irqstat;
 
@@ -93,20 +98,20 @@ static inline u64 __maybe_unused gic_read_iar(void)
 	return irqstat;
 }
 
-static inline void __maybe_unused gic_write_pmr(u64 val)
+static inline void __maybe_unused gic_write_pmr(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" ((u64)val));
 }
 
-static inline void __maybe_unused gic_write_ctlr(u64 val)
+static inline void __maybe_unused gic_write_ctlr(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_CTLR_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_CTLR_EL1) ", %0" : : "r" ((u64)val));
 	isb();
 }
 
-static inline void __maybe_unused gic_write_grpen1(u64 val)
+static inline void __maybe_unused gic_write_grpen1(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" ((u64)val));
 	isb();
 }
 
@@ -115,7 +120,7 @@ static inline void __maybe_unused gic_write_sgi1r(u64 val)
 	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
 }
 
-static inline u64 __maybe_unused gic_read_sre(void)
+static inline u32 __maybe_unused gic_read_sre(void)
 {
 	u64 val;
 
@@ -123,9 +128,9 @@ static inline u64 __maybe_unused gic_read_sre(void)
 	return val;
 }
 
-static inline void __maybe_unused gic_write_sre(u64 val)
+static inline void __maybe_unused gic_write_sre(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" (val));
+	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" ((u64)val));
 	isb();
 }
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b85d6b6..e2cd5ac 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -220,11 +220,11 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static u64 gic_mpidr_to_affinity(u64 mpidr)
+static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 {
 	u64 aff;
 
-	aff = (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
+	aff = ((u64)MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8  |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 0));
@@ -234,7 +234,7 @@ static u64 gic_mpidr_to_affinity(u64 mpidr)
 
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
-	u64 irqnr;
+	u32 irqnr;
 
 	do {
 		irqnr = gic_read_iar();
@@ -285,9 +285,9 @@ static void __init gic_dist_init(void)
 		writeq_relaxed(affinity, base + GICD_IROUTER + i * 8);
 }
 
-static int gic_populate_rdist(void)
+static int __init gic_populate_rdist(void)
 {
-	u64 mpidr = cpu_logical_map(smp_processor_id());
+	unsigned long mpidr = cpu_logical_map(smp_processor_id());
 	u64 typer;
 	u32 aff;
 	int i;
@@ -316,9 +316,8 @@ static int gic_populate_rdist(void)
 			typer = readq_relaxed(ptr + GICR_TYPER);
 			if ((typer >> 32) == aff) {
 				gic_data_rdist_rd_base() = ptr;
-				pr_info("CPU%d: found redistributor %llx @%p\n",
-					smp_processor_id(),
-					(unsigned long long)mpidr, ptr);
+				pr_info("CPU%d: found redistributor %lx @%p\n",
+					smp_processor_id(), mpidr, ptr);
 				return 0;
 			}
 
@@ -333,8 +332,8 @@ static int gic_populate_rdist(void)
 	}
 
 	/* We couldn't even deal with ourselves... */
-	WARN(true, "CPU%d: mpidr %llx has no re-distributor!\n",
-	     smp_processor_id(), (unsigned long long)mpidr);
+	WARN(true, "CPU%d: mpidr %lx has no re-distributor!\n",
+	     smp_processor_id(), mpidr);
 	return -ENODEV;
 }
 
@@ -403,10 +402,10 @@ static struct notifier_block gic_cpu_notifier = {
 };
 
 static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
-				   u64 cluster_id)
+				   unsigned long cluster_id)
 {
 	int cpu = *base_cpu;
-	u64 mpidr = cpu_logical_map(cpu);
+	unsigned long mpidr = cpu_logical_map(cpu);
 	u16 tlist = 0;
 
 	while (cpu < nr_cpu_ids) {
@@ -463,7 +462,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	smp_wmb();
 
 	for_each_cpu_mask(cpu, *mask) {
-		u64 cluster_id = cpu_logical_map(cpu) & ~0xffUL;
+		unsigned long cluster_id = cpu_logical_map(cpu) & ~0xffUL;
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index e70b56f..95171d1 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -39,7 +39,7 @@
 #define GICD_ICACTIVER			0x0380
 #define GICD_IPRIORITYR			0x0400
 #define GICD_ICFGR			0x0C00
-#define GICD_IROUTER			0x6000
+#define GICD_IROUTER			0x6000		/* 64bit */
 #define GICD_PIDR2			0xFFE8
 
 #define GICD_CTLR_RWP			(1U << 31)
@@ -61,7 +61,7 @@
 #define GICR_IIDR			0x0004
 #define GICR_TYPER			0x0008
 #define GICR_STATUSR			GICD_STATUSR
-#define GICR_WAKER			0x0014
+#define GICR_WAKER			0x0014		/* 32bit */
 #define GICR_SETLPIR			0x0040
 #define GICR_CLRLPIR			0x0048
 #define GICR_SEIR			GICD_SEIR
@@ -69,7 +69,7 @@
 #define GICR_PENDBASER			0x0078
 #define GICR_INVLPIR			0x00A0
 #define GICR_INVALLR			0x00B0
-#define GICR_SYNCR			0x00C0
+#define GICR_SYNCR			0x00C0		/* 32bit */
 #define GICR_MOVLPIR			0x0100
 #define GICR_MOVALLR			0x0110
 #define GICR_PIDR2			GICD_PIDR2
@@ -107,13 +107,13 @@
 /*
  * Hypervisor interface registers (SRE only)
  */
-#define ICH_LR_VIRTUAL_ID_MASK		((1UL << 32) - 1)
+#define ICH_LR_VIRTUAL_ID_MASK		((1ULL << 32) - 1)
 
-#define ICH_LR_EOI			(1UL << 41)
-#define ICH_LR_GROUP			(1UL << 60)
-#define ICH_LR_STATE			(3UL << 62)
-#define ICH_LR_PENDING_BIT		(1UL << 62)
-#define ICH_LR_ACTIVE_BIT		(1UL << 63)
+#define ICH_LR_EOI			(1ULL << 41)
+#define ICH_LR_GROUP			(1ULL << 60)
+#define ICH_LR_STATE			(3ULL << 62)
+#define ICH_LR_PENDING_BIT		(1ULL << 62)
+#define ICH_LR_ACTIVE_BIT		(1ULL << 63)
 
 #define ICH_MISR_EOI			(1 << 0)
 #define ICH_MISR_U			(1 << 1)
-- 
2.2.0.rc1
