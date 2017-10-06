From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Fri,  6 Oct 2017 10:24:00 -0500
Subject: [PATCH v4] irqchip/gicv3: Add support for Range Selector (RS) feature
Message-ID: <1507303440-12704-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new feature Range Selector (RS) has been added to GIC specification
in order to support more than 16 CPUs at affinity level 0. New fields
are introduced in SGI system registers (ICC_SGI0R_EL1, ICC_SGI1R_EL1
and ICC_ASGI1R_EL1) to relax an artificial limit of 16 at level 0.

- A new RSS field in ICC_CTLR_EL3, ICC_CTLR_EL1 and ICV_CTLR_EL1:
  [18] - Range Selector Support (RSS)
  0b0 = Targeted SGIs with affinity level 0 values of 0-15 are supported.
  0b1 = Targeted SGIs with affinity level 0 values of 0-255 are supported.

- A new RS field in ICC_SGI0R_EL1, ICC_SGI1R_EL1 and ICC_ASGI1R_EL1:
  [47:44] - RangeSelector (RS) which group of 16 TargetList[n] field
            TargetList[n] represents aff0 value ((RS*16)+n)
            When ICC_CTLR_EL3.RSS==0 or ICC_CTLR_EL1.RSS==0, RS is RES0.

- A new RSS field in GICD_TYPER:
  [26] - Range Selector Support (RSS)
  0b0 = Targeted SGIs with affinity level 0 values of 0-15 are supported.
  0b1 = Targeted SGIs with affinity level 0 values of 0-255 are supported.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v3:
   - Keep parentheses around a macro parameter.
Changes since v2:
   - Changed from pr_crit() to pr_crit_once().
   - Incorporated Marc's simplified RSS validation check.
Changes since v1:
   - Addressed Marc's review comments on RSS validation checks.
   - Apply code changes to gic_compute_target_list() to support RSS feature.
   - Fix the compilation on ARM32.

 arch/arm/include/asm/arch_gicv3.h   |  5 ++++
 arch/arm64/include/asm/arch_gicv3.h |  5 ++++
 drivers/irqchip/irq-gic-v3.c        | 49 ++++++++++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic-v3.h  |  4 +++
 4 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index eee2693..1070044 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -196,6 +196,11 @@ static inline void gic_write_ctlr(u32 val)
 	isb();
 }
 
+static inline u32 gic_read_ctlr(void)
+{
+	return read_sysreg(ICC_CTLR);
+}
+
 static inline void gic_write_grpen1(u32 val)
 {
 	write_sysreg(val, ICC_IGRPEN1);
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index b7e3f74..9becba9 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -87,6 +87,11 @@ static inline void gic_write_ctlr(u32 val)
 	isb();
 }
 
+static inline u32 gic_read_ctlr(void)
+{
+	return read_sysreg_s(SYS_ICC_CTLR_EL1);
+}
+
 static inline void gic_write_grpen1(u32 val)
 {
 	write_sysreg_s(val, SYS_ICC_IGRPEN1_EL1);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b5df99c..a7d255f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -55,6 +55,7 @@ struct gic_chip_data {
 	struct irq_domain	*domain;
 	u64			redist_stride;
 	u32			nr_redist_regions;
+	bool			has_rss;
 	unsigned int		irq_nr;
 	struct partition_desc	*ppi_descs[16];
 };
@@ -63,7 +64,9 @@ struct gic_chip_data {
 static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
 
 static struct gic_kvm_info gic_v3_kvm_info;
+static DEFINE_PER_CPU(bool, has_rss);
 
+#define MPIDR_RS(mpidr)			(((mpidr) & 0xF0UL) >> 4)
 #define gic_data_rdist()		(this_cpu_ptr(gic_data.rdists.rdist))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_sgi_base()	(gic_data_rdist_rd_base() + SZ_64K)
@@ -526,6 +529,10 @@ static void gic_update_vlpi_properties(void)
 
 static void gic_cpu_sys_reg_init(void)
 {
+	int i, cpu = smp_processor_id();
+	u64 mpidr = cpu_logical_map(cpu);
+	u64 need_rss = MPIDR_RS(mpidr);
+
 	/*
 	 * Need to check that the SRE bit has actually been set. If
 	 * not, it means that SRE is disabled at EL2. We're going to
@@ -557,6 +564,29 @@ static void gic_cpu_sys_reg_init(void)
 
 	/* ... and let's hit the road... */
 	gic_write_grpen1(1);
+
+	/* Keep the RSS capability status in per_cpu variable */
+	per_cpu(has_rss, cpu) = !!(gic_read_ctlr() & ICC_CTLR_EL1_RSS);
+
+	/* Check all the CPUs have capable of sending SGIs to other CPUs */
+	for_each_online_cpu(i) {
+		bool have_rss = per_cpu(has_rss, i) && per_cpu(has_rss, cpu);
+
+		need_rss |= MPIDR_RS(cpu_logical_map(i));
+		if (need_rss && (!have_rss))
+			pr_crit("CPU%d (%llx) can't SGI CPU%d (%llx), no RSS\n",
+				cpu, mpidr, i, cpu_logical_map(i));
+	}
+
+	/**
+	 * GIC spec says, when ICC_CTLR_EL1.RSS==1 and GICD_TYPER.RSS==0,
+	 * writing ICC_ASGI1R_EL1 register with RS != 0 is a CONSTRAINED
+	 * UNPREDICTABLE choice of :
+	 *   - The write is ignored.
+	 *   - The RS field is treated as 0.
+	 */
+	if (need_rss && (!gic_data.has_rss))
+		pr_crit_once("RSS is required but GICD doesn't support it\n");
 }
 
 static int gic_dist_supports_lpis(void)
@@ -591,6 +621,9 @@ static void gic_cpu_init(void)
 
 #ifdef CONFIG_SMP
 
+#define MPIDR_TO_SGI_RS(mpidr)	(MPIDR_RS(mpidr) << ICC_SGI1R_RS_SHIFT)
+#define MPIDR_TO_SGI_CLUSTER_ID(mpidr)	((mpidr) & ~0xFUL)
+
 static int gic_starting_cpu(unsigned int cpu)
 {
 	gic_cpu_init();
@@ -605,13 +638,6 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 	u16 tlist = 0;
 
 	while (cpu < nr_cpu_ids) {
-		/*
-		 * If we ever get a cluster of more than 16 CPUs, just
-		 * scream and skip that CPU.
-		 */
-		if (WARN_ON((mpidr & 0xff) >= 16))
-			goto out;
-
 		tlist |= 1 << (mpidr & 0xf);
 
 		next_cpu = cpumask_next(cpu, mask);
@@ -621,7 +647,7 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 
 		mpidr = cpu_logical_map(cpu);
 
-		if (cluster_id != (mpidr & ~0xffUL)) {
+		if (cluster_id != MPIDR_TO_SGI_CLUSTER_ID(mpidr)) {
 			cpu--;
 			goto out;
 		}
@@ -643,6 +669,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	       MPIDR_TO_SGI_AFFINITY(cluster_id, 2)	|
 	       irq << ICC_SGI1R_SGI_ID_SHIFT		|
 	       MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
+	       MPIDR_TO_SGI_RS(cluster_id)		|
 	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
 
 	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
@@ -663,7 +690,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	smp_wmb();
 
 	for_each_cpu(cpu, mask) {
-		unsigned long cluster_id = cpu_logical_map(cpu) & ~0xffUL;
+		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
@@ -1007,6 +1034,10 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		goto out_free;
 	}
 
+	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
+	pr_info("Distributor has %sRange Selector support\n",
+		gic_data.has_rss ? "" : "no ");
+
 	set_handle_irq(gic_handle_irq);
 
 	gic_update_vlpi_properties();
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 1ea576c..b8b5998 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -68,6 +68,7 @@
 #define GICD_CTLR_ENABLE_SS_G1		(1U << 1)
 #define GICD_CTLR_ENABLE_SS_G0		(1U << 0)
 
+#define GICD_TYPER_RSS			(1U << 26)
 #define GICD_TYPER_LPIS			(1U << 17)
 #define GICD_TYPER_MBIS			(1U << 16)
 
@@ -459,6 +460,7 @@
 #define ICC_CTLR_EL1_SEIS_MASK		(0x1 << ICC_CTLR_EL1_SEIS_SHIFT)
 #define ICC_CTLR_EL1_A3V_SHIFT		15
 #define ICC_CTLR_EL1_A3V_MASK		(0x1 << ICC_CTLR_EL1_A3V_SHIFT)
+#define ICC_CTLR_EL1_RSS		(0x1 << 18)
 #define ICC_PMR_EL1_SHIFT		0
 #define ICC_PMR_EL1_MASK		(0xff << ICC_PMR_EL1_SHIFT)
 #define ICC_BPR0_EL1_SHIFT		0
@@ -547,6 +549,8 @@
 #define ICC_SGI1R_AFFINITY_2_SHIFT	32
 #define ICC_SGI1R_AFFINITY_2_MASK	(0xffULL << ICC_SGI1R_AFFINITY_2_SHIFT)
 #define ICC_SGI1R_IRQ_ROUTING_MODE_BIT	40
+#define ICC_SGI1R_RS_SHIFT		44
+#define ICC_SGI1R_RS_MASK		(0xfULL << ICC_SGI1R_RS_SHIFT)
 #define ICC_SGI1R_AFFINITY_3_SHIFT	48
 #define ICC_SGI1R_AFFINITY_3_MASK	(0xffULL << ICC_SGI1R_AFFINITY_3_SHIFT)
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
